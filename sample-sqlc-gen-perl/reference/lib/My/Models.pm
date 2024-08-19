package My::Models;
use strict;
use warnings;

use SQLC::Types qw(Dict String Int Text);

use kura Author => Dict[
  id => Int,
  name => String,
  bio => Text,
];

1;
