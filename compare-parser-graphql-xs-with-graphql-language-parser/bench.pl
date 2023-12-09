use v5.38;

use Test2::V0;
use Benchmark qw(cmpthese);
use GraphQL::Language::Parser qw(parse);
use Data::Dumper;
use Parser::GraphQL::XS;
use JSON::XS qw(decode_json);

my $query = 'type Query { hello: String }';

my $parser = Parser::GraphQL::XS->new;

sub parse_xs($query) {
    my $r = $parser->parse_string($query);
    return decode_json($r);
}

my $r1 = parse_xs($query);
my $r2 = parse($query);

is $r1, $r2, 'same result';

note 'xs result';
note Dumper $r1;

note 'pp result';
note Dumper $r2;

done_testing;

cmpthese(
    -1,
    {
        'Parser::GraphQL::XS' => sub {
            parse_xs($query);
        },
        'GraphQL::Language::Parser' => sub {
            parse($query);
        },
    }
);
