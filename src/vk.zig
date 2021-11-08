const std = @import("std");
const builtin = @import("builtin");
const log = std.log.scoped(.zgpu);

const vk = @import("gen/vk.zig");
pub usingnamespace vk;
pub const allocator = @import("vk_allocator.zig");

pub const BaseDispatch = vk.BaseWrapper(.{
    .CreateInstance,
    .EnumerateInstanceLayerProperties,
    .GetInstanceProcAddr,
});

pub const InstanceDispatch = vk.InstanceWrapper(.{
    .CreateDevice,
    .DestroyInstance,
    .EnumeratePhysicalDevices,
    .GetDeviceProcAddr,
    .GetPhysicalDeviceProperties,
    .GetPhysicalDeviceQueueFamilyProperties,
});

pub const DeviceDispatch = vk.DeviceWrapper(.{
    .CreateShaderModule,
    .DestroyDevice,
});

// Simple loader for base Vulkan functions
pub threadlocal var loader = Loader{};
pub const Loader = struct {
    ref_count: usize = 0,
    lib: ?std.DynLib = null,
    getProcAddress: vk.PfnGetInstanceProcAddr = undefined,

    pub fn ref(self: *Loader) !void {
        if (self.lib != null) {
            self.ref_count += 1;
            return;
        }

        const lib_name = switch (builtin.os.tag) {
            .windows => "vulkan-1.dll",
            else => "libvulkan.so.1",
            .macos => @compileError("Unsupported platform: " ++ @tagName(builtin.os)),
        };
        if (!builtin.link_libc) {
            @compileError("zcompute requires libc to be linked");
        }

        self.lib = std.DynLib.open(lib_name) catch |err| {
            log.err("Could not load vulkan library '{s}': {s}", .{ lib_name, @errorName(err) });
            return err;
        };
        errdefer self.lib.?.close();

        self.getProcAddress = self.lib.?.lookup(
            vk.PfnGetInstanceProcAddr,
            "vkGetInstanceProcAddr",
        ) orelse {
            log.err("Vulkan loader does not export vkGetInstanceProcAddr", .{});
            return error.MissingSymbol;
        };
    }

    pub fn deref(self: *Loader) void {
        if (self.ref_count > 0) {
            self.ref_count -= 1;
            return;
        }

        self.lib.?.close();
        self.lib = null;
        self.getProcAddress = undefined;
    }
};
