use v5.40;
use utf8;

use MyError;
use ValueObject;

package Fuga {
    sub new ($class, $typename, $checker) {
        bless [$typename, $ckecker], $class;
    }

    sub typename($self) { $self->[0] }
    sub chcker($self) { $self->[1] }

    sub create($self, $value) {
        die "Must handle error" unless wantarray;
        my $r = {
            local $_ = $value;
            $self->checker->($value);
        };

        unless ($r) {
            return (undef, MyError->new(sprintf("Invalid value for %s: %s", $self->typename, $value)));
        }

        return (ValueObject->new($self->typename, $value), undef);
    }
}
