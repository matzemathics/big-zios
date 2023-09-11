pub const wchar16 = @import("defs.zig").wchar16;
pub const Status = @import("defs.zig").Status;
pub const SimpleTextOutputInterface = @import("SimpleTextOutputInterface.zig");

pub const TableHeader = extern struct {
    Signature: u64,
    Revision: u32,
    HeaderSize: u32,
    CRC32: u32,
    Reserved: u32,
};

pub const InputKey = extern struct {
    ScanCode: u16,
    UnicodeChar: wchar16,
};

pub const SimpleInputInterface = extern struct {
    pub const InputReset = *const fn (*SimpleInputInterface, bool) callconv(.C) Status;
    pub const InputReadKey = *const fn (*SimpleInputInterface, ?*InputKey) callconv(.C) Status;
    Reset: InputReset,
    ReadKeyStroke: InputReadKey,
    WaitForKey: ?*void,
};

pub const SystemTable = extern struct {
    pub fn conOut(self: *SystemTable) SimpleTextOutputInterface {
        return (SimpleTextOutputInterface){ .inner = self.ConOut };
    }

    Hdr: TableHeader,
    FirmwareVendor: [*c]wchar16,
    FirmwareRevision: u32,
    ConsoleInHandle: ?*void,
    ConIn: *SimpleInputInterface,
    ConsoleOutHandle: ?*void,
    ConOut: *SimpleTextOutputInterface.Inner,
    StandardErrorHandle: ?*void,
    StdErr: *SimpleTextOutputInterface.Inner,
    RuntimeServices: *void, // [*c]EFI_RUNTIME_SERVICES,
    BootServices: *void, // [*c]EFI_BOOT_SERVICES,
    NumberOfTableEntries: u64,
    ConfigurationTable: *void, // [*c]EFI_CONFIGURATION_TABLE,
};
