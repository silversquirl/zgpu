pub const BufferMapCallback = fn (
    status: BufferMapAsyncStatus,
    userdata: *c_void,
) callconv(.C) void;

pub const CreateComputePipelineAsyncCallback = fn (
    status: CreatePipelineAsyncStatus,
    pipeline: ComputePipeline,
    message: [*:0]const u8,
    userdata: *c_void,
) callconv(.C) void;

pub const CreateRenderPipelineAsyncCallback = fn (
    status: CreatePipelineAsyncStatus,
    pipeline: RenderPipeline,
    message: [*:0]const u8,
    userdata: *c_void,
) callconv(.C) void;

pub const DeviceLostCallback = fn (
    reason: DeviceLostReason,
    message: [*:0]const u8,
    userdata: *c_void,
) callconv(.C) void;

pub const ErrorCallback = fn (
    type: ErrorType,
    message: [*:0]const u8,
    userdata: *c_void,
) callconv(.C) void;

pub const QueueWorkDoneCallback = fn (
    status: QueueWorkDoneStatus,
    userdata: *c_void,
) callconv(.C) void;

pub const RequestAdapterCallback = fn (
    status: RequestAdapterStatus,
    adapter: Adapter,
    message: ?[*:0]const u8,
    userdata: *c_void,
) callconv(.C) void;

pub const RequestDeviceCallback = fn (
    status: RequestDeviceStatus,
    device: Device,
    message: ?[*:0]const u8,
    userdata: *c_void,
) callconv(.C) void;

pub const createInstance = wgpuCreateInstance;
extern fn wgpuCreateInstance(descriptor: *const InstanceDescriptor) Instance;

pub const getProcAddress = wgpuGetProcAddress;
extern fn wgpuGetProcAddress(device: Device, proc_name: [*:0]const u8) Proc;
pub const Proc = fn () callconv(.C) void;

pub const Adapter = *opaque {
    pub const getLimits = wgpuAdapterGetLimits;
    extern fn wgpuAdapterGetLimits(adapter: Adapter, limits: *SupportedLimits) void;

    pub const getProperties = wgpuAdapterGetProperties;
    extern fn wgpuAdapterGetProperties(adapter: Adapter, properties: *AdapterProperties) void;

    pub const hasFeature = wgpuAdapterHasFeature;
    extern fn wgpuAdapterHasFeature(adapter: Adapter, feature: FeatureName) bool;

    pub const requestDevice = wgpuAdapterRequestDevice;
    extern fn wgpuAdapterRequestDevice(
        adapter: Adapter,
        descriptor: *const DeviceDescriptor,
        callback: RequestDeviceCallback,
        userdata: *c_void,
    ) void;
};

pub const BindGroup = *opaque {
    // WGPU extras
    pub const drop = wgpuBindGroupDrop;
    extern fn wgpuBindGroupDrop(bind_group: BindGroup) void;
};

pub const BindGroupLayout = *opaque {
    // WGPU extras
    pub const drop = wgpuBindGroupLayoutDrop;
    extern fn wgpuBindGroupLayoutDrop(bind_group_layout: BindGroupLayout) void;
};

pub const Buffer = *opaque {
    pub const destroy = wgpuBufferDestroy;
    extern fn wgpuBufferDestroy(buffer: Buffer) void;

    pub const getConstMappedRange = wgpuBufferGetConstMappedRange;
    extern fn wgpuBufferGetConstMappedRange(buffer: Buffer, offset: usize, size: usize) *const c_void;

    pub const getMappedRange = wgpuBufferGetMappedRange;
    extern fn wgpuBufferGetMappedRange(buffer: Buffer, offset: usize, size: usize) *c_void;

    pub const mapAsync = wgpuBufferMapAsync;
    extern fn wgpuBufferMapAsync(
        buffer: Buffer,
        mode: MapMode,
        offset: usize,
        size: usize,
        callback: BufferMapCallback,
        userdata: *c_void,
    ) void;

    pub const unmap = wgpuBufferUnmap;
    extern fn wgpuBufferUnmap(buffer: Buffer) void;

    // WGPU extras
    pub const drop = wgpuBufferDrop;
    extern fn wgpuBufferDrop(buffer: Buffer) void;
};

pub const CommandBuffer = *opaque {
    // WGPU extras
    pub const drop = wgpuCommandBufferDrop;
    extern fn wgpuCommandBufferDrop(command_buffer: CommandBuffer) void;
};

pub const CommandEncoder = *opaque {
    pub const beginComputePass = wgpuCommandEncoderBeginComputePass;
    extern fn wgpuCommandEncoderBeginComputePass(
        command_encoder: CommandEncoder,
        descriptor: *const ComputePassDescriptor,
    ) ComputePassEncoder;

    pub const beginRenderPass = wgpuCommandEncoderBeginRenderPass;
    extern fn wgpuCommandEncoderBeginRenderPass(
        command_encoder: CommandEncoder,
        descriptor: *const RenderPassDescriptor,
    ) RenderPassEncoder;

    pub const copyBufferToBuffer = wgpuCommandEncoderCopyBufferToBuffer;
    extern fn wgpuCommandEncoderCopyBufferToBuffer(
        command_encoder: CommandEncoder,
        source: Buffer,
        source_offset: u64,
        destination: Buffer,
        destination_offset: u64,
        size: u64,
    ) void;

    pub const copyBufferToTexture = wgpuCommandEncoderCopyBufferToTexture;
    extern fn wgpuCommandEncoderCopyBufferToTexture(
        command_encoder: CommandEncoder,
        source: *const ImageCopyBuffer,
        destination: *const ImageCopyTexture,
        copy_size: *const Extent3D,
    ) void;

    pub const copyTextureToBuffer = wgpuCommandEncoderCopyTextureToBuffer;
    extern fn wgpuCommandEncoderCopyTextureToBuffer(
        command_encoder: CommandEncoder,
        source: *const ImageCopyTexture,
        destination: *const ImageCopyBuffer,
        copy_size: *const Extent3D,
    ) void;

    pub const copyTextureToTexture = wgpuCommandEncoderCopyTextureToTexture;
    extern fn wgpuCommandEncoderCopyTextureToTexture(
        command_encoder: CommandEncoder,
        source: *const ImageCopyTexture,
        destination: *const ImageCopyTexture,
        copy_size: *const Extent3D,
    ) void;

    pub const finish = wgpuCommandEncoderFinish;
    extern fn wgpuCommandEncoderFinish(
        command_encoder: CommandEncoder,
        descriptor: *const CommandBufferDescriptor,
    ) CommandBuffer;

    pub const insertDebugMarker = wgpuCommandEncoderInsertDebugMarker;
    extern fn wgpuCommandEncoderInsertDebugMarker(command_encoder: CommandEncoder, marker_label: [*:0]const u8) void;

    pub const popDebugGroup = wgpuCommandEncoderPopDebugGroup;
    extern fn wgpuCommandEncoderPopDebugGroup(command_encoder: CommandEncoder) void;

    pub const pushDebugGroup = wgpuCommandEncoderPushDebugGroup;
    extern fn wgpuCommandEncoderPushDebugGroup(command_encoder: CommandEncoder, group_label: [*:0]const u8) void;

    pub const resolveQuerySet = wgpuCommandEncoderResolveQuerySet;
    extern fn wgpuCommandEncoderResolveQuerySet(
        command_encoder: CommandEncoder,
        query_set: QuerySet,
        first_query: u32,
        query_count: u32,
        destination: Buffer,
        destination_offset: u64,
    ) void;

    pub const writeTimestamp = wgpuCommandEncoderWriteTimestamp;
    extern fn wgpuCommandEncoderWriteTimestamp(
        command_encoder: CommandEncoder,
        query_set: QuerySet,
        query_index: u32,
    ) void;

    // WGPU extras
    pub const drop = wgpuCommandEncoderDrop;
    extern fn wgpuCommandEncoderDrop(command_encoder: CommandEncoder) void;
};

pub const ComputePassEncoder = *opaque {
    pub const beginPipelineStatisticsQuery = wgpuComputePassEncoderBeginPipelineStatisticsQuery;
    extern fn wgpuComputePassEncoderBeginPipelineStatisticsQuery(
        compute_pass_encoder: ComputePassEncoder,
        query_set: QuerySet,
        query_index: u32,
    ) void;

    pub const dispatch = wgpuComputePassEncoderDispatch;
    extern fn wgpuComputePassEncoderDispatch(compute_pass_encoder: ComputePassEncoder, x: u32, y: u32, z: u32) void;

    pub const dispatchIndirect = wgpuComputePassEncoderDispatchIndirect;
    extern fn wgpuComputePassEncoderDispatchIndirect(
        compute_pass_encoder: ComputePassEncoder,
        indirect_buffer: Buffer,
        indirect_offset: u64,
    ) void;

    pub const endPass = wgpuComputePassEncoderEndPass;
    extern fn wgpuComputePassEncoderEndPass(compute_pass_encoder: ComputePassEncoder) void;

    pub const endPipelineStatisticsQuery = wgpuComputePassEncoderEndPipelineStatisticsQuery;
    extern fn wgpuComputePassEncoderEndPipelineStatisticsQuery(compute_pass_encoder: ComputePassEncoder) void;

    pub const insertDebugMarker = wgpuComputePassEncoderInsertDebugMarker;
    extern fn wgpuComputePassEncoderInsertDebugMarker(compute_pass_encoder: ComputePassEncoder, marker_label: [*:0]const u8) void;

    pub const popDebugGroup = wgpuComputePassEncoderPopDebugGroup;
    extern fn wgpuComputePassEncoderPopDebugGroup(compute_pass_encoder: ComputePassEncoder) void;

    pub const pushDebugGroup = wgpuComputePassEncoderPushDebugGroup;
    extern fn wgpuComputePassEncoderPushDebugGroup(compute_pass_encoder: ComputePassEncoder, group_label: [*:0]const u8) void;

    pub const setBindGroup = wgpuComputePassEncoderSetBindGroup;
    extern fn wgpuComputePassEncoderSetBindGroup(
        compute_pass_encoder: ComputePassEncoder,
        group_index: u32,
        group: BindGroup,
        dynamic_offset_count: u32,
        dynamic_offsets: [*]const u32,
    ) void;

    pub const setPipeline = wgpuComputePassEncoderSetPipeline;
    extern fn wgpuComputePassEncoderSetPipeline(compute_pass_encoder: ComputePassEncoder, pipeline: ComputePipeline) void;

    pub const writeTimestamp = wgpuComputePassEncoderWriteTimestamp;
    extern fn wgpuComputePassEncoderWriteTimestamp(
        compute_pass_encoder: ComputePassEncoder,
        query_set: QuerySet,
        query_index: u32,
    ) void;
};

pub const ComputePipeline = *opaque {
    pub const getBindGroupLayout = wgpuComputePipelineGetBindGroupLayout;
    extern fn wgpuComputePipelineGetBindGroupLayout(compute_pipeline: ComputePipeline, group_index: u32) BindGroupLayout;

    pub const setLabel = wgpuComputePipelineSetLabel;
    extern fn wgpuComputePipelineSetLabel(compute_pipeline: ComputePipeline, label: ?[*:0]const u8) void;

    // WGPU extras
    pub const drop = wgpuComputePipelineDrop;
    extern fn wgpuComputePipelineDrop(compute_pipeline: ComputePipeline) void;
};

pub const Device = *opaque {
    pub const createBindGroup = wgpuDeviceCreateBindGroup;
    extern fn wgpuDeviceCreateBindGroup(device: Device, descriptor: *const BindGroupDescriptor) BindGroup;

    pub const createBindGroupLayout = wgpuDeviceCreateBindGroupLayout;
    extern fn wgpuDeviceCreateBindGroupLayout(
        device: Device,
        descriptor: *const BindGroupLayoutDescriptor,
    ) BindGroupLayout;

    pub const createBuffer = wgpuDeviceCreateBuffer;
    extern fn wgpuDeviceCreateBuffer(device: Device, descriptor: *const BufferDescriptor) Buffer;

    pub const createCommandEncoder = wgpuDeviceCreateCommandEncoder;
    extern fn wgpuDeviceCreateCommandEncoder(
        device: Device,
        descriptor: *const CommandEncoderDescriptor,
    ) CommandEncoder;

    pub const createComputePipeline = wgpuDeviceCreateComputePipeline;
    extern fn wgpuDeviceCreateComputePipeline(
        device: Device,
        descriptor: *const ComputePipelineDescriptor,
    ) ComputePipeline;

    pub const createComputePipelineAsync = wgpuDeviceCreateComputePipelineAsync;
    extern fn wgpuDeviceCreateComputePipelineAsync(
        device: Device,
        descriptor: *const ComputePipelineDescriptor,
        callback: CreateComputePipelineAsyncCallback,
        userdata: *c_void,
    ) void;

    pub const createPipelineLayout = wgpuDeviceCreatePipelineLayout;
    extern fn wgpuDeviceCreatePipelineLayout(
        device: Device,
        descriptor: *const PipelineLayoutDescriptor,
    ) PipelineLayout;

    pub const createQuerySet = wgpuDeviceCreateQuerySet;
    extern fn wgpuDeviceCreateQuerySet(device: Device, descriptor: *const QuerySetDescriptor) QuerySet;

    pub const createRenderBundleEncoder = wgpuDeviceCreateRenderBundleEncoder;
    extern fn wgpuDeviceCreateRenderBundleEncoder(
        device: Device,
        descriptor: *const RenderBundleEncoderDescriptor,
    ) RenderBundleEncoder;

    pub const createRenderPipeline = wgpuDeviceCreateRenderPipeline;
    extern fn wgpuDeviceCreateRenderPipeline(
        device: Device,
        descriptor: *const RenderPipelineDescriptor,
    ) RenderPipeline;

    pub const createRenderPipelineAsync = wgpuDeviceCreateRenderPipelineAsync;
    extern fn wgpuDeviceCreateRenderPipelineAsync(
        device: Device,
        descriptor: *const RenderPipelineDescriptor,
        callback: CreateRenderPipelineAsyncCallback,
        userdata: *c_void,
    ) void;

    pub const createSampler = wgpuDeviceCreateSampler;
    extern fn wgpuDeviceCreateSampler(device: Device, descriptor: *const SamplerDescriptor) Sampler;

    pub const createShaderModule = wgpuDeviceCreateShaderModule;
    extern fn wgpuDeviceCreateShaderModule(device: Device, descriptor: *const ShaderModuleDescriptor) ShaderModule;

    pub const createSwapChain = wgpuDeviceCreateSwapChain;
    extern fn wgpuDeviceCreateSwapChain(
        device: Device,
        surface: Surface,
        descriptor: *const SwapChainDescriptor,
    ) SwapChain;

    pub const createTexture = wgpuDeviceCreateTexture;
    extern fn wgpuDeviceCreateTexture(device: Device, descriptor: *const TextureDescriptor) Texture;

    pub const destroy = wgpuDeviceDestroy;
    extern fn wgpuDeviceDestroy(device: Device) void;
    pub const getLimits = wgpuDeviceGetLimits;
    extern fn wgpuDeviceGetLimits(device: Device, limits: *SupportedLimits) bool;

    pub const getQueue = wgpuDeviceGetQueue;
    extern fn wgpuDeviceGetQueue(device: Device) Queue;

    pub const popErrorScope = wgpuDevicePopErrorScope;
    extern fn wgpuDevicePopErrorScope(device: Device, callback: ErrorCallback, userdata: *c_void) bool;

    pub const pushErrorScope = wgpuDevicePushErrorScope;
    extern fn wgpuDevicePushErrorScope(device: Device, filter: ErrorFilter) void;

    pub const setDeviceLostCallback = wgpuDeviceSetDeviceLostCallback;
    extern fn wgpuDeviceSetDeviceLostCallback(
        device: Device,
        callback: DeviceLostCallback,
        userdata: *c_void,
    ) void;

    pub const setUncapturedErrorCallback = wgpuDeviceSetUncapturedErrorCallback;
    extern fn wgpuDeviceSetUncapturedErrorCallback(
        device: Device,
        callback: ErrorCallback,
        userdata: *c_void,
    ) void;

    // WGPU extras
    pub const poll = wgpuDevicePoll;
    extern fn wgpuDevicePoll(device: Device, force_wait: bool) void;

    pub const drop = wgpuDeviceDrop;
    extern fn wgpuDeviceDrop(device: Device) void;
};

pub const Instance = *allowzero opaque {
    pub const createSurface = wgpuInstanceCreateSurface;
    extern fn wgpuInstanceCreateSurface(instance: Instance, descriptor: *const SurfaceDescriptor) Surface;

    pub const processEvents = wgpuInstanceProcessEvents;
    extern fn wgpuInstanceProcessEvents(instance: Instance) void;

    pub const requestAdapter = wgpuInstanceRequestAdapter;
    extern fn wgpuInstanceRequestAdapter(
        instance: Instance,
        options: *const RequestAdapterOptions,
        callback: RequestAdapterCallback,
        userdata: ?*c_void,
    ) void;
};
pub const base = @intToPtr(Instance, 0);

pub const PipelineLayout = *opaque {
    // WGPU extras
    pub const drop = wgpuPipelineLayoutDrop;
    extern fn wgpuPipelineLayoutDrop(pipeline_layout: PipelineLayout) void;
};

pub const QuerySet = *opaque {
    pub const destroy = wgpuQuerySetDestroy;
    extern fn wgpuQuerySetDestroy(query_set: QuerySet) void;

    // WGPU extras
    pub const drop = wgpuQuerySetDrop;
    extern fn wgpuQuerySetDrop(query_set: QuerySet) void;
};

pub const Queue = *opaque {
    pub const onSubmittedWorkDone = wgpuQueueOnSubmittedWorkDone;
    extern fn wgpuQueueOnSubmittedWorkDone(
        queue: Queue,
        signal_value: u64,
        callback: QueueWorkDoneCallback,
        userdata: *c_void,
    ) void;

    pub const submit = wgpuQueueSubmit;
    extern fn wgpuQueueSubmit(queue: Queue, command_count: u32, commands: [*]const CommandBuffer) void;

    pub const writeBuffer = wgpuQueueWriteBuffer;
    extern fn wgpuQueueWriteBuffer(
        queue: Queue,
        buffer: Buffer,
        buffer_offset: u64,
        data: *const c_void,
        size: usize,
    ) void;

    pub const writeTexture = wgpuQueueWriteTexture;
    extern fn wgpuQueueWriteTexture(
        queue: Queue,
        destination: *const ImageCopyTexture,
        data: *const c_void,
        data_size: usize,
        data_layout: *const TextureDataLayout,
        write_size: *const Extent3D,
    ) void;
};

pub const RenderBundle = *opaque {
    // WGPU extras
    pub const drop = wgpuRenderBundleDrop;
    extern fn wgpuRenderBundleDrop(render_bundle: RenderBundle) void;
};

pub const RenderBundleEncoder = *opaque {
    pub const draw = wgpuRenderBundleEncoderDraw;
    extern fn wgpuRenderBundleEncoderDraw(
        render_bundle_encoder: RenderBundleEncoder,
        vertex_count: u32,
        instance_count: u32,
        first_vertex: u32,
        first_instance: u32,
    ) void;

    pub const drawIndexed = wgpuRenderBundleEncoderDrawIndexed;
    extern fn wgpuRenderBundleEncoderDrawIndexed(
        render_bundle_encoder: RenderBundleEncoder,
        index_count: u32,
        instance_count: u32,
        first_index: u32,
        base_vertex: i32,
        first_instance: u32,
    ) void;

    pub const drawIndexedIndirect = wgpuRenderBundleEncoderDrawIndexedIndirect;
    extern fn wgpuRenderBundleEncoderDrawIndexedIndirect(
        render_bundle_encoder: RenderBundleEncoder,
        indirect_buffer: Buffer,
        indirect_offset: u64,
    ) void;

    pub const drawIndirect = wgpuRenderBundleEncoderDrawIndirect;
    extern fn wgpuRenderBundleEncoderDrawIndirect(
        render_bundle_encoder: RenderBundleEncoder,
        indirect_buffer: Buffer,
        indirect_offset: u64,
    ) void;

    pub const finish = wgpuRenderBundleEncoderFinish;
    extern fn wgpuRenderBundleEncoderFinish(
        render_bundle_encoder: RenderBundleEncoder,
        descriptor: *const RenderBundleDescriptor,
    ) RenderBundle;

    pub const insertDebugMarker = wgpuRenderBundleEncoderInsertDebugMarker;
    extern fn wgpuRenderBundleEncoderInsertDebugMarker(
        render_bundle_encoder: RenderBundleEncoder,
        marker_label: [*:0]const u8,
    ) void;

    pub const popDebugGroup = wgpuRenderBundleEncoderPopDebugGroup;
    extern fn wgpuRenderBundleEncoderPopDebugGroup(render_bundle_encoder: RenderBundleEncoder) void;

    pub const pushDebugGroup = wgpuRenderBundleEncoderPushDebugGroup;
    extern fn wgpuRenderBundleEncoderPushDebugGroup(
        render_bundle_encoder: RenderBundleEncoder,
        group_label: [*:0]const u8,
    ) void;

    pub const setBindGroup = wgpuRenderBundleEncoderSetBindGroup;
    extern fn wgpuRenderBundleEncoderSetBindGroup(
        render_bundle_encoder: RenderBundleEncoder,
        group_index: u32,
        group: BindGroup,
        dynamic_offset_count: u32,
        dynamic_offsets: [*]const u32,
    ) void;

    pub const setIndexBuffer = wgpuRenderBundleEncoderSetIndexBuffer;
    extern fn wgpuRenderBundleEncoderSetIndexBuffer(
        render_bundle_encoder: RenderBundleEncoder,
        buffer: Buffer,
        format: IndexFormat,
        offset: u64,
        size: u64,
    ) void;

    pub const setPipeline = wgpuRenderBundleEncoderSetPipeline;
    extern fn wgpuRenderBundleEncoderSetPipeline(render_bundle_encoder: RenderBundleEncoder, pipeline: RenderPipeline) void;

    pub const setVertexBuffer = wgpuRenderBundleEncoderSetVertexBuffer;
    extern fn wgpuRenderBundleEncoderSetVertexBuffer(
        render_bundle_encoder: RenderBundleEncoder,
        slot: u32,
        buffer: Buffer,
        offset: u64,
        size: u64,
    ) void;
};

pub const RenderPassEncoder = *opaque {
    pub const beginOcclusionQuery = wgpuRenderPassEncoderBeginOcclusionQuery;
    extern fn wgpuRenderPassEncoderBeginOcclusionQuery(render_pass_encoder: RenderPassEncoder, query_index: u32) void;

    pub const beginPipelineStatisticsQuery = wgpuRenderPassEncoderBeginPipelineStatisticsQuery;
    extern fn wgpuRenderPassEncoderBeginPipelineStatisticsQuery(
        render_pass_encoder: RenderPassEncoder,
        query_set: QuerySet,
        query_index: u32,
    ) void;

    pub const draw = wgpuRenderPassEncoderDraw;
    extern fn wgpuRenderPassEncoderDraw(
        render_pass_encoder: RenderPassEncoder,
        vertex_count: u32,
        instance_count: u32,
        first_vertex: u32,
        first_instance: u32,
    ) void;

    pub const drawIndexed = wgpuRenderPassEncoderDrawIndexed;
    extern fn wgpuRenderPassEncoderDrawIndexed(
        render_pass_encoder: RenderPassEncoder,
        index_count: u32,
        instance_count: u32,
        first_index: u32,
        base_vertex: i32,
        first_instance: u32,
    ) void;

    pub const drawIndexedIndirect = wgpuRenderPassEncoderDrawIndexedIndirect;
    extern fn wgpuRenderPassEncoderDrawIndexedIndirect(
        render_pass_encoder: RenderPassEncoder,
        indirect_buffer: Buffer,
        indirect_offset: u64,
    ) void;

    pub const drawIndirect = wgpuRenderPassEncoderDrawIndirect;
    extern fn wgpuRenderPassEncoderDrawIndirect(
        render_pass_encoder: RenderPassEncoder,
        indirect_buffer: Buffer,
        indirect_offset: u64,
    ) void;

    pub const endOcclusionQuery = wgpuRenderPassEncoderEndOcclusionQuery;
    extern fn wgpuRenderPassEncoderEndOcclusionQuery(render_pass_encoder: RenderPassEncoder) void;

    pub const endPass = wgpuRenderPassEncoderEndPass;
    extern fn wgpuRenderPassEncoderEndPass(render_pass_encoder: RenderPassEncoder) void;

    pub const endPipelineStatisticsQuery = wgpuRenderPassEncoderEndPipelineStatisticsQuery;
    extern fn wgpuRenderPassEncoderEndPipelineStatisticsQuery(render_pass_encoder: RenderPassEncoder) void;

    pub const executeBundles = wgpuRenderPassEncoderExecuteBundles;
    extern fn wgpuRenderPassEncoderExecuteBundles(
        render_pass_encoder: RenderPassEncoder,
        bundles_count: u32,
        bundles: *RenderBundle,
    ) void;

    pub const insertDebugMarker = wgpuRenderPassEncoderInsertDebugMarker;
    extern fn wgpuRenderPassEncoderInsertDebugMarker(render_pass_encoder: RenderPassEncoder, marker_label: [*:0]const u8) void;

    pub const popDebugGroup = wgpuRenderPassEncoderPopDebugGroup;
    extern fn wgpuRenderPassEncoderPopDebugGroup(render_pass_encoder: RenderPassEncoder) void;

    pub const pushDebugGroup = wgpuRenderPassEncoderPushDebugGroup;
    extern fn wgpuRenderPassEncoderPushDebugGroup(render_pass_encoder: RenderPassEncoder, group_label: [*:0]const u8) void;

    pub const setBindGroup = wgpuRenderPassEncoderSetBindGroup;
    extern fn wgpuRenderPassEncoderSetBindGroup(
        render_pass_encoder: RenderPassEncoder,
        group_index: u32,
        group: BindGroup,
        dynamic_offset_count: u32,
        dynamic_offsets: *u32,
    ) void;

    pub const setBlendConstant = wgpuRenderPassEncoderSetBlendConstant;
    extern fn wgpuRenderPassEncoderSetBlendConstant(render_pass_encoder: RenderPassEncoder, color: *Color) void;

    pub const setIndexBuffer = wgpuRenderPassEncoderSetIndexBuffer;
    extern fn wgpuRenderPassEncoderSetIndexBuffer(
        render_pass_encoder: RenderPassEncoder,
        buffer: Buffer,
        format: IndexFormat,
        offset: u64,
        size: u64,
    ) void;

    pub const setPipeline = wgpuRenderPassEncoderSetPipeline;
    extern fn wgpuRenderPassEncoderSetPipeline(render_pass_encoder: RenderPassEncoder, pipeline: RenderPipeline) void;

    pub const setScissorRect = wgpuRenderPassEncoderSetScissorRect;
    extern fn wgpuRenderPassEncoderSetScissorRect(
        render_pass_encoder: RenderPassEncoder,
        x: u32,
        y: u32,
        width: u32,
        height: u32,
    ) void;

    pub const setStencilReference = wgpuRenderPassEncoderSetStencilReference;
    extern fn wgpuRenderPassEncoderSetStencilReference(render_pass_encoder: RenderPassEncoder, reference: u32) void;

    pub const setVertexBuffer = wgpuRenderPassEncoderSetVertexBuffer;
    extern fn wgpuRenderPassEncoderSetVertexBuffer(
        render_pass_encoder: RenderPassEncoder,
        slot: u32,
        buffer: Buffer,
        offset: u64,
        size: u64,
    ) void;

    pub const setViewport = wgpuRenderPassEncoderSetViewport;
    extern fn wgpuRenderPassEncoderSetViewport(
        render_pass_encoder: RenderPassEncoder,
        x: f32,
        y: f32,
        width: f32,
        height: f32,
        min_depth: f32,
        max_depth: f32,
    ) void;

    pub const writeTimestamp = wgpuRenderPassEncoderWriteTimestamp;
    extern fn wgpuRenderPassEncoderWriteTimestamp(
        render_pass_encoder: RenderPassEncoder,
        query_set: QuerySet,
        query_index: u32,
    ) void;

    // WGPU extras
    pub const setPushConstants = wgpuRenderPassEncoderSetPushConstants;
    extern fn wgpuRenderPassEncoderSetPushConstants(
        encoder: RenderPassEncoder,
        stages: ShaderStage,
        offset: u32,
        sizeBytes: u32,
        data: *const c_void,
    ) void;
};

pub const RenderPipeline = *opaque {
    pub const getBindGroupLayout = wgpuRenderPipelineGetBindGroupLayout;
    extern fn wgpuRenderPipelineGetBindGroupLayout(render_pipeline: RenderPipeline, group_index: u32) BindGroupLayout;

    pub const setLabel = wgpuRenderPipelineSetLabel;
    extern fn wgpuRenderPipelineSetLabel(render_pipeline: RenderPipeline, label: ?[*:0]const u8) void;

    // WGPU extras
    pub const drop = wgpuRenderPipelineDrop;
    extern fn wgpuRenderPipelineDrop(render_pipeline: RenderPipeline) void;
};

pub const Sampler = *opaque {
    // WGPU extras
    pub const drop = wgpuSamplerDrop;
    extern fn wgpuSamplerDrop(sampler: Sampler) void;
};

pub const ShaderModule = *opaque {
    pub const setLabel = wgpuShaderModuleSetLabel;
    extern fn wgpuShaderModuleSetLabel(shader_module: ShaderModule, label: ?[*:0]const u8) void;

    // WGPU extras
    pub const drop = wgpuShaderModuleDrop;
    extern fn wgpuShaderModuleDrop(shader_module: ShaderModule) void;
};

pub const Surface = *opaque {
    pub const getPreferredFormat = wgpuSurfaceGetPreferredFormat;
    extern fn wgpuSurfaceGetPreferredFormat(
        surface: Surface,
        adapter: Adapter,
    ) TextureFormat;
};

pub const SwapChain = *opaque {
    pub const getCurrentTextureView = wgpuSwapChainGetCurrentTextureView;
    extern fn wgpuSwapChainGetCurrentTextureView(swap_chain: SwapChain) ?TextureView;

    pub const present = wgpuSwapChainPresent;
    extern fn wgpuSwapChainPresent(swap_chain: SwapChain) void;
};

pub const Texture = *opaque {
    pub const createView = wgpuTextureCreateView;
    extern fn wgpuTextureCreateView(texture: Texture, descriptor: *TextureViewDescriptor) TextureView;

    pub const destroy = wgpuTextureDestroy;
    extern fn wgpuTextureDestroy(texture: Texture) void;

    // WGPU extras
    pub const drop = wgpuTextureDrop;
    extern fn wgpuTextureDrop(texture: Texture) void;
};

pub const TextureView = *opaque {
    // WGPU extras
    pub const drop = wgpuTextureViewDrop;
    extern fn wgpuTextureViewDrop(texture_view: TextureView) void;
};

pub const AdapterType = enum(u32) {
    discrete_gpu = 0x00000000,
    integrated_gpu = 0x00000001,
    cpu = 0x00000002,
    unknown = 0x00000003,
};

pub const AddressMode = enum(u32) {
    repeat = 0x00000000,
    mirror_repeat = 0x00000001,
    clamp_to_edge = 0x00000002,
};

pub const BackendType = enum(u32) {
    none,
    webgpu,
    d3d11,
    d3d12,
    metal,
    vulkan,
    opengl,
    opengles,
};

pub const BlendFactor = enum(u32) {
    zero = 0x00000000,
    one = 0x00000001,
    src = 0x00000002,
    one_minus_src = 0x00000003,
    src_alpha = 0x00000004,
    one_minus_src_alpha = 0x00000005,
    dst = 0x00000006,
    one_minus_dst = 0x00000007,
    dst_alpha = 0x00000008,
    one_minus_dst_alpha = 0x00000009,
    src_alpha_saturated = 0x0000000A,
    constant = 0x0000000B,
    one_minus_constant = 0x0000000C,
};

pub const BlendOperation = enum(u32) {
    add = 0x00000000,
    subtract = 0x00000001,
    reverse_subtract = 0x00000002,
    min = 0x00000003,
    max = 0x00000004,
};

pub const BufferBindingType = enum(u32) {
    @"undefined",
    uniform,
    storage,
    read_only_storage,
};

pub const BufferMapAsyncStatus = enum(u32) {
    success = 0x00000000,
    @"error" = 0x00000001,
    unknown = 0x00000002,
    device_lost = 0x00000003,
    destroyed_before_callback = 0x00000004,
    unmapped_before_callback = 0x00000005,
};

pub const CompareFunction = enum(u32) {
    never = 0x00000001,
    less = 0x00000002,
    less_equal = 0x00000003,
    greater = 0x00000004,
    greater_equal = 0x00000005,
    equal = 0x00000006,
    not_equal = 0x00000007,
    always = 0x00000008,
};

pub const CompilationMessageType = enum(u32) {
    @"error",
    warning,
    info,
};

pub const CreatePipelineAsyncStatus = enum(u32) {
    success = 0x00000000,
    @"error" = 0x00000001,
    device_lost = 0x00000002,
    device_destroyed = 0x00000003,
    unknown = 0x00000004,
};

pub const CullMode = enum(u32) {
    none = 0x00000000,
    front = 0x00000001,
    back = 0x00000002,
};

pub const DeviceLostReason = enum(u32) {
    @"undefined",
    destroyed,
};

pub const ErrorFilter = enum(u32) {
    none = 0x00000000,
    validation = 0x00000001,
    out_of_memory = 0x00000002,
};

pub const ErrorType = enum(u32) {
    no_error = 0x00000000,
    validation = 0x00000001,
    out_of_memory = 0x00000002,
    unknown = 0x00000003,
    device_lost = 0x00000004,
};

pub const FeatureName = enum(u32) {
    @"undefined",
    depth_clamping,
    depth24_unorm_stencil8,
    depth32_float_stencil8,
    timestamp_query,
    pipeline_statistics_query,
    texture_compression_bc,
};

pub const FilterMode = enum(u32) {
    nearest = 0x00000000,
    linear = 0x00000001,
};

pub const FrontFace = enum(u32) {
    ccw = 0x00000000,
    cw = 0x00000001,
};

pub const IndexFormat = enum(u32) {
    unknown = 0,
    uint16 = 0x00000001,
    uint32 = 0x00000002,
};

pub const LoadOp = enum(u32) {
    clear = 0x00000000,
    load = 0x00000001,
};

pub const PipelineStatisticName = enum(u32) {
    vertex_shader_invocations = 0x00000000,
    clipper_invocations = 0x00000001,
    clipper_primitives_out = 0x00000002,
    fragment_shader_invocations = 0x00000003,
    compute_shader_invocations = 0x00000004,
};

pub const PowerPreference = enum(u32) {
    low_power,
    high_performance,
};

pub const PresentMode = enum(u32) {
    immediate = 0x00000000,
    mailbox = 0x00000001,
    fifo = 0x00000002,
};

pub const PrimitiveTopology = enum(u32) {
    pointlist = 0x00000000,
    line_list = 0x00000001,
    line_strip = 0x00000002,
    triangle_list = 0x00000003,
    triangle_strip = 0x00000004,
};

pub const QueryType = enum(u32) {
    occlusion = 0x00000000,
    pipeline_statistics = 0x00000001,
    timestamp = 0x00000002,
};

pub const QueueWorkDoneStatus = enum(u32) {
    success = 0x00000000,
    @"error" = 0x00000001,
    unknown = 0x00000002,
    device_lost = 0x00000003,
};

pub const RequestAdapterStatus = enum(u32) {
    success,
    unavailable,
    @"error",
    unknown,
};

pub const RequestDeviceStatus = enum(u32) {
    success,
    @"error",
    unknown,
};

pub const SType = enum(u32) {
    invalid = 0x00000000,
    surface_descriptor_from_metal_layer = 0x00000001,
    surface_descriptor_from_windows_hwnd = 0x00000002,
    surface_descriptor_from_xlib = 0x00000003,
    surface_descriptor_from_canvas_html_selector = 0x00000004,
    shader_module_spirv_descriptor = 0x00000005,
    shader_module_wgsl_descriptor = 0x00000006,
    primitive_depth_clamping_state = 0x00000007,

    // WGPU extras
    // Start at 6 to prevent collisions with webgpu STypes
    device_extras = 0x60000001,
    adapter_extras = 0x60000002,
};

pub const SamplerBindingType = enum(u32) {
    filtering = 0x00000001,
    non_filtering = 0x00000002,
    comparison = 0x00000003,
};

pub const StencilOperation = enum(u32) {
    keep = 0x00000000,
    zero = 0x00000001,
    replace = 0x00000002,
    invert = 0x00000003,
    increment_clamp = 0x00000004,
    decrement_clamp = 0x00000005,
    increment_wrap = 0x00000006,
    decrement_wrap = 0x00000007,
};

pub const StorageTextureAccess = enum(u32) {
    @"undefined",
    write_only,
};

pub const StoreOp = enum(u32) {
    store,
    discard,
};

pub const TextureAspect = enum(u32) {
    all = 0x00000000,
    stencil_only = 0x00000001,
    depth_only = 0x00000002,
};

pub const TextureComponentType = enum(u32) {
    float = 0x00000000,
    sint = 0x00000001,
    uint = 0x00000002,
    depth_comparison = 0x00000003,
};

pub const TextureDimension = enum(u32) {
    @"1d" = 0x00000000,
    @"2d" = 0x00000001,
    @"3d" = 0x00000002,
};

pub const TextureFormat = enum(u32) {
    r8_unorm = 1,
    r8_snorm,
    r8_uint,
    r8_sint,
    r16_uint,
    r16_sint,
    r16_float,
    rg8_unorm,
    rg8_snorm,
    rg8_uint,
    rg8_sint,
    r32_float,
    r32_uint,
    r32_sint,
    rg16_uint,
    rg16_sint,
    rg16_float,
    rgba8_unorm,
    rgba8_unorm_srgb,
    rgba8_snorm,
    rgba8_uint,
    rgba8_sint,
    bgra8_unorm,
    bgra8_unorm_srgb,
    rgb10_a_2_unorm,
    rg11b10_ufloat,
    rgb9e5_ufloat,
    rg32_float,
    rg32_uint,
    rg32_sint,
    rgba16_uint,
    rgba16_sint,
    rgba16_float,
    rgba32_float,
    rgba32_uint,
    rgba32_sint,
    stencil8,
    depth16_unorm,
    depth24_plus,
    depth24_plus_stencil_8,
    depth32_float,
    bc1_rgba_unorm,
    bc1_rgba_unorm_srgb,
    bc2_rgba_unorm,
    bc2_rgba_unorm_srgb,
    bc3_rgba_unorm,
    bc3_rgba_unorm_srgb,
    bc4_r_unorm,
    bc4_r_snorm,
    bc5_rg_unorm,
    bc5_rg_snorm,
    bc6h_rgb_ufloat,
    bc6h_rgb_float,
    bc7_rgba_unorm,
    bc7_rgba_unorm_srgb,
};

pub const TextureSampleType = enum(u32) {
    float = 0x00000001,
    unfilterable_float = 0x00000002,
    depth = 0x00000003,
    sint = 0x00000004,
    uint = 0x00000005,
};

pub const TextureViewDimension = enum(u32) {
    @"1d" = 0x00000001,
    @"2d" = 0x00000002,
    @"2darray" = 0x00000003,
    cube = 0x00000004,
    cube_array = 0x00000005,
    @"3d" = 0x00000006,
};

pub const VertexFormat = enum(u32) {
    uint8x_2 = 0x00000001,
    uint8x_4 = 0x00000002,
    sint8x_2 = 0x00000003,
    sint8x_4 = 0x00000004,
    unorm_8x_2 = 0x00000005,
    unorm_8x_4 = 0x00000006,
    snorm_8x_2 = 0x00000007,
    snorm_8x_4 = 0x00000008,
    uint16x_2 = 0x00000009,
    uint16x_4 = 0x0000000A,
    sint16x_2 = 0x0000000B,
    sint16x_4 = 0x0000000C,
    unorm_16x_2 = 0x0000000D,
    unorm_16x_4 = 0x0000000E,
    snorm_16x_2 = 0x0000000F,
    snorm_16x_4 = 0x00000010,
    float_16x_2 = 0x00000011,
    float_16x_4 = 0x00000012,
    float_32 = 0x00000013,
    float_32x_2 = 0x00000014,
    float_32x_3 = 0x00000015,
    float_32x_4 = 0x00000016,
    uint32 = 0x00000017,
    uint32x_2 = 0x00000018,
    uint32x_3 = 0x00000019,
    uint32x_4 = 0x0000001A,
    sint32 = 0x0000001B,
    sint32x_2 = 0x0000001C,
    sint32x_3 = 0x0000001D,
    sint32x_4 = 0x0000001E,
};

pub const VertexStepMode = enum(u32) {
    vertex,
    instance,
};

fn Flags(comptime names: []const []const u8, default: bool) type {
    const std = @import("std");

    var bool_fields: [names.len]std.builtin.TypeInfo.StructField = undefined;
    for (names) |name, i| {
        bool_fields[i] = .{
            .name = name,
            .field_type = bool,
            .alignment = 0,
            .default_value = default,
            .is_comptime = false,
        };
    }

    var fields: []const std.builtin.TypeInfo.StructField = &bool_fields;
    if (names.len % 8 != 0) { // Pad bits
        const T = std.meta.Int(.unsigned, 8 - names.len % 8);
        const pad_default: T = 0;
        fields = fields ++ &[_]std.builtin.TypeInfo.StructField{.{
            .name = "_bit_pad",
            .field_type = T,
            .alignment = 0,
            .default_value = pad_default,
            .is_comptime = false,
        }};
    }

    var byte_size = (names.len - 1) / 8 + 1;
    while (byte_size < 4) : (byte_size += 1) {
        const pad_default: u8 = 0;
        fields = fields ++ &[_]std.builtin.TypeInfo.StructField{.{
            .name = std.fmt.comptimePrint("_byte_pad{}", .{byte_size}),
            .field_type = u8,
            .alignment = 0,
            .default_value = pad_default,
            .is_comptime = false,
        }};
    }

    const T = @Type(.{ .Struct = .{
        .layout = .Packed,
        .fields = fields,
        .decls = &.{},
        .is_tuple = false,
    } });
    std.debug.assert(@bitSizeOf(T) == 32 and @sizeOf(T) == 4);
    return T;
}

pub const BufferUsage = Flags(&.{
    "map_read",
    "map_write",
    "copy_src",
    "copy_dst",
    "index",
    "vertex",
    "uniform",
    "storage",
    "indirect",
    "query_resolve",
}, false);

pub const ColorWriteMask = Flags(&.{
    "red",  "green",
    "blue", "alpha",
}, true);

pub const MapMode = Flags(&.{ "read", "write" }, false);

pub const ShaderStage = Flags(&.{ "vertex", "fragment", "compute" }, false);

pub const TextureUsage = Flags(&.{
    "copy_src",
    "copy_dst",
    "texture_binding",
    "storage_binding",
    "render_attachment",
}, false);

pub const ChainedStruct = extern struct {
    next: ?*const ChainedStruct,
    s_type: SType,
};

pub const ChainedStructOut = extern struct {
    next: ?*ChainedStructOut,
    s_type: SType,
};

pub const AdapterProperties = extern struct {
    next_in_chain: ?*ChainedStructOut = null,
    vendor_id: u32,
    device_id: u32,
    name: [*:0]const u8,
    driver_description: [*:0]const u8,
    adapter_type: AdapterType,
    backend_type: BackendType,
};

pub const BindGroupEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    binding: u32,
    buffer: Buffer,
    offset: u64,
    size: u64,
    sampler: Sampler,
    texture_view: TextureView,
};

pub const BlendComponent = extern struct {
    operation: BlendOperation,
    src_factor: BlendFactor,
    dst_factor: BlendFactor,
};

pub const BufferBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    type: BufferBindingType,
    has_dynamic_offset: bool,
    min_binding_size: u64,
};

pub const BufferDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    usage: BufferUsage,
    size: u64,
    mapped_at_creation: bool,
};

pub const Color = extern struct {
    r: f64,
    g: f64,
    b: f64,
    a: f64,
};

pub const CommandBufferDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
};

pub const CommandEncoderDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
};

pub const CompilationMessage = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    message: [*:0]const u8,
    type: CompilationMessageType,
    line_num: u64,
    line_pos: u64,
    offset: u64,
    length: u64,
};

pub const ComputePassDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
};

pub const ConstantEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    key: [*:0]const u8,
    value: f64,
};

pub const Extent3D = extern struct {
    width: u32,
    height: u32,
    depth_or_array_layers: u32,
};

pub const InstanceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
};

pub const Limits = extern struct {
    max_texture_dimension_1d: u32 = 0,
    max_texture_dimension_2d: u32 = 0,
    max_texture_dimension_3d: u32 = 0,
    max_texture_array_layers: u32 = 0,
    max_bind_groups: u32 = 0,
    max_dynamic_uniform_buffers_per_pipeline_layout: u32 = 0,
    max_dynamic_storage_buffers_per_pipeline_layout: u32 = 0,
    max_sampled_textures_per_shader_stage: u32 = 0,
    max_samplers_per_shader_stage: u32 = 0,
    max_storage_buffers_per_shader_stage: u32 = 0,
    max_storage_textures_per_shader_stage: u32 = 0,
    max_uniform_buffers_per_shader_stage: u32 = 0,
    max_uniform_buffer_binding_size: u64 = 0,
    max_storage_buffer_binding_size: u64 = 0,
    min_uniform_buffer_offset_alignment: u32 = 0,
    min_storage_buffer_offset_alignment: u32 = 0,
    max_vertex_buffers: u32 = 0,
    max_vertex_attributes: u32 = 0,
    max_vertex_buffer_array_stride: u32 = 0,
    max_inter_stage_shader_components: u32 = 0,
    max_compute_workgroup_storage_size: u32 = 0,
    max_compute_invocations_per_workgroup: u32 = 0,
    max_compute_workgroup_size_x: u32 = 0,
    max_compute_workgroup_size_y: u32 = 0,
    max_compute_workgroup_size_z: u32 = 0,
    max_compute_workgroups_per_dimension: u32 = 0,
};

pub const MultisampleState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    count: u32,
    mask: u32,
    alpha_to_coverage_enabled: bool,
};

pub const Origin3D = extern struct {
    x: u32,
    y: u32,
    z: u32,
};

pub const PipelineLayoutDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    bind_group_layout_count: u32,
    bind_group_layouts: ?*BindGroupLayout,
};

pub const PrimitiveDepthClampingState = extern struct {
    chain: ChainedStruct,
    clamp_depth: bool,
};

pub const PrimitiveState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    topology: PrimitiveTopology,
    strip_index_format: IndexFormat,
    front_face: FrontFace,
    cull_mode: CullMode,
};

pub const QuerySetDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    type: QueryType,
    count: u32,
    pipeline_statistics: *PipelineStatisticName,
    pipeline_statistics_count: u32,
};

pub const RenderBundleDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
};

pub const RenderBundleEncoderDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    color_formats_count: u32,
    color_formats: *TextureFormat,
    depth_stencil_format: TextureFormat,
    sample_count: u32,
};

pub const RenderPassDepthStencilAttachment = extern struct {
    view: TextureView,
    depth_load_op: LoadOp,
    depth_store_op: StoreOp,
    clear_depth: f32,
    depth_read_only: bool,
    stencil_load_op: LoadOp,
    stencil_store_op: StoreOp,
    clear_stencil: u32,
    stencil_read_only: bool,
};

pub const RequestAdapterOptions = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    compatible_surface: ?Surface,
    power_preference: PowerPreference,
    force_fallback_adapter: bool,
};

pub const SamplerBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    type: SamplerBindingType,
};

pub const SamplerDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    address_mode_u: AddressMode,
    address_mode_v: AddressMode,
    address_mode_w: AddressMode,
    mag_filter: FilterMode,
    min_filter: FilterMode,
    mipmap_filter: FilterMode,
    lod_min_clamp: f32,
    lod_max_clamp: f32,
    compare: CompareFunction,
    max_anisotropy: u16,
};

pub const ShaderModuleDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
};

pub const ShaderModuleSPIRVDescriptor = extern struct {
    chain: ChainedStruct,
    code_size: u32,
    code: *u32,
};

pub const ShaderModuleWGSLDescriptor = extern struct {
    chain: ChainedStruct = .{
        .next = null,
        .s_type = .shader_module_wgsl_descriptor,
    },
    source: [*:0]const u8,
};

pub const StencilFaceState = extern struct {
    compare: CompareFunction,
    fail_op: StencilOperation,
    depth_fail_op: StencilOperation,
    pass_op: StencilOperation,
};

pub const StorageTextureBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    access: StorageTextureAccess,
    format: TextureFormat,
    view_dimension: TextureViewDimension,
};

pub const SurfaceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
};

pub const SurfaceDescriptorFromCanvasHTMLSelector = extern struct {
    chain: ChainedStruct,
    selector: [*:0]const u8,
};

pub const SurfaceDescriptorFromMetalLayer = extern struct {
    chain: ChainedStruct,
    layer: *c_void,
};

pub const SurfaceDescriptorFromWindowsHWND = extern struct {
    chain: ChainedStruct,
    hinstance: *c_void,
    hwnd: *c_void,
};

pub const SurfaceDescriptorFromXlib = extern struct {
    chain: ChainedStruct = .{
        .next = null,
        .s_type = .surface_descriptor_from_xlib,
    },
    display: *c_void,
    window: u32,
};

pub const SwapChainDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    usage: TextureUsage,
    format: TextureFormat,
    width: u32,
    height: u32,
    present_mode: PresentMode,
};

pub const TextureBindingLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    sample_type: TextureSampleType,
    view_dimension: TextureViewDimension,
    multisampled: bool,
};

pub const TextureDataLayout = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    offset: u64,
    bytes_per_row: u32,
    rows_per_image: u32,
};

pub const TextureViewDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    format: TextureFormat,
    dimension: TextureViewDimension,
    base_mip_level: u32,
    mip_level_count: u32,
    base_array_layer: u32,
    array_layer_count: u32,
    aspect: TextureAspect,
};

pub const VertexAttribute = extern struct {
    format: VertexFormat,
    offset: u64,
    shader_location: u32,
};

pub const BindGroupDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    layout: BindGroupLayout,
    entry_count: u32,
    entries: [*]BindGroupEntry,
};

pub const BindGroupLayoutEntry = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    binding: u32,
    visibility: ShaderStage,
    buffer: BufferBindingLayout = .{
        .type = .@"undefined",
        .has_dynamic_offset = undefined,
        .min_binding_size = undefined,
    },
    sampler: SamplerBindingLayout = .{
        .type = .@"undefined",
    },
    texture: TextureBindingLayout,
    storage_texture: StorageTextureBindingLayout,
};

pub const BlendState = extern struct {
    color: BlendComponent,
    alpha: BlendComponent,
};

pub const CompilationInfo = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    message_count: u32,
    messages: [*]const CompilationMessage,
};

pub const DepthStencilState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    format: TextureFormat,
    depth_write_enabled: bool,
    depth_compare: CompareFunction,
    stencil_front: StencilFaceState,
    stencil_back: StencilFaceState,
    stencil_read_mask: u32,
    stencil_write_mask: u32,
    depth_bias: i32,
    depth_bias_slope_scale: f32,
    depth_bias_clamp: f32,
};

pub const ImageCopyBuffer = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    layout: TextureDataLayout,
    buffer: Buffer,
};

pub const ImageCopyTexture = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    texture: Texture,
    mip_level: u32,
    origin: Origin3D,
    aspect: TextureAspect,
};

pub const ProgrammableStageDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: ShaderModule,
    entry_point: [*:0]const u8,
    constant_count: u32,
    constants: [*]const ConstantEntry,
};

pub const RenderPassColorAttachment = extern struct {
    view: TextureView,
    resolve_target: ?TextureView,
    load_op: LoadOp,
    store_op: StoreOp,
    clear_color: Color,
};

pub const RequiredLimits = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    limits: Limits,
};

pub const SupportedLimits = extern struct {
    next_in_chain: ?*ChainedStructOut = null,
    limits: Limits,
};

pub const TextureDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    usage: TextureUsage,
    dimension: TextureDimension,
    size: Extent3D,
    format: TextureFormat,
    mip_level_count: u32,
    sample_count: u32,
};

pub const VertexBufferLayout = extern struct {
    array_stride: u64,
    step_mode: VertexStepMode,
    attribute_count: u32,
    attributes: *VertexAttribute,
};

pub const BindGroupLayoutDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    entry_count: u32,
    entries: *BindGroupLayoutEntry,
};

pub const ColorTargetState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    format: TextureFormat,
    blend: *const BlendState,
    write_mask: ColorWriteMask,
};

pub const ComputePipelineDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    layout: PipelineLayout,
    compute: ProgrammableStageDescriptor,
};

pub const DeviceDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    required_features_count: u32,
    required_features: [*]const FeatureName,
    required_limits: ?*const RequiredLimits,
};

pub const RenderPassDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    color_attachment_count: u32,
    color_attachments: ?[*]RenderPassColorAttachment,
    depth_stencil_attachment: ?*RenderPassDepthStencilAttachment = null,
    occlusion_query_set: ?QuerySet = null,
};

pub const VertexState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: ShaderModule,
    entry_point: [*:0]const u8,
    constant_count: u32,
    constants: [*]const ConstantEntry,
    buffer_count: u32,
    buffers: [*]const VertexBufferLayout,
};

pub const FragmentState = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    module: ShaderModule,
    entry_point: [*:0]const u8,
    constant_count: u32,
    constants: [*]const ConstantEntry,
    target_count: u32,
    targets: *const ColorTargetState,
};

pub const RenderPipelineDescriptor = extern struct {
    next_in_chain: ?*const ChainedStruct = null,
    label: ?[*:0]const u8 = null,
    layout: PipelineLayout,
    vertex: VertexState,
    primitive: PrimitiveState,
    depth_stencil: ?*const DepthStencilState,
    multisample: MultisampleState,
    fragment: ?*const FragmentState,
};

// WGPU extras
pub const NativeFeature = enum(u32) {
    none = 0,
    texture_adapter_specific_format_features = 0x10000000,
};

pub const LogLevel = enum(u32) {
    off = 0x00000000,
    err = 0x00000001,
    warn = 0x00000002,
    info = 0x00000003,
    debug = 0x00000004,
    trace = 0x00000005,
};

pub const AdapterExtras = extern struct {
    chain: ChainedStruct,
    backend: BackendType,
};

pub const DeviceExtras = extern struct {
    chain: ChainedStruct = .{
        .next = null,
        .s_type = .device_extras,
    },
    native_features: NativeFeature = .none,
    label: ?[*:0]const u8 = null,
    trace_path: ?[*:0]const u8 = null,
};

pub const LogCallback = fn (level: LogLevel, msg: [*:0]const u8) callconv(.C) void;

pub const setLogCallback = wgpuSetLogCallback;
extern fn wgpuSetLogCallback(callback: LogCallback) void;

pub const setLogLevel = wgpuSetLogLevel;
extern fn wgpuSetLogLevel(level: LogLevel) void;

pub const getVersion = wgpuGetVersion;
extern fn wgpuGetVersion() u32;
