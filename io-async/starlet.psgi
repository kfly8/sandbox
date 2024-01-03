use v5.38;

use Plack::Util;
use Plack::Loader;

my $app = Plack::Util::load_psgi( "app.psgi" );

Plack::Loader->load('Starlet',
    #workers => 0, # Run directly for debugging
    workers => 16,
    port => 8080,
)->run($app);
