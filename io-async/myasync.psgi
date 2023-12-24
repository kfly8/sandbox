use v5.38;

use Plack::Util;
use Net::Async::HTTP::Server::PSGI;
#use IO::Async::Loop::EV;
use IO::Async::Loop::UV;

my $app = Plack::Util::load_psgi( "app.psgi" );

#my $loop = IO::Async::Loop::EV->new;
my $loop = IO::Async::Loop::UV->new;

my $httpserver = Net::Async::HTTP::Server::PSGI->new(
   app => $app,
);

$loop->add( $httpserver );

$httpserver->listen(
   addr => { family => "inet6", socktype => "stream", port => 8080 },
)->get;

$loop->run;
