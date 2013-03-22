package ZAPP::Service;
use strict;
use warnings;

#
#
# stomp       => $args->{stomp},
# dbh         => $args->{dbh},
# serrializer => $args->{serializer},
# service     => $args->{service}->{svc},
#
#
sub new {
    my $class = shift;
    bless { @_ }, $class;
}

sub handle {
    my ($self, $req)  = @_;
    return $self->{service}->{$req->{svc}}->($self, $req);
}

1;
