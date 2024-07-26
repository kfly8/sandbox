#!perl
use v5.40;
use IO::Socket::INET;

my $server = IO::Socket::INET->new(
    LocalPort => 8080,
    Type      => SOCK_STREAM,
    Reuse     => 1,
    Listen    => 10
) or die "Could not create socket: $!\n";

print "Server is listening on port 8080\n";

my $RN = "\r\n";

while (my $client = $server->accept()) {
    print "Client connected\n";

    my $buffer = "";
    $client->recv($buffer, 16);
    print "Received from client: $buffer\n";

    sleep 5;

    my $response = "";
    $response .= "HTTP/1.1 200 OK$RN";
    $response .= "Content-Type: text/plain$RN";
    $response .= "Content-Length: 13$RN";
    $response .= "$RN";
    $response .= "Hello, World!";

    $client->send($response);

    close($client);
    print "Client disconnected\n";
}
close($server);
