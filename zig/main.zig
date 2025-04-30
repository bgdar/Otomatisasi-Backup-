const std = @import("std");
const management = @import("managements.zig");

pub fn main() !void {
    std.debug.print("App bakup Otomtis\n\n",.{});

    var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    std.debug.print("masukan target Path \n", .{});
    const targetPath :[]const u8 = try management.input(allocator, "[+] ");
    std.debug.print("masukan current path yang akan di bekup\n", .{});
    const currentPath :[]const u8= try management.input(allocator, "[+]");
 
    std.debug.print("target path : {s} dan current path : {s}\n\n", .{targetPath,currentPath});

    const dataBakup = management.ManagementsBakup  { // iisialisasi struct {};
        .targetPath = targetPath,
        .currentPath = currentPath,
    };
    const hasilCekBakup = try dataBakup.cekPathTarget(allocator); 


    std.debug.print("hasil yang di dapat {s} \n\n", .{hasilCekBakup});

   try dataBakup.onSave(allocator);


    //memori yang sebelumnyamenggunakan ArenaAllocator akan otomatis di free saat arena.deinit() otomatis di akhir program
}
