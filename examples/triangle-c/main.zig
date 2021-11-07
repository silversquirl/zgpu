//! Triangle example, but using cImport
const std = @import("std");
const glfw = @import("glfz");
const c = @cImport({
    @cInclude("webgpu-headers/webgpu.h");
    @cInclude("wgpu.h");
});

pub fn main() !void {
    try glfw.init();
    defer glfw.deinit();

    const win = try glfw.Window.init(800, 600, "zgpu triangle", .{
        .client_api = .none,
    });
    defer win.deinit();

    const dpy = glfw.getX11Display(c_void) orelse {
        return error.DisplayError;
    };
    const surface = c.wgpuInstanceCreateSurface(null, &.{
        .nextInChain = &(c.WGPUSurfaceDescriptorFromXlib{
            .chain = .{ .next = null, .sType = c.WGPUSType_SurfaceDescriptorFromXlib },
            .display = dpy,
            .window = win.getX11Window(),
        }).chain,
        .label = null,
    });

    var adapter: c.WGPUAdapter = undefined;
    c.wgpuInstanceRequestAdapter(null, &.{
        .nextInChain = null,
        .compatibleSurface = surface,
        .powerPreference = c.WGPUPowerPreference_HighPerformance,
        .forceFallbackAdapter = false,
    }, requestAdapterCallback, @ptrCast(*c_void, &adapter));

    var device: c.WGPUDevice = undefined;
    c.wgpuAdapterRequestDevice(adapter, &.{
        .nextInChain = null,
        .requiredFeaturesCount = 0,
        .requiredFeatures = undefined,
        .requiredLimits = &.{
            .nextInChain = null,
            .limits = std.mem.zeroInit(c.WGPULimits, .{}),
        },
    }, requestDeviceCallback, @ptrCast(*c_void, &device));
    defer c.wgpuDeviceDrop(device);

    const shader = c.wgpuDeviceCreateShaderModule(device, &.{
        .nextInChain = &(c.WGPUShaderModuleWGSLDescriptor{
            .chain = .{ .next = null, .sType = c.WGPUSType_ShaderModuleWGSLDescriptor },
            .source = @embedFile("shader.wgsl"),
        }).chain,
        .label = "shader.wgsl",
    });
    defer c.wgpuShaderModuleDrop(shader);

    const pipeline_layout = c.wgpuDeviceCreatePipelineLayout(device, &.{
        .nextInChain = null,
        .label = "Pipeline layout",
        .bindGroupLayoutCount = 0,
        .bindGroupLayouts = undefined,
    });
    defer c.wgpuPipelineLayoutDrop(pipeline_layout);

    const swapchain_format = c.wgpuSurfaceGetPreferredFormat(surface, adapter);

    const pipeline = c.wgpuDeviceCreateRenderPipeline(device, &c.WGPURenderPipelineDescriptor{
        .nextInChain = null,
        .label = "Render pipeline",
        .layout = pipeline_layout,
        .vertex = .{
            .nextInChain = null,
            .module = shader,
            .entryPoint = "vs_main",
            .constantCount = 0,
            .constants = undefined,
            .bufferCount = 0,
            .buffers = undefined,
        },
        .primitive = .{
            .nextInChain = null,
            .topology = c.WGPUPrimitiveTopology_TriangleList,
            .stripIndexFormat = c.WGPUIndexFormat_Undefined,
            .frontFace = c.WGPUFrontFace_CCW,
            .cullMode = c.WGPUCullMode_None,
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
            .constantCount = 0,
            .constants = undefined,
            .targetCount = 1,
            .targets = &[_]c.WGPUColorTargetState{.{
                .nextInChain = null,
                .format = swapchain_format,
                .blend = &.{
                    .color = .{
                        .srcFactor = c.WGPUBlendFactor_One,
                        .dstFactor = c.WGPUBlendFactor_One,
                        .operation = c.WGPUBlendOperation_Add,
                    },
                    .alpha = .{
                        .srcFactor = c.WGPUBlendFactor_One,
                        .dstFactor = c.WGPUBlendFactor_One,
                        .operation = c.WGPUBlendOperation_Add,
                    },
                },
                .writeMask = c.WGPUColorWriteMask_All,
            }},
        },
        .depthStencil = null,
    });
    defer c.wgpuRenderPipelineDrop(pipeline);

    var prev_size = win.windowSize();
    var swapchain = c.wgpuDeviceCreateSwapChain(device, surface, &.{
        .nextInChain = null,
        .label = "Swap chain",
        .usage = c.WGPUTextureUsage_RenderAttachment,
        .format = swapchain_format,
        .width = prev_size[0],
        .height = prev_size[1],
        .presentMode = c.WGPUPresentMode_Fifo,
    });

    while (!win.shouldClose()) {
        const size = win.windowSize();
        if (!std.meta.eql(size, prev_size)) {
            prev_size = size;
            swapchain = c.wgpuDeviceCreateSwapChain(device, surface, &.{
                .nextInChain = null,
                .label = "Swap chain",
                .usage = c.WGPUTextureUsage_RenderAttachment,
                .format = swapchain_format,
                .width = prev_size[0],
                .height = prev_size[1],
                .presentMode = c.WGPUPresentMode_Fifo,
            });
        }

        const next_texture = c.wgpuSwapChainGetCurrentTextureView(swapchain) orelse {
            return error.NoSwapchainTexture;
        };

        const encoder = c.wgpuDeviceCreateCommandEncoder(device, &.{
            .nextInChain = null,
            .label = "Command encoder",
        });

        const render_pass = c.wgpuCommandEncoderBeginRenderPass(encoder, &.{
            .nextInChain = null,
            .label = "Render pass",
            .colorAttachmentCount = 1,
            .colorAttachments = &[_]c.WGPURenderPassColorAttachment{.{
                .view = next_texture,
                .resolveTarget = null,
                .loadOp = c.WGPULoadOp_Clear,
                .storeOp = c.WGPUStoreOp_Store,
                .clearColor = .{ .r = 0, .g = 0, .b = 0, .a = 1 },
            }},
            .depthStencilAttachment = null,
            .occlusionQuerySet = null,
        });
        c.wgpuRenderPassEncoderSetPipeline(render_pass, pipeline);
        c.wgpuRenderPassEncoderDraw(render_pass, 3, 1, 0, 0);
        c.wgpuRenderPassEncoderEndPass(render_pass);

        const queue = c.wgpuDeviceGetQueue(device);
        const cmd_buffer = c.wgpuCommandEncoderFinish(encoder, &.{
            .nextInChain = null,
            .label = "Command buffer",
        });
        c.wgpuQueueSubmit(queue, 1, &[_]c.WGPUCommandBuffer{cmd_buffer});
        c.wgpuSwapChainPresent(swapchain);

        glfw.pollEvents();
    }
}

fn requestAdapterCallback(status: c.WGPURequestAdapterStatus, adapter: c.WGPUAdapter, message: ?[*:0]const u8, userdata: ?*c_void) callconv(.C) void {
    _ = status; // TODO: check
    _ = message;
    @ptrCast(*align(1) c.WGPUAdapter, userdata.?).* = adapter;
}

fn requestDeviceCallback(status: c.WGPURequestDeviceStatus, device: c.WGPUDevice, message: ?[*:0]const u8, userdata: ?*c_void) callconv(.C) void {
    _ = status; // TODO: check
    _ = message;
    @ptrCast(*align(1) c.WGPUDevice, userdata.?).* = device;
}
