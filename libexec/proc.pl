#!/usr/bin/perl
use strict;
use warnings;
use Zeta::Run;
use Net::Stomp;
use DBI;
use Carp;
use ZAPP::PROC;

sub {

    # 全局配置
    my $cfg = zkernel->zapp_config();

    # 连接数据库
    my $dbh = zkernel->zapp_dbh();

    # 构建proc对象
    my $proc = ZAPP::PROC->new(
        dbh  => $dbh, 
        book => $cfg->{book}, 
        yspz => $cfg->{yspz}, 
        proc => $cfg->{proc} 
    ) or confess "can not ZAPP::PROC->new";

    warn "ZAPP:PROC:\n"  . Data::Dump->dump($proc) if $ENV{ZAPP_DEBUG};

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





