package ZAPP::Admin;
use strict;
use warnings;

sub new {
    my ($class, $para) = @_;
}

my $cnt = 0;

sub handle {
    return {
       cnt      => $cnt++,
       datetime => `date +%Y-%m-%d %H:%M:%S`,
    };
}

1;

__END__

