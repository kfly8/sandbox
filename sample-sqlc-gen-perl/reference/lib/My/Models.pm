package My::Models;
use strict;
use warnings;

use Types::Standard -types;

use kura Author => Dict[
  id => Int,
  name => Str,
  bio => Str,
];

1;
