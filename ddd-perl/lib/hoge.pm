use v5.40;
use utf8;

use Carp ();
use Fuga;

package hoge {
    state %typenames;

    sub import($class, $typename, $checker) {
        my $caller = caller;
        if (exists $typenames{$typename}) {
            Carp::croak("Type name $typename is already defined");
        }
        $typenames{$typename} = 1;

        no strict 'refs';
        *{"${caller}::${typename}"} = sub () {
            state $fuga = Fuga->new($typename, $checker);
            $fuga;
        }
    }
}
