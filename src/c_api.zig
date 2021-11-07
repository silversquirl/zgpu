//! Implementation of webgpu.h based on zgpu
const std = @import("std");
const zgpu = @import("zgpu.zig");
const vk = @import("vk.zig");

const c = @cImport({
    @cInclude("zgpu.h");
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

export fn wgpuInstanceDestroy(self: *zgpu.Instance) void {
    self.deinit();
    allocator.destroy(self);
}

export fn wgpuInstanceRequestAdapter(
    self: *zgpu.Instance,
    opts: *const c.WGPURequestAdapterOptions,
    callback: c.WGPURequestAdapterCallback,
    userdata: *c_void,
) void {
    if (instanceRequestAdapterInternal(self, opts)) |adapter| {
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
fn instanceRequestAdapterInternal(
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

export fn wgpuAdapterDestroy(self: *zgpu.Adapter) void {
    allocator.destroy(self);
}

export fn wgpuAdapterRequestDevice(
    self: *zgpu.Adapter,
    opts: *const c.WGPUDeviceDescriptor,
    callback: c.WGPURequestDeviceCallback,
    userdata: *c_void,
) void {
    if (adapterRequestDeviceInternal(self, opts)) |device| {
        callback.?(
            c.WGPURequestDeviceStatus_Success,
            @ptrCast(c.WGPUDevice, device),
            null,
            userdata,
        );
    } else |err| {
        callback.?(
            c.WGPURequestAdapterStatus_Error,
            null,
            @errorName(err),
            userdata,
        );
    }
}
fn adapterRequestDeviceInternal(
    self: *zgpu.Adapter,
    opts: *const c.WGPUDeviceDescriptor,
) !*zgpu.Device {
    const device = try allocator.create(zgpu.Device);
    errdefer allocator.destroy(device);
    device.* = try zgpu.Device.init(self, .{
        .required_limits = convertLimits(opts.requiredLimits.*.limits),
    });
    return device;
}
fn convertLimits(wlimits: c.WGPULimits) zgpu.Limits {
    var limits: zgpu.Limits = undefined;
    const wnames = comptime std.meta.fieldNames(c.WGPULimits);
    const names = comptime std.meta.fieldNames(zgpu.Limits);
    comptime std.debug.assert(names.len == wnames.len);
    inline for (names) |name, i| {
        @field(limits, name) = @field(wlimits, wnames[i]);
    }
    return limits;
}

export fn wgpuDeviceDestroy(self: *zgpu.Device) void {
    self.deinit();
    allocator.destroy(self);
}
