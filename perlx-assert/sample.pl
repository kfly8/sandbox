use v5.40;

BEGIN {
    $ENV{PERL_STRICT} = 1;
}

use PerlX::Assert;
use Types::Standard -types;

use kote MyInt => Int & sub { $_ > 0 };

sub hoge($a, $b) {
    assert MyInt->check($a);
    assert MyInt->check($b);

    $a + $b;
}

say hoge(1, 2);
say hoge('hello', 'world');
