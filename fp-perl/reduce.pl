use v5.38;
use Test2::V0;

use List::Util qw(reduce);

sub sum(@numbers) {
    reduce { $a + $b } 0, @numbers
    #                  ^ initial value
}

sub total_length(@words) {
    reduce { $a + length($b) } 0, @words;
    #                          ^ initial value
}

is sum(5,1,2,4,100), 112;
is sum(), 0;

is total_length('a', 'bb', 'ccc'), 6;
is total_length(), 0;

done_testing;
