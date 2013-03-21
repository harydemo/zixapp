#!/usr/bin/perl
use strict;
use warnings;
use Carp;

my $cfg = do "$ENV{ZIXAPP_HOME}/conf/zixapp.conf";
confess "can not load $ENV{ZIXAPP_HOME}/conf/zixapp.conf error[$@]" unless $cfg;

helper  zapp_config => sub { $cfg };

