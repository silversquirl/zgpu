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

export fn wgpuInstanceCreateSurface(
    instance: *zgpu.Instance,
    desc: *const c.WGPUSurfaceDescriptor,
) ?*zgpu.Surface {
    const chain = desc.nextInChain orelse return null;
    switch (chain.*.sType) {
        c.WGPUSType_SurfaceDescriptorFromGlfwWindow => {
            const opts = @fieldParentPtr(c.WGPUSurfaceDescriptorFromGlfwWindow, "chain", chain);
            const self = allocator.create(zgpu.Surface) catch return null;
            self.* = zgpu.Surface.initGlfw(instance, opts.glfwWindow) catch {
                allocator.destroy(self);
                return null;
            };
            return self;
        },
        else => unreachable,
    }
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
        .compatible_surface = convertPointer(*zgpu.Surface, opts.compatibleSurface).*,
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

export fn wgpuDeviceDestroy(self: *zgpu.Device) void {
    self.deinit();
    allocator.destroy(self);
}

export fn wgpuDeviceCreatePipelineLayout(
    self: *zgpu.Device,
    opts: *const c.WGPUPipelineLayoutDescriptor,
) ?*zgpu.PipelineLayout {
    return deviceCreatePipelineInternal(self, opts) catch null;
}
fn deviceCreatePipelineInternal(
    self: *zgpu.Device,
    opts: *const c.WGPUPipelineLayoutDescriptor,
) !*zgpu.PipelineLayout {
    const layouts = try allocator.alloc(zgpu.BindGroupLayout, opts.bindGroupLayoutCount);
    defer allocator.free(layouts);
    for (opts.bindGroupLayouts[0..opts.bindGroupLayoutCount]) |layout, i| {
        layouts[i] = convertPointer(*zgpu.BindGroupLayout, layout).*;
    }

    const layout = try allocator.create(zgpu.PipelineLayout);
    layout.* = try zgpu.PipelineLayout.init(self, layouts);
    return layout;
}

export fn wgpuDeviceCreateShaderModule(
    self: *zgpu.Device,
    desc: *const c.WGPUShaderModuleDescriptor,
) ?*zgpu.ShaderModule {
    const chain = desc.nextInChain orelse return null;
    switch (chain.*.sType) {
        c.WGPUSType_ShaderModuleSPIRVDescriptor => {
            const opts = @fieldParentPtr(c.WGPUShaderModuleSPIRVDescriptor, "chain", chain);
            const shad = allocator.create(zgpu.ShaderModule) catch return null;
            shad.* = zgpu.ShaderModule.initSpirv(self, opts.code[0..opts.codeSize]) catch {
                allocator.destroy(shad);
                return null;
            };
            return shad;
        },
        else => unreachable,
    }
}

export fn wgpuPipelineLayoutDestroy(self: *zgpu.PipelineLayout) void {
    self.deinit();
    allocator.destroy(self);
}

export fn wgpuShaderModuleDestroy(self: *zgpu.ShaderModule) void {
    self.deinit();
    allocator.destroy(self);
}

export fn wgpuSurfaceDestroy(self: *zgpu.Surface) void {
    self.deinit();
    allocator.destroy(self);
}

export fn wgpuSurfaceGetPreferredFormat(self: *zgpu.Surface, adapter: *zgpu.Adapter) c.WGPUTextureFormat {
    const format = self.getPreferredFormat(adapter.*) catch .@"undefined";
    return textureFormatConverter.zig2C(format);
}

//// Internal functions for conversions to and from Zig types

/// Casts both pointer type and alignment
fn convertPointer(comptime Ptr: type, value: anytype) Ptr {
    return @ptrCast(Ptr, @alignCast(@alignOf(Ptr), value));
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

const textureFormatConverter = EnumConverter(
    zgpu.TextureFormat,
    c.WGPUTextureFormat,
    c.WGPUTextureFormat_Undefined,
    .{
        // 8-bit formats
        .r8_unorm = c.WGPUTextureFormat_R8Unorm,
        .r8_snorm = c.WGPUTextureFormat_R8Snorm,
        .r8_uint = c.WGPUTextureFormat_R8Uint,
        .r8_sint = c.WGPUTextureFormat_R8Sint,

        // 16-bit formats
        .r16_uint = c.WGPUTextureFormat_R16Uint,
        .r16_sint = c.WGPUTextureFormat_R16Sint,
        .r16_sfloat = c.WGPUTextureFormat_R16Float,
        .r8g8_unorm = c.WGPUTextureFormat_RG8Unorm,
        .r8g8_snorm = c.WGPUTextureFormat_RG8Snorm,
        .r8g8_uint = c.WGPUTextureFormat_RG8Uint,
        .r8g8_sint = c.WGPUTextureFormat_RG8Sint,

        // 32-bit formats
        .r32_sfloat = c.WGPUTextureFormat_R32Float,
        .r32_uint = c.WGPUTextureFormat_R32Uint,
        .r32_sint = c.WGPUTextureFormat_R32Sint,
        .r16g16_uint = c.WGPUTextureFormat_RG16Uint,
        .r16g16_sint = c.WGPUTextureFormat_RG16Sint,
        .r16g16_sfloat = c.WGPUTextureFormat_RG16Float,
        .r8g8b8a8_unorm = c.WGPUTextureFormat_RGBA8Unorm,
        .r8g8b8a8_srgb = c.WGPUTextureFormat_RGBA8UnormSrgb,
        .r8g8b8a8_snorm = c.WGPUTextureFormat_RGBA8Snorm,
        .r8g8b8a8_uint = c.WGPUTextureFormat_RGBA8Uint,
        .r8g8b8a8_sint = c.WGPUTextureFormat_RGBA8Sint,
        .b8g8r8a8_unorm = c.WGPUTextureFormat_BGRA8Unorm,
        .b8g8r8a8_srgb = c.WGPUTextureFormat_BGRA8UnormSrgb,
        .a2b10g10r10_unorm_pack32 = c.WGPUTextureFormat_RGB10A2Unorm,
        .b10g11r11_ufloat_pack32 = c.WGPUTextureFormat_RG11B10Ufloat,
        .e5b9g9r9_ufloat_pack32 = c.WGPUTextureFormat_RGB9E5Ufloat,

        // 64-bit formats
        .r32g32_sfloat = c.WGPUTextureFormat_RG32Float,
        .r32g32_uint = c.WGPUTextureFormat_RG32Uint,
        .r32g32_sint = c.WGPUTextureFormat_RG32Sint,
        .r16g16b16a16_uint = c.WGPUTextureFormat_RGBA16Uint,
        .r16g16b16a16_sint = c.WGPUTextureFormat_RGBA16Sint,
        .r16g16b16a16_sfloat = c.WGPUTextureFormat_RGBA16Float,

        // 128-bit formats
        .r32g32b32a32_sfloat = c.WGPUTextureFormat_RGBA32Float,
        .r32g32b32a32_uint = c.WGPUTextureFormat_RGBA32Uint,
        .r32g32b32a32_sint = c.WGPUTextureFormat_RGBA32Sint,

        // Depth and stencil formats
        .s8_uint = c.WGPUTextureFormat_Stencil8,
        .d16_unorm = c.WGPUTextureFormat_Depth16Unorm,
        .x8_d24_unorm_pack32 = c.WGPUTextureFormat_Depth24Plus,
        .d24_unorm_s8_uint = c.WGPUTextureFormat_Depth24PlusStencil8,
        .d32_sfloat = c.WGPUTextureFormat_Depth32Float,

        // BC compressed formats
        .bc1_rgba_unorm_block = c.WGPUTextureFormat_BC1RGBAUnorm,
        .bc1_rgba_srgb_block = c.WGPUTextureFormat_BC1RGBAUnormSrgb,
        .bc2_unorm_block = c.WGPUTextureFormat_BC2RGBAUnorm,
        .bc2_srgb_block = c.WGPUTextureFormat_BC2RGBAUnormSrgb,
        .bc3_unorm_block = c.WGPUTextureFormat_BC3RGBAUnorm,
        .bc3_srgb_block = c.WGPUTextureFormat_BC3RGBAUnormSrgb,
        .bc4_unorm_block = c.WGPUTextureFormat_BC4RUnorm,
        .bc4_snorm_block = c.WGPUTextureFormat_BC4RSnorm,
        .bc5_unorm_block = c.WGPUTextureFormat_BC5RGUnorm,
        .bc5_snorm_block = c.WGPUTextureFormat_BC5RGSnorm,
        .bc6h_ufloat_block = c.WGPUTextureFormat_BC6HRGBUfloat,
        .bc6h_sfloat_block = c.WGPUTextureFormat_BC6HRGBFloat,
        .bc7_unorm_block = c.WGPUTextureFormat_BC7RGBAUnorm,
        .bc7_srgb_block = c.WGPUTextureFormat_BC7RGBAUnormSrgb,
    },
);

fn EnumConverter(
    comptime Z: type,
    comptime C: type,
    comptime default: C,
    comptime values: std.enums.EnumFieldStruct(Z, C, default),
) type {
    return struct {
        const Self = @This();
        const zig_names = std.meta.fieldNames(@TypeOf(values));

        pub fn zig2C(v: Z) C {
            inline for (zig_names) |name| {
                if (v == @field(Z, name)) {
                    return @field(values, name);
                }
            }
            unreachable;
        }

        pub fn c2Zig(v: C) Z {
            inline for (zig_names) |name| {
                if (v == @field(values, name)) {
                    return @field(Z, name);
                }
            }
            unreachable;
        }
    };
}
