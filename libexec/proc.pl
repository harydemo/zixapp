#!/usr/bin/perl
use strict;
use warnings;
use Zeta::Run;
use Net::Stomp;
use DBI;
use Carp;
use ZAPP::PROC;

sub {

    # 获取配置
    my $cfg = zkernel->zapp_config();
    warn "zapp_config:\n" . Data::Dump->dump($cfg) if $ENV{ZAPP_DEBUG};

    # 连接数据库
    my $dbh = DBI->connect(
        @{$cfg->{db}}{qw/dsn user pass/},
        {
            RaiseError       => 1,
            PrintError       => 0,
            AutoCommit       => 0,
            FetchHashKeyName => 'NAME_lc',
            ChopBlanks       => 1,
        }
    );
    unless($dbh) {
        zlogger->error("can not connet db[@{$cfg->{db}}{qw/dsn user pass/}], quit");
        exit 0;
    }

    # 设置默认schema
    $dbh->do("set current schema $cfg->{db}->{schema}") or confess "can not set current schema $cfg->{db}->{schema}";

    # 构建proc对象
    my $proc = ZAPP::PROC->new(dbh => $dbh, book => $cfg->{book}, proc => $cfg->{proc} ) or confess "can not ZAPP::PROC->new";

    warn "ZAPP:PROC:\n"  . Data::Dump->dump($proc) if $ENV{ZAPP_DEBUG};

#
    # my $id = $proc->bfee_yhyf(1, undef, 3, 4, 5, 6, 7, 8, 9);
    # $proc->commit();
    # warn "bfee_yhyf got id[$id]";
    #while(1) { sleep 100; }
#};


    # 构建stomp客户端
    my $stomp = Net::Stomp->new( 
        {
            hostname => $cfg->{stomp}->{hostname}, 
            port     => $cfg->{stomp}->{port} ,
        }
    ) or confess "can not Net::Stomp with { hostname => $cfg->{stomp}->{hostname}, port => $cfg->{stomp}->{port} }";
    $stomp->connect({ login => 'hello', passcode => 'there' });

    # 订阅
    $stomp->subscribe(
        {   
            'destination'           => $cfg->{stomp}->{queue}->{proc},
            'ack'                   => 'client',
            'activemq.prefetchSize' => 1,
        }
    ) or confess "can not subscribe to $cfg->{stomp}->{queue}->{proc}";

    # 序列化工具对象
    my $ser = $cfg->{serializer};

    # 开始loop: 接收原始凭证， 处理原始凭证
    while (1) {

         my $frame = $stomp->receive_frame;
         zlogger->debug("recv frame:\n" . Data::Dump->dump($frame)) if $ENV{ZAPP_DEBUG};

         # 反序列化获取原始配置
         my $src = $ser->deserialize($frame->body);  
         unless($src) {
            zlogger->error("can not deserialize src[" . $frame->body . "]");
            $stomp->ack( { frame => $frame } );
            next;
         }
         zlogger->debug("recv src:\n" . Data::Dump->dump($src)) if $ENV{ZAPP_DEBUG};

         # 凭证处理
         unless($proc->handle($src)) {
            zlogger->error("can not handle src[" . $src . "]");
            $stomp->ack( { frame => $frame } );
            next;
         }

         $stomp->ack( { frame => $frame } );
    }
};

__END__





