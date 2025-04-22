const std = @import("std");


pub fn main() void {

    const data : []const u8 = "data string";
    std.debug.print("test {s}",.{data});


}
