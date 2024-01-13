use v5.38;
use FFI::Platypus 2.00;
use FFI::CheckLib qw( find_lib_or_die );
use File::Basename qw( dirname );

my $ffi = FFI::Platypus->new( api => 2, lang => 'Zig' );
$ffi->lib(
  find_lib_or_die(
    lib        => 'add',
    libpath    => [dirname __FILE__],
    systempath => [],
  )
);

$ffi->attach( add => ['i32','i32'] => 'i32' );

say add(1,2);
