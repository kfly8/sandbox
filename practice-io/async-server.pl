use v5.40;

use Future::AsyncAwait;
use Net::Async::HTTP::Server;

use IO::Async::Loop;

use HTTP::Response;

my $response = HTTP::Response->new( 200 );
$response->add_content( "Hello, world!\n" );
$response->content_type( "text/plain" );
$response->content_length( length $response->content );

my $loop = IO::Async::Loop->new;

use Net::Async::HTTP::Server::Request;

my $server = Net::Async::HTTP::Server->new(
    on_request => sub($self, $req) {

        my $res = $req->respond( $response );
        use Data::Dumper;
        warn Dumper $res;
        return $res;
    }
);


$loop->add( $server);

$server->listen(
   addr => { family => "inet6", socktype => "stream", port => 8080 },
)->get;

$loop->run;
