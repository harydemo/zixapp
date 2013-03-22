#!/usr/bin/perl
use strict;
use warnings;
use Zeta::Run;
use Net::Stomp;
use DBI;
use Carp;
use ZAPP::PROC;
use ZAPP::Service;

sub {

    # 获取配置
    my $cfg = zkernel->zapp_config();
    zlogger->debug("zapp_config:\n" . Data::Dump->dump($cfg)) if $ENV{ZAPP_DEBUG};

    # 连接数据库,设置当前schema
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
    $dbh->do("set current schema $cfg->{db}->{schema}") or confess "can not set current schema $cfg->{db}->{schema}";

    # 连接stomp
    my $stomp = Net::Stomp->new( 
        {
            hostname => $cfg->{stomp}->{hostname}, 
            port     => $cfg->{stomp}->{port} ,
        }
    ) or confess "can not Net::Stomp with { hostname => $cfg->{stomp}->{hostname}, port => $cfg->{stomp}->{port} }";
    $stomp->connect({ login => 'hello', passcode => 'there' });

    # 构建service的POE session
    Zeta::POE::HTTPD->spawn(
        ip     => $cfg->{service}->{ip},
        port   => $cfg->{service}->{port},
        module => 'ZAPP::Service',
        para   => {
            dbh        => $dbh, 
            stomp      => $stomp, 
            serializer => $cfg->{serializer}, 
            service    => $cfg->{service}->{svc},
        },
    ) or confess "can not ZAPP::Service->new";

    # 运行
    $poe_kernel->run();
    
};

__END__





