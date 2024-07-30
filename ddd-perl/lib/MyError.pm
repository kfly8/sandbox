use v5.40;
use utf8;

package MyError {
    sub new ($class, $message) {
        bless {
            message => $message,
        } => $class;
    }
    sub message($self) { $self->{message} }
}

