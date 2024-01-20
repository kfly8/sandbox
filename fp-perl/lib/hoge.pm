package hoge;
use v5.38;

use Data::Lock qw(dlock);
use Types::Standard -types;
use Type::Tie;
use Devel::StrictMode;
use Carp qw(croak);

sub import {
    my ($class, $func_name, $type) = @_;

    if (STRICT) {
        unless (Str->check($func_name)) {
            croak "first argument must be string";
        }

        unless ($type isa Type::Tiny) {
            croak "second argument must be Type::Tiny object";
        }
    }

    my $target = caller;
    my $is_hash = $type->is_a_type_of(HashRef);
    my $is_array = $type->is_a_type_of(ArrayRef);

    no strict qw(refs);
    *{"${target}::${func_name}"} = sub :prototype(;@) {
        return $type unless @_;

        if ($is_hash) {
            my %args = @_;
            if (STRICT) {
                croak $type->get_message(\%args) unless $type->check(\%args);
                dlock \%args;
            }
            return \%args;
        }
        elsif ($is_array) {
        }
        else {
        }
    };
}

1;
