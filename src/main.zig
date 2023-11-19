const std = @import("std");
const zip = @import("zip.zig");

pub fn main() !void {
    try zip.create("archive.zip", &[_][*:0]const u8{ "sandbox/file.txt", "sandbox/ironlily.jpg" });
    try zip.extract("archive.zip", "output", null, null);
}
