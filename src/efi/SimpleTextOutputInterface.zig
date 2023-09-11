pub const wchar16 = @import("defs.zig").wchar16;
pub const Status = @import("defs.zig").Status;
const SimpleTextOutputInterface = @This();

pub const TextReset = *const fn (*SimpleTextOutputInterface.Inner, extended_verification: bool) callconv(.C) Status;
pub fn reset(self: *const SimpleTextOutputInterface, extended_verification: bool) Status {
    return self.inner.Reset(self.inner, extended_verification);
}

pub const TextOutputString = *const fn (*SimpleTextOutputInterface.Inner, message: [*:0]const wchar16) callconv(.C) Status;
pub fn outputString(self: *const SimpleTextOutputInterface, str: [*:0]const wchar16) Status {
    return self.inner.OutputString(self.inner, str);
}

pub const TextTestString = *const fn (*SimpleTextOutputInterface.Inner, message: [*:0]const wchar16) callconv(.C) Status;
pub fn testString(self: *const SimpleTextOutputInterface, str: [*:0]const wchar16) Status {
    return self.inner.TestString(self.inner, str);
}

pub const TextQueryMode = *const fn (*SimpleTextOutputInterface.Inner, mode_number: u64, columns: ?*u64, rows: ?*u64) callconv(.C) Status;

pub const TextSetMode = *const fn (*SimpleTextOutputInterface.Inner, mode_number: u64) callconv(.C) Status;
pub fn setMode(self: *const SimpleTextOutputInterface, mode_number: u64) Status {
    return self.inner.SetMode(self.inner, mode_number);
}

pub const TextSetAttribute = *const fn (*SimpleTextOutputInterface.Inner, u64) callconv(.C) Status;

pub const TextClearScreen = *const fn (*SimpleTextOutputInterface.Inner) callconv(.C) Status;
pub fn clearScreen(self: *const SimpleTextOutputInterface) Status {
    return self.inner.ClearScreen(self.inner);
}

pub const TextSetCursorPosition = *const fn (*SimpleTextOutputInterface.Inner, column: u64, row: u64) callconv(.C) Status;

pub const TextEnableCursor = *const fn (*SimpleTextOutputInterface.Inner, bool) callconv(.C) Status;
pub fn enableCursor(self: *const SimpleTextOutputInterface, enable: bool) Status {
    return self.inner.EnableCursor(self.inner, enable);
}

pub const Mode = extern struct {
    MaxMode: i32,
    Mode: i32,
    Attribute: i32,
    CursorColumn: i32,
    CursorRow: i32,
    CursorVisible: bool,
};

pub const Inner = extern struct {
    Reset: TextReset,
    OutputString: TextOutputString,
    TestString: TextTestString,
    QueryMode: TextQueryMode,
    SetMode: TextSetMode,
    SetAttribute: TextSetAttribute,
    ClearScreen: TextClearScreen,
    SetCursorPosition: TextSetCursorPosition,
    EnableCursor: TextEnableCursor,
    Mode: *Mode,
};

inner: *Inner
