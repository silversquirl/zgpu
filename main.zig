const std = @import("std");
const glfw = @import("glfz");

const wgpu = @import("wgpu.zig");

pub fn main() !void {
    try glfw.init();
    defer glfw.deinit();

    const win = try glfw.Window.init(800, 600, "wgpu zig", .{
        .client_api = .none,
    });
    defer win.deinit();

    // TODO: support not-X11
    const surface = wgpu.base.createSurface(&.{
        .next_in_chain = &(wgpu.SurfaceDescriptorFromXlib{
            .display = glfw.getX11Display(c_void),
            .window = win.getX11Window(),
        }).chain,
    });

    var adapter: wgpu.Adapter = undefined;
    wgpu.base.requestAdapter(&.{
        .compatible_surface = surface,
    }, requestAdapterCallback, @ptrCast(*c_void, &adapter));

    var device: wgpu.Device = undefined;
    adapter.requestDevice(&.{
        .next_in_chain = &(wgpu.DeviceExtras{
            .max_bind_groups = 1,
            .label = "Device",
        }).chain,
    }, requestDeviceCallback, @ptrCast(*c_void, &device));
    defer device.drop();

    const source = try std.fs.cwd().readFileAllocOptions(
        std.heap.page_allocator,
        "shader.wgsl",
        100 << 20,
        null,
        1,
        0,
    );
    defer std.heap.page_allocator.free(source);
    const shader = device.createShaderModule(&.{
        .next_in_chain = &(wgpu.ShaderModuleWGSLDescriptor{
            .source = source,
        }).chain,
        .label = "shader.wgsl",
    });
    defer shader.drop();

    const pipeline_layout = device.createPipelineLayout(&.{
        .next_in_chain = null,
        .label = "Pipeline layout",
        .bind_group_layouts = null,
        .bind_group_layout_count = 0,
    });
    defer pipeline_layout.drop();

    var swapchain_format: wgpu.TextureFormat = undefined;
    surface.getPreferredFormat(adapter, preferredTextureCallback, &swapchain_format);

    const pipeline = device.createRenderPipeline(&wgpu.RenderPipelineDescriptor{
        .next_in_chain = null,
        .label = "Render Pipeline",
        .layout = pipeline_layout,
        .vertex = .{
            .next_in_chain = null,
            .module = shader,
            .entry_point = "vs_main",
            .buffer_count = 0,
            .buffers = null,
        },
        .primitive = .{
            .next_in_chain = null,
            .topology = .triangle_list,
            .strip_index_format = .unknown,
            .front_face = .ccw,
            .cull_mode = .none,
        },
        .multisample = .{
            .next_in_chain = null,
            .count = 1,
            .mask = ~@as(u32, 0),
            .alpha_to_coverage_enabled = false,
        },
        .fragment = &.{
            .next_in_chain = null,
            .module = shader,
            .entry_point = "fs_main",
            .target_count = 1,
            .targets = &wgpu.ColorTargetState{
                .next_in_chain = null,
                .format = swapchain_format,
                .blend = &.{
                    .color = .{
                        .src_factor = .one,
                        .dst_factor = .zero,
                        .operation = .add,
                    },
                    .alpha = .{
                        .src_factor = .one,
                        .dst_factor = .zero,
                        .operation = .add,
                    },
                },
                .write_mask = .{},
            },
        },
        .depth_stencil = null,
    });
    defer pipeline.drop();

    var prev_size = win.windowSize();
    var swapchain = device.createSwapChain(surface, &.{
        .label = "Swap chain",
        .usage = .{ .render_attachment = true },
        .format = swapchain_format,
        .width = prev_size[0],
        .height = prev_size[1],
        .present_mode = .fifo,
    });

    while (!win.shouldClose()) {
        const size = win.windowSize();
        if (!std.meta.eql(size, prev_size)) {
            prev_size = size;
            swapchain = device.createSwapChain(surface, &.{
                .label = "Swap chain",
                .usage = .{ .render_attachment = true },
                .format = swapchain_format,
                .width = prev_size[0],
                .height = prev_size[1],
                .present_mode = .fifo,
            });
        }

        const next_texture = swapchain.getCurrentTextureView() orelse {
            return error.SwapchainTextureError;
        };

        const encoder = device.createCommandEncoder(
            &.{ .label = "Command Encoder" },
        );

        const render_pass = encoder.beginRenderPass(&.{
            .label = "Render pass",
            .color_attachments = &[_]wgpu.RenderPassColorAttachment{.{
                .view = next_texture,
                .resolve_target = null,
                .load_op = .clear,
                .store_op = .store,
                .clear_color = .{ .r = 0, .g = 0, .b = 0, .a = 1 },
            }},
            .color_attachment_count = 1,
        });

        render_pass.setPipeline(pipeline);
        render_pass.draw(3, 1, 0, 0);
        render_pass.endPass();

        const queue = device.getQueue();
        const cmd_buffer = [_]wgpu.CommandBuffer{encoder.finish(&.{})};
        queue.submit(1, &cmd_buffer);
        swapchain.present();

        glfw.pollEvents();
    }
}

fn requestAdapterCallback(received: wgpu.Adapter, userdata: ?*c_void) callconv(.C) void {
    @ptrCast(*align(1) wgpu.Adapter, userdata.?).* = received;
}

fn requestDeviceCallback(received: wgpu.Device, userdata: ?*c_void) callconv(.C) void {
    @ptrCast(*align(1) wgpu.Device, userdata.?).* = received;
}

fn preferredTextureCallback(format: wgpu.TextureFormat, userdata: ?*c_void) callconv(.C) void {
    @ptrCast(*align(1) wgpu.TextureFormat, userdata.?).* = format;
}
