//! WebGPU implementation based on Vulkan
const std = @import("std");
const builtin = @import("builtin");
const vk = @import("vk.zig");

const engine_name = "zgpu";
const engine_version = std.SemanticVersion.parse("0.1.0") catch unreachable;

const vk_engine_version =
    engine_version.major * 1_00_00 +
    engine_version.minor * 1_00 +
    engine_version.patch;

comptime {
    if (!builtin.link_libc) {
        @compileError("zgpu requires libc to be linked");
    }
}

pub const Instance = struct {
    vk_alloc: ?vk.AllocationCallbacks,
    vkb: vk.BaseDispatch,
    vki: vk.InstanceDispatch,
    instance: vk.Instance,

    pub const InitOptions = struct {
        /// Hints to the driver, in case they want to special case things
        app_name: ?[:0]const u8 = null,
        app_version: u32 = 0,

        /// Enable Vulkan validation layers?
        /// Only applies if the validation layers are actually available
        validation: bool = builtin.mode == .Debug,
    };

    /// The allocator passed in here will be used many times for small, short-lived allocations.
    /// It should therefore not be a temporary allocator such as an arena or a fixed buffer allocator.
    ///
    /// There are also some potential issues with using GeneralPurposeAllocator (see ziglang/zig#10114),
    /// but this can be worked around by setting stack_trace_frames to zero.
    ///
    /// c_allocator is often a good choice here.
    pub fn init(allocator: *std.mem.Allocator, opts: InitOptions) !Instance {
        var self: Instance = undefined;
        self.vk_alloc = vk.allocator.wrap(allocator);

        try vk.loader.ref();
        errdefer vk.loader.deref();
        self.vkb = try vk.BaseDispatch.load(vk.loader.getProcAddress);

        const khr_validation = "VK_LAYER_KHRONOS_validation";
        const layers = [_][*:0]const u8{khr_validation};
        const n_layers = @boolToInt(opts.validation and try self.hasLayer(allocator, khr_validation));

        const app_name: ?[*:0]const u8 =
            if (opts.app_name) |name| name.ptr else null;
        self.instance = try self.vkb.createInstance(.{
            .flags = .{},
            .p_application_info = &.{
                .p_application_name = app_name,
                .application_version = opts.app_version,
                .p_engine_name = engine_name,
                .engine_version = vk_engine_version,
                .api_version = vk.makeApiVersion(0, 1, 1, 0),
            },
            .enabled_layer_count = n_layers,
            .pp_enabled_layer_names = &layers,
            .enabled_extension_count = 0,
            .pp_enabled_extension_names = undefined,
        }, self.vkAlloc());
        self.vki = try vk.InstanceDispatch.load(self.instance, self.vkb.dispatch.vkGetInstanceProcAddr);
        errdefer self.vki.destroyInstance(self.instance, self.vkAlloc());

        return self;
    }

    fn hasLayer(self: Instance, allocator: *std.mem.Allocator, name: []const u8) !bool {
        var n_supported_layers: u32 = undefined;
        _ = try self.vkb.enumerateInstanceLayerProperties(&n_supported_layers, null);
        const supported_layers = try allocator.alloc(vk.LayerProperties, n_supported_layers);
        defer allocator.free(supported_layers);
        _ = try self.vkb.enumerateInstanceLayerProperties(&n_supported_layers, supported_layers.ptr);

        for (supported_layers[0..n_supported_layers]) |supported| {
            if (std.mem.eql(u8, name, std.mem.sliceTo(&supported.layer_name, 0))) {
                return true;
            }
        }
        return false;
    }

    pub fn deinit(self: Instance) void {
        self.vki.destroyInstance(self.instance, self.vkAlloc());
        vk.loader.deref();
    }

    fn vkAlloc(self: *const Instance) ?*const vk.AllocationCallbacks {
        return if (self.vk_alloc) |*r| r else null;
    }
};

pub const Adapter = struct {
    i: *const Instance, // Not needed here, but Device needs it
    pdev: vk.PhysicalDevice,
    props: vk.PhysicalDeviceProperties,

    // Queue families
    graphics_family: u32,
    compute_family: u32,

    pub const InitOptions = struct {
        compatible_surface: Surface,
        power_preference: PowerPreference = .low_power,
        force_fallback_adapter: bool = false,
    };
    pub const PowerPreference = enum { low_power, high_performance };

    pub fn init(instance: *const Instance, opts: InitOptions) !Adapter {
        var self: Adapter = undefined;
        self.i = instance;
        const allocator = vk.allocator.unwrap(self.i.vkAlloc());

        var n_devices: u32 = undefined;
        _ = try self.i.vki.enumeratePhysicalDevices(self.i.instance, &n_devices, null);
        const devices = try allocator.alloc(vk.PhysicalDevice, n_devices);
        defer allocator.free(devices);
        _ = try self.i.vki.enumeratePhysicalDevices(self.i.instance, &n_devices, devices.ptr);

        var old_rank: ?u4 = null;
        for (devices[0..n_devices]) |dev| {
            // Check device type ranking
            const props = self.i.vki.getPhysicalDeviceProperties(dev);
            const new_rank = rankDevice(opts.power_preference, props);
            if (old_rank != null and new_rank > old_rank.?) continue;

            // Check queue family support
            var n_families: u32 = undefined;
            self.i.vki.getPhysicalDeviceQueueFamilyProperties(dev, &n_families, null);
            const families = try allocator.alloc(vk.QueueFamilyProperties, n_families);
            defer allocator.free(families);
            self.i.vki.getPhysicalDeviceQueueFamilyProperties(dev, &n_families, families.ptr);

            var graphics_family: ?u32 = null;
            var compute_family: ?u32 = null;
            for (families[0..n_families]) |family, i| {
                const idx = @intCast(u32, i);
                // Prefer the same family for both
                if (family.queue_flags.graphics_bit and family.queue_flags.compute_bit) {
                    graphics_family = idx;
                    compute_family = idx;
                    break;
                }
                // Otherwise, look for individual families
                if (family.queue_flags.graphics_bit and graphics_family == null) {
                    graphics_family = idx;
                }
                if (family.queue_flags.compute_bit and compute_family == null) {
                    compute_family = idx;
                }
                // Check if we've found all the families we need
                if (graphics_family != null and compute_family != null) {
                    break;
                }
            } else {
                continue;
            }

            // Set current best device
            old_rank = new_rank;
            self.pdev = dev;
            self.props = props;
            self.graphics_family = graphics_family.?;
            self.compute_family = compute_family.?;
        }
        if (old_rank == null) {
            return error.AdapterUnavailable;
        }

        return self;
    }

    /// Ranks devices according to power preferences. Lower is more preferable
    fn rankDevice(power: PowerPreference, props: vk.PhysicalDeviceProperties) u4 {
        return switch (props.device_type) {
            .integrated_gpu => switch (power) {
                .low_power => @as(u4, 0),
                .high_performance => 1,
            },
            .discrete_gpu => switch (power) {
                .low_power => @as(u4, 1),
                .high_performance => 0,
            },
            .virtual_gpu => 2,
            .cpu => 2,
            .other => 2,
            else => unreachable,
        };
    }
};

pub const Device = struct {
    vk_alloc: ?*const vk.AllocationCallbacks,
    adapter: *const Adapter, // Required for swapchain creation
    vkd: vk.DeviceDispatch,
    dev: vk.Device,
    graphics_pool: vk.CommandPool,
    compute_pool: vk.CommandPool,

    pub const InitOptions = struct {
        // TODO: features
        required_limits: Limits,
    };

    pub fn init(adapter: *const Adapter, opts: InitOptions) !Device {
        var self: Device = undefined;
        self.vk_alloc = adapter.i.vkAlloc();
        self.adapter = adapter;

        _ = opts; // TODO: check limits are acceptable

        const queue_infos = if (adapter.graphics_family == adapter.compute_family)
            &[_]vk.DeviceQueueCreateInfo{.{
                .flags = .{},
                .queue_family_index = adapter.graphics_family,
                .queue_count = 1,
                .p_queue_priorities = &[1]f32{1.0},
            }}
        else
            &[_]vk.DeviceQueueCreateInfo{ .{
                .flags = .{},
                .queue_family_index = adapter.graphics_family,
                .queue_count = 1,
                .p_queue_priorities = &[1]f32{1.0},
            }, .{
                .flags = .{},
                .queue_family_index = adapter.compute_family,
                .queue_count = 1,
                .p_queue_priorities = &[1]f32{1.0},
            } };

        self.dev = try adapter.i.vki.createDevice(adapter.pdev, .{
            .flags = .{},

            .queue_create_info_count = @intCast(u32, queue_infos.len),
            .p_queue_create_infos = queue_infos.ptr,

            .enabled_layer_count = 0,
            .pp_enabled_layer_names = undefined,

            .enabled_extension_count = 0,
            .pp_enabled_extension_names = undefined,

            .p_enabled_features = null, // TODO: independent blending, etc
        }, self.vk_alloc);
        self.vkd = try vk.DeviceDispatch.load(self.dev, adapter.i.vki.dispatch.vkGetDeviceProcAddr);
        errdefer self.vkd.destroyDevice(self.dev, self.vk_alloc);

        self.graphics_pool = try self.vkd.createCommandPool(self.dev, .{
            .flags = .{ .transient_bit = true },
            .queue_family_index = adapter.graphics_family,
        }, self.vk_alloc);
        errdefer self.vkd.destroyCommandPool(self.dev, self.graphics_pool, self.vk_alloc);

        self.compute_pool = try self.vkd.createCommandPool(self.dev, .{
            .flags = .{ .transient_bit = true },
            .queue_family_index = adapter.compute_family,
        }, self.vk_alloc);
        errdefer self.vkd.destroyCommandPool(self.dev, self.compute_pool, self.vk_alloc);

        return self;
    }

    pub fn deinit(self: Device) void {
        self.vkd.destroyCommandPool(self.dev, self.compute_pool, self.vk_alloc);
        self.vkd.destroyCommandPool(self.dev, self.graphics_pool, self.vk_alloc);
        self.vkd.destroyDevice(self.dev, self.vk_alloc);
    }

    pub fn getQueue(self: *const Device) Queue {
        return .{
            .d = self,
            .graphics = self.vkd.getDeviceQueue(self.dev, self.adapter.graphics_family, 0),
            .compute = self.vkd.getDeviceQueue(self.dev, self.adapter.compute_family, 0),
        };
    }
};

pub const Queue = struct {
    d: *const Device,
    graphics: vk.Queue,
    compute: vk.Queue,

    pub fn submit(self: Queue, buffers: []const CommandBuffer) !void {
        const allocator = vk.allocator.unwrap(self.d.vk_alloc);
        const vk_buffers = try allocator.alloc(vk.CommandBuffer, buffers.len);
        defer allocator.free(vk_buffers);

        // Find the number of graphics buffers vs compute buffers
        var compute_offset: usize = 0;
        for (buffers) |buf| {
            switch (buf.kind) {
                .graphics => compute_offset += 1,
                .compute => {},
            }
        }

        for (buffers) |buf, i| {
            const idx = switch (buf.kind) {
                .graphics => i,
                .compute => i + compute_offset,
            };
            vk_buffers[idx] = buf.buf;
        }

        const graphics_buffers = vk_buffers[0..compute_offset];
        const compute_buffers = vk_buffers[vk_buffers.len - compute_offset ..];

        if (graphics_buffers.len > 0) {
            try self.d.vkd.queueSubmit(self.graphics, 1, &[1]vk.SubmitInfo{.{
                .wait_semaphore_count = 0,
                .p_wait_semaphores = undefined,
                .p_wait_dst_stage_mask = undefined,

                .command_buffer_count = @intCast(u32, graphics_buffers.len),
                .p_command_buffers = graphics_buffers.ptr,

                .signal_semaphore_count = 0,
                .p_signal_semaphores = undefined,
            }}, .null_handle);
        }

        if (compute_buffers.len > 0) {
            try self.d.vkd.queueSubmit(self.compute, 1, &[1]vk.SubmitInfo{.{
                .wait_semaphore_count = 0,
                .p_wait_semaphores = undefined,
                .p_wait_dst_stage_mask = undefined,

                .command_buffer_count = @intCast(u32, compute_buffers.len),
                .p_command_buffers = compute_buffers.ptr,

                .signal_semaphore_count = 0,
                .p_signal_semaphores = undefined,
            }}, .null_handle);
        }
    }
};

pub const Limits = struct {
    max_texture_dimension_1d: u32,
    max_texture_dimension_2d: u32,
    max_texture_dimension_3d: u32,
    max_texture_array_layers: u32,
    max_bind_groups: u32,
    max_dynamic_uniform_buffers_per_pipeline_layout: u32,
    max_dynamic_storage_buffers_per_pipeline_layout: u32,
    max_sampled_textures_per_shader_stage: u32,
    max_samplers_per_shader_stage: u32,
    max_storage_buffers_per_shader_stage: u32,
    max_storage_textures_per_shader_stage: u32,
    max_uniform_buffers_per_shader_stage: u32,
    max_uniform_buffer_binding_size: u64,
    max_storage_buffer_binding_size: u64,
    min_uniform_buffer_offset_alignment: u32,
    min_storage_buffer_offset_alignment: u32,
    max_vertex_buffers: u32,
    max_vertex_attributes: u32,
    max_vertex_buffer_array_stride: u32,
    max_inter_stage_shader_components: u32,
    max_compute_workgroup_storage_size: u32,
    max_compute_invocations_per_workgroup: u32,
    max_compute_workgroup_size_x: u32,
    max_compute_workgroup_size_y: u32,
    max_compute_workgroup_size_z: u32,
    max_compute_workgroups_per_dimension: u32,
};

pub const Surface = struct {
    i: *const Instance,
    surf: vk.SurfaceKHR,

    pub fn initGlfw(instance: *const Instance, glfw_window: anytype) !Surface {
        const win = @ptrCast(*GlfwWindow, glfw_window);
        var surface: vk.SurfaceKHR = undefined;
        const res = glfwCreateWindowSurface(instance.instance, win, instance.vkAlloc(), &surface);
        // TODO: better error handling
        switch (res) {
            .success => {},
            else => return error.Unexpected,
        }
        return Surface{
            .i = instance,
            .surf = surface,
        };
    }
    extern fn glfwCreateWindowSurface(vk.Instance, *GlfwWindow, ?*const vk.AllocationCallbacks, *vk.SurfaceKHR) vk.Result;
    const GlfwWindow = opaque {};

    pub fn deinit(self: Surface) void {
        self.i.vki.destroySurfaceKHR(self.i.instance, self.surf, self.i.vkAlloc());
    }

    pub fn getPreferredFormat(self: Surface, adapter: Adapter) !TextureFormat {
        const format = try self.getPreferredFormatVk(adapter);
        return format.format;
    }
    fn getPreferredFormatVk(self: Surface, adapter: Adapter) !vk.SurfaceFormatKHR {
        // TODO: using the first one might not be the correct thing to do here
        var count: u32 = 1;
        var formats: [1]vk.SurfaceFormatKHR = undefined;
        _ = try adapter.i.vki.getPhysicalDeviceSurfaceFormatsKHR(
            adapter.pdev,
            self.surf,
            &count,
            &formats,
        );
        return formats[0];
    }
};

pub const ShaderModule = struct {
    d: *const Device,
    shad: vk.ShaderModule,

    /// Create a shader module from SPIR-V source. Will autodetect the byte order.
    pub fn initSpirv(dev: *const Device, code: []const u32) !ShaderModule {
        const spirv_magic = 0x07230203;
        switch (code[0]) {
            spirv_magic => return initSpirvNative(dev, code),

            @byteSwap(u32, spirv_magic) => {
                const allocator = vk.allocator.unwrap(dev.vk_alloc);
                const code_native = try allocator.alloc(u32, code.len);
                defer allocator.free(code);

                for (code) |x, i| {
                    code_native[i] = @byteSwap(u32, x);
                }

                return initSpirvNative(dev, code_native);
            },

            else => return error.InvalidShader,
        }
    }

    fn initSpirvNative(dev: *const Device, code: []const u32) !ShaderModule {
        const shad = try dev.vkd.createShaderModule(dev.dev, .{
            .flags = .{},
            .code_size = 4 * code.len,
            .p_code = code.ptr,
        }, dev.vk_alloc);
        return ShaderModule{ .d = dev, .shad = shad };
    }

    pub fn deinit(self: ShaderModule) void {
        self.d.vkd.destroyShaderModule(self.d.dev, self.shad, self.d.vk_alloc);
    }
};

pub const BindGroupLayout = struct {
    d: *const Device,
    layout: vk.DescriptorSetLayout,

    // TODO
};

pub const PipelineLayout = struct {
    d: *const Device,
    layout: vk.PipelineLayout,

    pub fn init(dev: *const Device, bind_layouts: []const BindGroupLayout) !PipelineLayout {
        const allocator = vk.allocator.unwrap(dev.vk_alloc);
        const set_layouts = try allocator.alloc(vk.DescriptorSetLayout, bind_layouts.len);
        defer allocator.free(set_layouts);
        for (bind_layouts) |layout, i| {
            set_layouts[i] = layout.layout;
        }

        const pipeline_layout = try dev.vkd.createPipelineLayout(dev.dev, .{
            .flags = .{},
            .set_layout_count = @intCast(u32, set_layouts.len),
            .p_set_layouts = set_layouts.ptr,
            .push_constant_range_count = 0,
            .p_push_constant_ranges = undefined,
        }, dev.vk_alloc);

        return PipelineLayout{ .d = dev, .layout = pipeline_layout };
    }

    pub fn deinit(self: PipelineLayout) void {
        self.d.vkd.destroyPipelineLayout(self.d.dev, self.layout, self.d.vk_alloc);
    }
};

pub const ConstantEntry = struct {
    key: [:0]const u8,
    value: f64,
};

pub const IndexFormat = enum {
    uint16,
    uint32,
};

pub const CompareFunction = vk.CompareOp;

pub const RenderPipeline = struct {
    d: *const Device,
    pipeline: vk.Pipeline,
    pass: vk.RenderPass,

    pub const InitOptions = struct {
        layout: PipelineLayout,
        vertex: VertexState,
        primitive: PrimitiveState = .{},
        depth_stencil: ?DepthStencilState = null,
        multisample: MultisampleState = .{},
        fragment: ?FragmentState = null,
    };

    pub const VertexState = struct {
        module: ShaderModule,
        entry_point: [:0]const u8,
        constants: []const ConstantEntry,
        buffers: []const BufferLayout = &.{},

        pub const BufferLayout = struct {
            array_stride: u32,
            step_mode: StepMode = .vertex,
            attributes: []const Attribute,
        };

        pub const StepMode = vk.VertexInputRate;

        pub const Attribute = struct {
            format: Format,
            offset: u32,
            shader_location: u32,
        };

        pub const Format = enum {
            // 8-bit int vectors
            uint8x2,
            uint8x4,
            sint8x2,
            sint8x4,
            unorm8x2,
            unorm8x4,
            snorm8x2,
            snorm8x4,

            // 16-bit int vectors
            uint16x2,
            uint16x4,
            sint16x2,
            sint16x4,
            unorm16x2,
            unorm16x4,
            snorm16x2,
            snorm16x4,

            // 16-bit float vectors
            float16x2,
            float16x4,

            // 32-bit float vectors
            float32,
            float32x2,
            float32x3,
            float32x4,

            // 32-bit int vectors
            uint32,
            uint32x2,
            uint32x3,
            uint32x4,
            sint32,
            sint32x2,
            sint32x3,
            sint32x4,
        };
    };

    pub const PrimitiveState = struct {
        topology: Topology = .triangle_list,
        strip_index_format: ?IndexFormat = null,
        front_face: FrontFace = .ccw,
        cull_mode: CullMode = .none,

        pub const Topology = vk.PrimitiveTopology;
        pub const FrontFace = enum { ccw, cw };
        pub const CullMode = enum { none, front, back };
    };

    pub const DepthStencilState = struct {
        format: TextureFormat,
        depth_write_enabled: bool = false,
        depth_compare: CompareFunction = .always,
        stencil_front: FaceState = .{},
        stencil_back: FaceState = .{},
        stencil_read_mask: u32 = ~@as(u32, 0),
        stencil_write_mask: u32 = ~@as(u32, 0),
        depth_bias: i32 = 0,
        depth_bias_slope_scale: f32 = 0,
        depth_bias_clamp: f32 = 0,

        pub const FaceState = struct {
            compare: CompareFunction = .always,
            fail_op: Operation = .keep,
            depth_fail_op: Operation = .keep,
            pass_op: Operation = .keep,

            pub const Operation = vk.StencilOp;
        };
    };

    pub const MultisampleState = struct {
        count: u32 = 1,
        mask: u32 = ~@as(u32, 0),
        alpha_to_coverage_enabled: bool = false,
    };

    pub const FragmentState = struct {
        module: ShaderModule,
        entry_point: [:0]const u8,
        constants: []const ConstantEntry,
        targets: []const ColorTargetState,

        pub const ColorTargetState = struct {
            format: TextureFormat,
            blend: ?BlendState,
            write_mask: ColorWriteFlags = .{
                .red = true,
                .green = true,
                .blue = true,
                .alpha = true,
            },

            pub const ColorWriteFlags = packed struct {
                red: bool = false,
                green: bool = false,
                blue: bool = false,
                alpha: bool = false,
            };
        };

        pub const BlendState = struct {
            color: Component,
            alpha: Component,

            pub const Component = struct {
                operation: Operation = .add,
                src_factor: Factor = .one,
                dst_factor: Factor = .zero,
            };

            pub const Operation = vk.BlendOp;
            pub const Factor = vk.BlendFactor;
        };
    };

    pub fn init(dev: *const Device, opts: InitOptions) !RenderPipeline {
        const allocator = vk.allocator.unwrap(dev.vk_alloc);

        // TODO: Snektron/vulkan-zig#27
        const multisample_count_vk: vk.SampleCountFlags = switch (opts.multisample.count) {
            1 => .{ .@"1_bit" = true },
            2 => .{ .@"2_bit" = true },
            4 => .{ .@"4_bit" = true },
            8 => .{ .@"8_bit" = true },
            16 => .{ .@"16_bit" = true },
            32 => .{ .@"32_bit" = true },
            else => unreachable,
        };

        // Create render pass
        // TODO: may be best to defer vulkan render pass (and hence pipeline) creation until it's
        //       used with a render pass? Would require recreating the pipeline if it's used again
        //       with an incompatible render pass.
        var attachments: []vk.AttachmentDescription = &.{};
        defer allocator.free(attachments);
        if (opts.depth_stencil != null) {
            @panic("FIXME: depth_stencil needs to go in render pass attachments");
        }
        if (opts.fragment) |frag| {
            attachments = try allocator.alloc(vk.AttachmentDescription, frag.targets.len);
            for (frag.targets) |target, i| {
                attachments[i] = .{
                    .flags = .{ .may_alias_bit = true }, // TODO: do we actually need this? Check spec
                    .format = target.format,
                    .samples = multisample_count_vk,
                    .load_op = .load,
                    .store_op = .store,
                    .stencil_load_op = .dont_care,
                    .stencil_store_op = .dont_care,
                    .initial_layout = .general,
                    .final_layout = .general,
                };
            }
        }

        const render_pass = try dev.vkd.createRenderPass(dev.dev, .{
            .flags = .{},
            .attachment_count = @intCast(u32, attachments.len),
            .p_attachments = attachments.ptr,
            .subpass_count = 0,
            .p_subpasses = undefined,
            .dependency_count = 0,
            .p_dependencies = undefined,
        }, dev.vk_alloc);
        errdefer dev.vkd.destroyRenderPass(dev.dev, render_pass, dev.vk_alloc);

        // Create shader stage info
        var shader_stages: [2]vk.PipelineShaderStageCreateInfo = undefined;
        var stage_count: u32 = 1;
        shader_stages[0] = .{
            .flags = .{},
            .stage = .{ .vertex_bit = true },
            .module = opts.vertex.module.shad,
            .p_name = opts.vertex.entry_point,
            .p_specialization_info = null, // TODO: specialization constants
        };
        std.debug.assert(opts.vertex.constants.len == 0); // TODO: specialization constants

        if (opts.fragment) |frag_state| {
            shader_stages[1] = .{
                .flags = .{},
                .stage = .{ .fragment_bit = true },
                .module = frag_state.module.shad,
                .p_name = frag_state.entry_point,
                .p_specialization_info = null,
            };
            std.debug.assert(frag_state.constants.len == 0); // TODO: specialization constants
            stage_count += 1;
        }

        // Create vertex state info
        const vbinds = try allocator.alloc(vk.VertexInputBindingDescription, opts.vertex.buffers.len);
        defer allocator.free(vbinds);
        var vattrs = std.ArrayList(vk.VertexInputAttributeDescription).init(allocator);
        defer vattrs.deinit();
        for (opts.vertex.buffers) |buf, i| {
            const bind = @intCast(u32, i);
            vbinds[i] = .{
                .binding = bind,
                .stride = buf.array_stride,
                .input_rate = buf.step_mode,
            };
            for (buf.attributes) |attr| {
                try vattrs.append(.{
                    .location = attr.shader_location,
                    .binding = bind,
                    .format = switch (attr.format) {
                        .uint8x2 => .r8g8_uint,
                        .uint8x4 => .r8g8b8a8_uint,
                        .sint8x2 => .r8g8_sint,
                        .sint8x4 => .r8g8b8a8_sint,
                        .unorm8x2 => .r8g8_unorm,
                        .unorm8x4 => .r8g8b8a8_unorm,
                        .snorm8x2 => .r8g8_snorm,
                        .snorm8x4 => .r8g8b8a8_snorm,

                        .uint16x2 => .r16g16_uint,
                        .uint16x4 => .r16g16b16a16_uint,
                        .sint16x2 => .r16g16_sint,
                        .sint16x4 => .r16g16b16a16_sint,
                        .unorm16x2 => .r16g16_unorm,
                        .unorm16x4 => .r16g16b16a16_unorm,
                        .snorm16x2 => .r16g16_snorm,
                        .snorm16x4 => .r16g16b16a16_snorm,

                        .float16x2 => .r16g16_sfloat,
                        .float16x4 => .r16g16b16a16_sfloat,

                        .float32 => .r16_sfloat,
                        .float32x2 => .r16g16_sfloat,
                        .float32x3 => .r16g16b16_sfloat,
                        .float32x4 => .r16g16b16a16_sfloat,

                        .uint32 => .r32_uint,
                        .uint32x2 => .r32g32_uint,
                        .uint32x3 => .r32g32b32_uint,
                        .uint32x4 => .r32g32b32a32_uint,
                        .sint32 => .r32_sint,
                        .sint32x2 => .r32g32_sint,
                        .sint32x3 => .r32g32b32_sint,
                        .sint32x4 => .r32g32b32a32_sint,
                    },
                    .offset = attr.offset,
                });
            }
        }

        // Create blend attachment info
        var blend_attachments = try allocator.alloc(vk.PipelineColorBlendAttachmentState, attachments.len);
        defer allocator.free(blend_attachments);
        for (blend_attachments) |*vk_blend, i| {
            const target = opts.fragment.?.targets[i];
            if (target.blend) |blend| {
                vk_blend.* = .{
                    .blend_enable = vk.TRUE,
                    .src_color_blend_factor = blend.color.src_factor,
                    .dst_color_blend_factor = blend.color.dst_factor,
                    .color_blend_op = blend.color.operation,
                    .src_alpha_blend_factor = blend.alpha.src_factor,
                    .dst_alpha_blend_factor = blend.alpha.dst_factor,
                    .alpha_blend_op = blend.alpha.operation,
                    .color_write_mask = .{
                        .r_bit = target.write_mask.red,
                        .g_bit = target.write_mask.green,
                        .b_bit = target.write_mask.blue,
                        .a_bit = target.write_mask.alpha,
                    },
                };
            } else {
                vk_blend.blend_enable = vk.FALSE;
            }
        }

        // Create pipeline
        var pipelines: [1]vk.Pipeline = undefined;
        _ = try dev.vkd.createGraphicsPipelines(dev.dev, .null_handle, 1, &[1]vk.GraphicsPipelineCreateInfo{.{
            .flags = .{},

            .stage_count = stage_count,
            .p_stages = &shader_stages,

            .p_vertex_input_state = &.{
                .flags = .{},
                .vertex_binding_description_count = @intCast(u32, vbinds.len),
                .p_vertex_binding_descriptions = vbinds.ptr,
                .vertex_attribute_description_count = @intCast(u32, vattrs.items.len),
                .p_vertex_attribute_descriptions = vattrs.items.ptr,
            },

            .p_input_assembly_state = &.{
                .flags = .{},
                .topology = opts.primitive.topology,
                .primitive_restart_enable = vk.FALSE,
            },

            .p_tessellation_state = null,

            .p_viewport_state = &.{
                .flags = .{},
                .viewport_count = 1,
                .p_viewports = undefined, // Dynamic
                .scissor_count = 1,
                .p_scissors = undefined, // Dynamic
            },

            .p_rasterization_state = &.{
                .flags = .{},
                .depth_clamp_enable = vk.FALSE,
                .rasterizer_discard_enable = vk.FALSE,
                .polygon_mode = .fill, // TODO: Having a "wireframe" extension might be nice for debugging
                .cull_mode = switch (opts.primitive.cull_mode) {
                    .none => vk.CullModeFlags{},
                    .front => .{ .front_bit = true },
                    .back => .{ .back_bit = true },
                },
                .front_face = switch (opts.primitive.front_face) {
                    .ccw => vk.FrontFace.counter_clockwise,
                    .cw => .clockwise,
                },

                // TODO: I'm mostly guessing on how this works. The WebGPU spec doesn't really cover it
                // TODO: this code is ugly as fuck, think about how to clean it up
                .depth_bias_enable = if (opts.depth_stencil) |ds|
                    @boolToInt(ds.depth_bias != 0 or ds.depth_bias_slope_scale != 0)
                else
                    vk.FALSE,
                .depth_bias_constant_factor = if (opts.depth_stencil) |ds|
                    @intToFloat(f32, ds.depth_bias)
                else
                    undefined,
                .depth_bias_clamp = if (opts.depth_stencil) |ds|
                    ds.depth_bias_clamp
                else
                    undefined,
                .depth_bias_slope_factor = if (opts.depth_stencil) |ds|
                    ds.depth_bias_slope_scale
                else
                    undefined,

                .line_width = 1,
            },

            .p_multisample_state = &.{
                .flags = .{},
                .rasterization_samples = multisample_count_vk,
                .sample_shading_enable = vk.FALSE,
                .min_sample_shading = undefined,
                .p_sample_mask = &[1]u32{opts.multisample.mask},
                .alpha_to_coverage_enable = @boolToInt(opts.multisample.alpha_to_coverage_enabled),
                .alpha_to_one_enable = vk.FALSE,
            },

            .p_depth_stencil_state = if (opts.depth_stencil) |ds| &.{
                .flags = .{},
                .depth_test_enable = vk.TRUE,
                .depth_write_enable = @boolToInt(ds.depth_write_enabled),
                .depth_compare_op = ds.depth_compare,
                .depth_bounds_test_enable = vk.FALSE,
                .stencil_test_enable = @boolToInt(ds.stencil_read_mask != 0 or ds.stencil_write_mask != 0),
                .front = .{
                    .fail_op = ds.stencil_front.fail_op,
                    .depth_fail_op = ds.stencil_front.depth_fail_op,
                    .pass_op = ds.stencil_front.pass_op,
                    .compare_op = ds.stencil_front.compare,
                    .compare_mask = ds.stencil_read_mask,
                    .write_mask = ds.stencil_write_mask,
                    .reference = 0,
                },
                .back = .{
                    .fail_op = ds.stencil_back.fail_op,
                    .depth_fail_op = ds.stencil_back.depth_fail_op,
                    .pass_op = ds.stencil_back.pass_op,
                    .compare_op = ds.stencil_back.compare,
                    .compare_mask = ds.stencil_read_mask,
                    .write_mask = ds.stencil_write_mask,
                    .reference = 0,
                },
                .min_depth_bounds = undefined,
                .max_depth_bounds = undefined,
            } else &.{
                .flags = .{},
                .depth_test_enable = vk.FALSE,
                .depth_write_enable = undefined,
                .depth_compare_op = undefined,
                .depth_bounds_test_enable = vk.FALSE,
                .stencil_test_enable = vk.FALSE,
                .front = undefined,
                .back = undefined,
                .min_depth_bounds = undefined,
                .max_depth_bounds = undefined,
            },

            .p_color_blend_state = &.{
                .flags = .{},
                .logic_op_enable = vk.FALSE,
                .logic_op = undefined,
                .attachment_count = @intCast(u32, blend_attachments.len),
                .p_attachments = blend_attachments.ptr,
                .blend_constants = .{ 0, 0, 0, 0 },
            },

            .p_dynamic_state = &.{
                .flags = .{},
                .dynamic_state_count = dynamic_states.len,
                .p_dynamic_states = &dynamic_states,
            },

            .layout = opts.layout.layout,
            .render_pass = render_pass,
            .subpass = 0,

            .base_pipeline_handle = .null_handle,
            .base_pipeline_index = -1,
        }}, dev.vk_alloc, &pipelines);
        return RenderPipeline{
            .d = dev,
            .pipeline = pipelines[0],
            .pass = render_pass,
        };
    }

    const dynamic_states = [_]vk.DynamicState{
        .viewport, .scissor, .stencil_reference, .blend_constants,
        // TODO: lots more
    };

    pub fn deinit(self: RenderPipeline) void {
        self.d.vkd.destroyPipeline(self.d.dev, self.pipeline, self.d.vk_alloc);
        self.d.vkd.destroyRenderPass(self.d.dev, self.pass, self.d.vk_alloc);
    }
};

pub const SwapChain = struct {
    d: *const Device,
    chain: vk.SwapchainKHR,
    views: []const TextureView,

    pub const InitOptions = struct {
        usage: TextureUsage,
        format: TextureFormat,
        width: u32,
        height: u32,
        present_mode: PresentMode,
    };
    pub const PresentMode = enum {
        immediate,
        mailbox,
        fifo,
    };

    pub fn init(dev: *const Device, surf: Surface, opts: InitOptions) !SwapChain {
        const surf_format = try surf.getPreferredFormatVk(dev.adapter.*);
        const swapchain = try dev.vkd.createSwapchainKHR(dev.dev, .{
            .flags = .{},
            .surface = surf.surf,
            .min_image_count = 2, // TODO: this might not be right, idk
            .image_format = opts.format,
            .image_color_space = surf_format.color_space,
            .image_extent = .{
                .width = opts.width,
                .height = opts.height,
            },
            .image_array_layers = 1,
            .image_usage = .{
                .transfer_src_bit = opts.usage.copy_src,
                .transfer_dst_bit = opts.usage.copy_dst,
                .sampled_bit = opts.usage.texture_binding,
                .storage_bit = opts.usage.storage_binding,
                .color_attachment_bit = opts.usage.render_attachment,
                .depth_stencil_attachment_bit = opts.usage.render_attachment, // TODO: Not sure about this
            },
            .image_sharing_mode = .exclusive, // FIXME: this is probably wrong but I'm lazy
            .queue_family_index_count = 0,
            .p_queue_family_indices = undefined,
            .pre_transform = .{ .identity_bit_khr = true },
            .composite_alpha = .{ .inherit_bit_khr = true }, // TODO: extension to control this
            .present_mode = switch (opts.present_mode) {
                .immediate => .immediate_khr,
                .mailbox => .mailbox_khr,
                .fifo => .fifo_khr,
            },
            .clipped = vk.FALSE, // TODO: check if WebGPU actually requires this. If it does, add an extension to control it
            .old_swapchain = .null_handle, // TODO: extension
        }, dev.vk_alloc);
        errdefer dev.vkd.destroySwapchainKHR(dev.dev, swapchain, dev.vk_alloc);

        // Get swapchain images
        const allocator = vk.allocator.unwrap(dev.vk_alloc);
        var image_count: u32 = undefined;
        _ = try dev.vkd.getSwapchainImagesKHR(dev.dev, swapchain, &image_count, null);
        const images = try allocator.alloc(vk.Image, image_count);
        defer allocator.free(images);
        _ = try dev.vkd.getSwapchainImagesKHR(dev.dev, swapchain, &image_count, images.ptr);

        // Wrap images in views
        const views = try allocator.alloc(TextureView, image_count);
        errdefer allocator.free(views);
        for (images[0..image_count]) |img, i| {
            views[i] = try TextureView.init(.{
                .d = dev,
                .img = img,
                .size = .{
                    .width = opts.width,
                    .height = opts.height,
                    .depth = 1,
                },
            }, .{
                .format = opts.format,
                .dimension = .@"2d",
                .mip_level_count = 1,
                .array_layer_count = 1,
            });
        }

        return SwapChain{
            .d = dev,
            .chain = swapchain,
            .views = views,
        };
    }

    pub fn deinit(self: SwapChain) void {
        for (self.views) |view| {
            view.deinit();
        }
        const allocator = vk.allocator.unwrap(self.d.vk_alloc);
        allocator.free(self.views);
        self.d.vkd.destroySwapchainKHR(self.d.dev, self.chain, self.d.vk_alloc);
    }

    pub fn getCurrentTextureView(self: SwapChain) !TextureView {
        const res = try self.d.vkd.acquireNextImageKHR(
            self.d.dev,
            self.chain,
            std.time.ns_per_s, // If it takes this long, something's gone very wrong
            .null_handle,
            .null_handle,
        );
        switch (res.result) {
            .success => {},
            .timeout => return error.Timeout,
            else => unreachable,
        }
        return self.views[res.image_index];
    }
};

pub const Texture = struct {
    d: *const Device,
    img: vk.Image,
    size: vk.Extent3D,
};

pub const TextureView = struct {
    d: *const Device,
    view: vk.ImageView,
    format: TextureFormat,
    size: vk.Extent3D,

    pub const InitOptions = struct {
        format: TextureFormat,
        dimension: Dimension,
        aspect: TextureAspect = .all,
        base_mip_level: u32 = 0,
        mip_level_count: u32,
        base_array_layer: u32 = 0,
        array_layer_count: u32,
    };
    pub const Dimension = vk.ImageViewType;

    pub fn init(tex: Texture, opts: InitOptions) !TextureView {
        const view = try tex.d.vkd.createImageView(tex.d.dev, .{
            .flags = .{},
            .image = tex.img,
            .view_type = opts.dimension,
            .format = opts.format,
            .components = .{
                .r = .identity,
                .g = .identity,
                .b = .identity,
                .a = .identity,
            },
            .subresource_range = .{
                .aspect_mask = switch (opts.aspect) {
                    .all => vk.ImageAspectFlags{
                        .color_bit = true,
                        .depth_bit = true,
                        .stencil_bit = true,
                    },
                    .stencil_only => .{ .stencil_bit = true },
                    .depth_only => .{ .depth_bit = true },
                },
                .base_mip_level = opts.base_mip_level,
                .level_count = opts.mip_level_count,
                .base_array_layer = opts.base_array_layer,
                .layer_count = opts.array_layer_count,
            },
        }, tex.d.vk_alloc);
        return TextureView{
            .d = tex.d,
            .view = view,
            .format = opts.format,
            .size = tex.size,
        };
    }

    pub fn deinit(self: TextureView) void {
        self.d.vkd.destroyImageView(self.d.dev, self.view, self.d.vk_alloc);
    }
};

// TODO: move these to un-prefixed names under Texture?
pub const TextureFormat = vk.Format;
pub const TextureUsage = packed struct {
    copy_src: bool = false,
    copy_dst: bool = false,
    texture_binding: bool = false,
    storage_binding: bool = false,
    render_attachment: bool = false,
};
pub const TextureAspect = enum {
    all,
    stencil_only,
    depth_only,
};

// TODO: currently we only allow render or compute passes, not both. Obviously, we need to be able
//       to mix them to comply with WebGPU spec. The way to do this is probably to sync two command
//       buffers (using semaphores) if the graphics and compute queue families are different.
pub const CommandEncoder = struct {
    d: *const Device,
    state: enum { init, graphics, compute, finished } = .init,
    buf: vk.CommandBuffer = undefined,

    pub fn init(dev: *const Device) CommandEncoder {
        return .{ .d = dev };
    }

    pub fn deinit(self: CommandEncoder) void {
        const pool = switch (self.state) {
            .init => return,
            .graphics => self.d.graphics_pool,
            .compute => self.d.compute_pool,
            .finished => unreachable,
        };
        self.d.vkd.freeCommandBuffers(self.d.dev, pool, &.{self.buf}, self.d.vk_alloc);
    }

    pub const RenderPassOptions = struct {
        color_attachments: []const ColorAttachment,
        depth_stencil_attachment: ?DepthStencilAttachment = null,
        occlusion_query_set: ?QuerySet = null,

        pub const ColorAttachment = struct {
            view: TextureView,
            resolve_target: ?TextureView = null,
            load_op: LoadOp,
            store_op: StoreOp,
            clear_color: Color,
        };

        pub const DepthStencilAttachment = struct {
            view: TextureView,

            depth_load_op: LoadOp,
            depth_store_op: StoreOp,
            clear_depth: f32,
            depth_read_only: bool = false,

            stencil_load_op: LoadOp,
            stencil_store_op: StoreOp,
            clear_stencil: u32,
            stencil_read_only: bool = false,
        };
    };

    pub fn beginRenderPass(self: *CommandEncoder, opts: RenderPassOptions) !RenderPassEncoder {
        switch (self.state) {
            .init => {
                self.state = .graphics;
                var bufs: [1]vk.CommandBuffer = undefined;
                try self.d.vkd.allocateCommandBuffers(self.d.dev, .{
                    .command_pool = self.d.graphics_pool,
                    .level = .primary,
                    .command_buffer_count = 1,
                }, &bufs);
                self.buf = bufs[0];

                try self.d.vkd.beginCommandBuffer(self.buf, .{
                    .flags = .{ .one_time_submit_bit = true },
                    .p_inheritance_info = undefined,
                });
            },
            .graphics => {},
            .compute => @panic("TODO: allow mixing graphics and compute"),
            .finished => unreachable,
        }

        if (opts.occlusion_query_set != null) {
            @panic("TODO: occlusion query set");
        }

        const allocator = vk.allocator.unwrap(self.d.vk_alloc);
        const pass_attach = try allocator.alloc(
            vk.AttachmentDescription,
            opts.color_attachments.len + @boolToInt(opts.depth_stencil_attachment != null),
        );
        defer allocator.free(pass_attach);
        const fbuf_attach = try allocator.alloc(vk.ImageView, pass_attach.len);
        defer allocator.free(fbuf_attach);
        const clear_values = try allocator.alloc(vk.ClearValue, pass_attach.len);
        defer allocator.free(clear_values);

        for (opts.color_attachments) |attach, i| {
            pass_attach[i] = .{
                .flags = .{ .may_alias_bit = true }, // TODO: do we actually need this? Check spec
                .format = attach.view.format,
                .samples = .{ .@"1_bit" = true }, // FIXME: detect from the image view
                .load_op = attach.load_op,
                .store_op = attach.store_op,
                .stencil_load_op = .dont_care,
                .stencil_store_op = .dont_care,
                .initial_layout = .general,
                .final_layout = .general,
            };
            if (attach.load_op != .load or attach.store_op != .store) {
                @panic("TODO: make pipeline creation lazy");
            }

            fbuf_attach[i] = attach.view.view;

            if (attach.load_op == .clear) {
                clear_values[i] = .{
                    .color = @panic("TODO: clear value type conversion"),
                };
            }
        }

        if (opts.depth_stencil_attachment) |attach| {
            const i = pass_attach.len - 1;

            pass_attach[i] = .{
                .flags = .{ .may_alias_bit = true }, // TODO: do we actually need this? Check spec
                .format = attach.view.format,
                .samples = .{ .@"1_bit" = true }, // FIXME: detect from the image view
                .load_op = attach.depth_load_op,
                .store_op = attach.depth_store_op,
                .stencil_load_op = attach.stencil_load_op,
                .stencil_store_op = attach.stencil_store_op,
                .initial_layout = .general,
                .final_layout = .general,
            };
            if (attach.depth_load_op != .load or attach.depth_store_op != .store) {
                @panic("TODO: make pipeline creation lazy");
            }
            if (attach.stencil_load_op != .load or attach.stencil_store_op != .store) {
                @panic("TODO: make pipeline creation lazy");
            }

            fbuf_attach[i] = attach.view.view;

            if (attach.depth_load_op == .clear or attach.stencil_load_op == .clear) {
                clear_values[i] = .{
                    .depth_stencil = .{
                        .depth = attach.clear_depth,
                        .stencil = attach.clear_stencil,
                    },
                };
            }
        }

        // Create render pass
        // TODO: caching
        const render_pass = try self.d.vkd.createRenderPass(self.d.dev, .{
            .flags = .{},
            .attachment_count = @intCast(u32, pass_attach.len),
            .p_attachments = pass_attach.ptr,
            .subpass_count = 0,
            .p_subpasses = undefined,
            .dependency_count = 0,
            .p_dependencies = undefined,
        }, self.d.vk_alloc);

        // Create framebuffer
        // TODO: caching
        const fbuf_size = if (opts.color_attachments.len > 0)
            opts.color_attachments[0].view.size
        else
            opts.depth_stencil_attachment.?.view.size;
        const framebuffer = try self.d.vkd.createFramebuffer(self.d.dev, .{
            .flags = .{},
            .render_pass = render_pass,
            .attachment_count = @intCast(u32, fbuf_attach.len),
            .p_attachments = fbuf_attach.ptr,
            .width = fbuf_size.width,
            .height = fbuf_size.height,
            .layers = fbuf_size.depth,
        }, self.d.vk_alloc);

        // FIXME: render_pass and framebuffer need to be deleted

        // Begin render pass on command buffer
        self.d.vkd.cmdBeginRenderPass(self.buf, .{
            .render_pass = render_pass,
            .framebuffer = framebuffer,
            .render_area = .{
                .offset = .{ .x = 0, .y = 0 },
                .extent = .{
                    .width = fbuf_size.width,
                    .height = fbuf_size.height,
                },
            },
            .clear_value_count = @intCast(u32, clear_values.len),
            .p_clear_values = clear_values.ptr,
        }, .@"inline");

        return RenderPassEncoder{ .enc = self };
    }

    pub fn finish(self: *CommandEncoder) !CommandBuffer {
        const kind: CommandBuffer.Kind = switch (self.state) {
            .init => .graphics, // We need to choose one :)
            .graphics => .graphics,
            .compute => .compute,
            .finished => unreachable,
        };
        try self.d.vkd.endCommandBuffer(self.buf);
        return CommandBuffer{
            .buf = self.buf,
            .kind = kind,
        };
    }

    fn cmd(self: CommandEncoder, comptime name: @Type(.EnumLiteral), args: anytype) void {
        std.debug.assert(self.state != .finished);

        // Turn commandName into cmdCommandName
        const name_str = @tagName(name);
        const full_name = "cmd" ++
            [1]u8{std.ascii.toUpper(name_str[0])} ++
            name_str[1..];

        // Stick the dispatch and the buffer on the front of the arg list
        const full_args = .{ self.d.vkd, self.buf } ++ args;

        // Call the function
        @call(.{}, @field(vk.DeviceDispatch, full_name), full_args);
    }
};

pub const CommandBuffer = struct {
    buf: vk.CommandBuffer,
    kind: Kind,
    const Kind = enum { graphics, compute };
};

pub const RenderPassEncoder = extern struct {
    enc: *CommandEncoder,

    pub fn endPass(self: RenderPassEncoder) void {
        self.enc.cmd(.endRenderPass, .{});
    }

    pub fn draw(
        self: RenderPassEncoder,
        vertex_count: u32,
        instance_count: u32,
        first_vertex: u32,
        first_instance: u32,
    ) void {
        self.enc.cmd(.draw, .{ vertex_count, instance_count, first_vertex, first_instance });
    }

    pub fn setPipeline(self: RenderPassEncoder, pipeline: RenderPipeline) void {
        self.enc.cmd(.bindPipeline, .{ .graphics, pipeline.pipeline });
    }
};

pub const LoadOp = vk.AttachmentLoadOp;
pub const StoreOp = vk.AttachmentStoreOp;

pub const Color = struct {
    r: f64,
    g: f64,
    b: f64,
    a: f64,

    pub fn rgba(r: f64, g: f64, b: f64, a: f64) Color {
        return .{ .r = r, .g = g, .b = b, .a = a };
    }
};

pub const QuerySet = struct {
    d: *const Device,
    // TODO
};
