const std = @import("std");
const c = @cImport({
    @cInclude("zip.h");
});

pub fn main() !void {
    var files = [_][*c]const u8{ "sandbox/file.txt", "sandbox/ironlily.jpg" };
    _ = c.zip_create("archive.zip", files.items.ptr, 2);
}
