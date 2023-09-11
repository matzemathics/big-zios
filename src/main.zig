const std = @import("std");
const lstr = std.unicode.utf8ToUtf16LeStringLiteral;
const efi = @import("efi/efi.zig");

pub export fn EfiMain(image_handle: *void, st: *efi.SystemTable) callconv(.C) efi.Status {
    _ = image_handle;

    _ = st.conOut().clearScreen();
    _ = st.conOut().outputString(lstr("Hello from Zig (again)"));
    _ = st.ConIn.Reset(st.ConIn, false);

    var status = efi.Status.not_ready;
    var key: efi.InputKey = undefined;

    while (status == efi.Status.not_ready) {
        status = st.ConIn.ReadKeyStroke(st.ConIn, &key);
    }

    return status;
}
