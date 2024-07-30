use v5.40;
use utf8;

use hoge MonsterName => sub {
    /\A[a-z]+\z/;
};

my $err;

(my $dragon, $err) = MonsterName->create('dragon');
if ($err) {
    die "Invalid monster name: $dragon";
}

say $dragon->value; # => 'dragon'
say $dragon->typename; # => 'MonsterName'

(my $goblin, $err) = MonsterName->create('goblin');
if ($err) {
   die "Invalid monster name: " . $err->message;
}
