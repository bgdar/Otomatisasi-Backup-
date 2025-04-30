const std = @import("std");
const builtin = @import("builtin");

pub const Status = enum {
    SedangMenyalin,
    Gagal,
    Sukses,
 };

///struct yag akan menghndle data dan path 
pub const  ManagementsBakup = struct{
    targetPath: []const u8,
    currentPath : []const u8,
    //status : Status,
   // deadLine : 

    pub fn onSave(this:ManagementsBakup,allocator:std.mem.Allocator) !void {

        var child = std.process.Child.init(
            &[_][]const u8{"cp","-r",this.currentPath,this.targetPath}
        ,allocator);

        child.stdout_behavior = .Inherit;
        child.stdin_behavior = .Inherit;
        child.stderr_behavior = .Inherit;

        try child.spawn();
        const result = try child.wait();
        
        if (result != .Exited or result.Exited != 0 ) {
            std.log.warn("procces gagal di jalankan {} \n", .{result} );
        }else {
            std.log.info("Proccess copy success {}\n", .{result});
        }
    }
    /// mengembalikan slice string targetPath apakah ada atau tidak jadi cukup panggil aja  
    pub fn cekPathTarget(this:ManagementsBakup,allocator:std.mem.Allocator) ![]const u8 {
        const cwd = std.fs.cwd();
        const exists = blk: { // gunakan untuk menangkap true | false  bukan void
            if (cwd.access(this.targetPath, .{})) |_| {
                break :blk true;
            } else |_| {
                break :blk false;
            }
        };
        // targetPath + 30 (adalah batas string yang di kirim ke buffer yang total sebenatnya 20)
        // coba hitung yang bagian else
        const bufferData  = try allocator.alloc(u8,this.targetPath.len + 30);
        const output = if (exists) blk: {
            break :blk try std.fmt.bufPrint(bufferData, "path {s} tersedia\n", .{this.targetPath}) ;          
        } else blk: {
            break :blk try std.fmt.bufPrint(bufferData, "path {s} tidak tersedia\n", .{this.targetPath}) ;
        };

   // std.log.debug("Data sebelum dikirim: {s}\n", .{output});
   

    return output;
    }
};
/// Mengambil input dari stdin dan mengembalikannya sebagai slice string.
/// Example: input "hlo" akan jadi ["h", "l", "o"]
pub fn input(allocator: std.mem.Allocator, prompt: []const u8) ![] const u8 {
    const stdin = std.io.getStdIn().reader();
    var buffer: [100]u8 = undefined;

    std.debug.print("{s}", .{prompt});
    const result = try stdin.readUntilDelimiter(&buffer, '\n');

    const cleanEnter = std.mem.trimRight(u8, result, "\r\n");

    // Salin ke memori heap agar bisa digunakan di luar fungsi
    var list = std.ArrayList(u8).init(allocator);

    try list.appendSlice(cleanEnter);
    return list.toOwnedSlice(); // slice heap-allocated (bisa dipakai lama)
}


