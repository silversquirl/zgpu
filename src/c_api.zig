//! Implementation of webgpu.h based on zgpu
const std = @import("std");
const zgpu = @import("zgpu.zig");
const vk = @import("vk.zig");

const c = @cImport({
    @cInclude("webgpu.h");
});

const allocator = std.heap.c_allocator;

export fn wgpuCreateInstance(desc: *const c.WGPUInstanceDescriptor) ?*zgpu.Instance {
    _ = desc; // TODO: exension types to allow changing name etc
    const self = allocator.create(zgpu.Instance) catch return null;
    self.* = zgpu.Instance.init(allocator, .{}) catch {
        allocator.destroy(self);
        return null;
    };
    return self;
}

export fn wgpuInstanceRequestAdapter(
    self: *zgpu.Instance,
    opts: *const c.WGPURequestAdapterOptions,
    callback: c.WGPURequestAdapterCallback,
    userdata: *c_void,
) void {
    if (wgpuInstanceRequestAdapterInternal(self, opts)) |adapter| {
        callback.?(
            c.WGPURequestAdapterStatus_Success,
            @ptrCast(c.WGPUAdapter, adapter),
            null,
            userdata,
        );
    } else |err| {
        callback.?(
            switch (err) {
                error.AdapterUnavailable => c.WGPURequestAdapterStatus_Unavailable,
                else => c.WGPURequestAdapterStatus_Error,
            },
            null,
            @errorName(err),
            userdata,
        );
    }
}
fn wgpuInstanceRequestAdapterInternal(
    self: *zgpu.Instance,
    opts: *const c.WGPURequestAdapterOptions,
) !*zgpu.Adapter {
    const adapter = try allocator.create(zgpu.Adapter);
    errdefer allocator.destroy(adapter);
    adapter.* = try zgpu.Adapter.init(self, .{
        .compatible_surface = @ptrCast(*zgpu.Surface, opts.compatibleSurface).*,
        .power_preference = @intToEnum(zgpu.Adapter.PowerPreference, opts.powerPreference),
        .force_fallback_adapter = opts.forceFallbackAdapter,
    });
    return adapter;
}
