#!/usr/bin/perl

use Zeta::Run;
use Zeta::IPC::MsgQ;

use POE;
use Zeta::Run::Main::HTTP;

sub {
    my $cfg = zkernel->zapp_config()->{main};
    Zeta::Run::Main::HTTP->run( 
         port   => $cfg->{port}, 
         module => $cfg->{module}, 
         para   => $cfg->{para}
    );
};

__END__

