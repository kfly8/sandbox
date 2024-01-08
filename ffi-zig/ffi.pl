use v5.38;
use FFI::Platypus;

my $ffi = FFI::Platypus->new;
$ffi->lib('./zig-out/lib/libffi-zig.dylib');

$ffi->attach( add => ['int', 'int'] => 'int' );

say add(1,2);
