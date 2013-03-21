package ZAPP::PROC;
use strict;
use warnings;

#
#  @para = (
#     dbh  => $dbh,
#     book => [ 'bamt_yhyf', 'bfee_yhyf'],
#     proc => {
#         0001  => sub { ... },
#     }
#  );
#
#
sub new {
    my $class = shift;
    my $self  = bless { @_ }, $class;
    unless( $self->{dbh} && $self->{book} && $self->{proc} ) {
        return;
    }

    my %book;
    for my $name (@{delete $self->{book}}) {

        my $seq = 'seq_' . $name;

        # 取得nhash
        my $sql_nhash = "select * from book_$name";
        warn "sql_nhash[$sql_nhash]" if $ENV{ZAPP_DEBUG};
        my $sth_nhash = $self->{dbh}->prepare("select * from book_$name") or return;
        my %nhash = %{$sth_nhash->{NAME_hash}};
        warn "nhash:\n";
        Data::Dump->dump(\%nhash);
        delete $nhash{TS_C};
        $sth_nhash->finish();

        # @key && @val
        %nhash = reverse %nhash;
        warn "nhash rev:\n";
        Data::Dump->dump(\%nhash);
        my @idx = sort keys %nhash;
        my @val = @nhash{@idx};

        # 产生insert sth
        my $fld  = join ', ', @val;
        my $mark = join ', ', ('?') x @val;
        my $sql_ins = "insert into book_$name($fld, TS_C) values ($mark, current timestamp)";
        warn "sql_ins[$sql_ins]" if $ENV{ZAPP_DEBUG};
        my $sth_ins = $self->{dbh}->prepare($sql_ins) or return;

        # 产生 seq sth
        my $sql_seq = "values nextval for $seq";
        my $sth_seq = $self->{dbh}->prepare("values nextval for $seq") or return;
        warn "sql_seq[$sql_seq]" if $ENV{ZAPP_DEBUG};
        $book{$name} = [ $sth_seq, $sth_ins ];

       # 批量产生函数      
       no strict 'refs';
       *{__PACKAGE__ . "::$name"} = sub {
           my $self = shift;

           warn "got args[@_]";

           # 获取id
           $self->{book}->{$name}->[0]->execute();
           my ($id) = $self->{book}->{$name}->[0]->fetchrow_array();

           # 插入记录
           warn "execute with[$id @_]";
           $self->{book}->{$name}->[1]->execute($id, @_);

           # 返回id
           return $id;
       };
    }
    $self->{book}  = \%book;
    $self->{jz_id} = $self->{dbh}->prepare(qq/values nextval for seq_jzpz/) or return;
    my $sql_jzpz = qq/insert into jzpz(id, j_id, j_book, d_id, d_book, ys_type, ys_id, ts_c) values(?,?,?,?,?,?,?,current timestamp)/;
    $self->{jzpz}  = $self->{dbh}->prepare($sql_jzpz) or return;

    return $self;
}

#
# 记账配置id
#
sub jzpz_id {
    my $self = shift; 
    $self->{jz_id}->execute();
    my ($id) = $self->{jzpz}->fetchrow_array();
    return $id;
}

#
# 插入记账凭证
#
sub jzpz {
    my $self = shift;
    $self->{jzpz}->execute(@_);
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

