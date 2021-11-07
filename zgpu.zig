//! WebGPU implementation based on Vulkan
const std = @import("std");
const builtin = @import("builtin");
const vk = @import("gen/vk.zig");

comptime {
    if (!builtin.link_libc) {
        @compileError("zgpu requires libc to be linked");
    }
}

pub const Instance = struct {};
