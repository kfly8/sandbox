const std = @import("std");
const expect = @import("std").testing.expect;
const expectEqual = @import("std").testing.expectEqual;
const expectError = @import("std").testing.expectError;

test "if statement" {
    const a = true;
    const got = if (a) 1 else unreachable;
    try expectEqual(got, 1);
}

test "while" {
    var sum: u8 = 0;
    var i: u8 = 0;
    while (i < 10) : (i += 1) {
        sum += i;
    }
    try expect(sum == 45);
}

test "for" {
    const str = [_]u8{ 'a', 'b', 'c' };

    for (str, 0..) |char, i| {
        try expect(char == str[i]);
    }
}

fn addFive(x: u32) u32 {
    return x + 5;
}

test "function" {
    const y = addFive(3);
    try expectEqual(y, 8);
}

fn fib(n: u16) u16 {
    if (n == 0 or n == 1) return n;
    return fib(n - 1) + fib(n - 2);
}

test "function recursion" {
    const y = fib(10);
    try expectEqual(y, 55);
}

test "defer" {
    var x: i16 = 5;
    {
        defer x += 2;
        try expectEqual(x, 5);
    }
    try expectEqual(x, 7);
}

test "multi defer" {
    var x: f32 = 5;
    {
        defer x += 2;
        defer x /= 2;
    }
    // LIFO order
    try expectEqual(x, 4.5); // 5/2 + 2
}

// --------------------------------------
// Error
// --------------------------------------

const SomeError = error{
    Forbidden,
    NotFound,
};

fn doSomething() SomeError {
    return SomeError.Forbidden;
}

test "error" {
    const err: SomeError = doSomething();
    try expectEqual(err, SomeError.Forbidden);
}

fn doSomething2() SomeError!void {
    return SomeError.Forbidden;
}

test "error2" {
    doSomething2() catch |err| {
        try expectEqual(err, SomeError.Forbidden);
    };
}

// `try x` is a shortcut for `x catch |err| return err;`
fn failingFunction() error{Oops}!void {
    return error.Oops;
}

fn failFn() error{Oops}!i32 {
    try failingFunction();
    return 12;
}

test "try" {
    const v = failFn() catch |err| {
        try expectEqual(err, error.Oops);
        return;
    };
    try expectEqual(v, 12); // is never reached
}

var problems: u32 = 98;
fn failFnCounter() error{Oops}!void {
    errdefer problems += 1;
    try failingFunction();
}

test "errdefer" {
    failFnCounter() catch |err| {
        try expectEqual(err, error.Oops);
        try expectEqual(problems, 99);
        return;
    };
    unreachable;
}

const A = error{
    NotDir,
    PathNotFound,
};
const B = error{
    OutOfMemory,
    PathNotFound,
};
const C = B || A;

test "merged Error types" {
    try expectEqual(C.NotDir, A.NotDir);
    try expectEqual(C.PathNotFound, A.PathNotFound);
    try expectEqual(C.OutOfMemory, B.OutOfMemory);
    //std.debug.print("=== {s} ===\n", .{@typeName(C)});
}

// --------------------------------------
// Switch
// https://ziglearn.org/chapter-1/#switch
// --------------------------------------

fn switchExpression(x: i8) i8 {
    return switch (x) {
        -1...1 => {
            return -x;
        },
        10, 100 => @divExact(x, 10),
        else => x,
    };
}

test "switch expression" {
    try expectEqual(switchExpression(1), -1);
    try expectEqual(switchExpression(10), 1);
    try expectEqual(switchExpression(100), 10);
}

fn switchStatement(x: i8) i8 {
    var y = x;
    switch (x) {
        -1...1 => {
            y = -x;
        },
        10, 100 => {
            y = @divExact(x, 10);
        },
        else => {},
    }
    return y;
}

test "switch statement" {
    try expectEqual(switchStatement(1), -1);
    try expectEqual(switchStatement(10), 1);
    try expectEqual(switchStatement(100), 10);
}

// --------------------------------------
// Runtime Safety
// --------------------------------------

test "out of bounds" {
    @setRuntimeSafety(false);
    const a = [3]u8{ 1, 2, 3 };
    var index: u8 = 5;
    const b = a[index];
    _ = b;
}

// --------------------------------------
// unreachable
// --------------------------------------

test "unreachable" {
    const x: i32 = 2;
    const y: u32 = if (x == 2) 5 else unreachable;
    _ = y;
}

// --------------------------------------
// Pointers
// --------------------------------------
fn incr(num: *u8) void {
    num.* += 1;
}

test "pointers" {
    var x: u8 = 1;
    incr(&x);
    try expectEqual(x, 2);

    //const y: u8 = 1;
    // error: expected type '*u8', found '*const u8'
    // 型引数の型を揃えて、num.* += 1; をしようとしても、
    // error: cannot assign to constant
    //incr(&y);
    //try expectEqual(y, 2);
}

// --------------------------------------
// Slices
// --------------------------------------
fn total(values: []const u8) usize {
    var sum: usize = 0;
    for (values) |value| {
        sum += value;
    }
    return sum;
}

test "slices" {
    const values = [_]u8{ 1, 2, 3, 4, 5 };
    const slice = values[1..3];
    try expectEqual(total(slice), 5);
    try expectEqual(@TypeOf(slice), *const [2]u8);

    try expectEqual(total(values[0..]), 15); // values[n ..] slices from n to the end.
}

// --------------------------------------
// Enums
// --------------------------------------

const Direction = enum { north, south, east, west };

test "enum ordinal value" {
    try expectEqual(@intFromEnum(Direction.north), 0);
    try expectEqual(@intFromEnum(Direction.south), 1);
    try expectEqual(@intFromEnum(Direction.east), 2);
    try expectEqual(@intFromEnum(Direction.west), 3);
}

const Suit = enum {
    clubs,
    spades,
    diamonds,
    hearts,
    pub fn isClubs(self: Suit) bool {
        return self == Suit.clubs;
    }
};

test "enum method" {
    try expectEqual(Suit.clubs.isClubs(), true);
    try expectEqual(Suit.spades.isClubs(), false);
}

// --------------------------------------
// Structs
// --------------------------------------

const Vec3 = struct {
    x: f32,
    y: f32,
    z: f32 = 0.0,
    fn abs(self: Vec3) f32 {
        return @sqrt(self.x * self.x + self.y * self.y + self.z * self.z);
    }
};

test "struct usage" {
    const v = Vec3{
        .x = 1.0,
        .y = 2.0,
        .z = 3.0,
    };
    try expectEqual(v.x, 1.0); // pointer dereference を自力でする必要なし

    const w = Vec3{
        .x = 3.0,
        .y = 4.0,
    };
    try expectEqual(w.z, 0.0);

    try expectEqual(w.abs(), 5.0);
}

// --------------------------------------
// Unions
// --------------------------------------

const Result = union {
    case1: u8,
    case2: u8,
};

test "simple union" {
    const result = Result{ .case1 = 12 };
    try expectEqual(result.case1, 12);
    // try expectEqual(result.case2, 12); // error: access of union field 'case2' while field 'case1' is active
}

// --------------------------------------
// Integer Rules
// https://ziglearn.org/chapter-1/#integer-rules
// --------------------------------------

test "integer widening" {
    const a: u8 = 250;
    const b: u16 = a;
    try expectEqual(b, 250);
    try expectEqual(@TypeOf(a), u8);
    try expectEqual(@TypeOf(b), u16);
}

test "@intCast" {
    const x: u64 = 200;
    const y = @as(u8, @intCast(x));
    try expectEqual(@TypeOf(x), u64);
    try expectEqual(@TypeOf(y), u8);
}

test "overflow" {
    var a: u8 = 255;
    // a += 1; // panic: integer overflow
    a +%= 1; // overflowを許容する場合は、+= ではなく、+%= を使う
    try expectEqual(a, 0);
}

// --------------------------------------
// Floats
// --------------------------------------

// --------------------------------------
// Labelled Blocks
// --------------------------------------

test "Labelled blocks" {
    const count = uooo: {
        var sum: u32 = 0;
        var i: u32 = 0;
        while (i < 10) : (i += 1) {
            sum += i;
        }
        break :uooo sum;
    };
    try expectEqual(count, 45);
    try expectEqual(@TypeOf(count), u32);

    hoge: {
        std.debug.print("-- hoge -- \n", .{});
        break :hoge;
    }
}

// --------------------------------------
// Labels Loops
// --------------------------------------

// --------------------------------------
// Loops as expressions
// --------------------------------------

fn rangeHasNum(begin: usize, end: usize, number: usize) bool {
    var i = begin;
    return while (i < end) : (i += 1) {
        if (i == number) return true;
    } else {
        return false;
    };
}

test "while loop expression" {
    try expectEqual(rangeHasNum(0, 5, 3), true);
    try expectEqual(rangeHasNum(0, 5, 10), false); // else blockに入る
}

// --------------------------------------
// Optionals
// --------------------------------------

test "optional" {
    var found: ?usize = null;
    const data = [_]usize{ 1, 2, 3, 4, 5 };
    for (data, 0..) |value, i| {
        if (value == 100) {
            found = i;
            break;
        }
    }
    try expectEqual(found, null);
}

test "orelse unreachable" {
    const a: ?f32 = 5;
    const b = a orelse unreachable;
    const c = a.?;
    try expectEqual(b, c);
    try expectEqual(@TypeOf(a), ?f32);
    try expectEqual(@TypeOf(b), f32);
}

// --------------------------------------
// Comptime
// --------------------------------------

// comptimeを利用すれば、強制的に、コンパイル時に実行される

test "comptime block" {
    const x = comptime fib(10);
    try expectEqual(x, 55);

    const y = comptime block: {
        break :block fib(10);
    };
    try expectEqual(y, 55);
}

// --------------------------------------
// Payload Captures
// --------------------------------------

test "optional-if" {
    var maybe_num: ?usize = 10;
    if (maybe_num) |num| {
        try expect(@TypeOf(num) == usize);
        try expectEqual(num, 10);
    } else {
        unreachable;
    }
}

test "error union if" {
    var ent_num: error{UnknownEntity}!u32 = 5;
    if (ent_num) |num| {
        try expectEqual(num, 5);
        try expectEqual(@TypeOf(num), u32);
    } else |err| {
        try expectEqual(err, error.UnknownEntity);
        unreachable;
    }
}

test "while optional" {
    var i: ?u32 = 10;
    while (i) |num| : (i.? -= 1) {
        try expect(@TypeOf(num) == u32);
        if (num == 1) {
            i = null;
            break;
        }
    }
    try expect(i == null);
}

// --------------------------------------
// Anonymous Structs
// --------------------------------------
test "anonymous struct literal" {
    const Point = struct {
        x: f32,
        y: f32,
    };

    var v: Point = .{
        .x = 1.0,
        .y = 2.0,
    };
    try expectEqual(v.x, 1.0);
    try expectEqual(v.y, 2.0);
}
