use v5.40;
use utf8;

package ValueObject {
    sub new ($class, $typename, $value) {
        bless [$typename, $value], $class;
    }

    sub typename($self) { $self->[0] }
    sub value($self) { $self->[1] }
    sub equals($self, $other) {
        $self->__typename eq $other->__typename
        && $self->value eq $other->value;
    }
}
