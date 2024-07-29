use v5.40;
use Parallel::Prefork;
use IO::Socket::INET;

sub run {
    my $pm = Parallel::Prefork->new({
      max_workers  => 3,
      trap_signals => {
        TERM => 'TERM',
        HUP  => 'TERM',
      }
    });

    my $server = IO::Socket::INET->new(
        LocalPort => 8080,
        Type      => SOCK_STREAM,
        Reuse     => 1,
        Listen    => SOMAXCONN,
    ) or die "Could not create server socket: $!";

    while ($pm->signal_received ne 'TERM') {
      $pm->start(sub {
        accept_loop($server);
      });
    }

    my $timeout = 10;
    while ($pm->wait_all_children($timeout)) {
        $pm->signal_all_children('TERM');
    }
}

my $response = "HTTP/1.0 200 OK\r\nContent-Length: 11\r\n\r\nHello World\n";

sub accept_loop ($server) {
    while (1) {
        warn "[$$] start accept";
        my $conn = $server->accept();
        next unless $conn;

        warn "[$$] accepted";

        my $request;
        while (<$conn>) {
            last if /^[\r\n]+$/;
            $request .= $_;
        }

        print $conn $response;

        warn "[$$] write response";

        $conn->close;
        warn "[$$] connection closed";
    }
}

run();
