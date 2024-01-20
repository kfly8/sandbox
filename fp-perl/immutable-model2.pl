use v5.38;
use Test2::V0;
use lib 'lib';

use Types::Standard -types;

# TODO: What name is better than `hoge`??
use hoge Lang => Dict[
    name => Str,
    year => Optional[Int],
];

subtest 'Lang builds immutable hashref' => sub {
    my $perl = Lang(name => 'Perl', year => 1987);
    is $perl->{name}, 'Perl';
    is $perl, {
        name => 'Perl',
        year => 1987,
    };

    # check only when StrictMode is enabled
    ok dies { $perl->{aaaa}; };
    ok dies { $perl->{name} = 'Python'; };
    ok dies { Lang(year => '1982'); };

    # write to hashref
    my $perl7 = Lang(%$perl, name => 'Perl7');
    is $perl7->{name}, 'Perl7';
};

subtest 'Lang::type returns Type::Tiny object' => sub {
    isa_ok Lang::type, 'Type::Tiny';
    is Lang::type, 'Dict[name=>Str,year=>Optional[Int]]';
};

subtest 'Lang::inline_object builds inline object' => sub {
    my $perl = Lang::inline_object(name => 'Perl', year => 1987);
    is $perl->name, 'Perl';
    is $perl, object {
        prop blessed => 'hoge::Prototype';
        call name => 'Perl';
        call year => 1987;
    };

    is $perl->to_hash, {
        name => 'Perl',
        year => 1987,
    };
};

subtest 'Lang::inline_object_type returns Type::Tiny object' => sub {
    isa_ok Lang::inline_object_type, 'Type::Tiny';
    is Lang::inline_object_type, 'InstanceOf[hoge::Prototype] + Dict[name=>Str,year=>Optional[Int]]';
};

done_testing
