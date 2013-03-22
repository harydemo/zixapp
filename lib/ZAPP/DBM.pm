package ZAPP::DBM;
use strict;
use warnings;

#
#  @para = (
#     dbh  => $dbh,
#  );
#
sub new {

    my $class = shift;
    my $self  = bless { @_ }, $class;
    unless( $self->{dbh} ) {
        return;
    }
    return $self;
}

#
#
#
sub _check_maint {
    my ($self, $cfg) = @_;
    if ($cfg->{padd} ) {
        my $padd = $cfg->{padd};
        unless( $padd->{name} ) {
        }
    }
}

#
#
#
sub table_info {
    my $sql_show = "list data partitions show detail";
    my $sql_tbsp = "list tablespaces show detail";
}

######################################################
#  book => 'bamt_yhyf'
#  pdel => 'p_0'
#  padd => {
#       start => 'xxxx',
#       end   => 'xxxx',
#       name => 'p_1',
#       tbsp  => {
#           name => 'tbsp_1',
#           create => {
#               pagesize => '8k',
#               bufferpool => 'bk32k',
#               size => '2G',
#               dir  => ‘/tmp',
#           }
#       },
#  },
######################################################
sub mqt_maint {

    my ($self, $cfg) = @_;

    unless( $self->_check_maint($cfg) ) {
        return;
    }

    my $book   = $cfg->{book};
    my $pdel   = $cfg->{pdel};
    my $padd   = $cfg->{padd}->{name};
    my $pstart = $cfg->{padd}->{start};
    my $pend   = $cfg->{padd}->{end};
    my $tbsp   = $cfg->{padd}->{tbsp};

    # 取得nhash
    my $sql_nhash = "select * from book_$book";
    my $sth_nhash = $self->{dbh}->prepare("select * from book_$book") or return;
    my %nhash = %{$sth_nhash->{NAME_hash}};
    delete $nhash{TS_C};     # 创建时间不要
    delete $nhash{YS_TYPE};  # 期间日期不要
    delete $nhash{YS_ID};    # 期间日期不要
    delete $nhash{JZPZ_ID};  # 期间日期不要
    delete $nhash{J};        # 期间日期不要
    delete $nhash{D};        # 期间日期不要
    delete $nhash{ID};        # 期间日期不要
    $sth_nhash->finish();

    # 拿到所有dim字段
    %nhash = reverse %nhash;
    my @dim = map { lc $_ } @nhash{sort keys %nhash};
    my $dim_fld = join ",\n        ", map { "$_ as $_" } @dim;
    my $dim_grp = join ', ', @dim;

    ##########################################################
    # 分离分区 
    # 添加分区
    # 取消物化
    # 绑定物化
    # 删除无用数据
    # 确立完整性
    ##########################################################
    my $sql_tbsp;
    if ($tbsp) {
        my $name     = $tbsp->{name};  
        if ($tbsp->{create}) {
            my $pagesize = $tbsp->{create}->{pagesize};  
            my $size     = $tbsp->{create}->{size};  
            my $bp       = $tbsp->{create}->{bufferpool};  
            my $dir      = $tbsp->{create}->{dir};  
            $sql_tbsp = "create tablespace $name " . 
                    "pagesize $pagesize " .
                    "managed by database " . 
                    "using ( file \'$dir/$name\' $size ) " . 
                    "bufferpool $bp no file system caching"; 
        }
    }
    my $sql_detach = qq/alter table book_$book detach partition $pdel into book_${book}_$pdel/ if $pdel;
    my $sql_attach = qq/alter table book_$book attach partition $padd starting $pstart ending $pend/ if $padd;
    $sql_attach .= " in $tbsp->{name}" if $padd and $tbsp;
    my $sql_unmqt  = qq/alter table sum_$book drop materialized query/;
    my $sql_mqt    =<<EOF;
alter table sum_$book add materialized query (
    select 
        $dim_fld, 
        sum(j) as j, 
        sum(d) as d, 
        count(*) as cnt 
    from 
        book_$book 
    group by 
        $dim_grp
) data initially deferred refresh immediate
EOF
    my $sql_del    = qq/delete from sum_$book where j = d/;
    my $sql_int = qq/set integrity for sum_$book materialized query immediate unchecked/;

    warn "$sql_tbsp\n";
    warn "$sql_detach\n";
    warn "$sql_attach\n";
    warn "$sql_unmqt\n";
    warn "$sql_mqt\n";
    warn "$sql_del\n";
    warn "$sql_int\n";
    
    return $self;
}

#
# 提交
#
sub commit {
    my $self = shift;
    $self->{dbh}->commit(); 
}

#
# 处理
#
sub handle {
    my ($self, $src) = @_;
    my $proc = $self->{proc}->{$src->{_type}};
    return unless $proc;
    $proc->($self, $src) or return;
}

1;

__END__

