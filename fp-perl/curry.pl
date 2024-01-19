use v5.38;
use Test2::V0;

sub larger_than($threshold) {
    sub ($x) { $x > $threshold };
}

sub divisible_by($divisor) {
    sub ($x) { $x % $divisor == 0 };
}

sub shorter_than($length) {
    sub ($x) { length($x) < $length };
}

{
    my sub larger_than_10($x) {
        state $f = larger_than(10); # $f is a closure
        $f->($x);
    }

    ok larger_than_10(11);
}
#ok larger_than_10(11);

done_testing;
