package My::DB;
use strict;
use warnings;
use utf8;

use Carp;
use Syntax::Keyword::Assert;
use Types::Standard -types;

sub new {
    my ($class, $dbh) = @_;
    assert { (InstanceOf['DBI::db'])->check($dbh) };
    bless [$dbh], $class;
}

sub dbh { $_[0][0] }

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
    my ($self, $arg) = @_;
    assert { CreateAuthorParams->check($arg) };

    my $sth = $self->dbh->prepare(createAuthor);
    my @bind = ($arg->{name}, $arg->{bio});
    my $ret = $sth->execute(@bind) or croak $sth->errstr;
    return $ret;
}

use constant deleteAuthor => q{-- name: DeleteAuthor :exec
DELETE FROM authors
WHERE id = ?
};

sub DeleteAuthor {
    my ($self, $id) = @_;
    assert { Int->check($id) };

    my $sth = $self->dbh->prepare(deleteAuthor);
    my @bind = ($id);
    my $ret = $sth->execute(@bind) or croak $sth->errstr;
    return $ret;
}

use constant getAuthor => q{-- name: GetAuthor :one
SELECT id, name, bio FROM authors
WHERE id = ? LIMIT 1
};

sub GetAuthor {
    my ($self, $id) = @_;
    assert { Int->check($id) };

    my $sth = $self->dbh->prepare(getAuthor);
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
    my ($self) = @_;

    my $sth = $self->dbh->prepare(listAuthors);
    my $ret = $sth->execute() or croak $sth->errstr;

    my $rows = $ret && $sth->fetchall_arrayref({});

    assert { (ArrayRef[Author])->check($rows) };
    return $rows;
}

use constant countAuthors => q{-- name: CountAuthors :one
SELECT count(*) FROM authors
};

sub CountAuthors {
    my ($self) = @_;

    my $sth = $self->dbh->prepare(countAuthors);
    my $ret = $sth->execute() or croak $sth->errstr;

    my $row = $ret && $sth->fetchrow_arrayref;
    return unless $row;

    assert { Int->check($row->[0]) };
    return $row->[0];
}

use constant countAuthorsByName => q{-- name: CountAuthorsByName :many
SELECT name , count(*) AS count FROM authors
GROUP BY name
ORDER BY count
};

use kura CountAuthorsByNameRow => Dict[
    name => Str,
    count => Int,
];

sub CountAuthorsByName {
    my ($self) = @_;

    my $sth = $self->dbh->prepare(countAuthorsByName);
    my $ret = $sth->execute() or croak $sth->errstr;

    my $rows = $ret && $sth->fetchall_arrayref({});

    assert { (ArrayRef[CountAuthorsByNameRow])->check($rows) };
    return $rows;
}

1;
