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


use My::DB;

my $q = My::DB->new($dbh);

$q->CreateAuthor({
    name => 'John Doe',
    bio => 'A mysterious',
});

my $authors = $q->ListAuthors();

use Data::Dumper;
warn Dumper $authors;

$q->DeleteAuthor($authors->[0]{id});

$authors = $q->ListAuthors();
warn Dumper $authors;

my $author = $q->GetAuthor($authors->[0]{id});
warn Dumper $author;
