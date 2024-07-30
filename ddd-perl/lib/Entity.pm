use v5.40;
use utf8;
use experimental 'class';

package D::Entity {
    sub new ($class, $id, $value, $__typename) {
        bless [$id, $value, $__typename], $class;
    }

    sub id($self) { $self->[0] }
    sub __typename($self) { $self->[2] }
}
