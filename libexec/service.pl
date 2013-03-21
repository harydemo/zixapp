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

    # 连接stomp
    my $stomp = Net::Stomp->new( 
        {
            hostname => $cfg->{stomp}->{hostname}, 
            port     => $cfg->{stomp}->{port} ,
        }
    ) or confess "can not Net::Stomp with { hostname => $cfg->{stomp}->{hostname}, port => $cfg->{stomp}->{port} }";
    $stomp->connect({ login => 'hello', passcode => 'there' });

    # 序列化工具对象
    my $ser = $cfg->{serializer};

    # service 对象
    ZAPP::Service->spawn();

    $poe_kernel->run();
    
};

__END__





