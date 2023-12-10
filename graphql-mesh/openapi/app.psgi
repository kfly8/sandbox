use v5.38;
use utf8;

use Kossy;

my $books = [
    {
        id => '1',
        title => 'すごい本',
        author => 'すごい人',
        isbn => '978-4-8399-7275-0',
        publishedDate => '2017-02-25',
    },
    {
        id => '2',
        title => 'つよい本',
        author => 'つよい人',
        isbn => '978-4-8399-7275-1',
        publishedDate => '2017-02-26',
    },
];

get '/books' => sub {
    my ( $self, $c ) = @_;
    $c->render_json($books);
};

get '/books/:id' => sub {
    my ( $self, $c ) = @_;
    my $id = $c->args->{id};
    my $book = (grep { $_->{id} eq $id } @$books)[0];

    $c->halt(404) unless $book;
    $c->render_json($book);
};

__PACKAGE__->psgi;
