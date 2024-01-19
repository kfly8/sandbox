use v5.38;
use Test2::V0;

use Object::Pad;

class ProgrammingLanguage {
    field $name :param :reader;
    field $year :param :reader;
}

my $perl = ProgrammingLanguage->new(name => 'Perl', year => 1987);
my $java = ProgrammingLanguage->new(name => 'Java', year => 1995);

is $perl->name, 'Perl';
is $perl->year, 1987;

is $java->name, 'Java';

done_testing;
