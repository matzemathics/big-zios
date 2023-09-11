pub inline fn EFIERR(a: u64) u64 {
    return 0x8000000000000000 | a;
}

pub inline fn EFIWARN(a: u64) u64 {
    return a;
}

pub const Status = enum(u64) {
    success = 0,
    load_error = EFIERR(1),
    invalid_parameter = EFIERR(2),
    unsupported = EFIERR(3),
    bad_buffer_size = EFIERR(4),
    buffer_too_small = EFIERR(5),
    not_ready = EFIERR(6),
    device_error = EFIERR(7),
    write_protected = EFIERR(8),
    out_of_resources = EFIERR(9),
    volume_corrupted = EFIERR(10),
    volume_full = EFIERR(11),
    no_media = EFIERR(12),
    media_changed = EFIERR(13),
    not_found = EFIERR(14),
    access_denied = EFIERR(15),
    no_response = EFIERR(16),
    no_mapping = EFIERR(17),
    timeout = EFIERR(18),
    not_started = EFIERR(19),
    already_started = EFIERR(20),
    aborted = EFIERR(21),
    icmp_error = EFIERR(22),
    tftp_error = EFIERR(23),
    protocol_error = EFIERR(24),
    incompatible_version = EFIERR(25),
    security_violation = EFIERR(26),
    crc_error = EFIERR(27),
    end_of_media = EFIERR(28),
    end_of_file = EFIERR(31),
    invalid_language = EFIERR(32),
    compromised_data = EFIERR(33),

    warn_unknown_glyph = EFIWARN(1),
    warn_delete_failure = EFIWARN(2),
    warn_write_failure = EFIWARN(3),
    warn_buffer_too_small = EFIWARN(4),

    network_unreachable = EFIERR(100),
    host_unreachable = EFIERR(101),
    protocol_unreachable = EFIERR(102),
    port_unreachable = EFIERR(103),
    connection_fin = EFIERR(104),
    connection_reset = EFIERR(105),
    connection_refused = EFIERR(106),
};

pub const wchar16 = u16;
