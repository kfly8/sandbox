use v5.38;
use Test2::V0;

sub larger_than($threshold) {
    return sub ($x) { $x > $threshold };
}

sub divisible_by($divisor) {
    return sub ($x) { $x % $divisor == 0 };
}

sub shorter_than($length) {
    return sub ($x) { length($x) < $length };
}

{
    my sub larger_than_10($x) { larger_than(10)->($x) };

    ok larger_than_10(11);
}
#ok larger_than_10(11);

done_testing;
