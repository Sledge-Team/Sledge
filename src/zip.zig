const c = @cImport({
    @cInclude("zip.h");
});

pub const ZipError = error{
    ENOINIT,
    EINVENTNAME,
    ENOENT,
    EINVMODE,
    EINVLVL,
    ENOSUP64,
    EMEMSET,
    EWRTENT,
    ETDEFLINIT,
    EINVIDX,
    ENOHDR,
    ETDEFLBUF,
    ECRTHDR,
    EWRTHDR,
    EWRTDIR,
    EOPNFILE,
    EINVENTTYPE,
    EMEMNOALLOC,
    ENOFILE,
    ENOPERM,
    EOOMEM,
    EINVZIPNAME,
    EMKDIR,
    ESYMLINK,
    ECLSZIP,
    ECAPSIZE,
    EFSEEK,
    EFREAD,
    EFWRITE,
    ERINIT,
    EWINIT,
    EWRINIT,
};

pub fn create(zipname: [:0]const u8, filenames: []const [*:0]const u8) ZipError!void {
    return getError(c.zip_create(zipname, @ptrCast(@constCast(filenames.ptr)), filenames.len)) orelse {};
}

pub fn extract(
    zipname: [:0]const u8,
    dir: [:0]const u8,
    on_extract_entry: ?*const fn ([*c]const u8, ?*anyopaque) callconv(.C) c_int,
    arg: ?*anyopaque,
) ZipError!void {
    return getError(c.zip_extract(zipname, dir, on_extract_entry, arg)) orelse {};
}

fn getError(code: c_int) ?ZipError {
    return switch (code) {
        -1 => error.ENOINIT,
        -2 => error.EINVENTNAME,
        -3 => error.ENOENT,
        -4 => error.EINVMODE,
        -5 => error.EINVLVL,
        -6 => error.ENOSUP64,
        -7 => error.EMEMSET,
        -8 => error.EWRTENT,
        -9 => error.ETDEFLINIT,
        -10 => error.EINVIDX,
        -11 => error.ENOHDR,
        -12 => error.ETDEFLBUF,
        -13 => error.ECRTHDR,
        -14 => error.EWRTHDR,
        -15 => error.EWRTDIR,
        -16 => error.EOPNFILE,
        -17 => error.EINVENTTYPE,
        -18 => error.EMEMNOALLOC,
        -19 => error.ENOFILE,
        -20 => error.ENOPERM,
        -21 => error.EOOMEM,
        -22 => error.EINVZIPNAME,
        -23 => error.EMKDIR,
        -24 => error.ESYMLINK,
        -25 => error.ECLSZIP,
        -26 => error.ECAPSIZE,
        -27 => error.EFSEEK,
        -28 => error.EFREAD,
        -29 => error.EFWRITE,
        -30 => error.ERINIT,
        -31 => error.EWINIT,
        -32 => error.EWRINIT,
        else => null,
    };
}
