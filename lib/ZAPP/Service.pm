package ZAPP::Service;
use strict;
use warnings;

#
# {
#   stomp       => $args->{stomp},
#   dbh         => $args->{dbh},
#   serrializer => $args->{serializer},
#   service     => $args->{service}->{svc},
# }
#
sub new {
    my ($class, $args)  = @_;
    bless $args, $class;
}

sub handle {
    my ($self, $req)  = @_;
    warn "-----------------------------------\n";
    Data::Dump->dump($req);
    Data::Dump->dump($self->{service});
    return $self->{service}->{$req->{svc}}->($self, $req);
}

1;
