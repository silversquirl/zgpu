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
    vk_alloc: vk.AllocationCallbacks,
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
        }, &self.vk_alloc);
        self.vki = try vk.InstanceDispatch.load(self.instance, self.vkb.dispatch.vkGetInstanceProcAddr);
        errdefer self.vki.destroyInstance(self.instance, &self.vk_alloc);

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
        self.vki.destroyInstance(self.instance, &self.vk_alloc);
        vk.loader.deref();
    }
};

pub const Adapter = struct {
    i: *Instance,
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

    pub fn init(instance: *Instance, opts: InitOptions) !Adapter {
        var self: Adapter = undefined;
        self.i = instance;
        const allocator = vk.allocator.unwrap(self.i.vk_alloc);

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
    i: *Instance,
    vkd: vk.DeviceDispatch,
    dev: vk.Device,

    pub const InitOptions = struct {
        // TODO: features
        required_limits: Limits,
    };

    pub fn init(adapter: *const Adapter, opts: InitOptions) !Device {
        var self: Device = undefined;
        self.i = adapter.i;

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

        self.dev = try self.i.vki.createDevice(adapter.pdev, .{
            .flags = .{},

            .queue_create_info_count = @intCast(u32, queue_infos.len),
            .p_queue_create_infos = queue_infos.ptr,

            .enabled_layer_count = 0,
            .pp_enabled_layer_names = undefined,

            .enabled_extension_count = 0,
            .pp_enabled_extension_names = undefined,

            .p_enabled_features = null,
        }, &self.i.vk_alloc);
        self.vkd = try vk.DeviceDispatch.load(self.dev, self.i.vki.dispatch.vkGetDeviceProcAddr);
        errdefer self.vkd.destroyDevice(self.dev, &self.i.vk_alloc);

        return self;
    }

    pub fn deinit(self: Device) void {
        self.vkd.destroyDevice(self.dev, &self.i.vk_alloc);
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
    i: *Instance,
    surf: vk.SurfaceKHR,

    pub fn initGlfw(instance: *Instance, glfw_window: anytype) !Surface {
        const win = @ptrCast(*GlfwWindow, glfw_window);
        var surface: vk.SurfaceKHR = undefined;
        const res = glfwCreateWindowSurface(instance.instance, win, &instance.vk_alloc, &surface);
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
    extern fn glfwCreateWindowSurface(vk.Instance, *GlfwWindow, *vk.AllocationCallbacks, *vk.SurfaceKHR) vk.Result;
    const GlfwWindow = opaque {};
};

pub const ShaderModule = struct {
    d: *Device,
    shad: vk.ShaderModule,

    /// Create a shader module from SPIR-V source. Will autodetect the byte order.
    pub fn initSpirv(dev: *Device, code: []const u32) !ShaderModule {
        const spirv_magic = 0x07230203;
        switch (code[0]) {
            spirv_magic => return initSpirvNative(dev, code),

            @byteSwap(u32, spirv_magic) => {
                const allocator = vk.allocator.unwrap(dev.i.vk_alloc);
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

    fn initSpirvNative(dev: *Device, code: []const u32) !ShaderModule {
        const shad = try dev.vkd.createShaderModule(dev.dev, .{
            .flags = .{},
            .code_size = 4 * code.len,
            .p_code = code.ptr,
        }, &dev.i.vk_alloc);
        return ShaderModule{ .d = dev, .shad = shad };
    }

    pub fn deinit(self: ShaderModule) void {
        self.d.vkd.destroyShaderModule(self.d.dev, self.shad, &self.d.i.vk_alloc);
    }
};

pub const BindGroupLayout = struct {
    d: *Device,
    layout: vk.DescriptorSetLayout,

    // TODO
};

pub const PipelineLayout = struct {
    d: *Device,
    layout: vk.PipelineLayout,

    pub fn init(dev: *Device, bind_layouts: []const BindGroupLayout) !PipelineLayout {
        const allocator = vk.allocator.unwrap(dev.i.vk_alloc);
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
        }, &dev.i.vk_alloc);

        return PipelineLayout{ .d = dev, .layout = pipeline_layout };
    }

    pub fn deinit(self: PipelineLayout) void {
        self.d.vkd.destroyPipelineLayout(self.d.dev, self.layout, &self.d.i.vk_alloc);
    }
};
