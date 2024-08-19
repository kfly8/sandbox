package My::Querier;
use strict;
use warnings;

our @EXPORT_OK;
push @EXPORT_OK => qw(CreateAuthor DeleteAuthor GetAuthor ListAuthors);

use SQLC qw(__exec __one __many);
use SQLC::Types qw(ArrayRef Dict String Text);
use SQLC::Assert qw(assert);

use My::Models qw(Author);

use constant createAuthor => q{-- name: CreateAuthor :exec
INSERT INTO authors (
  name, bio
) VALUES (
  ?, ?
)
};

use kura CreateAuthorParams => Dict[
    name => String,
    bio => Text,
];

sub CreateAuthor {
    my ($dbh, $arg) = @_;

    assert { CreateAuthorParams->check($arg); };
    my $err = __exec($dbh, createAuthor, $arg->{name}, $arg->{bio});
    return $err;
}

use constant deleteAuthor => q{-- name: DeleteAuthor :exec
DELETE FROM authors
WHERE id = ?
};

sub DeleteAuthor {
    my ($dbh, $id) = @_;

    assert { Int->check($id) };
    my $err = __exec($dbh, deleteAuthor, $id);
    return $err;
}

use constant getAuthor => q{-- name: GetAuthor :one
SELECT id, name, bio FROM authors
WHERE id = ? LIMIT 1
};

sub GetAuthor {
    my ($dbh, $id) = @_;

    assert { Int->check($id) };
    my $row = __one($dbh, getAuthor, $id);
    assert { Author->check($row) };
    return $row;
}

use constant listAuthors => q{-- name: ListAuthors :many
SELECT id, name, bio FROM authors
ORDER BY name
};

sub ListAuthors {
    my ($dbh) = @_;

    my $rows = __many($dbh, listAuthors);
    assert { (ArrayRef[Author])->check($rows) };
    return $rows;
}

1;
