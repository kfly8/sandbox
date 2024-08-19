package My::Models;
use strict;
use warnings;

use Types::Standard -types;

use kura Author => Dict[
  id => Str,
  name => Str,
  bio => Str,
];

1;
