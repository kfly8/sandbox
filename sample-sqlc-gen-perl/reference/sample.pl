use v5.40;
use lib './lib';

use DBI;
my $dbh = DBI->connect('dbi:SQLite:dbname=sample.db', '', '', {
    RaiseError => 1,
    PrintError => 0,
    AutoCommit => 1,
});

# $dbh->do(q{
# CREATE TABLE authors (
#   id   INTEGER PRIMARY KEY AUTOINCREMENT,
#   name TEXT NOT NULL,
#   bio  TEXT
# )
# });


use My::DB qw(
    CreateAuthor
    ListAuthors
);

CreateAuthor($dbh, {
    name => 'John Doe',
    bio => 'A mysterious',
});

my $authors = ListAuthors($dbh);

use Data::Dumper;
warn Dumper $authors;
