use v5.38;

use Net::Async::HTTP::Server;
use HTTP::Response;
use IO::Async::Loop;
use IO::Async::Stream;
use Log::Minimal;

my $loop = IO::Async::Loop->new;

my $stream = IO::Async::Stream->new(
    write_handle => \*STDOUT,
);

$loop->add($stream);

my $httpserver = Net::Async::HTTP::Server->new(
    on_request => sub($self, $req) {

        my $response = HTTP::Response->new( 200 );
        $response->add_content( "Hello, world!\n" );
        $response->content_type( "text/plain" );
        $response->content_length( length $response->content );

        infof("%s %s %s %s", $req->method, $req->path, $req->protocol, 200);

        $req->respond( $response );
    },
);

$loop->add( $httpserver );

$httpserver->listen(
    addr => { family => "inet6", socktype => "stream", port => 8080 },
)->get;

$loop->run;
