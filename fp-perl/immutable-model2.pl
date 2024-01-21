use v5.38;
use Test2::V0;
use lib 'lib';

use Types::Standard -types;
use Type::Utils qw(compile_match_on_type);

use caseval Manga => Dict[
    title => Str,
    author => Str,
];

use caseval Magazine => Dict[
    title => Str,
    year => Int,
];

subtest 'Manga, Magazine isa Type::Tiny' => sub {
    is Manga, object {
        prop blessed => 'Type::Tiny';
        call display_name => 'Dict[author=>Str,title=>Str]';
    };

    is Magazine, object {
        prop blessed => 'Type::Tiny';
        call display_name => 'Dict[title=>Str,year=>Int]';
    };
};

subtest 'Manga::val, Magazine::val build immutable hashrefs' => sub {
    my $naruto = Manga::val(title => 'Naruto', author => 'Masashi Kishimoto');
    is $naruto, {
        title => 'Naruto',
        author => 'Masashi Kishimoto',
    };

    my $jump = Magazine::val(title => 'Weekly Shonen Jump', year => 1968);
    is $jump, {
        title => 'Weekly Shonen Jump',
        year => 1968,
    };

    # When StrictMode is enabled, the following code will die.
    ok dies { $naruto->{aaaa}; };
    ok dies { $jump->{title} = 'Sunday'; };
    ok dies { Manga::val(title => '...'); };

    # Modify hashref
    my $boruto = Manga::val(%$naruto, title => 'Boruto');
    is $boruto->{title}, 'Boruto';
};

subtest 'Pattern Match' => sub {

    my sub hello($pub) {
        my $code = compile_match_on_type(
            Manga, sub {
                my $manga = shift;
                return "Hello, $manga->{title} by $manga->{author}";
            },
            Magazine, sub {
                my $magazine = shift;
                return "Hello, $magazine->{title} ($magazine->{year})";
            },
        );
        $code->($pub);
    }

    is hello(Manga::val(title => 'Hunter x Hunter', author => 'Yoshihiro Togashi')),
        'Hello, Hunter x Hunter by Yoshihiro Togashi';

    is hello(Magazine::val(title => 'Time', year => 1923)),
        'Hello, Time (1923)';
};

done_testing
