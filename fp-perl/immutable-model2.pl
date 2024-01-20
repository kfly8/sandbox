use v5.38;
use Test2::V0;
use lib 'lib';

BEGIN {
    $ENV{PERL_STRICT} = 1;
}

use Types::Standard -types;

use hoge Lang => Dict[
    name => Str,
    year => Int,
];


my $perl = Lang(name => 'Perl', year => 1987);
my $ruby = Lang(name => 'Ruby', year => 1989);

is $perl->{name}, 'Perl';
is $ruby->{year}, 1989;

isa_ok Lang, 'Type::Tiny';
is Lang, 'Dict[name=>Str,year=>Int]';

subtest 'Exceptions' => sub {
    like dies {
        $perl->{nameee};
    }, qr/Attempt to access disallowed key 'nameee' in a restricted hash/;

    like dies {
        $perl->{name} = 'heello';
    }, qr/Modification of a read-only value attempted/;

    like dies {
        Lang(namee => 'Python', year => 1989);
    }, qr/Reference \{"namee" => "Python","year" => 1989\} did not pass type constraint/;
};

done_testing
