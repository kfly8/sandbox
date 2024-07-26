use v5.40;
use Data::Dumper;

## This is a simple function that adds two numbersand returns the result.
## - hello
## - world
sub add($x, $y) {
    return $x + $y;
}

say add(1, 2); # 3

say Dumper(\&add);
