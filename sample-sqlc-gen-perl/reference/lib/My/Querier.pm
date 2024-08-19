package My::Querier;
use strict;
use warnings;

our @EXPORT_OK;
push @EXPORT_OK => qw(CreateAuthor DeleteAuthor GetAuthor ListAuthors);

use Syntax::Keyword::Assert;
use Types::Standard -types;

use My::Models qw(Author);

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

sub CreateAuthor($db, $arg) {
    assert { CreateAuthorParams->check($arg); };

    my $err = $db->exec(createAuthor, $arg->{name}, $arg->{bio});
    return $err;
}

use constant deleteAuthor => q{-- name: DeleteAuthor :exec
DELETE FROM authors
WHERE id = ?
};

sub DeleteAuthor($db, $id) {
    my $err = $db->exec(deleteAuthor, $id);
    return $err;
}

use constant getAuthor => q{-- name: GetAuthor :one
SELECT id, name, bio FROM authors
WHERE id = ? LIMIT 1
};

sub GetAuthor($db, $id) {
    my $row = $db->select_row(getAuthor, $id);
    assert { Author->check($row) };
    return $row;
}

use constant listAuthors => q{-- name: ListAuthors :many
SELECT id, name, bio FROM authors
ORDER BY name
};

sub ListAuthors($db) {
    my $rows = $db->select_all(listAuthors);
    assert { (ArrayRef[Author])->check($rows) };
    return $rows;
}

1;
