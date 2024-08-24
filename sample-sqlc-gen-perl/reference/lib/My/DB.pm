package My::DB;
use strict;
use warnings;
use utf8;

our @EXPORT_OK;
push @EXPORT_OK => qw(
    CreateAuthor
    DeleteAuthor
    GetAuthor
    ListAuthors
);

use Carp;
use Syntax::Keyword::Assert;
use Types::Standard -types;

# Define Models
use kura Author => Dict[
  id => Int,
  name => Str,
  bio => Str,
];

# Define Queries
use constant createAuthor => q{-- name: CreateAuthor :exec
INSERT INTO authors (
  name, bio
) VALUES (
  ?, ?
)
};

use kura CreateAuthorParams => Dict[
    name => Str,
    bio => Str,
];

sub CreateAuthor {
    my ($dbh, $arg) = @_;
    assert { CreateAuthorParams->check($arg); };

    my $sth = $dbh->prepare(createAuthor);
    my @bind = ($arg->{name}, $arg->{bio});
    my $ret = $sth->execute(@bind) or croak $sth->errstr;
    return $ret;
}

use constant deleteAuthor => q{-- name: DeleteAuthor :exec
DELETE FROM authors
WHERE id = ?
};

sub DeleteAuthor {
    my ($dbh, $id) = @_;
    assert { Int->check($id) };

    my $sth = $dbh->prepare(deleteAuthor);
    my @bind = ($id);
    my $ret = $sth->execute(@bind) or croak $sth->errstr;
    return $ret;
}

use constant getAuthor => q{-- name: GetAuthor :one
SELECT id, name, bio FROM authors
WHERE id = ? LIMIT 1
};

sub GetAuthor {
    my ($dbh, $id) = @_;
    assert { Int->check($id) };

    my $sth = $dbh->prepare(getAuthor);
    my @bind = ($id);
    my $ret = $sth->execute(@bind) or croak $sth->errstr;

    my $row = $ret && $sth->fetchrow_hashref;
    return unless $row;

    assert { Author->check($row) };
    return $row;
}

use constant listAuthors => q{-- name: ListAuthors :many
SELECT id, name, bio FROM authors
ORDER BY name
};

sub ListAuthors {
    my ($dbh) = @_;

    my $sth = $dbh->prepare(listAuthors);
    my $ret = $sth->execute() or croak $sth->errstr;

    my $rows = $ret && $sth->fetchall_arrayref({});

    assert { (ArrayRef[Author])->check($rows) };
    return $rows;
}

1;
