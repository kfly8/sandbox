use v5.38;

use Plack::Builder;

my $app = sub {
    my $env = shift;
    return [ 200, [ "Content-Type" => "text/plain" ], [ "Hello, world!" ] ];
};

builder {
    enable "AccessLog";
    $app;
}
