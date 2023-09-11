const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const target = std.zig.CrossTarget.parse(.{ .arch_os_abi = "x86_64-uefi-gnu" }) catch unreachable;

    const main_exe = b.addExecutable(.{
        .root_source_file = .{ .path = "src/main.zig" },
        .main_pkg_path = .{ .path = "src" },
        .target = target,
        .optimize = .ReleaseSmall,
        .name = "bootx64",
        .use_lld = true,
        .link_libc = false,
    });
    main_exe.stack_protector = false;
    main_exe.red_zone = false;
    main_exe.subsystem = .EfiApplication;

    b.installArtifact(main_exe);

    const img_path = b.fmt("{s}/fat.img", .{b.exe_dir});

    const blank_img = b.addSystemCommand(&[_][]const u8{
        "dd",
        "if=/dev/zero",
        b.fmt("of={s}", .{img_path}),
        "bs=1k",
        "count=1440",
    });
    blank_img.step.dependOn(&main_exe.step);

    const format_img = b.addSystemCommand(&[_][]const u8{ "mformat", "-i", img_path, "-f", "1440", "::" });
    format_img.step.dependOn(&blank_img.step);

    const mkdir_img = b.addSystemCommand(&[_][]const u8{ "mmd", "-i", img_path, "::/EFI", "::/EFI/BOOT" });
    mkdir_img.step.dependOn(&format_img.step);

    const copy_to_img = b.addSystemCommand(&[_][]const u8{ "mcopy", "-i", img_path, "-D", "o" });
    copy_to_img.addFileArg(main_exe.getEmittedBin());
    copy_to_img.addArg("::/EFI/BOOT");
    copy_to_img.step.dependOn(&mkdir_img.step);

    const img_step = b.step("img", "Build a FAT image");
    img_step.dependOn(&copy_to_img.step);
    b.default_step.dependOn(img_step);

    const run_qemu = b.addSystemCommand(&[_][]const u8{
        "qemu-system-x86_64",
        "-bios",
        "/usr/share/ovmf/x64/OVMF.fd",
        "-drive",
        b.fmt("format=raw,file={s}", .{img_path}),
    });
    run_qemu.step.dependOn(img_step);

    const run_step = b.step("run", "run the image in qemu");
    run_step.dependOn(&run_qemu.step);
}
