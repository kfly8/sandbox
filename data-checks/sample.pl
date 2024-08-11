use v5.40;
use Test2::V0;

#use Types::Standard qw(Str Num);
use Data::Checks qw(Str Num);
use Syntax::Operator::Is;
use PerlX::Assert;

ok "foo" is Str;
ok 123 is Str;
ok 123 is Num;

assert { 'hello' is Str };
assert { {} is Str };

pass;

done_testing;
