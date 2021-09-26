const std = @import("std");
const glfw = @import("glfz");

const wgpu = @cImport({
    @cInclude("wgpu.h");
});

pub fn main() !void {
    try glfw.init();
    defer glfw.deinit();

    const win = try glfw.Window.init(800, 600, "wgpu zig", .{
        .client_api = .none,
    });
    defer win.deinit();

    // TODO: support not-X11
    const surface = wgpu.wgpuInstanceCreateSurface(null, &.{
        .label = null,
        .nextInChain = &(wgpu.WGPUSurfaceDescriptorFromXlib{
            .chain = .{
                .next = null,
                .sType = wgpu.WGPUSType_SurfaceDescriptorFromXlib,
            },
            .display = glfw.getX11Display(c_void),
            .window = win.getX11Window(),
        }).chain,
    });

    var adapter: wgpu.WGPUAdapter = undefined;
    wgpu.wgpuInstanceRequestAdapter(null, &.{
        .nextInChain = null,
        .compatibleSurface = surface,
    }, requestAdapterCallback, &adapter);

    var device: wgpu.WGPUDevice = undefined;
    wgpu.wgpuAdapterRequestDevice(adapter, &.{
        .nextInChain = &std.mem.zeroInit(wgpu.WGPUDeviceExtras, .{
            .chain = .{
                .next = null,
                .sType = wgpu.WGPUSType_DeviceExtras,
            },
            .maxBindGroups = 1,
            .label = "Device",
            .tracePath = null,
        }).chain,
    }, requestDeviceCallback, &device);
    defer wgpu.wgpuDeviceDrop(device);

    const source = try std.fs.cwd().readFileAllocOptions(
        std.heap.page_allocator,
        "shader.wgsl",
        100 << 20,
        null,
        1,
        0,
    );
    defer std.heap.page_allocator.free(source);
    const shader = wgpu.wgpuDeviceCreateShaderModule(device, &.{
        .nextInChain = &(wgpu.WGPUShaderModuleWGSLDescriptor{
            .chain = .{
                .next = null,
                .sType = wgpu.WGPUSType_ShaderModuleWGSLDescriptor,
            },
            .source = source,
        }).chain,
        .label = "shader.wgsl",
    });
    defer wgpu.wgpuShaderModuleDrop(shader);

    const pipeline_layout = wgpu.wgpuDeviceCreatePipelineLayout(device, &.{
        .nextInChain = null,
        .label = "Pipeline layout",
        .bindGroupLayouts = null,
        .bindGroupLayoutCount = 0,
    });
    defer wgpu.wgpuPipelineLayoutDrop(pipeline_layout);

    var swapchain_format: wgpu.WGPUTextureFormat = undefined;
    wgpu.wgpuSurfaceGetPreferredFormat(surface, adapter, preferredTextureCallback, &swapchain_format);

    const pipeline = wgpu.wgpuDeviceCreateRenderPipeline(device, &wgpu.WGPURenderPipelineDescriptor{
        .nextInChain = null,
        .label = "Render Pipeline",
        .layout = pipeline_layout,
        .vertex = .{
            .nextInChain = null,
            .module = shader,
            .entryPoint = "vs_main",
            .bufferCount = 0,
            .buffers = null,
        },
        .primitive = .{
            .nextInChain = null,
            .topology = wgpu.WGPUPrimitiveTopology_TriangleList,
            .stripIndexFormat = wgpu.WGPUIndexFormat_Undefined,
            .frontFace = wgpu.WGPUFrontFace_CCW,
            .cullMode = wgpu.WGPUCullMode_None,
        },
        .multisample = .{
            .nextInChain = null,
            .count = 1,
            .mask = ~@as(u32, 0),
            .alphaToCoverageEnabled = false,
        },
        .fragment = &.{
            .nextInChain = null,
            .module = shader,
            .entryPoint = "fs_main",
            .targetCount = 1,
            .targets = &.{
                .nextInChain = null,
                .format = swapchain_format,
                .blend = &.{
                    .color = .{
                        .srcFactor = wgpu.WGPUBlendFactor_One,
                        .dstFactor = wgpu.WGPUBlendFactor_Zero,
                        .operation = wgpu.WGPUBlendOperation_Add,
                    },
                    .alpha = .{
                        .srcFactor = wgpu.WGPUBlendFactor_One,
                        .dstFactor = wgpu.WGPUBlendFactor_Zero,
                        .operation = wgpu.WGPUBlendOperation_Add,
                    },
                },
                .writeMask = wgpu.WGPUColorWriteMask_All,
            },
        },
        .depthStencil = null,
    });
    defer wgpu.wgpuRenderPipelineDrop(pipeline);

    var prev_size = win.windowSize();

    var swapchain = wgpu.wgpuDeviceCreateSwapChain(device, surface, &.{
        .nextInChain = null,
        .label = "Swap chain",
        .usage = wgpu.WGPUTextureUsage_RenderAttachment,
        .format = swapchain_format,
        .width = prev_size[0],
        .height = prev_size[1],
        .presentMode = wgpu.WGPUPresentMode_Fifo,
    });

    while (!win.shouldClose()) {
        const size = win.windowSize();
        if (!std.meta.eql(size, prev_size)) {
            prev_size = size;

            swapchain = wgpu.wgpuDeviceCreateSwapChain(device, surface, &.{
                .nextInChain = null,
                .label = "Swap chain",
                .usage = wgpu.WGPUTextureUsage_RenderAttachment,
                .format = swapchain_format,
                .width = prev_size[0],
                .height = prev_size[1],
                .presentMode = wgpu.WGPUPresentMode_Fifo,
            });
        }

        const next_texture = wgpu.wgpuSwapChainGetCurrentTextureView(swapchain) orelse {
            return error.SwapchainTextureError;
        };

        const encoder = wgpu.wgpuDeviceCreateCommandEncoder(
            device,
            &.{ .nextInChain = null, .label = "Command Encoder" },
        );

        const render_pass = wgpu.wgpuCommandEncoderBeginRenderPass(encoder, &.{
            .nextInChain = null,
            .label = "Render pass",
            .colorAttachments = &.{
                .view = next_texture,
                .resolveTarget = null,
                .loadOp = wgpu.WGPULoadOp_Clear,
                .storeOp = wgpu.WGPUStoreOp_Store,
                .clearColor = .{ .r = 0, .g = 0, .b = 0, .a = 1 },
            },
            .colorAttachmentCount = 1,
            .depthStencilAttachment = null,
            .occlusionQuerySet = null,
        });

        wgpu.wgpuRenderPassEncoderSetPipeline(render_pass, pipeline);
        wgpu.wgpuRenderPassEncoderDraw(render_pass, 3, 1, 0, 0);
        wgpu.wgpuRenderPassEncoderEndPass(render_pass);

        const queue = wgpu.wgpuDeviceGetQueue(device);
        const cmd_buffer = wgpu.wgpuCommandEncoderFinish(encoder, &.{ .nextInChain = null, .label = null });
        wgpu.wgpuQueueSubmit(queue, 1, &cmd_buffer);
        wgpu.wgpuSwapChainPresent(swapchain);

        glfw.pollEvents();
    }
}

fn requestAdapterCallback(received: wgpu.WGPUAdapter, userdata: ?*c_void) callconv(.C) void {
    @ptrCast(*align(1) wgpu.WGPUAdapter, userdata.?).* = received;
}

fn requestDeviceCallback(received: wgpu.WGPUDevice, userdata: ?*c_void) callconv(.C) void {
    @ptrCast(*align(1) wgpu.WGPUDevice, userdata.?).* = received;
}

fn preferredTextureCallback(format: wgpu.WGPUTextureFormat, userdata: ?*c_void) callconv(.C) void {
    @ptrCast(*align(1) wgpu.WGPUTextureFormat, userdata.?).* = format;
}
