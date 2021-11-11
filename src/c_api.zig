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

export fn wgpuCommandEncoderBeginRenderPass(
    self: *zgpu.CommandEncoder,
    opts: *const c.WGPURenderPassDescriptor,
) c.WGPURenderPassEncoder {
    const pass = commandEncoderBeginRenderPassInternal(self, opts) catch return null;
    return convertSmall(c.WGPURenderPassEncoder, pass);
}
fn commandEncoderBeginRenderPassInternal(
    self: *zgpu.CommandEncoder,
    opts: *const c.WGPURenderPassDescriptor,
) !zgpu.RenderPassEncoder {
    const color_attach = try allocator.alloc(
        zgpu.CommandEncoder.RenderPassOptions.ColorAttachment,
        opts.colorAttachmentCount,
    );
    defer allocator.free(color_attach);
    for (opts.colorAttachments[0..opts.colorAttachmentCount]) |attach, i| {
        color_attach[i] = .{
            .view = convertPointer(*zgpu.TextureView, attach.view).*,
            .resolve_target = if (attach.resolveTarget) |t|
                convertPointer(*zgpu.TextureView, t).*
            else
                null,
            .load_op = convertLoadOp(attach.loadOp),
            .store_op = convertStoreOp(attach.storeOp),
            .clear_color = .{
                .r = attach.clearColor.r,
                .g = attach.clearColor.g,
                .b = attach.clearColor.b,
                .a = attach.clearColor.a,
            },
        };
    }

    return self.beginRenderPass(.{
        .color_attachments = color_attach,
        .depth_stencil_attachment = if (opts.depthStencilAttachment) |ds| .{
            .view = convertPointer(*zgpu.TextureView, ds.*.view).*,

            .depth_load_op = convertLoadOp(ds.*.depthLoadOp),
            .depth_store_op = convertStoreOp(ds.*.depthStoreOp),
            .clear_depth = ds.*.clearDepth,
            .depth_read_only = ds.*.depthReadOnly,

            .stencil_load_op = convertLoadOp(ds.*.stencilLoadOp),
            .stencil_store_op = convertStoreOp(ds.*.stencilStoreOp),
            .clear_stencil = ds.*.clearStencil,
            .stencil_read_only = ds.*.stencilReadOnly,
        } else null,
        .occlusion_query_set = convertPointer(*zgpu.QuerySet, opts.occlusionQuerySet).*,
    });
}

export fn wgpuCommandEncoderFinish(
    self: *zgpu.CommandEncoder,
    opts: *const c.WGPUCommandBufferDescriptor,
) ?*zgpu.CommandBuffer {
    _ = opts; // We don't care about label
    const buffer = allocator.create(zgpu.CommandBuffer) catch return null;
    buffer.* = self.finish() catch {
        allocator.destroy(buffer);
        return null;
    };
    return buffer;
}

export fn wgpuDeviceCreateCommandEncoder(
    self: *zgpu.Device,
    opts: *const c.WGPUCommandEncoderDescriptor,
) ?*zgpu.CommandEncoder {
    _ = opts; // We don't care about label
    const encoder = allocator.create(zgpu.CommandEncoder) catch return null;
    encoder.* = zgpu.CommandEncoder.init(self);
    return encoder;
}

export fn wgpuDeviceCreatePipelineLayout(
    self: *zgpu.Device,
    opts: *const c.WGPUPipelineLayoutDescriptor,
) ?*zgpu.PipelineLayout {
    return deviceCreatePipelineLayoutInternal(self, opts) catch null;
}
fn deviceCreatePipelineLayoutInternal(
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

export fn wgpuDeviceCreateRenderPipeline(
    self: *zgpu.Device,
    opts: *const c.WGPURenderPipelineDescriptor,
) ?*zgpu.RenderPipeline {
    return deviceCreateRenderPipelineInternal(self, opts) catch null;
}
fn deviceCreateRenderPipelineInternal(
    self: *zgpu.Device,
    opts: *const c.WGPURenderPipelineDescriptor,
) !*zgpu.RenderPipeline {
    // Convert vertex state data
    const vconstants = try allocator.alloc(zgpu.ConstantEntry, opts.vertex.constantCount);
    defer allocator.free(vconstants);
    for (opts.vertex.constants[0..opts.vertex.constantCount]) |constant, i| {
        vconstants[i] = .{
            .key = std.mem.span(constant.key),
            .value = constant.value,
        };
    }

    var vattrs = std.ArrayList(zgpu.RenderPipeline.VertexState.Attribute).init(allocator);
    defer vattrs.deinit();
    for (opts.vertex.buffers[0..opts.vertex.bufferCount]) |buffer| {
        for (buffer.attributes[0..buffer.attributeCount]) |attr| {
            try vattrs.append(.{
                .format = switch (attr.format) {
                    c.WGPUVertexFormat_Uint8x2 => .uint8x2,
                    c.WGPUVertexFormat_Uint8x4 => .uint8x4,
                    c.WGPUVertexFormat_Sint8x2 => .sint8x2,
                    c.WGPUVertexFormat_Sint8x4 => .sint8x4,
                    c.WGPUVertexFormat_Unorm8x2 => .unorm8x2,
                    c.WGPUVertexFormat_Unorm8x4 => .unorm8x4,
                    c.WGPUVertexFormat_Snorm8x2 => .snorm8x2,
                    c.WGPUVertexFormat_Snorm8x4 => .snorm8x4,
                    c.WGPUVertexFormat_Uint16x2 => .uint16x2,
                    c.WGPUVertexFormat_Uint16x4 => .uint16x4,
                    c.WGPUVertexFormat_Sint16x2 => .sint16x2,
                    c.WGPUVertexFormat_Sint16x4 => .sint16x4,
                    c.WGPUVertexFormat_Unorm16x2 => .unorm16x2,
                    c.WGPUVertexFormat_Unorm16x4 => .unorm16x4,
                    c.WGPUVertexFormat_Snorm16x2 => .snorm16x2,
                    c.WGPUVertexFormat_Snorm16x4 => .snorm16x4,
                    c.WGPUVertexFormat_Float16x2 => .float16x2,
                    c.WGPUVertexFormat_Float16x4 => .float16x4,
                    c.WGPUVertexFormat_Float32 => .float32,
                    c.WGPUVertexFormat_Float32x2 => .float32x2,
                    c.WGPUVertexFormat_Float32x3 => .float32x3,
                    c.WGPUVertexFormat_Float32x4 => .float32x4,
                    c.WGPUVertexFormat_Uint32 => .uint32,
                    c.WGPUVertexFormat_Uint32x2 => .uint32x2,
                    c.WGPUVertexFormat_Uint32x3 => .uint32x3,
                    c.WGPUVertexFormat_Uint32x4 => .uint32x4,
                    c.WGPUVertexFormat_Sint32 => .sint32,
                    c.WGPUVertexFormat_Sint32x2 => .sint32x2,
                    c.WGPUVertexFormat_Sint32x3 => .sint32x3,
                    c.WGPUVertexFormat_Sint32x4 => .sint32x4,
                    else => unreachable,
                },
                .offset = @intCast(u32, attr.offset),
                .shader_location = attr.shaderLocation,
            });
        }
    }

    const vbuffers = try allocator.alloc(zgpu.RenderPipeline.VertexState.BufferLayout, opts.vertex.bufferCount);
    defer allocator.free(vbuffers);
    var attr_i: usize = 0;
    for (opts.vertex.buffers[0..opts.vertex.bufferCount]) |buffer, i| {
        vbuffers[i] = .{
            .array_stride = @intCast(u32, buffer.arrayStride),
            .step_mode = switch (buffer.stepMode) {
                c.WGPUVertexStepMode_Vertex => .vertex,
                c.WGPUVertexStepMode_Instance => .instance,
                else => unreachable,
            },
            .attributes = vattrs.items[attr_i .. attr_i + buffer.attributeCount],
        };
        attr_i += buffer.attributeCount;
    }
    std.debug.assert(attr_i == vattrs.items.len);

    // Convert fragment state data
    var fconstants: []zgpu.ConstantEntry = &.{};
    defer allocator.free(fconstants);
    var ftargets: []zgpu.RenderPipeline.FragmentState.ColorTargetState = &.{};
    defer allocator.free(ftargets);
    if (opts.fragment) |frag| {
        fconstants = try allocator.alloc(zgpu.ConstantEntry, frag.*.constantCount);
        for (frag.*.constants[0..frag.*.constantCount]) |constant, i| {
            fconstants[i] = .{
                .key = std.mem.span(constant.key),
                .value = constant.value,
            };
        }

        ftargets = try allocator.alloc(zgpu.RenderPipeline.FragmentState.ColorTargetState, frag.*.targetCount);
        for (frag.*.targets[0..frag.*.targetCount]) |target, i| {
            ftargets[i] = .{
                .format = textureFormatConverter.c2Zig(target.format),
                .blend = if (target.blend) |blend| .{
                    .color = convertBlendComponent(blend.*.color),
                    .alpha = convertBlendComponent(blend.*.alpha),
                } else null,
                .write_mask = .{
                    .red = target.writeMask & c.WGPUColorWriteMask_Red != 0,
                    .green = target.writeMask & c.WGPUColorWriteMask_Green != 0,
                    .blue = target.writeMask & c.WGPUColorWriteMask_Blue != 0,
                    .alpha = target.writeMask & c.WGPUColorWriteMask_Alpha != 0,
                },
            };
        }
    }

    // Create pipeline
    const pipeline = try allocator.create(zgpu.RenderPipeline);
    pipeline.* = try zgpu.RenderPipeline.init(self, .{
        .layout = convertPointer(*zgpu.PipelineLayout, opts.layout).*,

        .vertex = .{
            .module = convertPointer(*zgpu.ShaderModule, opts.vertex.module).*,
            .entry_point = std.mem.span(opts.vertex.entryPoint),
            .constants = vconstants,
            .buffers = vbuffers,
        },

        .primitive = .{
            .topology = switch (opts.primitive.topology) {
                c.WGPUPrimitiveTopology_PointList => .point_list,
                c.WGPUPrimitiveTopology_LineList => .line_list,
                c.WGPUPrimitiveTopology_LineStrip => .line_list,
                c.WGPUPrimitiveTopology_TriangleList => .triangle_list,
                c.WGPUPrimitiveTopology_TriangleStrip => .triangle_list,
                else => unreachable,
            },
            .strip_index_format = switch (opts.primitive.stripIndexFormat) {
                c.WGPUIndexFormat_Undefined => null,
                c.WGPUIndexFormat_Uint16 => .uint16,
                c.WGPUIndexFormat_Uint32 => .uint32,
                else => unreachable,
            },
            .front_face = switch (opts.primitive.frontFace) {
                c.WGPUFrontFace_CCW => .ccw,
                c.WGPUFrontFace_CW => .cw,
                else => unreachable,
            },
            .cull_mode = switch (opts.primitive.cullMode) {
                c.WGPUCullMode_None => .none,
                c.WGPUCullMode_Front => .front,
                c.WGPUCullMode_Back => .back,
                else => unreachable,
            },
        },

        .depth_stencil = if (opts.depthStencil) |depth_stencil| .{
            .format = textureFormatConverter.c2Zig(depth_stencil.*.format),
            .depth_write_enabled = depth_stencil.*.depthWriteEnabled,
            .depth_compare = compareFunctionConverter.c2Zig(depth_stencil.*.depthCompare),
            .stencil_front = convertStencilFaceState(depth_stencil.*.stencilFront),
            .stencil_back = convertStencilFaceState(depth_stencil.*.stencilBack),
            .stencil_read_mask = depth_stencil.*.stencilReadMask,
            .stencil_write_mask = depth_stencil.*.stencilWriteMask,
            .depth_bias = depth_stencil.*.depthBias,
            .depth_bias_slope_scale = depth_stencil.*.depthBiasSlopeScale,
            .depth_bias_clamp = depth_stencil.*.depthBiasClamp,
        } else null,

        .multisample = .{
            .count = opts.multisample.count,
            .mask = opts.multisample.mask,
            .alpha_to_coverage_enabled = opts.multisample.alphaToCoverageEnabled,
        },

        .fragment = if (opts.fragment) |frag| .{
            .module = convertPointer(*zgpu.ShaderModule, frag.*.module).*,
            .entry_point = std.mem.span(frag.*.entryPoint),
            .constants = fconstants,
            .targets = ftargets,
        } else null,
    });
    return pipeline;
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

export fn wgpuDeviceCreateSwapChain(
    self: *zgpu.Device,
    surf: *zgpu.Surface,
    opts: *const c.WGPUSwapChainDescriptor,
) ?*zgpu.SwapChain {
    const swapchain = allocator.create(zgpu.SwapChain) catch return null;
    swapchain.* = zgpu.SwapChain.init(self, surf.*, .{
        .usage = .{
            .copy_src = opts.usage & c.WGPUTextureUsage_CopySrc != 0,
            .copy_dst = opts.usage & c.WGPUTextureUsage_CopyDst != 0,
            .texture_binding = opts.usage & c.WGPUTextureUsage_TextureBinding != 0,
            .storage_binding = opts.usage & c.WGPUTextureUsage_StorageBinding != 0,
            .render_attachment = opts.usage & c.WGPUTextureUsage_RenderAttachment != 0,
        },
        .format = textureFormatConverter.c2Zig(opts.format),
        .width = opts.width,
        .height = opts.height,
        .present_mode = switch (opts.presentMode) {
            c.WGPUPresentMode_Immediate => .immediate,
            c.WGPUPresentMode_Mailbox => .mailbox,
            c.WGPUPresentMode_Fifo => .fifo,
            else => unreachable,
        },
    }) catch {
        allocator.destroy(swapchain);
        return null;
    };
    return swapchain;
}

export fn wgpuDeviceDestroy(self: *zgpu.Device) void {
    self.deinit();
    allocator.destroy(self);
}

export fn wgpuDeviceGetQueue(self: *zgpu.Device) ?*zgpu.Queue {
    const queue = allocator.create(zgpu.Queue) catch return null;
    queue.* = self.getQueue();
    return queue;
}

export fn wgpuPipelineLayoutDestroy(self: *zgpu.PipelineLayout) void {
    self.deinit();
    allocator.destroy(self);
}

export fn wgpuQueueSubmit(
    self: *zgpu.Queue,
    command_count: u32,
    commands: [*]const *zgpu.CommandBuffer,
) void {
    // TODO: handle OOM better
    const buffers = allocator.alloc(zgpu.CommandBuffer, command_count) catch @panic("Out of memory");
    defer allocator.free(buffers);
    for (commands[0..command_count]) |buf, i| {
        buffers[i] = buf.*;
    }
    self.submit(buffers) catch |err| @panic(@errorName(err));
}

export fn wgpuRenderPassEndPass(c_enc: c.WGPURenderPassEncoder) void {
    const self = convertSmall(zgpu.RenderPassEncoder, c_enc);
    self.endPass();
}

export fn wgpuRenderPassEncoderSetPipeline(
    c_enc: c.WGPURenderPassEncoder,
    pipeline: *zgpu.RenderPipeline,
) void {
    const self = convertSmall(zgpu.RenderPassEncoder, c_enc);
    self.setPipeline(pipeline.*);
}

export fn wgpuRenderPassEncoderDraw(
    c_enc: c.WGPURenderPassEncoder,
    vertex_count: u32,
    instance_count: u32,
    first_vertex: u32,
    first_instance: u32,
) void {
    const self = convertSmall(zgpu.RenderPassEncoder, c_enc);
    self.draw(vertex_count, instance_count, first_vertex, first_instance);
}

export fn wgpuRenderPipelineDestroy(self: *zgpu.RenderPipeline) void {
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

export fn wgpuSwapChainDestroy(self: *zgpu.SwapChain) void {
    self.deinit();
    allocator.destroy(self);
}
export fn wgpuSwapChainGetCurrentTextureView(self: *zgpu.SwapChain) ?*zgpu.TextureView {
    const view = allocator.create(zgpu.TextureView) catch return null;
    view.* = self.getCurrentTextureView() catch {
        allocator.destroy(view);
        return null;
    };
    return view;
}
export fn wgpuSwapChainPresent(self: *zgpu.SwapChain) void {
    // FIXME: don't panic
    self.present() catch |err| std.debug.panic("Swapchain present failed: {s}", .{@errorName(err)});
}

export fn wgpuSurfaceGetPreferredFormat(self: *zgpu.Surface, adapter: *zgpu.Adapter) c.WGPUTextureFormat {
    const format = self.getPreferredFormat(adapter.*) catch .@"undefined";
    return textureFormatConverter.zig2C(format);
}

export fn wgpuTextureCreateView(
    self: *zgpu.Texture,
    opts: c.WGPUTextureViewDescriptor,
) ?*zgpu.TextureView {
    const view = allocator.create(zgpu.TextureView) catch return null;
    view.* = zgpu.TextureView.init(self.*, .{
        .format = textureFormatConverter.c2Zig(opts.format),
        .dimension = switch (opts.dimension) {
            c.WGPUTextureViewDimension_1D => .@"1d",
            c.WGPUTextureViewDimension_2D => .@"2d",
            c.WGPUTextureViewDimension_2DArray => .@"2d_array",
            c.WGPUTextureViewDimension_Cube => .@"cube",
            c.WGPUTextureViewDimension_CubeArray => .@"cube_array",
            c.WGPUTextureViewDimension_3D => .@"3d",
            else => unreachable,
        },
        .base_mip_level = opts.baseMipLevel,
        .mip_level_count = opts.mipLevelCount,
        .base_array_layer = opts.baseArrayLayer,
        .array_layer_count = opts.arrayLayerCount,
        .aspect = switch (opts.aspect) {
            c.WGPUTextureAspect_All => .all,
            c.WGPUTextureAspect_StencilOnly => .stencil_only,
            c.WGPUTextureAspect_DepthOnly => .depth_only,
            else => unreachable,
        },
    }) catch {
        allocator.destroy(view);
        return null;
    };
    return view;
}

export fn wgpuTextureViewDestroy(self: *zgpu.TextureView) void {
    self.deinit();
    allocator.destroy(self);
}

//// Internal functions for conversions to and from Zig types

/// Casts both pointer type and alignment
fn convertPointer(comptime Ptr: type, value: anytype) Ptr {
    return @ptrCast(Ptr, @alignCast(std.meta.alignment(Ptr), value));
}

/// Bitcasts a value to or from a pointer type
fn convertSmall(comptime T: type, value: anytype) T {
    const ti = @typeInfo(T);
    if (ti == .Pointer or
        (ti == .Optional and @typeInfo(ti.Optional.child) == .Pointer))
    {
        return @intToPtr(T, @bitCast(usize, value));
    } else {
        return @bitCast(T, @ptrToInt(value));
    }
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

fn convertStencilFaceState(state: c.WGPUStencilFaceState) zgpu.RenderPipeline.DepthStencilState.FaceState {
    return .{
        .compare = compareFunctionConverter.c2Zig(state.compare),
        .fail_op = convertStencilOperation(state.failOp),
        .depth_fail_op = convertStencilOperation(state.depthFailOp),
        .pass_op = convertStencilOperation(state.passOp),
    };
}
fn convertStencilOperation(op: c.WGPUStencilOperation) zgpu.RenderPipeline.DepthStencilState.FaceState.Operation {
    return switch (op) {
        c.WGPUStencilOperation_Keep => .keep,
        c.WGPUStencilOperation_Zero => .zero,
        c.WGPUStencilOperation_Replace => .replace,
        c.WGPUStencilOperation_Invert => .invert,
        c.WGPUStencilOperation_IncrementClamp => .increment_and_clamp,
        c.WGPUStencilOperation_DecrementClamp => .decrement_and_clamp,
        c.WGPUStencilOperation_IncrementWrap => .increment_and_wrap,
        c.WGPUStencilOperation_DecrementWrap => .decrement_and_wrap,
        else => unreachable,
    };
}

fn convertBlendComponent(comp: c.WGPUBlendComponent) zgpu.RenderPipeline.FragmentState.BlendState.Component {
    return .{
        .operation = switch (comp.operation) {
            c.WGPUBlendOperation_Add => .add,
            c.WGPUBlendOperation_Subtract => .subtract,
            c.WGPUBlendOperation_ReverseSubtract => .reverse_subtract,
            c.WGPUBlendOperation_Min => .min,
            c.WGPUBlendOperation_Max => .max,
            else => unreachable,
        },
        .src_factor = convertBlendFactor(comp.srcFactor),
        .dst_factor = convertBlendFactor(comp.dstFactor),
    };
}
fn convertBlendFactor(fac: c.WGPUBlendFactor) zgpu.RenderPipeline.FragmentState.BlendState.Factor {
    return switch (fac) {
        c.WGPUBlendFactor_Zero => .zero,
        c.WGPUBlendFactor_One => .one,
        c.WGPUBlendFactor_Src => .src_color,
        c.WGPUBlendFactor_OneMinusSrc => .one_minus_src_color,
        c.WGPUBlendFactor_SrcAlpha => .src_alpha,
        c.WGPUBlendFactor_OneMinusSrcAlpha => .one_minus_src_alpha,
        c.WGPUBlendFactor_Dst => .dst_color,
        c.WGPUBlendFactor_OneMinusDst => .one_minus_dst_color,
        c.WGPUBlendFactor_DstAlpha => .dst_alpha,
        c.WGPUBlendFactor_OneMinusDstAlpha => .one_minus_dst_alpha,
        c.WGPUBlendFactor_SrcAlphaSaturated => .src_alpha_saturate,
        // FIXME: constant might differ depending on whether it's alpha or color, maybe don't use the vk type here
        c.WGPUBlendFactor_Constant => .constant_color,
        c.WGPUBlendFactor_OneMinusConstant => .one_minus_constant_color,
        else => unreachable,
    };
}

fn convertLoadOp(op: c.WGPULoadOp) zgpu.LoadOp {
    return switch (op) {
        c.WGPULoadOp_Clear => .clear,
        c.WGPULoadOp_Load => .load,
        else => unreachable,
    };
}
fn convertStoreOp(op: c.WGPUStoreOp) zgpu.StoreOp {
    return switch (op) {
        c.WGPUStoreOp_Store => .store,
        c.WGPUStoreOp_Discard => .dont_care,
        else => unreachable,
    };
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

const compareFunctionConverter = EnumConverter(
    zgpu.CompareFunction,
    c.WGPUCompareFunction,
    c.WGPUCompareFunction_Undefined,
    .{
        .never = c.WGPUCompareFunction_Never,
        .less = c.WGPUCompareFunction_Less,
        .less_or_equal = c.WGPUCompareFunction_LessEqual,
        .greater = c.WGPUCompareFunction_Greater,
        .greater_or_equal = c.WGPUCompareFunction_GreaterEqual,
        .equal = c.WGPUCompareFunction_Equal,
        .not_equal = c.WGPUCompareFunction_NotEqual,
        .always = c.WGPUCompareFunction_Always,
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
