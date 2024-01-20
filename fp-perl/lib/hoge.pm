package hoge;
use v5.38;

use Data::Lock qw(dlock);
use Types::Standard -types;
use Type::Tie;
#use Devel::StrictMode;
use Carp qw(croak);

use constant STRICT => 1;

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

    my $code = $is_hash ? sub {
        my $data = { @_ };
        if (STRICT) {
            croak $type->get_message($data) unless $type->check($data);
            dlock $data;
        }
        return $data;
    } : $is_array ? sub {
        ...
    } : sub {
        ...
    };

    my $object = sub {
        my $result = $code->(@_);
        bless +{ %$result }, 'hoge::Prototype';
    };

    no strict qw(refs);
    *{"${target}::${func_name}"} = $code;
    *{"${target}::${func_name}::type"} = sub () { $type };
    *{"${target}::${func_name}::inline_object"} = $object;
    *{"${target}::${func_name}::inline_object_type"} = sub () {
        state $t = Type::Tiny->new(
            display_name => "InstanceOf[hoge::Prototype] + $type",
            constraint => sub {
                return unless (InstanceOf['hoge::Prototype'])->check($_);
                return unless $type->check(+{ %$_ });
                return 1;
            },
            get_message => sub {
                return "xxxx" unless InstanceOf['hoge::Prototype']->check($_);
                return "yyyy" unless $type->check(+{ %$_ });
                return;
            },
        );
        $t;
    };
}

package hoge::Prototype;

our $AUTOLOAD;
sub can {
    return $_[0]->{$_[1]} if Scalar::Util::blessed($_[0]);
    goto &UNIVERSAL::can;
}

sub to_hash {
    my $self = shift;
    +{ %$self };
}

sub AUTOLOAD {
    my $self = shift;
    my $attr = $AUTOLOAD;
    $attr =~ s/.*://;

    if (exists $self->{$attr}) {
        return $self->{$attr};
    }
    else {
        ...
    }
}

sub DESTROY { }

1;
