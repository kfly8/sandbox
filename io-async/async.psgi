use v5.38;

use Plack::Util;
use Plack::Handler::Net::Async::HTTP::Server;

my $handler = Plack::Handler::Net::Async::HTTP::Server->new(
   listen => [ ":8080" ],
);

my $app = Plack::Util::load_psgi( "app.psgi" );

$handler->run( $app );
