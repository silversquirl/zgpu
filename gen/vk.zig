//
// Copyright 2015-2021 The Khronos Group Inc.
//
// SPDX-License-Identifier: Apache-2.0 OR MIT
//

// This file is generated from the Khronos Vulkan XML API registry by vulkan-zig.

const std = @import("std");
const builtin = @import("builtin");
const root = @import("root");

const GlobalScope = @This();

pub const vulkan_call_conv: std.builtin.CallingConvention = if (builtin.os.tag == .windows and builtin.cpu.arch == .i386)
    .Stdcall
else if (builtin.abi == .android and (builtin.cpu.arch.isARM() or builtin.cpu.arch.isThumb()) and std.Target.arm.featureSetHas(builtin.cpu.features, .has_v7) and builtin.cpu.arch.ptrBitWidth() == 32)
    // On Android 32-bit ARM targets, Vulkan functions use the "hardfloat"
    // calling convention, i.e. float parameters are passed in registers. This
    // is true even if the rest of the application passes floats on the stack,
    // as it does by default when compiling for the armeabi-v7a NDK ABI.
    .AAPCSVFP
else
    .C;
pub fn FlagsMixin(comptime FlagsType: type, comptime Int: type) type {
    return struct {
        pub const IntType = Int;
        pub fn toInt(self: FlagsType) IntType {
            return @bitCast(IntType, self);
        }
        pub fn fromInt(flags: IntType) FlagsType {
            return @bitCast(FlagsType, flags);
        }
        pub fn merge(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return fromInt(toInt(lhs) | toInt(rhs));
        }
        pub fn intersect(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return fromInt(toInt(lhs) & toInt(rhs));
        }
        pub fn complement(self: FlagsType) FlagsType {
            return fromInt(~toInt(self));
        }
        pub fn subtract(lhs: FlagsType, rhs: FlagsType) FlagsType {
            return fromInt(toInt(lhs) & toInt(rhs.complement()));
        }
        pub fn contains(lhs: FlagsType, rhs: FlagsType) bool {
            return toInt(intersect(lhs, rhs)) == toInt(rhs);
        }
    };
}
pub fn makeApiVersion(variant: u3, major: u7, minor: u10, patch: u12) u32 {
    return (@as(u32, variant) << 29) | (@as(u32, major) << 22) | (@as(u32, minor) << 12) | patch;
}
pub fn apiVersionVariant(version: u32) u3 {
    return @truncate(u3, version >> 29);
}
pub fn apiVersionMajor(version: u32) u7 {
    return @truncate(u7, version >> 22);
}
pub fn apiVersionMinor(version: u32) u10 {
    return @truncate(u10, version >> 12);
}
pub fn apiVersionPatch(version: u32) u12 {
    return @truncate(u12, version);
}
pub const BaseCommand = enum {
    CreateInstance,
    GetInstanceProcAddr,
    EnumerateInstanceVersion,
    EnumerateInstanceLayerProperties,
    EnumerateInstanceExtensionProperties,
};
fn BaseCommandToString(cmd: BaseCommand) []const u8 {
    return std.meta.tagName(cmd);
}
pub const InstanceCommand = enum {
    DestroyInstance,
    EnumeratePhysicalDevices,
    GetDeviceProcAddr,
    GetPhysicalDeviceProperties,
    GetPhysicalDeviceQueueFamilyProperties,
    GetPhysicalDeviceMemoryProperties,
    GetPhysicalDeviceFeatures,
    GetPhysicalDeviceFormatProperties,
    GetPhysicalDeviceImageFormatProperties,
    CreateDevice,
    EnumerateDeviceLayerProperties,
    EnumerateDeviceExtensionProperties,
    GetPhysicalDeviceSparseImageFormatProperties,
    CreateAndroidSurfaceKHR,
    GetPhysicalDeviceDisplayPropertiesKHR,
    GetPhysicalDeviceDisplayPlanePropertiesKHR,
    GetDisplayPlaneSupportedDisplaysKHR,
    GetDisplayModePropertiesKHR,
    CreateDisplayModeKHR,
    GetDisplayPlaneCapabilitiesKHR,
    CreateDisplayPlaneSurfaceKHR,
    DestroySurfaceKHR,
    GetPhysicalDeviceSurfaceSupportKHR,
    GetPhysicalDeviceSurfaceCapabilitiesKHR,
    GetPhysicalDeviceSurfaceFormatsKHR,
    GetPhysicalDeviceSurfacePresentModesKHR,
    CreateViSurfaceNN,
    CreateWaylandSurfaceKHR,
    GetPhysicalDeviceWaylandPresentationSupportKHR,
    CreateWin32SurfaceKHR,
    GetPhysicalDeviceWin32PresentationSupportKHR,
    CreateXlibSurfaceKHR,
    GetPhysicalDeviceXlibPresentationSupportKHR,
    CreateXcbSurfaceKHR,
    GetPhysicalDeviceXcbPresentationSupportKHR,
    CreateDirectFBSurfaceEXT,
    GetPhysicalDeviceDirectFBPresentationSupportEXT,
    CreateImagePipeSurfaceFUCHSIA,
    CreateStreamDescriptorSurfaceGGP,
    CreateScreenSurfaceQNX,
    GetPhysicalDeviceScreenPresentationSupportQNX,
    CreateDebugReportCallbackEXT,
    DestroyDebugReportCallbackEXT,
    DebugReportMessageEXT,
    GetPhysicalDeviceExternalImageFormatPropertiesNV,
    GetPhysicalDeviceFeatures2,
    GetPhysicalDeviceProperties2,
    GetPhysicalDeviceFormatProperties2,
    GetPhysicalDeviceImageFormatProperties2,
    GetPhysicalDeviceQueueFamilyProperties2,
    GetPhysicalDeviceMemoryProperties2,
    GetPhysicalDeviceSparseImageFormatProperties2,
    GetPhysicalDeviceExternalBufferProperties,
    GetPhysicalDeviceExternalSemaphoreProperties,
    GetPhysicalDeviceExternalFenceProperties,
    ReleaseDisplayEXT,
    AcquireXlibDisplayEXT,
    GetRandROutputDisplayEXT,
    AcquireWinrtDisplayNV,
    GetWinrtDisplayNV,
    GetPhysicalDeviceSurfaceCapabilities2EXT,
    EnumeratePhysicalDeviceGroups,
    GetPhysicalDevicePresentRectanglesKHR,
    CreateIOSSurfaceMVK,
    CreateMacOSSurfaceMVK,
    CreateMetalSurfaceEXT,
    GetPhysicalDeviceMultisamplePropertiesEXT,
    GetPhysicalDeviceSurfaceCapabilities2KHR,
    GetPhysicalDeviceSurfaceFormats2KHR,
    GetPhysicalDeviceDisplayProperties2KHR,
    GetPhysicalDeviceDisplayPlaneProperties2KHR,
    GetDisplayModeProperties2KHR,
    GetDisplayPlaneCapabilities2KHR,
    GetPhysicalDeviceCalibrateableTimeDomainsEXT,
    CreateDebugUtilsMessengerEXT,
    DestroyDebugUtilsMessengerEXT,
    SubmitDebugUtilsMessageEXT,
    GetPhysicalDeviceCooperativeMatrixPropertiesNV,
    GetPhysicalDeviceSurfacePresentModes2EXT,
    EnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR,
    GetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR,
    CreateHeadlessSurfaceEXT,
    GetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV,
    GetPhysicalDeviceToolPropertiesEXT,
    GetPhysicalDeviceFragmentShadingRatesKHR,
    GetPhysicalDeviceVideoCapabilitiesKHR,
    GetPhysicalDeviceVideoFormatPropertiesKHR,
    AcquireDrmDisplayEXT,
    GetDrmDisplayEXT,
};
fn InstanceCommandToString(cmd: InstanceCommand) []const u8 {
    return std.meta.tagName(cmd);
}
pub const DeviceCommand = enum {
    DestroyDevice,
    GetDeviceQueue,
    QueueSubmit,
    QueueWaitIdle,
    DeviceWaitIdle,
    AllocateMemory,
    FreeMemory,
    MapMemory,
    UnmapMemory,
    FlushMappedMemoryRanges,
    InvalidateMappedMemoryRanges,
    GetDeviceMemoryCommitment,
    GetBufferMemoryRequirements,
    BindBufferMemory,
    GetImageMemoryRequirements,
    BindImageMemory,
    GetImageSparseMemoryRequirements,
    QueueBindSparse,
    CreateFence,
    DestroyFence,
    ResetFences,
    GetFenceStatus,
    WaitForFences,
    CreateSemaphore,
    DestroySemaphore,
    CreateEvent,
    DestroyEvent,
    GetEventStatus,
    SetEvent,
    ResetEvent,
    CreateQueryPool,
    DestroyQueryPool,
    GetQueryPoolResults,
    ResetQueryPool,
    CreateBuffer,
    DestroyBuffer,
    CreateBufferView,
    DestroyBufferView,
    CreateImage,
    DestroyImage,
    GetImageSubresourceLayout,
    CreateImageView,
    DestroyImageView,
    CreateShaderModule,
    DestroyShaderModule,
    CreatePipelineCache,
    DestroyPipelineCache,
    GetPipelineCacheData,
    MergePipelineCaches,
    CreateGraphicsPipelines,
    CreateComputePipelines,
    GetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI,
    DestroyPipeline,
    CreatePipelineLayout,
    DestroyPipelineLayout,
    CreateSampler,
    DestroySampler,
    CreateDescriptorSetLayout,
    DestroyDescriptorSetLayout,
    CreateDescriptorPool,
    DestroyDescriptorPool,
    ResetDescriptorPool,
    AllocateDescriptorSets,
    FreeDescriptorSets,
    UpdateDescriptorSets,
    CreateFramebuffer,
    DestroyFramebuffer,
    CreateRenderPass,
    DestroyRenderPass,
    GetRenderAreaGranularity,
    CreateCommandPool,
    DestroyCommandPool,
    ResetCommandPool,
    AllocateCommandBuffers,
    FreeCommandBuffers,
    BeginCommandBuffer,
    EndCommandBuffer,
    ResetCommandBuffer,
    CmdBindPipeline,
    CmdSetViewport,
    CmdSetScissor,
    CmdSetLineWidth,
    CmdSetDepthBias,
    CmdSetBlendConstants,
    CmdSetDepthBounds,
    CmdSetStencilCompareMask,
    CmdSetStencilWriteMask,
    CmdSetStencilReference,
    CmdBindDescriptorSets,
    CmdBindIndexBuffer,
    CmdBindVertexBuffers,
    CmdDraw,
    CmdDrawIndexed,
    CmdDrawMultiEXT,
    CmdDrawMultiIndexedEXT,
    CmdDrawIndirect,
    CmdDrawIndexedIndirect,
    CmdDispatch,
    CmdDispatchIndirect,
    CmdSubpassShadingHUAWEI,
    CmdCopyBuffer,
    CmdCopyImage,
    CmdBlitImage,
    CmdCopyBufferToImage,
    CmdCopyImageToBuffer,
    CmdUpdateBuffer,
    CmdFillBuffer,
    CmdClearColorImage,
    CmdClearDepthStencilImage,
    CmdClearAttachments,
    CmdResolveImage,
    CmdSetEvent,
    CmdResetEvent,
    CmdWaitEvents,
    CmdPipelineBarrier,
    CmdBeginQuery,
    CmdEndQuery,
    CmdBeginConditionalRenderingEXT,
    CmdEndConditionalRenderingEXT,
    CmdResetQueryPool,
    CmdWriteTimestamp,
    CmdCopyQueryPoolResults,
    CmdPushConstants,
    CmdBeginRenderPass,
    CmdNextSubpass,
    CmdEndRenderPass,
    CmdExecuteCommands,
    CreateSharedSwapchainsKHR,
    CreateSwapchainKHR,
    DestroySwapchainKHR,
    GetSwapchainImagesKHR,
    AcquireNextImageKHR,
    QueuePresentKHR,
    DebugMarkerSetObjectNameEXT,
    DebugMarkerSetObjectTagEXT,
    CmdDebugMarkerBeginEXT,
    CmdDebugMarkerEndEXT,
    CmdDebugMarkerInsertEXT,
    GetMemoryWin32HandleNV,
    CmdExecuteGeneratedCommandsNV,
    CmdPreprocessGeneratedCommandsNV,
    CmdBindPipelineShaderGroupNV,
    GetGeneratedCommandsMemoryRequirementsNV,
    CreateIndirectCommandsLayoutNV,
    DestroyIndirectCommandsLayoutNV,
    CmdPushDescriptorSetKHR,
    TrimCommandPool,
    GetMemoryWin32HandleKHR,
    GetMemoryWin32HandlePropertiesKHR,
    GetMemoryFdKHR,
    GetMemoryFdPropertiesKHR,
    GetMemoryZirconHandleFUCHSIA,
    GetMemoryZirconHandlePropertiesFUCHSIA,
    GetMemoryRemoteAddressNV,
    GetSemaphoreWin32HandleKHR,
    ImportSemaphoreWin32HandleKHR,
    GetSemaphoreFdKHR,
    ImportSemaphoreFdKHR,
    GetSemaphoreZirconHandleFUCHSIA,
    ImportSemaphoreZirconHandleFUCHSIA,
    GetFenceWin32HandleKHR,
    ImportFenceWin32HandleKHR,
    GetFenceFdKHR,
    ImportFenceFdKHR,
    DisplayPowerControlEXT,
    RegisterDeviceEventEXT,
    RegisterDisplayEventEXT,
    GetSwapchainCounterEXT,
    GetDeviceGroupPeerMemoryFeatures,
    BindBufferMemory2,
    BindImageMemory2,
    CmdSetDeviceMask,
    GetDeviceGroupPresentCapabilitiesKHR,
    GetDeviceGroupSurfacePresentModesKHR,
    AcquireNextImage2KHR,
    CmdDispatchBase,
    CreateDescriptorUpdateTemplate,
    DestroyDescriptorUpdateTemplate,
    UpdateDescriptorSetWithTemplate,
    CmdPushDescriptorSetWithTemplateKHR,
    SetHdrMetadataEXT,
    GetSwapchainStatusKHR,
    GetRefreshCycleDurationGOOGLE,
    GetPastPresentationTimingGOOGLE,
    CmdSetViewportWScalingNV,
    CmdSetDiscardRectangleEXT,
    CmdSetSampleLocationsEXT,
    GetBufferMemoryRequirements2,
    GetImageMemoryRequirements2,
    GetImageSparseMemoryRequirements2,
    GetDeviceBufferMemoryRequirementsKHR,
    GetDeviceImageMemoryRequirementsKHR,
    GetDeviceImageSparseMemoryRequirementsKHR,
    CreateSamplerYcbcrConversion,
    DestroySamplerYcbcrConversion,
    GetDeviceQueue2,
    CreateValidationCacheEXT,
    DestroyValidationCacheEXT,
    GetValidationCacheDataEXT,
    MergeValidationCachesEXT,
    GetDescriptorSetLayoutSupport,
    GetSwapchainGrallocUsageANDROID,
    GetSwapchainGrallocUsage2ANDROID,
    AcquireImageANDROID,
    QueueSignalReleaseImageANDROID,
    GetShaderInfoAMD,
    SetLocalDimmingAMD,
    GetCalibratedTimestampsEXT,
    SetDebugUtilsObjectNameEXT,
    SetDebugUtilsObjectTagEXT,
    QueueBeginDebugUtilsLabelEXT,
    QueueEndDebugUtilsLabelEXT,
    QueueInsertDebugUtilsLabelEXT,
    CmdBeginDebugUtilsLabelEXT,
    CmdEndDebugUtilsLabelEXT,
    CmdInsertDebugUtilsLabelEXT,
    GetMemoryHostPointerPropertiesEXT,
    CmdWriteBufferMarkerAMD,
    CreateRenderPass2,
    CmdBeginRenderPass2,
    CmdNextSubpass2,
    CmdEndRenderPass2,
    GetSemaphoreCounterValue,
    WaitSemaphores,
    SignalSemaphore,
    GetAndroidHardwareBufferPropertiesANDROID,
    GetMemoryAndroidHardwareBufferANDROID,
    CmdDrawIndirectCount,
    CmdDrawIndexedIndirectCount,
    CmdSetCheckpointNV,
    GetQueueCheckpointDataNV,
    CmdBindTransformFeedbackBuffersEXT,
    CmdBeginTransformFeedbackEXT,
    CmdEndTransformFeedbackEXT,
    CmdBeginQueryIndexedEXT,
    CmdEndQueryIndexedEXT,
    CmdDrawIndirectByteCountEXT,
    CmdSetExclusiveScissorNV,
    CmdBindShadingRateImageNV,
    CmdSetViewportShadingRatePaletteNV,
    CmdSetCoarseSampleOrderNV,
    CmdDrawMeshTasksNV,
    CmdDrawMeshTasksIndirectNV,
    CmdDrawMeshTasksIndirectCountNV,
    CompileDeferredNV,
    CreateAccelerationStructureNV,
    CmdBindInvocationMaskHUAWEI,
    DestroyAccelerationStructureKHR,
    DestroyAccelerationStructureNV,
    GetAccelerationStructureMemoryRequirementsNV,
    BindAccelerationStructureMemoryNV,
    CmdCopyAccelerationStructureNV,
    CmdCopyAccelerationStructureKHR,
    CopyAccelerationStructureKHR,
    CmdCopyAccelerationStructureToMemoryKHR,
    CopyAccelerationStructureToMemoryKHR,
    CmdCopyMemoryToAccelerationStructureKHR,
    CopyMemoryToAccelerationStructureKHR,
    CmdWriteAccelerationStructuresPropertiesKHR,
    CmdWriteAccelerationStructuresPropertiesNV,
    CmdBuildAccelerationStructureNV,
    WriteAccelerationStructuresPropertiesKHR,
    CmdTraceRaysKHR,
    CmdTraceRaysNV,
    GetRayTracingShaderGroupHandlesKHR,
    GetRayTracingCaptureReplayShaderGroupHandlesKHR,
    GetAccelerationStructureHandleNV,
    CreateRayTracingPipelinesNV,
    CreateRayTracingPipelinesKHR,
    CmdTraceRaysIndirectKHR,
    GetDeviceAccelerationStructureCompatibilityKHR,
    GetRayTracingShaderGroupStackSizeKHR,
    CmdSetRayTracingPipelineStackSizeKHR,
    GetImageViewHandleNVX,
    GetImageViewAddressNVX,
    GetDeviceGroupSurfacePresentModes2EXT,
    AcquireFullScreenExclusiveModeEXT,
    ReleaseFullScreenExclusiveModeEXT,
    AcquireProfilingLockKHR,
    ReleaseProfilingLockKHR,
    GetImageDrmFormatModifierPropertiesEXT,
    GetBufferOpaqueCaptureAddress,
    GetBufferDeviceAddress,
    InitializePerformanceApiINTEL,
    UninitializePerformanceApiINTEL,
    CmdSetPerformanceMarkerINTEL,
    CmdSetPerformanceStreamMarkerINTEL,
    CmdSetPerformanceOverrideINTEL,
    AcquirePerformanceConfigurationINTEL,
    ReleasePerformanceConfigurationINTEL,
    QueueSetPerformanceConfigurationINTEL,
    GetPerformanceParameterINTEL,
    GetDeviceMemoryOpaqueCaptureAddress,
    GetPipelineExecutablePropertiesKHR,
    GetPipelineExecutableStatisticsKHR,
    GetPipelineExecutableInternalRepresentationsKHR,
    CmdSetLineStippleEXT,
    CreateAccelerationStructureKHR,
    CmdBuildAccelerationStructuresKHR,
    CmdBuildAccelerationStructuresIndirectKHR,
    BuildAccelerationStructuresKHR,
    GetAccelerationStructureDeviceAddressKHR,
    CreateDeferredOperationKHR,
    DestroyDeferredOperationKHR,
    GetDeferredOperationMaxConcurrencyKHR,
    GetDeferredOperationResultKHR,
    DeferredOperationJoinKHR,
    CmdSetCullModeEXT,
    CmdSetFrontFaceEXT,
    CmdSetPrimitiveTopologyEXT,
    CmdSetViewportWithCountEXT,
    CmdSetScissorWithCountEXT,
    CmdBindVertexBuffers2EXT,
    CmdSetDepthTestEnableEXT,
    CmdSetDepthWriteEnableEXT,
    CmdSetDepthCompareOpEXT,
    CmdSetDepthBoundsTestEnableEXT,
    CmdSetStencilTestEnableEXT,
    CmdSetStencilOpEXT,
    CmdSetPatchControlPointsEXT,
    CmdSetRasterizerDiscardEnableEXT,
    CmdSetDepthBiasEnableEXT,
    CmdSetLogicOpEXT,
    CmdSetPrimitiveRestartEnableEXT,
    CreatePrivateDataSlotEXT,
    DestroyPrivateDataSlotEXT,
    SetPrivateDataEXT,
    GetPrivateDataEXT,
    CmdCopyBuffer2KHR,
    CmdCopyImage2KHR,
    CmdBlitImage2KHR,
    CmdCopyBufferToImage2KHR,
    CmdCopyImageToBuffer2KHR,
    CmdResolveImage2KHR,
    CmdSetFragmentShadingRateKHR,
    CmdSetFragmentShadingRateEnumNV,
    GetAccelerationStructureBuildSizesKHR,
    CmdSetVertexInputEXT,
    CmdSetColorWriteEnableEXT,
    CmdSetEvent2KHR,
    CmdResetEvent2KHR,
    CmdWaitEvents2KHR,
    CmdPipelineBarrier2KHR,
    QueueSubmit2KHR,
    CmdWriteTimestamp2KHR,
    CmdWriteBufferMarker2AMD,
    GetQueueCheckpointData2NV,
    CreateVideoSessionKHR,
    DestroyVideoSessionKHR,
    CreateVideoSessionParametersKHR,
    UpdateVideoSessionParametersKHR,
    DestroyVideoSessionParametersKHR,
    GetVideoSessionMemoryRequirementsKHR,
    BindVideoSessionMemoryKHR,
    CmdDecodeVideoKHR,
    CmdBeginVideoCodingKHR,
    CmdControlVideoCodingKHR,
    CmdEndVideoCodingKHR,
    CmdEncodeVideoKHR,
    CreateCuModuleNVX,
    CreateCuFunctionNVX,
    DestroyCuModuleNVX,
    DestroyCuFunctionNVX,
    CmdCuLaunchKernelNVX,
    SetDeviceMemoryPriorityEXT,
    WaitForPresentKHR,
    CreateBufferCollectionFUCHSIA,
    SetBufferCollectionBufferConstraintsFUCHSIA,
    SetBufferCollectionImageConstraintsFUCHSIA,
    DestroyBufferCollectionFUCHSIA,
    GetBufferCollectionPropertiesFUCHSIA,
    CmdBeginRenderingKHR,
    CmdEndRenderingKHR,
};
fn DeviceCommandToString(cmd: DeviceCommand) []const u8 {
    return std.meta.tagName(cmd);
}
pub const MAX_PHYSICAL_DEVICE_NAME_SIZE = 256;
pub const UUID_SIZE = 16;
pub const LUID_SIZE = 8;
pub const LUID_SIZE_KHR = LUID_SIZE;
pub const MAX_EXTENSION_NAME_SIZE = 256;
pub const MAX_DESCRIPTION_SIZE = 256;
pub const MAX_MEMORY_TYPES = 32;
pub const MAX_MEMORY_HEAPS = 16;
pub const LOD_CLAMP_NONE = @as(f32, 1000.0);
pub const REMAINING_MIP_LEVELS = ~@as(u32, 0);
pub const REMAINING_ARRAY_LAYERS = ~@as(u32, 0);
pub const WHOLE_SIZE = ~@as(u64, 0);
pub const ATTACHMENT_UNUSED = ~@as(u32, 0);
pub const TRUE = 1;
pub const FALSE = 0;
pub const QUEUE_FAMILY_IGNORED = ~@as(u32, 0);
pub const QUEUE_FAMILY_EXTERNAL = ~@as(u32, 1);
pub const QUEUE_FAMILY_EXTERNAL_KHR = QUEUE_FAMILY_EXTERNAL;
pub const QUEUE_FAMILY_FOREIGN_EXT = ~@as(u32, 2);
pub const SUBPASS_EXTERNAL = ~@as(u32, 0);
pub const MAX_DEVICE_GROUP_SIZE = 32;
pub const MAX_DEVICE_GROUP_SIZE_KHR = MAX_DEVICE_GROUP_SIZE;
pub const MAX_DRIVER_NAME_SIZE = 256;
pub const MAX_DRIVER_NAME_SIZE_KHR = MAX_DRIVER_NAME_SIZE;
pub const MAX_DRIVER_INFO_SIZE = 256;
pub const MAX_DRIVER_INFO_SIZE_KHR = MAX_DRIVER_INFO_SIZE;
pub const SHADER_UNUSED_KHR = ~@as(u32, 0);
pub const SHADER_UNUSED_NV = SHADER_UNUSED_KHR;
pub const MAX_GLOBAL_PRIORITY_SIZE_EXT = 16;
pub const API_VERSION_1_0 = makeApiVersion(0, 1, 0, 0);
pub const API_VERSION_1_1 = makeApiVersion(0, 1, 1, 0);
pub const API_VERSION_1_2 = makeApiVersion(0, 1, 2, 0);
pub const HEADER_VERSION = 197;
pub const HEADER_VERSION_COMPLETE = makeApiVersion(0, 1, 2, HEADER_VERSION);
pub const Display = if (@hasDecl(root, "Display")) root.Display else opaque {};
pub const VisualID = if (@hasDecl(root, "VisualID")) root.VisualID else c_uint;
pub const Window = if (@hasDecl(root, "Window")) root.Window else c_ulong;
pub const RROutput = if (@hasDecl(root, "RROutput")) root.RROutput else c_ulong;
pub const wl_display = if (@hasDecl(root, "wl_display")) root.wl_display else opaque {};
pub const wl_surface = if (@hasDecl(root, "wl_surface")) root.wl_surface else opaque {};
pub const HINSTANCE = if (@hasDecl(root, "HINSTANCE")) root.HINSTANCE else std.os.HINSTANCE;
pub const HWND = if (@hasDecl(root, "HWND")) root.HWND else *opaque {};
pub const HMONITOR = if (@hasDecl(root, "HMONITOR")) root.HMONITOR else *opaque {};
pub const HANDLE = if (@hasDecl(root, "HANDLE")) root.HANDLE else std.os.HANDLE;
pub const SECURITY_ATTRIBUTES = if (@hasDecl(root, "SECURITY_ATTRIBUTES")) root.SECURITY_ATTRIBUTES else std.os.SECURITY_ATTRIBUTES;
pub const DWORD = if (@hasDecl(root, "DWORD")) root.DWORD else std.os.DWORD;
pub const LPCWSTR = if (@hasDecl(root, "LPCWSTR")) root.LPCWSTR else std.os.LPCWSTR;
pub const xcb_connection_t = if (@hasDecl(root, "xcb_connection_t")) root.xcb_connection_t else opaque {};
pub const xcb_visualid_t = if (@hasDecl(root, "xcb_visualid_t")) root.xcb_visualid_t else u32;
pub const xcb_window_t = if (@hasDecl(root, "xcb_window_t")) root.xcb_window_t else u32;
pub const IDirectFB = if (@hasDecl(root, "IDirectFB")) root.IDirectFB else @compileError("Missing type definition of 'IDirectFB'");
pub const IDirectFBSurface = if (@hasDecl(root, "IDirectFBSurface")) root.IDirectFBSurface else @compileError("Missing type definition of 'IDirectFBSurface'");
pub const zx_handle_t = if (@hasDecl(root, "zx_handle_t")) root.zx_handle_t else u32;
pub const GgpStreamDescriptor = if (@hasDecl(root, "GgpStreamDescriptor")) root.GgpStreamDescriptor else @compileError("Missing type definition of 'GgpStreamDescriptor'");
pub const GgpFrameToken = if (@hasDecl(root, "GgpFrameToken")) root.GgpFrameToken else @compileError("Missing type definition of 'GgpFrameToken'");
pub const _screen_context = if (@hasDecl(root, "_screen_context")) root._screen_context else opaque {};
pub const _screen_window = if (@hasDecl(root, "_screen_window")) root._screen_window else opaque {};
pub const ANativeWindow = opaque {};
pub const AHardwareBuffer = opaque {};
pub const CAMetalLayer = opaque {};
pub const SampleMask = u32;
pub const Bool32 = u32;
pub const Flags = u32;
pub const Flags64 = u64;
pub const DeviceSize = u64;
pub const DeviceAddress = u64;
pub const QueryPoolCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(QueryPoolCreateFlags, Flags);
};
pub const PipelineLayoutCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineLayoutCreateFlags, Flags);
};
pub const PipelineDepthStencilStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineDepthStencilStateCreateFlags, Flags);
};
pub const PipelineDynamicStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineDynamicStateCreateFlags, Flags);
};
pub const PipelineColorBlendStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineColorBlendStateCreateFlags, Flags);
};
pub const PipelineMultisampleStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineMultisampleStateCreateFlags, Flags);
};
pub const PipelineRasterizationStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineRasterizationStateCreateFlags, Flags);
};
pub const PipelineViewportStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineViewportStateCreateFlags, Flags);
};
pub const PipelineTessellationStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineTessellationStateCreateFlags, Flags);
};
pub const PipelineInputAssemblyStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineInputAssemblyStateCreateFlags, Flags);
};
pub const PipelineVertexInputStateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineVertexInputStateCreateFlags, Flags);
};
pub const BufferViewCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(BufferViewCreateFlags, Flags);
};
pub const InstanceCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(InstanceCreateFlags, Flags);
};
pub const DeviceCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DeviceCreateFlags, Flags);
};
pub const SemaphoreCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(SemaphoreCreateFlags, Flags);
};
pub const ShaderModuleCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(ShaderModuleCreateFlags, Flags);
};
pub const MemoryMapFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(MemoryMapFlags, Flags);
};
pub const DescriptorPoolResetFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DescriptorPoolResetFlags, Flags);
};
pub const GeometryFlagsNV = GeometryFlagsKHR;
pub const GeometryInstanceFlagsNV = GeometryInstanceFlagsKHR;
pub const BuildAccelerationStructureFlagsNV = BuildAccelerationStructureFlagsKHR;
pub const DescriptorUpdateTemplateCreateFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DescriptorUpdateTemplateCreateFlags, Flags);
};
pub const DescriptorUpdateTemplateCreateFlagsKHR = DescriptorUpdateTemplateCreateFlags;
pub const SemaphoreWaitFlagsKHR = SemaphoreWaitFlags;
pub const AccelerationStructureMotionInfoFlagsNV = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(AccelerationStructureMotionInfoFlagsNV, Flags);
};
pub const AccelerationStructureMotionInstanceFlagsNV = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(AccelerationStructureMotionInstanceFlagsNV, Flags);
};
pub const DisplayModeCreateFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DisplayModeCreateFlagsKHR, Flags);
};
pub const DisplaySurfaceCreateFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DisplaySurfaceCreateFlagsKHR, Flags);
};
pub const AndroidSurfaceCreateFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(AndroidSurfaceCreateFlagsKHR, Flags);
};
pub const ViSurfaceCreateFlagsNN = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(ViSurfaceCreateFlagsNN, Flags);
};
pub const WaylandSurfaceCreateFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(WaylandSurfaceCreateFlagsKHR, Flags);
};
pub const Win32SurfaceCreateFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(Win32SurfaceCreateFlagsKHR, Flags);
};
pub const XlibSurfaceCreateFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(XlibSurfaceCreateFlagsKHR, Flags);
};
pub const XcbSurfaceCreateFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(XcbSurfaceCreateFlagsKHR, Flags);
};
pub const DirectFBSurfaceCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DirectFBSurfaceCreateFlagsEXT, Flags);
};
pub const IOSSurfaceCreateFlagsMVK = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(IOSSurfaceCreateFlagsMVK, Flags);
};
pub const MacOSSurfaceCreateFlagsMVK = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(MacOSSurfaceCreateFlagsMVK, Flags);
};
pub const MetalSurfaceCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(MetalSurfaceCreateFlagsEXT, Flags);
};
pub const ImagePipeSurfaceCreateFlagsFUCHSIA = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(ImagePipeSurfaceCreateFlagsFUCHSIA, Flags);
};
pub const StreamDescriptorSurfaceCreateFlagsGGP = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(StreamDescriptorSurfaceCreateFlagsGGP, Flags);
};
pub const HeadlessSurfaceCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(HeadlessSurfaceCreateFlagsEXT, Flags);
};
pub const ScreenSurfaceCreateFlagsQNX = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(ScreenSurfaceCreateFlagsQNX, Flags);
};
pub const PeerMemoryFeatureFlagsKHR = PeerMemoryFeatureFlags;
pub const MemoryAllocateFlagsKHR = MemoryAllocateFlags;
pub const CommandPoolTrimFlags = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(CommandPoolTrimFlags, Flags);
};
pub const CommandPoolTrimFlagsKHR = CommandPoolTrimFlags;
pub const ExternalMemoryHandleTypeFlagsKHR = ExternalMemoryHandleTypeFlags;
pub const ExternalMemoryFeatureFlagsKHR = ExternalMemoryFeatureFlags;
pub const ExternalSemaphoreHandleTypeFlagsKHR = ExternalSemaphoreHandleTypeFlags;
pub const ExternalSemaphoreFeatureFlagsKHR = ExternalSemaphoreFeatureFlags;
pub const SemaphoreImportFlagsKHR = SemaphoreImportFlags;
pub const ExternalFenceHandleTypeFlagsKHR = ExternalFenceHandleTypeFlags;
pub const ExternalFenceFeatureFlagsKHR = ExternalFenceFeatureFlags;
pub const FenceImportFlagsKHR = FenceImportFlags;
pub const PipelineViewportSwizzleStateCreateFlagsNV = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineViewportSwizzleStateCreateFlagsNV, Flags);
};
pub const PipelineDiscardRectangleStateCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineDiscardRectangleStateCreateFlagsEXT, Flags);
};
pub const PipelineCoverageToColorStateCreateFlagsNV = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineCoverageToColorStateCreateFlagsNV, Flags);
};
pub const PipelineCoverageModulationStateCreateFlagsNV = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineCoverageModulationStateCreateFlagsNV, Flags);
};
pub const PipelineCoverageReductionStateCreateFlagsNV = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineCoverageReductionStateCreateFlagsNV, Flags);
};
pub const ValidationCacheCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(ValidationCacheCreateFlagsEXT, Flags);
};
pub const DebugUtilsMessengerCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DebugUtilsMessengerCreateFlagsEXT, Flags);
};
pub const DebugUtilsMessengerCallbackDataFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DebugUtilsMessengerCallbackDataFlagsEXT, Flags);
};
pub const DeviceMemoryReportFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(DeviceMemoryReportFlagsEXT, Flags);
};
pub const PipelineRasterizationConservativeStateCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineRasterizationConservativeStateCreateFlagsEXT, Flags);
};
pub const DescriptorBindingFlagsEXT = DescriptorBindingFlags;
pub const ResolveModeFlagsKHR = ResolveModeFlags;
pub const PipelineRasterizationStateStreamCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineRasterizationStateStreamCreateFlagsEXT, Flags);
};
pub const PipelineRasterizationDepthClipStateCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineRasterizationDepthClipStateCreateFlagsEXT, Flags);
};
pub const ImageFormatConstraintsFlagsFUCHSIA = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(ImageFormatConstraintsFlagsFUCHSIA, Flags);
};
pub const VideoBeginCodingFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(VideoBeginCodingFlagsKHR, Flags);
};
pub const VideoEndCodingFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(VideoEndCodingFlagsKHR, Flags);
};
pub const VideoDecodeH264CreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(VideoDecodeH264CreateFlagsEXT, Flags);
};
pub const VideoDecodeH265CreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(VideoDecodeH265CreateFlagsEXT, Flags);
};
pub const VideoEncodeH265CapabilityFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(VideoEncodeH265CapabilityFlagsEXT, Flags);
};
pub const VideoEncodeH265CreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(VideoEncodeH265CreateFlagsEXT, Flags);
};
pub const Instance = enum(usize) { null_handle = 0, _ };
pub const PhysicalDevice = enum(usize) { null_handle = 0, _ };
pub const Device = enum(usize) { null_handle = 0, _ };
pub const Queue = enum(usize) { null_handle = 0, _ };
pub const CommandBuffer = enum(usize) { null_handle = 0, _ };
pub const DeviceMemory = enum(u64) { null_handle = 0, _ };
pub const CommandPool = enum(u64) { null_handle = 0, _ };
pub const Buffer = enum(u64) { null_handle = 0, _ };
pub const BufferView = enum(u64) { null_handle = 0, _ };
pub const Image = enum(u64) { null_handle = 0, _ };
pub const ImageView = enum(u64) { null_handle = 0, _ };
pub const ShaderModule = enum(u64) { null_handle = 0, _ };
pub const Pipeline = enum(u64) { null_handle = 0, _ };
pub const PipelineLayout = enum(u64) { null_handle = 0, _ };
pub const Sampler = enum(u64) { null_handle = 0, _ };
pub const DescriptorSet = enum(u64) { null_handle = 0, _ };
pub const DescriptorSetLayout = enum(u64) { null_handle = 0, _ };
pub const DescriptorPool = enum(u64) { null_handle = 0, _ };
pub const Fence = enum(u64) { null_handle = 0, _ };
pub const Semaphore = enum(u64) { null_handle = 0, _ };
pub const Event = enum(u64) { null_handle = 0, _ };
pub const QueryPool = enum(u64) { null_handle = 0, _ };
pub const Framebuffer = enum(u64) { null_handle = 0, _ };
pub const RenderPass = enum(u64) { null_handle = 0, _ };
pub const PipelineCache = enum(u64) { null_handle = 0, _ };
pub const IndirectCommandsLayoutNV = enum(u64) { null_handle = 0, _ };
pub const DescriptorUpdateTemplate = enum(u64) { null_handle = 0, _ };
pub const DescriptorUpdateTemplateKHR = DescriptorUpdateTemplate;
pub const SamplerYcbcrConversion = enum(u64) { null_handle = 0, _ };
pub const SamplerYcbcrConversionKHR = SamplerYcbcrConversion;
pub const ValidationCacheEXT = enum(u64) { null_handle = 0, _ };
pub const AccelerationStructureKHR = enum(u64) { null_handle = 0, _ };
pub const AccelerationStructureNV = enum(u64) { null_handle = 0, _ };
pub const PerformanceConfigurationINTEL = enum(u64) { null_handle = 0, _ };
pub const BufferCollectionFUCHSIA = enum(u64) { null_handle = 0, _ };
pub const DeferredOperationKHR = enum(u64) { null_handle = 0, _ };
pub const PrivateDataSlotEXT = enum(u64) { null_handle = 0, _ };
pub const CuModuleNVX = enum(u64) { null_handle = 0, _ };
pub const CuFunctionNVX = enum(u64) { null_handle = 0, _ };
pub const DisplayKHR = enum(u64) { null_handle = 0, _ };
pub const DisplayModeKHR = enum(u64) { null_handle = 0, _ };
pub const SurfaceKHR = enum(u64) { null_handle = 0, _ };
pub const SwapchainKHR = enum(u64) { null_handle = 0, _ };
pub const DebugReportCallbackEXT = enum(u64) { null_handle = 0, _ };
pub const DebugUtilsMessengerEXT = enum(u64) { null_handle = 0, _ };
pub const VideoSessionKHR = enum(u64) { null_handle = 0, _ };
pub const VideoSessionParametersKHR = enum(u64) { null_handle = 0, _ };
pub const DescriptorUpdateTemplateTypeKHR = DescriptorUpdateTemplateType;
pub const PointClippingBehaviorKHR = PointClippingBehavior;
pub const SemaphoreTypeKHR = SemaphoreType;
pub const CopyAccelerationStructureModeNV = CopyAccelerationStructureModeKHR;
pub const AccelerationStructureTypeNV = AccelerationStructureTypeKHR;
pub const GeometryTypeNV = GeometryTypeKHR;
pub const RayTracingShaderGroupTypeNV = RayTracingShaderGroupTypeKHR;
pub const TessellationDomainOriginKHR = TessellationDomainOrigin;
pub const SamplerYcbcrModelConversionKHR = SamplerYcbcrModelConversion;
pub const SamplerYcbcrRangeKHR = SamplerYcbcrRange;
pub const ChromaLocationKHR = ChromaLocation;
pub const SamplerReductionModeEXT = SamplerReductionMode;
pub const ShaderFloatControlsIndependenceKHR = ShaderFloatControlsIndependence;
pub const DriverIdKHR = DriverId;
pub const PfnInternalAllocationNotification = ?fn (
    p_user_data: *c_void,
    size: usize,
    allocation_type: InternalAllocationType,
    allocation_scope: SystemAllocationScope,
) callconv(vulkan_call_conv) void;
pub const PfnInternalFreeNotification = ?fn (
    p_user_data: *c_void,
    size: usize,
    allocation_type: InternalAllocationType,
    allocation_scope: SystemAllocationScope,
) callconv(vulkan_call_conv) void;
pub const PfnReallocationFunction = ?fn (
    p_user_data: *c_void,
    p_original: *c_void,
    size: usize,
    alignment: usize,
    allocation_scope: SystemAllocationScope,
) callconv(vulkan_call_conv) *c_void;
pub const PfnAllocationFunction = ?fn (
    p_user_data: *c_void,
    size: usize,
    alignment: usize,
    allocation_scope: SystemAllocationScope,
) callconv(vulkan_call_conv) *c_void;
pub const PfnFreeFunction = ?fn (
    p_user_data: *c_void,
    p_memory: *c_void,
) callconv(vulkan_call_conv) void;
pub const PfnVoidFunction = ?fn () callconv(vulkan_call_conv) void;
pub const PfnDebugReportCallbackEXT = ?fn (
    flags: DebugReportFlagsEXT.IntType,
    object_type: DebugReportObjectTypeEXT,
    object: u64,
    location: usize,
    message_code: i32,
    p_layer_prefix: *const u8,
    p_message: *const u8,
    p_user_data: *c_void,
) callconv(vulkan_call_conv) Bool32;
pub const PfnDebugUtilsMessengerCallbackEXT = ?fn (
    message_severity: DebugUtilsMessageSeverityFlagsEXT.IntType,
    message_types: DebugUtilsMessageTypeFlagsEXT.IntType,
    p_callback_data: *const DebugUtilsMessengerCallbackDataEXT,
    p_user_data: *c_void,
) callconv(vulkan_call_conv) Bool32;
pub const PfnDeviceMemoryReportCallbackEXT = ?fn (
    p_callback_data: *const DeviceMemoryReportCallbackDataEXT,
    p_user_data: *c_void,
) callconv(vulkan_call_conv) void;
pub const BaseOutStructure = extern struct {
    s_type: StructureType,
    p_next: ?*BaseOutStructure = null,
};
pub const BaseInStructure = extern struct {
    s_type: StructureType,
    p_next: ?*const BaseInStructure = null,
};
pub const Offset2D = extern struct {
    x: i32,
    y: i32,
};
pub const Offset3D = extern struct {
    x: i32,
    y: i32,
    z: i32,
};
pub const Extent2D = extern struct {
    width: u32,
    height: u32,
};
pub const Extent3D = extern struct {
    width: u32,
    height: u32,
    depth: u32,
};
pub const Viewport = extern struct {
    x: f32,
    y: f32,
    width: f32,
    height: f32,
    min_depth: f32,
    max_depth: f32,
};
pub const Rect2D = extern struct {
    offset: Offset2D,
    extent: Extent2D,
};
pub const ClearRect = extern struct {
    rect: Rect2D,
    base_array_layer: u32,
    layer_count: u32,
};
pub const ComponentMapping = extern struct {
    r: ComponentSwizzle,
    g: ComponentSwizzle,
    b: ComponentSwizzle,
    a: ComponentSwizzle,
};
pub const PhysicalDeviceProperties = extern struct {
    api_version: u32,
    driver_version: u32,
    vendor_id: u32,
    device_id: u32,
    device_type: PhysicalDeviceType,
    device_name: [MAX_PHYSICAL_DEVICE_NAME_SIZE]u8,
    pipeline_cache_uuid: [UUID_SIZE]u8,
    limits: PhysicalDeviceLimits,
    sparse_properties: PhysicalDeviceSparseProperties,
};
pub const ExtensionProperties = extern struct {
    extension_name: [MAX_EXTENSION_NAME_SIZE]u8,
    spec_version: u32,
};
pub const LayerProperties = extern struct {
    layer_name: [MAX_EXTENSION_NAME_SIZE]u8,
    spec_version: u32,
    implementation_version: u32,
    description: [MAX_DESCRIPTION_SIZE]u8,
};
pub const ApplicationInfo = extern struct {
    s_type: StructureType = .application_info,
    p_next: ?*const c_void = null,
    p_application_name: ?[*:0]const u8,
    application_version: u32,
    p_engine_name: ?[*:0]const u8,
    engine_version: u32,
    api_version: u32,
};
pub const AllocationCallbacks = extern struct {
    p_user_data: ?*c_void,
    pfn_allocation: PfnAllocationFunction,
    pfn_reallocation: PfnReallocationFunction,
    pfn_free: PfnFreeFunction,
    pfn_internal_allocation: PfnInternalAllocationNotification,
    pfn_internal_free: PfnInternalFreeNotification,
};
pub const DeviceQueueCreateInfo = extern struct {
    s_type: StructureType = .device_queue_create_info,
    p_next: ?*const c_void = null,
    flags: DeviceQueueCreateFlags,
    queue_family_index: u32,
    queue_count: u32,
    p_queue_priorities: [*]const f32,
};
pub const DeviceCreateInfo = extern struct {
    s_type: StructureType = .device_create_info,
    p_next: ?*const c_void = null,
    flags: DeviceCreateFlags,
    queue_create_info_count: u32,
    p_queue_create_infos: [*]const DeviceQueueCreateInfo,
    enabled_layer_count: u32,
    pp_enabled_layer_names: [*]const [*:0]const u8,
    enabled_extension_count: u32,
    pp_enabled_extension_names: [*]const [*:0]const u8,
    p_enabled_features: ?*const PhysicalDeviceFeatures,
};
pub const InstanceCreateInfo = extern struct {
    s_type: StructureType = .instance_create_info,
    p_next: ?*const c_void = null,
    flags: InstanceCreateFlags,
    p_application_info: ?*const ApplicationInfo,
    enabled_layer_count: u32,
    pp_enabled_layer_names: [*]const [*:0]const u8,
    enabled_extension_count: u32,
    pp_enabled_extension_names: [*]const [*:0]const u8,
};
pub const QueueFamilyProperties = extern struct {
    queue_flags: QueueFlags,
    queue_count: u32,
    timestamp_valid_bits: u32,
    min_image_transfer_granularity: Extent3D,
};
pub const PhysicalDeviceMemoryProperties = extern struct {
    memory_type_count: u32,
    memory_types: [MAX_MEMORY_TYPES]MemoryType,
    memory_heap_count: u32,
    memory_heaps: [MAX_MEMORY_HEAPS]MemoryHeap,
};
pub const MemoryAllocateInfo = extern struct {
    s_type: StructureType = .memory_allocate_info,
    p_next: ?*const c_void = null,
    allocation_size: DeviceSize,
    memory_type_index: u32,
};
pub const MemoryRequirements = extern struct {
    size: DeviceSize,
    alignment: DeviceSize,
    memory_type_bits: u32,
};
pub const SparseImageFormatProperties = extern struct {
    aspect_mask: ImageAspectFlags,
    image_granularity: Extent3D,
    flags: SparseImageFormatFlags,
};
pub const SparseImageMemoryRequirements = extern struct {
    format_properties: SparseImageFormatProperties,
    image_mip_tail_first_lod: u32,
    image_mip_tail_size: DeviceSize,
    image_mip_tail_offset: DeviceSize,
    image_mip_tail_stride: DeviceSize,
};
pub const MemoryType = extern struct {
    property_flags: MemoryPropertyFlags,
    heap_index: u32,
};
pub const MemoryHeap = extern struct {
    size: DeviceSize,
    flags: MemoryHeapFlags,
};
pub const MappedMemoryRange = extern struct {
    s_type: StructureType = .mapped_memory_range,
    p_next: ?*const c_void = null,
    memory: DeviceMemory,
    offset: DeviceSize,
    size: DeviceSize,
};
pub const FormatProperties = extern struct {
    linear_tiling_features: FormatFeatureFlags,
    optimal_tiling_features: FormatFeatureFlags,
    buffer_features: FormatFeatureFlags,
};
pub const ImageFormatProperties = extern struct {
    max_extent: Extent3D,
    max_mip_levels: u32,
    max_array_layers: u32,
    sample_counts: SampleCountFlags,
    max_resource_size: DeviceSize,
};
pub const DescriptorBufferInfo = extern struct {
    buffer: Buffer,
    offset: DeviceSize,
    range: DeviceSize,
};
pub const DescriptorImageInfo = extern struct {
    sampler: Sampler,
    image_view: ImageView,
    image_layout: ImageLayout,
};
pub const WriteDescriptorSet = extern struct {
    s_type: StructureType = .write_descriptor_set,
    p_next: ?*const c_void = null,
    dst_set: DescriptorSet,
    dst_binding: u32,
    dst_array_element: u32,
    descriptor_count: u32,
    descriptor_type: DescriptorType,
    p_image_info: [*]const DescriptorImageInfo,
    p_buffer_info: [*]const DescriptorBufferInfo,
    p_texel_buffer_view: [*]const BufferView,
};
pub const CopyDescriptorSet = extern struct {
    s_type: StructureType = .copy_descriptor_set,
    p_next: ?*const c_void = null,
    src_set: DescriptorSet,
    src_binding: u32,
    src_array_element: u32,
    dst_set: DescriptorSet,
    dst_binding: u32,
    dst_array_element: u32,
    descriptor_count: u32,
};
pub const BufferCreateInfo = extern struct {
    s_type: StructureType = .buffer_create_info,
    p_next: ?*const c_void = null,
    flags: BufferCreateFlags,
    size: DeviceSize,
    usage: BufferUsageFlags,
    sharing_mode: SharingMode,
    queue_family_index_count: u32,
    p_queue_family_indices: [*]const u32,
};
pub const BufferViewCreateInfo = extern struct {
    s_type: StructureType = .buffer_view_create_info,
    p_next: ?*const c_void = null,
    flags: BufferViewCreateFlags,
    buffer: Buffer,
    format: Format,
    offset: DeviceSize,
    range: DeviceSize,
};
pub const ImageSubresource = extern struct {
    aspect_mask: ImageAspectFlags,
    mip_level: u32,
    array_layer: u32,
};
pub const ImageSubresourceLayers = extern struct {
    aspect_mask: ImageAspectFlags,
    mip_level: u32,
    base_array_layer: u32,
    layer_count: u32,
};
pub const ImageSubresourceRange = extern struct {
    aspect_mask: ImageAspectFlags,
    base_mip_level: u32,
    level_count: u32,
    base_array_layer: u32,
    layer_count: u32,
};
pub const MemoryBarrier = extern struct {
    s_type: StructureType = .memory_barrier,
    p_next: ?*const c_void = null,
    src_access_mask: AccessFlags,
    dst_access_mask: AccessFlags,
};
pub const BufferMemoryBarrier = extern struct {
    s_type: StructureType = .buffer_memory_barrier,
    p_next: ?*const c_void = null,
    src_access_mask: AccessFlags,
    dst_access_mask: AccessFlags,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    buffer: Buffer,
    offset: DeviceSize,
    size: DeviceSize,
};
pub const ImageMemoryBarrier = extern struct {
    s_type: StructureType = .image_memory_barrier,
    p_next: ?*const c_void = null,
    src_access_mask: AccessFlags,
    dst_access_mask: AccessFlags,
    old_layout: ImageLayout,
    new_layout: ImageLayout,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    image: Image,
    subresource_range: ImageSubresourceRange,
};
pub const ImageCreateInfo = extern struct {
    s_type: StructureType = .image_create_info,
    p_next: ?*const c_void = null,
    flags: ImageCreateFlags,
    image_type: ImageType,
    format: Format,
    extent: Extent3D,
    mip_levels: u32,
    array_layers: u32,
    samples: SampleCountFlags,
    tiling: ImageTiling,
    usage: ImageUsageFlags,
    sharing_mode: SharingMode,
    queue_family_index_count: u32,
    p_queue_family_indices: [*]const u32,
    initial_layout: ImageLayout,
};
pub const SubresourceLayout = extern struct {
    offset: DeviceSize,
    size: DeviceSize,
    row_pitch: DeviceSize,
    array_pitch: DeviceSize,
    depth_pitch: DeviceSize,
};
pub const ImageViewCreateInfo = extern struct {
    s_type: StructureType = .image_view_create_info,
    p_next: ?*const c_void = null,
    flags: ImageViewCreateFlags,
    image: Image,
    view_type: ImageViewType,
    format: Format,
    components: ComponentMapping,
    subresource_range: ImageSubresourceRange,
};
pub const BufferCopy = extern struct {
    src_offset: DeviceSize,
    dst_offset: DeviceSize,
    size: DeviceSize,
};
pub const SparseMemoryBind = extern struct {
    resource_offset: DeviceSize,
    size: DeviceSize,
    memory: DeviceMemory,
    memory_offset: DeviceSize,
    flags: SparseMemoryBindFlags,
};
pub const SparseImageMemoryBind = extern struct {
    subresource: ImageSubresource,
    offset: Offset3D,
    extent: Extent3D,
    memory: DeviceMemory,
    memory_offset: DeviceSize,
    flags: SparseMemoryBindFlags,
};
pub const SparseBufferMemoryBindInfo = extern struct {
    buffer: Buffer,
    bind_count: u32,
    p_binds: [*]const SparseMemoryBind,
};
pub const SparseImageOpaqueMemoryBindInfo = extern struct {
    image: Image,
    bind_count: u32,
    p_binds: [*]const SparseMemoryBind,
};
pub const SparseImageMemoryBindInfo = extern struct {
    image: Image,
    bind_count: u32,
    p_binds: [*]const SparseImageMemoryBind,
};
pub const BindSparseInfo = extern struct {
    s_type: StructureType = .bind_sparse_info,
    p_next: ?*const c_void = null,
    wait_semaphore_count: u32,
    p_wait_semaphores: [*]const Semaphore,
    buffer_bind_count: u32,
    p_buffer_binds: [*]const SparseBufferMemoryBindInfo,
    image_opaque_bind_count: u32,
    p_image_opaque_binds: [*]const SparseImageOpaqueMemoryBindInfo,
    image_bind_count: u32,
    p_image_binds: [*]const SparseImageMemoryBindInfo,
    signal_semaphore_count: u32,
    p_signal_semaphores: [*]const Semaphore,
};
pub const ImageCopy = extern struct {
    src_subresource: ImageSubresourceLayers,
    src_offset: Offset3D,
    dst_subresource: ImageSubresourceLayers,
    dst_offset: Offset3D,
    extent: Extent3D,
};
pub const ImageBlit = extern struct {
    src_subresource: ImageSubresourceLayers,
    src_offsets: [2]Offset3D,
    dst_subresource: ImageSubresourceLayers,
    dst_offsets: [2]Offset3D,
};
pub const BufferImageCopy = extern struct {
    buffer_offset: DeviceSize,
    buffer_row_length: u32,
    buffer_image_height: u32,
    image_subresource: ImageSubresourceLayers,
    image_offset: Offset3D,
    image_extent: Extent3D,
};
pub const ImageResolve = extern struct {
    src_subresource: ImageSubresourceLayers,
    src_offset: Offset3D,
    dst_subresource: ImageSubresourceLayers,
    dst_offset: Offset3D,
    extent: Extent3D,
};
pub const ShaderModuleCreateInfo = extern struct {
    s_type: StructureType = .shader_module_create_info,
    p_next: ?*const c_void = null,
    flags: ShaderModuleCreateFlags,
    code_size: usize,
    p_code: [*]const u32,
};
pub const DescriptorSetLayoutBinding = extern struct {
    binding: u32,
    descriptor_type: DescriptorType,
    descriptor_count: u32,
    stage_flags: ShaderStageFlags,
    p_immutable_samplers: ?[*]const Sampler,
};
pub const DescriptorSetLayoutCreateInfo = extern struct {
    s_type: StructureType = .descriptor_set_layout_create_info,
    p_next: ?*const c_void = null,
    flags: DescriptorSetLayoutCreateFlags,
    binding_count: u32,
    p_bindings: [*]const DescriptorSetLayoutBinding,
};
pub const DescriptorPoolSize = extern struct {
    @"type": DescriptorType,
    descriptor_count: u32,
};
pub const DescriptorPoolCreateInfo = extern struct {
    s_type: StructureType = .descriptor_pool_create_info,
    p_next: ?*const c_void = null,
    flags: DescriptorPoolCreateFlags,
    max_sets: u32,
    pool_size_count: u32,
    p_pool_sizes: [*]const DescriptorPoolSize,
};
pub const DescriptorSetAllocateInfo = extern struct {
    s_type: StructureType = .descriptor_set_allocate_info,
    p_next: ?*const c_void = null,
    descriptor_pool: DescriptorPool,
    descriptor_set_count: u32,
    p_set_layouts: [*]const DescriptorSetLayout,
};
pub const SpecializationMapEntry = extern struct {
    constant_id: u32,
    offset: u32,
    size: usize,
};
pub const SpecializationInfo = extern struct {
    map_entry_count: u32,
    p_map_entries: [*]const SpecializationMapEntry,
    data_size: usize,
    p_data: *const c_void,
};
pub const PipelineShaderStageCreateInfo = extern struct {
    s_type: StructureType = .pipeline_shader_stage_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineShaderStageCreateFlags,
    stage: ShaderStageFlags,
    module: ShaderModule,
    p_name: [*:0]const u8,
    p_specialization_info: ?*const SpecializationInfo,
};
pub const ComputePipelineCreateInfo = extern struct {
    s_type: StructureType = .compute_pipeline_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineCreateFlags,
    stage: PipelineShaderStageCreateInfo,
    layout: PipelineLayout,
    base_pipeline_handle: Pipeline,
    base_pipeline_index: i32,
};
pub const VertexInputBindingDescription = extern struct {
    binding: u32,
    stride: u32,
    input_rate: VertexInputRate,
};
pub const VertexInputAttributeDescription = extern struct {
    location: u32,
    binding: u32,
    format: Format,
    offset: u32,
};
pub const PipelineVertexInputStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_vertex_input_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineVertexInputStateCreateFlags,
    vertex_binding_description_count: u32,
    p_vertex_binding_descriptions: [*]const VertexInputBindingDescription,
    vertex_attribute_description_count: u32,
    p_vertex_attribute_descriptions: [*]const VertexInputAttributeDescription,
};
pub const PipelineInputAssemblyStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_input_assembly_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineInputAssemblyStateCreateFlags,
    topology: PrimitiveTopology,
    primitive_restart_enable: Bool32,
};
pub const PipelineTessellationStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_tessellation_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineTessellationStateCreateFlags,
    patch_control_points: u32,
};
pub const PipelineViewportStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_viewport_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineViewportStateCreateFlags,
    viewport_count: u32,
    p_viewports: ?[*]const Viewport,
    scissor_count: u32,
    p_scissors: ?[*]const Rect2D,
};
pub const PipelineRasterizationStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_rasterization_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineRasterizationStateCreateFlags,
    depth_clamp_enable: Bool32,
    rasterizer_discard_enable: Bool32,
    polygon_mode: PolygonMode,
    cull_mode: CullModeFlags,
    front_face: FrontFace,
    depth_bias_enable: Bool32,
    depth_bias_constant_factor: f32,
    depth_bias_clamp: f32,
    depth_bias_slope_factor: f32,
    line_width: f32,
};
pub const PipelineMultisampleStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_multisample_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineMultisampleStateCreateFlags,
    rasterization_samples: SampleCountFlags,
    sample_shading_enable: Bool32,
    min_sample_shading: f32,
    p_sample_mask: ?[*]const SampleMask,
    alpha_to_coverage_enable: Bool32,
    alpha_to_one_enable: Bool32,
};
pub const PipelineColorBlendAttachmentState = extern struct {
    blend_enable: Bool32,
    src_color_blend_factor: BlendFactor,
    dst_color_blend_factor: BlendFactor,
    color_blend_op: BlendOp,
    src_alpha_blend_factor: BlendFactor,
    dst_alpha_blend_factor: BlendFactor,
    alpha_blend_op: BlendOp,
    color_write_mask: ColorComponentFlags,
};
pub const PipelineColorBlendStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_color_blend_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineColorBlendStateCreateFlags,
    logic_op_enable: Bool32,
    logic_op: LogicOp,
    attachment_count: u32,
    p_attachments: [*]const PipelineColorBlendAttachmentState,
    blend_constants: [4]f32,
};
pub const PipelineDynamicStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_dynamic_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineDynamicStateCreateFlags,
    dynamic_state_count: u32,
    p_dynamic_states: [*]const DynamicState,
};
pub const StencilOpState = extern struct {
    fail_op: StencilOp,
    pass_op: StencilOp,
    depth_fail_op: StencilOp,
    compare_op: CompareOp,
    compare_mask: u32,
    write_mask: u32,
    reference: u32,
};
pub const PipelineDepthStencilStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_depth_stencil_state_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineDepthStencilStateCreateFlags,
    depth_test_enable: Bool32,
    depth_write_enable: Bool32,
    depth_compare_op: CompareOp,
    depth_bounds_test_enable: Bool32,
    stencil_test_enable: Bool32,
    front: StencilOpState,
    back: StencilOpState,
    min_depth_bounds: f32,
    max_depth_bounds: f32,
};
pub const GraphicsPipelineCreateInfo = extern struct {
    s_type: StructureType = .graphics_pipeline_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineCreateFlags,
    stage_count: u32,
    p_stages: [*]const PipelineShaderStageCreateInfo,
    p_vertex_input_state: ?*const PipelineVertexInputStateCreateInfo,
    p_input_assembly_state: ?*const PipelineInputAssemblyStateCreateInfo,
    p_tessellation_state: ?*const PipelineTessellationStateCreateInfo,
    p_viewport_state: ?*const PipelineViewportStateCreateInfo,
    p_rasterization_state: *const PipelineRasterizationStateCreateInfo,
    p_multisample_state: ?*const PipelineMultisampleStateCreateInfo,
    p_depth_stencil_state: ?*const PipelineDepthStencilStateCreateInfo,
    p_color_blend_state: ?*const PipelineColorBlendStateCreateInfo,
    p_dynamic_state: ?*const PipelineDynamicStateCreateInfo,
    layout: PipelineLayout,
    render_pass: RenderPass,
    subpass: u32,
    base_pipeline_handle: Pipeline,
    base_pipeline_index: i32,
};
pub const PipelineCacheCreateInfo = extern struct {
    s_type: StructureType = .pipeline_cache_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineCacheCreateFlags,
    initial_data_size: usize,
    p_initial_data: *const c_void,
};
pub const PipelineCacheHeaderVersionOne = extern struct {
    header_size: u32,
    header_version: PipelineCacheHeaderVersion,
    vendor_id: u32,
    device_id: u32,
    pipeline_cache_uuid: [UUID_SIZE]u8,
};
pub const PushConstantRange = extern struct {
    stage_flags: ShaderStageFlags,
    offset: u32,
    size: u32,
};
pub const PipelineLayoutCreateInfo = extern struct {
    s_type: StructureType = .pipeline_layout_create_info,
    p_next: ?*const c_void = null,
    flags: PipelineLayoutCreateFlags,
    set_layout_count: u32,
    p_set_layouts: [*]const DescriptorSetLayout,
    push_constant_range_count: u32,
    p_push_constant_ranges: [*]const PushConstantRange,
};
pub const SamplerCreateInfo = extern struct {
    s_type: StructureType = .sampler_create_info,
    p_next: ?*const c_void = null,
    flags: SamplerCreateFlags,
    mag_filter: Filter,
    min_filter: Filter,
    mipmap_mode: SamplerMipmapMode,
    address_mode_u: SamplerAddressMode,
    address_mode_v: SamplerAddressMode,
    address_mode_w: SamplerAddressMode,
    mip_lod_bias: f32,
    anisotropy_enable: Bool32,
    max_anisotropy: f32,
    compare_enable: Bool32,
    compare_op: CompareOp,
    min_lod: f32,
    max_lod: f32,
    border_color: BorderColor,
    unnormalized_coordinates: Bool32,
};
pub const CommandPoolCreateInfo = extern struct {
    s_type: StructureType = .command_pool_create_info,
    p_next: ?*const c_void = null,
    flags: CommandPoolCreateFlags,
    queue_family_index: u32,
};
pub const CommandBufferAllocateInfo = extern struct {
    s_type: StructureType = .command_buffer_allocate_info,
    p_next: ?*const c_void = null,
    command_pool: CommandPool,
    level: CommandBufferLevel,
    command_buffer_count: u32,
};
pub const CommandBufferInheritanceInfo = extern struct {
    s_type: StructureType = .command_buffer_inheritance_info,
    p_next: ?*const c_void = null,
    render_pass: RenderPass,
    subpass: u32,
    framebuffer: Framebuffer,
    occlusion_query_enable: Bool32,
    query_flags: QueryControlFlags,
    pipeline_statistics: QueryPipelineStatisticFlags,
};
pub const CommandBufferBeginInfo = extern struct {
    s_type: StructureType = .command_buffer_begin_info,
    p_next: ?*const c_void = null,
    flags: CommandBufferUsageFlags,
    p_inheritance_info: ?*const CommandBufferInheritanceInfo,
};
pub const RenderPassBeginInfo = extern struct {
    s_type: StructureType = .render_pass_begin_info,
    p_next: ?*const c_void = null,
    render_pass: RenderPass,
    framebuffer: Framebuffer,
    render_area: Rect2D,
    clear_value_count: u32,
    p_clear_values: [*]const ClearValue,
};
pub const ClearColorValue = extern union {
    float_32: [4]f32,
    int_32: [4]i32,
    uint_32: [4]u32,
};
pub const ClearDepthStencilValue = extern struct {
    depth: f32,
    stencil: u32,
};
pub const ClearValue = extern union {
    color: ClearColorValue,
    depth_stencil: ClearDepthStencilValue,
};
pub const ClearAttachment = extern struct {
    aspect_mask: ImageAspectFlags,
    color_attachment: u32,
    clear_value: ClearValue,
};
pub const AttachmentDescription = extern struct {
    flags: AttachmentDescriptionFlags,
    format: Format,
    samples: SampleCountFlags,
    load_op: AttachmentLoadOp,
    store_op: AttachmentStoreOp,
    stencil_load_op: AttachmentLoadOp,
    stencil_store_op: AttachmentStoreOp,
    initial_layout: ImageLayout,
    final_layout: ImageLayout,
};
pub const AttachmentReference = extern struct {
    attachment: u32,
    layout: ImageLayout,
};
pub const SubpassDescription = extern struct {
    flags: SubpassDescriptionFlags,
    pipeline_bind_point: PipelineBindPoint,
    input_attachment_count: u32,
    p_input_attachments: [*]const AttachmentReference,
    color_attachment_count: u32,
    p_color_attachments: [*]const AttachmentReference,
    p_resolve_attachments: ?[*]const AttachmentReference,
    p_depth_stencil_attachment: ?*const AttachmentReference,
    preserve_attachment_count: u32,
    p_preserve_attachments: [*]const u32,
};
pub const SubpassDependency = extern struct {
    src_subpass: u32,
    dst_subpass: u32,
    src_stage_mask: PipelineStageFlags,
    dst_stage_mask: PipelineStageFlags,
    src_access_mask: AccessFlags,
    dst_access_mask: AccessFlags,
    dependency_flags: DependencyFlags,
};
pub const RenderPassCreateInfo = extern struct {
    s_type: StructureType = .render_pass_create_info,
    p_next: ?*const c_void = null,
    flags: RenderPassCreateFlags,
    attachment_count: u32,
    p_attachments: [*]const AttachmentDescription,
    subpass_count: u32,
    p_subpasses: [*]const SubpassDescription,
    dependency_count: u32,
    p_dependencies: [*]const SubpassDependency,
};
pub const EventCreateInfo = extern struct {
    s_type: StructureType = .event_create_info,
    p_next: ?*const c_void = null,
    flags: EventCreateFlags,
};
pub const FenceCreateInfo = extern struct {
    s_type: StructureType = .fence_create_info,
    p_next: ?*const c_void = null,
    flags: FenceCreateFlags,
};
pub const PhysicalDeviceFeatures = extern struct {
    robust_buffer_access: Bool32 = FALSE,
    full_draw_index_uint_32: Bool32 = FALSE,
    image_cube_array: Bool32 = FALSE,
    independent_blend: Bool32 = FALSE,
    geometry_shader: Bool32 = FALSE,
    tessellation_shader: Bool32 = FALSE,
    sample_rate_shading: Bool32 = FALSE,
    dual_src_blend: Bool32 = FALSE,
    logic_op: Bool32 = FALSE,
    multi_draw_indirect: Bool32 = FALSE,
    draw_indirect_first_instance: Bool32 = FALSE,
    depth_clamp: Bool32 = FALSE,
    depth_bias_clamp: Bool32 = FALSE,
    fill_mode_non_solid: Bool32 = FALSE,
    depth_bounds: Bool32 = FALSE,
    wide_lines: Bool32 = FALSE,
    large_points: Bool32 = FALSE,
    alpha_to_one: Bool32 = FALSE,
    multi_viewport: Bool32 = FALSE,
    sampler_anisotropy: Bool32 = FALSE,
    texture_compression_etc2: Bool32 = FALSE,
    texture_compression_astc_ldr: Bool32 = FALSE,
    texture_compression_bc: Bool32 = FALSE,
    occlusion_query_precise: Bool32 = FALSE,
    pipeline_statistics_query: Bool32 = FALSE,
    vertex_pipeline_stores_and_atomics: Bool32 = FALSE,
    fragment_stores_and_atomics: Bool32 = FALSE,
    shader_tessellation_and_geometry_point_size: Bool32 = FALSE,
    shader_image_gather_extended: Bool32 = FALSE,
    shader_storage_image_extended_formats: Bool32 = FALSE,
    shader_storage_image_multisample: Bool32 = FALSE,
    shader_storage_image_read_without_format: Bool32 = FALSE,
    shader_storage_image_write_without_format: Bool32 = FALSE,
    shader_uniform_buffer_array_dynamic_indexing: Bool32 = FALSE,
    shader_sampled_image_array_dynamic_indexing: Bool32 = FALSE,
    shader_storage_buffer_array_dynamic_indexing: Bool32 = FALSE,
    shader_storage_image_array_dynamic_indexing: Bool32 = FALSE,
    shader_clip_distance: Bool32 = FALSE,
    shader_cull_distance: Bool32 = FALSE,
    shader_float_64: Bool32 = FALSE,
    shader_int_64: Bool32 = FALSE,
    shader_int_16: Bool32 = FALSE,
    shader_resource_residency: Bool32 = FALSE,
    shader_resource_min_lod: Bool32 = FALSE,
    sparse_binding: Bool32 = FALSE,
    sparse_residency_buffer: Bool32 = FALSE,
    sparse_residency_image_2d: Bool32 = FALSE,
    sparse_residency_image_3d: Bool32 = FALSE,
    sparse_residency_2_samples: Bool32 = FALSE,
    sparse_residency_4_samples: Bool32 = FALSE,
    sparse_residency_8_samples: Bool32 = FALSE,
    sparse_residency_16_samples: Bool32 = FALSE,
    sparse_residency_aliased: Bool32 = FALSE,
    variable_multisample_rate: Bool32 = FALSE,
    inherited_queries: Bool32 = FALSE,
};
pub const PhysicalDeviceSparseProperties = extern struct {
    residency_standard_2d_block_shape: Bool32,
    residency_standard_2d_multisample_block_shape: Bool32,
    residency_standard_3d_block_shape: Bool32,
    residency_aligned_mip_size: Bool32,
    residency_non_resident_strict: Bool32,
};
pub const PhysicalDeviceLimits = extern struct {
    max_image_dimension_1d: u32,
    max_image_dimension_2d: u32,
    max_image_dimension_3d: u32,
    max_image_dimension_cube: u32,
    max_image_array_layers: u32,
    max_texel_buffer_elements: u32,
    max_uniform_buffer_range: u32,
    max_storage_buffer_range: u32,
    max_push_constants_size: u32,
    max_memory_allocation_count: u32,
    max_sampler_allocation_count: u32,
    buffer_image_granularity: DeviceSize,
    sparse_address_space_size: DeviceSize,
    max_bound_descriptor_sets: u32,
    max_per_stage_descriptor_samplers: u32,
    max_per_stage_descriptor_uniform_buffers: u32,
    max_per_stage_descriptor_storage_buffers: u32,
    max_per_stage_descriptor_sampled_images: u32,
    max_per_stage_descriptor_storage_images: u32,
    max_per_stage_descriptor_input_attachments: u32,
    max_per_stage_resources: u32,
    max_descriptor_set_samplers: u32,
    max_descriptor_set_uniform_buffers: u32,
    max_descriptor_set_uniform_buffers_dynamic: u32,
    max_descriptor_set_storage_buffers: u32,
    max_descriptor_set_storage_buffers_dynamic: u32,
    max_descriptor_set_sampled_images: u32,
    max_descriptor_set_storage_images: u32,
    max_descriptor_set_input_attachments: u32,
    max_vertex_input_attributes: u32,
    max_vertex_input_bindings: u32,
    max_vertex_input_attribute_offset: u32,
    max_vertex_input_binding_stride: u32,
    max_vertex_output_components: u32,
    max_tessellation_generation_level: u32,
    max_tessellation_patch_size: u32,
    max_tessellation_control_per_vertex_input_components: u32,
    max_tessellation_control_per_vertex_output_components: u32,
    max_tessellation_control_per_patch_output_components: u32,
    max_tessellation_control_total_output_components: u32,
    max_tessellation_evaluation_input_components: u32,
    max_tessellation_evaluation_output_components: u32,
    max_geometry_shader_invocations: u32,
    max_geometry_input_components: u32,
    max_geometry_output_components: u32,
    max_geometry_output_vertices: u32,
    max_geometry_total_output_components: u32,
    max_fragment_input_components: u32,
    max_fragment_output_attachments: u32,
    max_fragment_dual_src_attachments: u32,
    max_fragment_combined_output_resources: u32,
    max_compute_shared_memory_size: u32,
    max_compute_work_group_count: [3]u32,
    max_compute_work_group_invocations: u32,
    max_compute_work_group_size: [3]u32,
    sub_pixel_precision_bits: u32,
    sub_texel_precision_bits: u32,
    mipmap_precision_bits: u32,
    max_draw_indexed_index_value: u32,
    max_draw_indirect_count: u32,
    max_sampler_lod_bias: f32,
    max_sampler_anisotropy: f32,
    max_viewports: u32,
    max_viewport_dimensions: [2]u32,
    viewport_bounds_range: [2]f32,
    viewport_sub_pixel_bits: u32,
    min_memory_map_alignment: usize,
    min_texel_buffer_offset_alignment: DeviceSize,
    min_uniform_buffer_offset_alignment: DeviceSize,
    min_storage_buffer_offset_alignment: DeviceSize,
    min_texel_offset: i32,
    max_texel_offset: u32,
    min_texel_gather_offset: i32,
    max_texel_gather_offset: u32,
    min_interpolation_offset: f32,
    max_interpolation_offset: f32,
    sub_pixel_interpolation_offset_bits: u32,
    max_framebuffer_width: u32,
    max_framebuffer_height: u32,
    max_framebuffer_layers: u32,
    framebuffer_color_sample_counts: SampleCountFlags,
    framebuffer_depth_sample_counts: SampleCountFlags,
    framebuffer_stencil_sample_counts: SampleCountFlags,
    framebuffer_no_attachments_sample_counts: SampleCountFlags,
    max_color_attachments: u32,
    sampled_image_color_sample_counts: SampleCountFlags,
    sampled_image_integer_sample_counts: SampleCountFlags,
    sampled_image_depth_sample_counts: SampleCountFlags,
    sampled_image_stencil_sample_counts: SampleCountFlags,
    storage_image_sample_counts: SampleCountFlags,
    max_sample_mask_words: u32,
    timestamp_compute_and_graphics: Bool32,
    timestamp_period: f32,
    max_clip_distances: u32,
    max_cull_distances: u32,
    max_combined_clip_and_cull_distances: u32,
    discrete_queue_priorities: u32,
    point_size_range: [2]f32,
    line_width_range: [2]f32,
    point_size_granularity: f32,
    line_width_granularity: f32,
    strict_lines: Bool32,
    standard_sample_locations: Bool32,
    optimal_buffer_copy_offset_alignment: DeviceSize,
    optimal_buffer_copy_row_pitch_alignment: DeviceSize,
    non_coherent_atom_size: DeviceSize,
};
pub const SemaphoreCreateInfo = extern struct {
    s_type: StructureType = .semaphore_create_info,
    p_next: ?*const c_void = null,
    flags: SemaphoreCreateFlags,
};
pub const QueryPoolCreateInfo = extern struct {
    s_type: StructureType = .query_pool_create_info,
    p_next: ?*const c_void = null,
    flags: QueryPoolCreateFlags,
    query_type: QueryType,
    query_count: u32,
    pipeline_statistics: QueryPipelineStatisticFlags,
};
pub const FramebufferCreateInfo = extern struct {
    s_type: StructureType = .framebuffer_create_info,
    p_next: ?*const c_void = null,
    flags: FramebufferCreateFlags,
    render_pass: RenderPass,
    attachment_count: u32,
    p_attachments: [*]const ImageView,
    width: u32,
    height: u32,
    layers: u32,
};
pub const DrawIndirectCommand = extern struct {
    vertex_count: u32,
    instance_count: u32,
    first_vertex: u32,
    first_instance: u32,
};
pub const DrawIndexedIndirectCommand = extern struct {
    index_count: u32,
    instance_count: u32,
    first_index: u32,
    vertex_offset: i32,
    first_instance: u32,
};
pub const DispatchIndirectCommand = extern struct {
    x: u32,
    y: u32,
    z: u32,
};
pub const MultiDrawInfoEXT = extern struct {
    first_vertex: u32,
    vertex_count: u32,
};
pub const MultiDrawIndexedInfoEXT = extern struct {
    first_index: u32,
    index_count: u32,
    vertex_offset: i32,
};
pub const SubmitInfo = extern struct {
    s_type: StructureType = .submit_info,
    p_next: ?*const c_void = null,
    wait_semaphore_count: u32,
    p_wait_semaphores: [*]const Semaphore,
    p_wait_dst_stage_mask: [*]const PipelineStageFlags,
    command_buffer_count: u32,
    p_command_buffers: [*]const CommandBuffer,
    signal_semaphore_count: u32,
    p_signal_semaphores: [*]const Semaphore,
};
pub const DisplayPropertiesKHR = extern struct {
    display: DisplayKHR,
    display_name: [*:0]const u8,
    physical_dimensions: Extent2D,
    physical_resolution: Extent2D,
    supported_transforms: SurfaceTransformFlagsKHR,
    plane_reorder_possible: Bool32,
    persistent_content: Bool32,
};
pub const DisplayPlanePropertiesKHR = extern struct {
    current_display: DisplayKHR,
    current_stack_index: u32,
};
pub const DisplayModeParametersKHR = extern struct {
    visible_region: Extent2D,
    refresh_rate: u32,
};
pub const DisplayModePropertiesKHR = extern struct {
    display_mode: DisplayModeKHR,
    parameters: DisplayModeParametersKHR,
};
pub const DisplayModeCreateInfoKHR = extern struct {
    s_type: StructureType = .display_mode_create_info_khr,
    p_next: ?*const c_void = null,
    flags: DisplayModeCreateFlagsKHR,
    parameters: DisplayModeParametersKHR,
};
pub const DisplayPlaneCapabilitiesKHR = extern struct {
    supported_alpha: DisplayPlaneAlphaFlagsKHR,
    min_src_position: Offset2D,
    max_src_position: Offset2D,
    min_src_extent: Extent2D,
    max_src_extent: Extent2D,
    min_dst_position: Offset2D,
    max_dst_position: Offset2D,
    min_dst_extent: Extent2D,
    max_dst_extent: Extent2D,
};
pub const DisplaySurfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .display_surface_create_info_khr,
    p_next: ?*const c_void = null,
    flags: DisplaySurfaceCreateFlagsKHR,
    display_mode: DisplayModeKHR,
    plane_index: u32,
    plane_stack_index: u32,
    transform: SurfaceTransformFlagsKHR,
    global_alpha: f32,
    alpha_mode: DisplayPlaneAlphaFlagsKHR,
    image_extent: Extent2D,
};
pub const DisplayPresentInfoKHR = extern struct {
    s_type: StructureType = .display_present_info_khr,
    p_next: ?*const c_void = null,
    src_rect: Rect2D,
    dst_rect: Rect2D,
    persistent: Bool32,
};
pub const SurfaceCapabilitiesKHR = extern struct {
    min_image_count: u32,
    max_image_count: u32,
    current_extent: Extent2D,
    min_image_extent: Extent2D,
    max_image_extent: Extent2D,
    max_image_array_layers: u32,
    supported_transforms: SurfaceTransformFlagsKHR,
    current_transform: SurfaceTransformFlagsKHR,
    supported_composite_alpha: CompositeAlphaFlagsKHR,
    supported_usage_flags: ImageUsageFlags,
};
pub const AndroidSurfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .android_surface_create_info_khr,
    p_next: ?*const c_void = null,
    flags: AndroidSurfaceCreateFlagsKHR,
    window: *ANativeWindow,
};
pub const ViSurfaceCreateInfoNN = extern struct {
    s_type: StructureType = .vi_surface_create_info_nn,
    p_next: ?*const c_void = null,
    flags: ViSurfaceCreateFlagsNN,
    window: *c_void,
};
pub const WaylandSurfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .wayland_surface_create_info_khr,
    p_next: ?*const c_void = null,
    flags: WaylandSurfaceCreateFlagsKHR,
    display: *wl_display,
    surface: *wl_surface,
};
pub const Win32SurfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .win32_surface_create_info_khr,
    p_next: ?*const c_void = null,
    flags: Win32SurfaceCreateFlagsKHR,
    hinstance: HINSTANCE,
    hwnd: HWND,
};
pub const XlibSurfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .xlib_surface_create_info_khr,
    p_next: ?*const c_void = null,
    flags: XlibSurfaceCreateFlagsKHR,
    dpy: *Display,
    window: Window,
};
pub const XcbSurfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .xcb_surface_create_info_khr,
    p_next: ?*const c_void = null,
    flags: XcbSurfaceCreateFlagsKHR,
    connection: *xcb_connection_t,
    window: xcb_window_t,
};
pub const DirectFBSurfaceCreateInfoEXT = extern struct {
    s_type: StructureType = .directfb_surface_create_info_ext,
    p_next: ?*const c_void = null,
    flags: DirectFBSurfaceCreateFlagsEXT,
    dfb: *IDirectFB,
    surface: *IDirectFBSurface,
};
pub const ImagePipeSurfaceCreateInfoFUCHSIA = extern struct {
    s_type: StructureType = .imagepipe_surface_create_info_fuchsia,
    p_next: ?*const c_void = null,
    flags: ImagePipeSurfaceCreateFlagsFUCHSIA,
    image_pipe_handle: zx_handle_t,
};
pub const StreamDescriptorSurfaceCreateInfoGGP = extern struct {
    s_type: StructureType = .stream_descriptor_surface_create_info_ggp,
    p_next: ?*const c_void = null,
    flags: StreamDescriptorSurfaceCreateFlagsGGP,
    stream_descriptor: GgpStreamDescriptor,
};
pub const ScreenSurfaceCreateInfoQNX = extern struct {
    s_type: StructureType = .screen_surface_create_info_qnx,
    p_next: ?*const c_void = null,
    flags: ScreenSurfaceCreateFlagsQNX,
    context: *_screen_context,
    window: *_screen_window,
};
pub const SurfaceFormatKHR = extern struct {
    format: Format,
    color_space: ColorSpaceKHR,
};
pub const SwapchainCreateInfoKHR = extern struct {
    s_type: StructureType = .swapchain_create_info_khr,
    p_next: ?*const c_void = null,
    flags: SwapchainCreateFlagsKHR,
    surface: SurfaceKHR,
    min_image_count: u32,
    image_format: Format,
    image_color_space: ColorSpaceKHR,
    image_extent: Extent2D,
    image_array_layers: u32,
    image_usage: ImageUsageFlags,
    image_sharing_mode: SharingMode,
    queue_family_index_count: u32,
    p_queue_family_indices: [*]const u32,
    pre_transform: SurfaceTransformFlagsKHR,
    composite_alpha: CompositeAlphaFlagsKHR,
    present_mode: PresentModeKHR,
    clipped: Bool32,
    old_swapchain: SwapchainKHR,
};
pub const PresentInfoKHR = extern struct {
    s_type: StructureType = .present_info_khr,
    p_next: ?*const c_void = null,
    wait_semaphore_count: u32,
    p_wait_semaphores: [*]const Semaphore,
    swapchain_count: u32,
    p_swapchains: [*]const SwapchainKHR,
    p_image_indices: [*]const u32,
    p_results: ?[*]Result,
};
pub const DebugReportCallbackCreateInfoEXT = extern struct {
    s_type: StructureType = .debug_report_callback_create_info_ext,
    p_next: ?*const c_void = null,
    flags: DebugReportFlagsEXT,
    pfn_callback: PfnDebugReportCallbackEXT,
    p_user_data: ?*c_void,
};
pub const ValidationFlagsEXT = extern struct {
    s_type: StructureType = .validation_flags_ext,
    p_next: ?*const c_void = null,
    disabled_validation_check_count: u32,
    p_disabled_validation_checks: [*]const ValidationCheckEXT,
};
pub const ValidationFeaturesEXT = extern struct {
    s_type: StructureType = .validation_features_ext,
    p_next: ?*const c_void = null,
    enabled_validation_feature_count: u32,
    p_enabled_validation_features: [*]const ValidationFeatureEnableEXT,
    disabled_validation_feature_count: u32,
    p_disabled_validation_features: [*]const ValidationFeatureDisableEXT,
};
pub const PipelineRasterizationStateRasterizationOrderAMD = extern struct {
    s_type: StructureType = .pipeline_rasterization_state_rasterization_order_amd,
    p_next: ?*const c_void = null,
    rasterization_order: RasterizationOrderAMD,
};
pub const DebugMarkerObjectNameInfoEXT = extern struct {
    s_type: StructureType = .debug_marker_object_name_info_ext,
    p_next: ?*const c_void = null,
    object_type: DebugReportObjectTypeEXT,
    object: u64,
    p_object_name: [*:0]const u8,
};
pub const DebugMarkerObjectTagInfoEXT = extern struct {
    s_type: StructureType = .debug_marker_object_tag_info_ext,
    p_next: ?*const c_void = null,
    object_type: DebugReportObjectTypeEXT,
    object: u64,
    tag_name: u64,
    tag_size: usize,
    p_tag: *const c_void,
};
pub const DebugMarkerMarkerInfoEXT = extern struct {
    s_type: StructureType = .debug_marker_marker_info_ext,
    p_next: ?*const c_void = null,
    p_marker_name: [*:0]const u8,
    color: [4]f32,
};
pub const DedicatedAllocationImageCreateInfoNV = extern struct {
    s_type: StructureType = .dedicated_allocation_image_create_info_nv,
    p_next: ?*const c_void = null,
    dedicated_allocation: Bool32,
};
pub const DedicatedAllocationBufferCreateInfoNV = extern struct {
    s_type: StructureType = .dedicated_allocation_buffer_create_info_nv,
    p_next: ?*const c_void = null,
    dedicated_allocation: Bool32,
};
pub const DedicatedAllocationMemoryAllocateInfoNV = extern struct {
    s_type: StructureType = .dedicated_allocation_memory_allocate_info_nv,
    p_next: ?*const c_void = null,
    image: Image,
    buffer: Buffer,
};
pub const ExternalImageFormatPropertiesNV = extern struct {
    image_format_properties: ImageFormatProperties,
    external_memory_features: ExternalMemoryFeatureFlagsNV,
    export_from_imported_handle_types: ExternalMemoryHandleTypeFlagsNV,
    compatible_handle_types: ExternalMemoryHandleTypeFlagsNV,
};
pub const ExternalMemoryImageCreateInfoNV = extern struct {
    s_type: StructureType = .external_memory_image_create_info_nv,
    p_next: ?*const c_void = null,
    handle_types: ExternalMemoryHandleTypeFlagsNV,
};
pub const ExportMemoryAllocateInfoNV = extern struct {
    s_type: StructureType = .export_memory_allocate_info_nv,
    p_next: ?*const c_void = null,
    handle_types: ExternalMemoryHandleTypeFlagsNV,
};
pub const ImportMemoryWin32HandleInfoNV = extern struct {
    s_type: StructureType = .import_memory_win32_handle_info_nv,
    p_next: ?*const c_void = null,
    handle_type: ExternalMemoryHandleTypeFlagsNV,
    handle: HANDLE,
};
pub const ExportMemoryWin32HandleInfoNV = extern struct {
    s_type: StructureType = .export_memory_win32_handle_info_nv,
    p_next: ?*const c_void = null,
    p_attributes: ?*const SECURITY_ATTRIBUTES,
    dw_access: DWORD,
};
pub const Win32KeyedMutexAcquireReleaseInfoNV = extern struct {
    s_type: StructureType = .win32_keyed_mutex_acquire_release_info_nv,
    p_next: ?*const c_void = null,
    acquire_count: u32,
    p_acquire_syncs: [*]const DeviceMemory,
    p_acquire_keys: [*]const u64,
    p_acquire_timeout_milliseconds: [*]const u32,
    release_count: u32,
    p_release_syncs: [*]const DeviceMemory,
    p_release_keys: [*]const u64,
};
pub const PhysicalDeviceDeviceGeneratedCommandsFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_device_generated_commands_features_nv,
    p_next: ?*c_void = null,
    device_generated_commands: Bool32 = FALSE,
};
pub const DevicePrivateDataCreateInfoEXT = extern struct {
    s_type: StructureType = .device_private_data_create_info_ext,
    p_next: ?*const c_void = null,
    private_data_slot_request_count: u32,
};
pub const PrivateDataSlotCreateInfoEXT = extern struct {
    s_type: StructureType = .private_data_slot_create_info_ext,
    p_next: ?*const c_void = null,
    flags: PrivateDataSlotCreateFlagsEXT,
};
pub const PhysicalDevicePrivateDataFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_private_data_features_ext,
    p_next: ?*c_void = null,
    private_data: Bool32 = FALSE,
};
pub const PhysicalDeviceDeviceGeneratedCommandsPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_device_generated_commands_properties_nv,
    p_next: ?*c_void = null,
    max_graphics_shader_group_count: u32,
    max_indirect_sequence_count: u32,
    max_indirect_commands_token_count: u32,
    max_indirect_commands_stream_count: u32,
    max_indirect_commands_token_offset: u32,
    max_indirect_commands_stream_stride: u32,
    min_sequences_count_buffer_offset_alignment: u32,
    min_sequences_index_buffer_offset_alignment: u32,
    min_indirect_commands_buffer_offset_alignment: u32,
};
pub const PhysicalDeviceMultiDrawPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_multi_draw_properties_ext,
    p_next: ?*c_void = null,
    max_multi_draw_count: u32,
};
pub const GraphicsShaderGroupCreateInfoNV = extern struct {
    s_type: StructureType = .graphics_shader_group_create_info_nv,
    p_next: ?*const c_void = null,
    stage_count: u32,
    p_stages: [*]const PipelineShaderStageCreateInfo,
    p_vertex_input_state: ?*const PipelineVertexInputStateCreateInfo,
    p_tessellation_state: ?*const PipelineTessellationStateCreateInfo,
};
pub const GraphicsPipelineShaderGroupsCreateInfoNV = extern struct {
    s_type: StructureType = .graphics_pipeline_shader_groups_create_info_nv,
    p_next: ?*const c_void = null,
    group_count: u32,
    p_groups: [*]const GraphicsShaderGroupCreateInfoNV,
    pipeline_count: u32,
    p_pipelines: [*]const Pipeline,
};
pub const BindShaderGroupIndirectCommandNV = extern struct {
    group_index: u32,
};
pub const BindIndexBufferIndirectCommandNV = extern struct {
    buffer_address: DeviceAddress,
    size: u32,
    index_type: IndexType,
};
pub const BindVertexBufferIndirectCommandNV = extern struct {
    buffer_address: DeviceAddress,
    size: u32,
    stride: u32,
};
pub const SetStateFlagsIndirectCommandNV = extern struct {
    data: u32,
};
pub const IndirectCommandsStreamNV = extern struct {
    buffer: Buffer,
    offset: DeviceSize,
};
pub const IndirectCommandsLayoutTokenNV = extern struct {
    s_type: StructureType = .indirect_commands_layout_token_nv,
    p_next: ?*const c_void = null,
    token_type: IndirectCommandsTokenTypeNV,
    stream: u32,
    offset: u32,
    vertex_binding_unit: u32,
    vertex_dynamic_stride: Bool32,
    pushconstant_pipeline_layout: PipelineLayout,
    pushconstant_shader_stage_flags: ShaderStageFlags,
    pushconstant_offset: u32,
    pushconstant_size: u32,
    indirect_state_flags: IndirectStateFlagsNV,
    index_type_count: u32,
    p_index_types: [*]const IndexType,
    p_index_type_values: [*]const u32,
};
pub const IndirectCommandsLayoutCreateInfoNV = extern struct {
    s_type: StructureType = .indirect_commands_layout_create_info_nv,
    p_next: ?*const c_void = null,
    flags: IndirectCommandsLayoutUsageFlagsNV,
    pipeline_bind_point: PipelineBindPoint,
    token_count: u32,
    p_tokens: [*]const IndirectCommandsLayoutTokenNV,
    stream_count: u32,
    p_stream_strides: [*]const u32,
};
pub const GeneratedCommandsInfoNV = extern struct {
    s_type: StructureType = .generated_commands_info_nv,
    p_next: ?*const c_void = null,
    pipeline_bind_point: PipelineBindPoint,
    pipeline: Pipeline,
    indirect_commands_layout: IndirectCommandsLayoutNV,
    stream_count: u32,
    p_streams: [*]const IndirectCommandsStreamNV,
    sequences_count: u32,
    preprocess_buffer: Buffer,
    preprocess_offset: DeviceSize,
    preprocess_size: DeviceSize,
    sequences_count_buffer: Buffer,
    sequences_count_offset: DeviceSize,
    sequences_index_buffer: Buffer,
    sequences_index_offset: DeviceSize,
};
pub const GeneratedCommandsMemoryRequirementsInfoNV = extern struct {
    s_type: StructureType = .generated_commands_memory_requirements_info_nv,
    p_next: ?*const c_void = null,
    pipeline_bind_point: PipelineBindPoint,
    pipeline: Pipeline,
    indirect_commands_layout: IndirectCommandsLayoutNV,
    max_sequences_count: u32,
};
pub const PhysicalDeviceFeatures2 = extern struct {
    s_type: StructureType = .physical_device_features_2,
    p_next: ?*c_void = null,
    features: PhysicalDeviceFeatures,
};
pub const PhysicalDeviceFeatures2KHR = PhysicalDeviceFeatures2;
pub const PhysicalDeviceProperties2 = extern struct {
    s_type: StructureType = .physical_device_properties_2,
    p_next: ?*c_void = null,
    properties: PhysicalDeviceProperties,
};
pub const PhysicalDeviceProperties2KHR = PhysicalDeviceProperties2;
pub const FormatProperties2 = extern struct {
    s_type: StructureType = .format_properties_2,
    p_next: ?*c_void = null,
    format_properties: FormatProperties,
};
pub const FormatProperties2KHR = FormatProperties2;
pub const ImageFormatProperties2 = extern struct {
    s_type: StructureType = .image_format_properties_2,
    p_next: ?*c_void = null,
    image_format_properties: ImageFormatProperties,
};
pub const ImageFormatProperties2KHR = ImageFormatProperties2;
pub const PhysicalDeviceImageFormatInfo2 = extern struct {
    s_type: StructureType = .physical_device_image_format_info_2,
    p_next: ?*const c_void = null,
    format: Format,
    @"type": ImageType,
    tiling: ImageTiling,
    usage: ImageUsageFlags,
    flags: ImageCreateFlags,
};
pub const PhysicalDeviceImageFormatInfo2KHR = PhysicalDeviceImageFormatInfo2;
pub const QueueFamilyProperties2 = extern struct {
    s_type: StructureType = .queue_family_properties_2,
    p_next: ?*c_void = null,
    queue_family_properties: QueueFamilyProperties,
};
pub const QueueFamilyProperties2KHR = QueueFamilyProperties2;
pub const PhysicalDeviceMemoryProperties2 = extern struct {
    s_type: StructureType = .physical_device_memory_properties_2,
    p_next: ?*c_void = null,
    memory_properties: PhysicalDeviceMemoryProperties,
};
pub const PhysicalDeviceMemoryProperties2KHR = PhysicalDeviceMemoryProperties2;
pub const SparseImageFormatProperties2 = extern struct {
    s_type: StructureType = .sparse_image_format_properties_2,
    p_next: ?*c_void = null,
    properties: SparseImageFormatProperties,
};
pub const SparseImageFormatProperties2KHR = SparseImageFormatProperties2;
pub const PhysicalDeviceSparseImageFormatInfo2 = extern struct {
    s_type: StructureType = .physical_device_sparse_image_format_info_2,
    p_next: ?*const c_void = null,
    format: Format,
    @"type": ImageType,
    samples: SampleCountFlags,
    usage: ImageUsageFlags,
    tiling: ImageTiling,
};
pub const PhysicalDeviceSparseImageFormatInfo2KHR = PhysicalDeviceSparseImageFormatInfo2;
pub const PhysicalDevicePushDescriptorPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_push_descriptor_properties_khr,
    p_next: ?*c_void = null,
    max_push_descriptors: u32,
};
pub const ConformanceVersion = extern struct {
    major: u8,
    minor: u8,
    subminor: u8,
    patch: u8,
};
pub const ConformanceVersionKHR = ConformanceVersion;
pub const PhysicalDeviceDriverProperties = extern struct {
    s_type: StructureType = .physical_device_driver_properties,
    p_next: ?*c_void = null,
    driver_id: DriverId,
    driver_name: [MAX_DRIVER_NAME_SIZE]u8,
    driver_info: [MAX_DRIVER_INFO_SIZE]u8,
    conformance_version: ConformanceVersion,
};
pub const PhysicalDeviceDriverPropertiesKHR = PhysicalDeviceDriverProperties;
pub const PresentRegionsKHR = extern struct {
    s_type: StructureType = .present_regions_khr,
    p_next: ?*const c_void = null,
    swapchain_count: u32,
    p_regions: ?[*]const PresentRegionKHR,
};
pub const PresentRegionKHR = extern struct {
    rectangle_count: u32,
    p_rectangles: ?[*]const RectLayerKHR,
};
pub const RectLayerKHR = extern struct {
    offset: Offset2D,
    extent: Extent2D,
    layer: u32,
};
pub const PhysicalDeviceVariablePointersFeatures = extern struct {
    s_type: StructureType = .physical_device_variable_pointers_features,
    p_next: ?*c_void = null,
    variable_pointers_storage_buffer: Bool32 = FALSE,
    variable_pointers: Bool32 = FALSE,
};
pub const PhysicalDeviceVariablePointersFeaturesKHR = PhysicalDeviceVariablePointersFeatures;
pub const PhysicalDeviceVariablePointerFeaturesKHR = PhysicalDeviceVariablePointersFeatures;
pub const PhysicalDeviceVariablePointerFeatures = PhysicalDeviceVariablePointersFeatures;
pub const ExternalMemoryProperties = extern struct {
    external_memory_features: ExternalMemoryFeatureFlags,
    export_from_imported_handle_types: ExternalMemoryHandleTypeFlags,
    compatible_handle_types: ExternalMemoryHandleTypeFlags,
};
pub const ExternalMemoryPropertiesKHR = ExternalMemoryProperties;
pub const PhysicalDeviceExternalImageFormatInfo = extern struct {
    s_type: StructureType = .physical_device_external_image_format_info,
    p_next: ?*const c_void = null,
    handle_type: ExternalMemoryHandleTypeFlags,
};
pub const PhysicalDeviceExternalImageFormatInfoKHR = PhysicalDeviceExternalImageFormatInfo;
pub const ExternalImageFormatProperties = extern struct {
    s_type: StructureType = .external_image_format_properties,
    p_next: ?*c_void = null,
    external_memory_properties: ExternalMemoryProperties,
};
pub const ExternalImageFormatPropertiesKHR = ExternalImageFormatProperties;
pub const PhysicalDeviceExternalBufferInfo = extern struct {
    s_type: StructureType = .physical_device_external_buffer_info,
    p_next: ?*const c_void = null,
    flags: BufferCreateFlags,
    usage: BufferUsageFlags,
    handle_type: ExternalMemoryHandleTypeFlags,
};
pub const PhysicalDeviceExternalBufferInfoKHR = PhysicalDeviceExternalBufferInfo;
pub const ExternalBufferProperties = extern struct {
    s_type: StructureType = .external_buffer_properties,
    p_next: ?*c_void = null,
    external_memory_properties: ExternalMemoryProperties,
};
pub const ExternalBufferPropertiesKHR = ExternalBufferProperties;
pub const PhysicalDeviceIDProperties = extern struct {
    s_type: StructureType = .physical_device_id_properties,
    p_next: ?*c_void = null,
    device_uuid: [UUID_SIZE]u8,
    driver_uuid: [UUID_SIZE]u8,
    device_luid: [LUID_SIZE]u8,
    device_node_mask: u32,
    device_luid_valid: Bool32,
};
pub const PhysicalDeviceIDPropertiesKHR = PhysicalDeviceIDProperties;
pub const ExternalMemoryImageCreateInfo = extern struct {
    s_type: StructureType = .external_memory_image_create_info,
    p_next: ?*const c_void = null,
    handle_types: ExternalMemoryHandleTypeFlags,
};
pub const ExternalMemoryImageCreateInfoKHR = ExternalMemoryImageCreateInfo;
pub const ExternalMemoryBufferCreateInfo = extern struct {
    s_type: StructureType = .external_memory_buffer_create_info,
    p_next: ?*const c_void = null,
    handle_types: ExternalMemoryHandleTypeFlags,
};
pub const ExternalMemoryBufferCreateInfoKHR = ExternalMemoryBufferCreateInfo;
pub const ExportMemoryAllocateInfo = extern struct {
    s_type: StructureType = .export_memory_allocate_info,
    p_next: ?*const c_void = null,
    handle_types: ExternalMemoryHandleTypeFlags,
};
pub const ExportMemoryAllocateInfoKHR = ExportMemoryAllocateInfo;
pub const ImportMemoryWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .import_memory_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    handle_type: ExternalMemoryHandleTypeFlags,
    handle: HANDLE,
    name: LPCWSTR,
};
pub const ExportMemoryWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .export_memory_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    p_attributes: ?*const SECURITY_ATTRIBUTES,
    dw_access: DWORD,
    name: LPCWSTR,
};
pub const ImportMemoryZirconHandleInfoFUCHSIA = extern struct {
    s_type: StructureType = .import_memory_zircon_handle_info_fuchsia,
    p_next: ?*const c_void = null,
    handle_type: ExternalMemoryHandleTypeFlags,
    handle: zx_handle_t,
};
pub const MemoryZirconHandlePropertiesFUCHSIA = extern struct {
    s_type: StructureType = .memory_zircon_handle_properties_fuchsia,
    p_next: ?*c_void = null,
    memory_type_bits: u32,
};
pub const MemoryGetZirconHandleInfoFUCHSIA = extern struct {
    s_type: StructureType = .memory_get_zircon_handle_info_fuchsia,
    p_next: ?*const c_void = null,
    memory: DeviceMemory,
    handle_type: ExternalMemoryHandleTypeFlags,
};
pub const MemoryWin32HandlePropertiesKHR = extern struct {
    s_type: StructureType = .memory_win32_handle_properties_khr,
    p_next: ?*c_void = null,
    memory_type_bits: u32,
};
pub const MemoryGetWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .memory_get_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    memory: DeviceMemory,
    handle_type: ExternalMemoryHandleTypeFlags,
};
pub const ImportMemoryFdInfoKHR = extern struct {
    s_type: StructureType = .import_memory_fd_info_khr,
    p_next: ?*const c_void = null,
    handle_type: ExternalMemoryHandleTypeFlags,
    fd: c_int,
};
pub const MemoryFdPropertiesKHR = extern struct {
    s_type: StructureType = .memory_fd_properties_khr,
    p_next: ?*c_void = null,
    memory_type_bits: u32,
};
pub const MemoryGetFdInfoKHR = extern struct {
    s_type: StructureType = .memory_get_fd_info_khr,
    p_next: ?*const c_void = null,
    memory: DeviceMemory,
    handle_type: ExternalMemoryHandleTypeFlags,
};
pub const Win32KeyedMutexAcquireReleaseInfoKHR = extern struct {
    s_type: StructureType = .win32_keyed_mutex_acquire_release_info_khr,
    p_next: ?*const c_void = null,
    acquire_count: u32,
    p_acquire_syncs: [*]const DeviceMemory,
    p_acquire_keys: [*]const u64,
    p_acquire_timeouts: [*]const u32,
    release_count: u32,
    p_release_syncs: [*]const DeviceMemory,
    p_release_keys: [*]const u64,
};
pub const PhysicalDeviceExternalSemaphoreInfo = extern struct {
    s_type: StructureType = .physical_device_external_semaphore_info,
    p_next: ?*const c_void = null,
    handle_type: ExternalSemaphoreHandleTypeFlags,
};
pub const PhysicalDeviceExternalSemaphoreInfoKHR = PhysicalDeviceExternalSemaphoreInfo;
pub const ExternalSemaphoreProperties = extern struct {
    s_type: StructureType = .external_semaphore_properties,
    p_next: ?*c_void = null,
    export_from_imported_handle_types: ExternalSemaphoreHandleTypeFlags,
    compatible_handle_types: ExternalSemaphoreHandleTypeFlags,
    external_semaphore_features: ExternalSemaphoreFeatureFlags,
};
pub const ExternalSemaphorePropertiesKHR = ExternalSemaphoreProperties;
pub const ExportSemaphoreCreateInfo = extern struct {
    s_type: StructureType = .export_semaphore_create_info,
    p_next: ?*const c_void = null,
    handle_types: ExternalSemaphoreHandleTypeFlags,
};
pub const ExportSemaphoreCreateInfoKHR = ExportSemaphoreCreateInfo;
pub const ImportSemaphoreWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .import_semaphore_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    semaphore: Semaphore,
    flags: SemaphoreImportFlags,
    handle_type: ExternalSemaphoreHandleTypeFlags,
    handle: HANDLE,
    name: LPCWSTR,
};
pub const ExportSemaphoreWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .export_semaphore_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    p_attributes: ?*const SECURITY_ATTRIBUTES,
    dw_access: DWORD,
    name: LPCWSTR,
};
pub const D3D12FenceSubmitInfoKHR = extern struct {
    s_type: StructureType = .d3d12_fence_submit_info_khr,
    p_next: ?*const c_void = null,
    wait_semaphore_values_count: u32,
    p_wait_semaphore_values: ?[*]const u64,
    signal_semaphore_values_count: u32,
    p_signal_semaphore_values: ?[*]const u64,
};
pub const SemaphoreGetWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .semaphore_get_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    semaphore: Semaphore,
    handle_type: ExternalSemaphoreHandleTypeFlags,
};
pub const ImportSemaphoreFdInfoKHR = extern struct {
    s_type: StructureType = .import_semaphore_fd_info_khr,
    p_next: ?*const c_void = null,
    semaphore: Semaphore,
    flags: SemaphoreImportFlags,
    handle_type: ExternalSemaphoreHandleTypeFlags,
    fd: c_int,
};
pub const SemaphoreGetFdInfoKHR = extern struct {
    s_type: StructureType = .semaphore_get_fd_info_khr,
    p_next: ?*const c_void = null,
    semaphore: Semaphore,
    handle_type: ExternalSemaphoreHandleTypeFlags,
};
pub const ImportSemaphoreZirconHandleInfoFUCHSIA = extern struct {
    s_type: StructureType = .import_semaphore_zircon_handle_info_fuchsia,
    p_next: ?*const c_void = null,
    semaphore: Semaphore,
    flags: SemaphoreImportFlags,
    handle_type: ExternalSemaphoreHandleTypeFlags,
    zircon_handle: zx_handle_t,
};
pub const SemaphoreGetZirconHandleInfoFUCHSIA = extern struct {
    s_type: StructureType = .semaphore_get_zircon_handle_info_fuchsia,
    p_next: ?*const c_void = null,
    semaphore: Semaphore,
    handle_type: ExternalSemaphoreHandleTypeFlags,
};
pub const PhysicalDeviceExternalFenceInfo = extern struct {
    s_type: StructureType = .physical_device_external_fence_info,
    p_next: ?*const c_void = null,
    handle_type: ExternalFenceHandleTypeFlags,
};
pub const PhysicalDeviceExternalFenceInfoKHR = PhysicalDeviceExternalFenceInfo;
pub const ExternalFenceProperties = extern struct {
    s_type: StructureType = .external_fence_properties,
    p_next: ?*c_void = null,
    export_from_imported_handle_types: ExternalFenceHandleTypeFlags,
    compatible_handle_types: ExternalFenceHandleTypeFlags,
    external_fence_features: ExternalFenceFeatureFlags,
};
pub const ExternalFencePropertiesKHR = ExternalFenceProperties;
pub const ExportFenceCreateInfo = extern struct {
    s_type: StructureType = .export_fence_create_info,
    p_next: ?*const c_void = null,
    handle_types: ExternalFenceHandleTypeFlags,
};
pub const ExportFenceCreateInfoKHR = ExportFenceCreateInfo;
pub const ImportFenceWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .import_fence_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    fence: Fence,
    flags: FenceImportFlags,
    handle_type: ExternalFenceHandleTypeFlags,
    handle: HANDLE,
    name: LPCWSTR,
};
pub const ExportFenceWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .export_fence_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    p_attributes: ?*const SECURITY_ATTRIBUTES,
    dw_access: DWORD,
    name: LPCWSTR,
};
pub const FenceGetWin32HandleInfoKHR = extern struct {
    s_type: StructureType = .fence_get_win32_handle_info_khr,
    p_next: ?*const c_void = null,
    fence: Fence,
    handle_type: ExternalFenceHandleTypeFlags,
};
pub const ImportFenceFdInfoKHR = extern struct {
    s_type: StructureType = .import_fence_fd_info_khr,
    p_next: ?*const c_void = null,
    fence: Fence,
    flags: FenceImportFlags,
    handle_type: ExternalFenceHandleTypeFlags,
    fd: c_int,
};
pub const FenceGetFdInfoKHR = extern struct {
    s_type: StructureType = .fence_get_fd_info_khr,
    p_next: ?*const c_void = null,
    fence: Fence,
    handle_type: ExternalFenceHandleTypeFlags,
};
pub const PhysicalDeviceMultiviewFeatures = extern struct {
    s_type: StructureType = .physical_device_multiview_features,
    p_next: ?*c_void = null,
    multiview: Bool32 = FALSE,
    multiview_geometry_shader: Bool32 = FALSE,
    multiview_tessellation_shader: Bool32 = FALSE,
};
pub const PhysicalDeviceMultiviewFeaturesKHR = PhysicalDeviceMultiviewFeatures;
pub const PhysicalDeviceMultiviewProperties = extern struct {
    s_type: StructureType = .physical_device_multiview_properties,
    p_next: ?*c_void = null,
    max_multiview_view_count: u32,
    max_multiview_instance_index: u32,
};
pub const PhysicalDeviceMultiviewPropertiesKHR = PhysicalDeviceMultiviewProperties;
pub const RenderPassMultiviewCreateInfo = extern struct {
    s_type: StructureType = .render_pass_multiview_create_info,
    p_next: ?*const c_void = null,
    subpass_count: u32,
    p_view_masks: [*]const u32,
    dependency_count: u32,
    p_view_offsets: [*]const i32,
    correlation_mask_count: u32,
    p_correlation_masks: [*]const u32,
};
pub const RenderPassMultiviewCreateInfoKHR = RenderPassMultiviewCreateInfo;
pub const SurfaceCapabilities2EXT = extern struct {
    s_type: StructureType = .surface_capabilities_2_ext,
    p_next: ?*c_void = null,
    min_image_count: u32,
    max_image_count: u32,
    current_extent: Extent2D,
    min_image_extent: Extent2D,
    max_image_extent: Extent2D,
    max_image_array_layers: u32,
    supported_transforms: SurfaceTransformFlagsKHR,
    current_transform: SurfaceTransformFlagsKHR,
    supported_composite_alpha: CompositeAlphaFlagsKHR,
    supported_usage_flags: ImageUsageFlags,
    supported_surface_counters: SurfaceCounterFlagsEXT,
};
pub const DisplayPowerInfoEXT = extern struct {
    s_type: StructureType = .display_power_info_ext,
    p_next: ?*const c_void = null,
    power_state: DisplayPowerStateEXT,
};
pub const DeviceEventInfoEXT = extern struct {
    s_type: StructureType = .device_event_info_ext,
    p_next: ?*const c_void = null,
    device_event: DeviceEventTypeEXT,
};
pub const DisplayEventInfoEXT = extern struct {
    s_type: StructureType = .display_event_info_ext,
    p_next: ?*const c_void = null,
    display_event: DisplayEventTypeEXT,
};
pub const SwapchainCounterCreateInfoEXT = extern struct {
    s_type: StructureType = .swapchain_counter_create_info_ext,
    p_next: ?*const c_void = null,
    surface_counters: SurfaceCounterFlagsEXT,
};
pub const PhysicalDeviceGroupProperties = extern struct {
    s_type: StructureType = .physical_device_group_properties,
    p_next: ?*c_void = null,
    physical_device_count: u32,
    physical_devices: [MAX_DEVICE_GROUP_SIZE]PhysicalDevice,
    subset_allocation: Bool32,
};
pub const PhysicalDeviceGroupPropertiesKHR = PhysicalDeviceGroupProperties;
pub const MemoryAllocateFlagsInfo = extern struct {
    s_type: StructureType = .memory_allocate_flags_info,
    p_next: ?*const c_void = null,
    flags: MemoryAllocateFlags,
    device_mask: u32,
};
pub const MemoryAllocateFlagsInfoKHR = MemoryAllocateFlagsInfo;
pub const BindBufferMemoryInfo = extern struct {
    s_type: StructureType = .bind_buffer_memory_info,
    p_next: ?*const c_void = null,
    buffer: Buffer,
    memory: DeviceMemory,
    memory_offset: DeviceSize,
};
pub const BindBufferMemoryInfoKHR = BindBufferMemoryInfo;
pub const BindBufferMemoryDeviceGroupInfo = extern struct {
    s_type: StructureType = .bind_buffer_memory_device_group_info,
    p_next: ?*const c_void = null,
    device_index_count: u32,
    p_device_indices: [*]const u32,
};
pub const BindBufferMemoryDeviceGroupInfoKHR = BindBufferMemoryDeviceGroupInfo;
pub const BindImageMemoryInfo = extern struct {
    s_type: StructureType = .bind_image_memory_info,
    p_next: ?*const c_void = null,
    image: Image,
    memory: DeviceMemory,
    memory_offset: DeviceSize,
};
pub const BindImageMemoryInfoKHR = BindImageMemoryInfo;
pub const BindImageMemoryDeviceGroupInfo = extern struct {
    s_type: StructureType = .bind_image_memory_device_group_info,
    p_next: ?*const c_void = null,
    device_index_count: u32,
    p_device_indices: [*]const u32,
    split_instance_bind_region_count: u32,
    p_split_instance_bind_regions: [*]const Rect2D,
};
pub const BindImageMemoryDeviceGroupInfoKHR = BindImageMemoryDeviceGroupInfo;
pub const DeviceGroupRenderPassBeginInfo = extern struct {
    s_type: StructureType = .device_group_render_pass_begin_info,
    p_next: ?*const c_void = null,
    device_mask: u32,
    device_render_area_count: u32,
    p_device_render_areas: [*]const Rect2D,
};
pub const DeviceGroupRenderPassBeginInfoKHR = DeviceGroupRenderPassBeginInfo;
pub const DeviceGroupCommandBufferBeginInfo = extern struct {
    s_type: StructureType = .device_group_command_buffer_begin_info,
    p_next: ?*const c_void = null,
    device_mask: u32,
};
pub const DeviceGroupCommandBufferBeginInfoKHR = DeviceGroupCommandBufferBeginInfo;
pub const DeviceGroupSubmitInfo = extern struct {
    s_type: StructureType = .device_group_submit_info,
    p_next: ?*const c_void = null,
    wait_semaphore_count: u32,
    p_wait_semaphore_device_indices: [*]const u32,
    command_buffer_count: u32,
    p_command_buffer_device_masks: [*]const u32,
    signal_semaphore_count: u32,
    p_signal_semaphore_device_indices: [*]const u32,
};
pub const DeviceGroupSubmitInfoKHR = DeviceGroupSubmitInfo;
pub const DeviceGroupBindSparseInfo = extern struct {
    s_type: StructureType = .device_group_bind_sparse_info,
    p_next: ?*const c_void = null,
    resource_device_index: u32,
    memory_device_index: u32,
};
pub const DeviceGroupBindSparseInfoKHR = DeviceGroupBindSparseInfo;
pub const DeviceGroupPresentCapabilitiesKHR = extern struct {
    s_type: StructureType = .device_group_present_capabilities_khr,
    p_next: ?*c_void = null,
    present_mask: [MAX_DEVICE_GROUP_SIZE]u32,
    modes: DeviceGroupPresentModeFlagsKHR,
};
pub const ImageSwapchainCreateInfoKHR = extern struct {
    s_type: StructureType = .image_swapchain_create_info_khr,
    p_next: ?*const c_void = null,
    swapchain: SwapchainKHR,
};
pub const BindImageMemorySwapchainInfoKHR = extern struct {
    s_type: StructureType = .bind_image_memory_swapchain_info_khr,
    p_next: ?*const c_void = null,
    swapchain: SwapchainKHR,
    image_index: u32,
};
pub const AcquireNextImageInfoKHR = extern struct {
    s_type: StructureType = .acquire_next_image_info_khr,
    p_next: ?*const c_void = null,
    swapchain: SwapchainKHR,
    timeout: u64,
    semaphore: Semaphore,
    fence: Fence,
    device_mask: u32,
};
pub const DeviceGroupPresentInfoKHR = extern struct {
    s_type: StructureType = .device_group_present_info_khr,
    p_next: ?*const c_void = null,
    swapchain_count: u32,
    p_device_masks: [*]const u32,
    mode: DeviceGroupPresentModeFlagsKHR,
};
pub const DeviceGroupDeviceCreateInfo = extern struct {
    s_type: StructureType = .device_group_device_create_info,
    p_next: ?*const c_void = null,
    physical_device_count: u32,
    p_physical_devices: [*]const PhysicalDevice,
};
pub const DeviceGroupDeviceCreateInfoKHR = DeviceGroupDeviceCreateInfo;
pub const DeviceGroupSwapchainCreateInfoKHR = extern struct {
    s_type: StructureType = .device_group_swapchain_create_info_khr,
    p_next: ?*const c_void = null,
    modes: DeviceGroupPresentModeFlagsKHR,
};
pub const DescriptorUpdateTemplateEntry = extern struct {
    dst_binding: u32,
    dst_array_element: u32,
    descriptor_count: u32,
    descriptor_type: DescriptorType,
    offset: usize,
    stride: usize,
};
pub const DescriptorUpdateTemplateEntryKHR = DescriptorUpdateTemplateEntry;
pub const DescriptorUpdateTemplateCreateInfo = extern struct {
    s_type: StructureType = .descriptor_update_template_create_info,
    p_next: ?*const c_void = null,
    flags: DescriptorUpdateTemplateCreateFlags,
    descriptor_update_entry_count: u32,
    p_descriptor_update_entries: [*]const DescriptorUpdateTemplateEntry,
    template_type: DescriptorUpdateTemplateType,
    descriptor_set_layout: DescriptorSetLayout,
    pipeline_bind_point: PipelineBindPoint,
    pipeline_layout: PipelineLayout,
    set: u32,
};
pub const DescriptorUpdateTemplateCreateInfoKHR = DescriptorUpdateTemplateCreateInfo;
pub const XYColorEXT = extern struct {
    x: f32,
    y: f32,
};
pub const PhysicalDevicePresentIdFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_present_id_features_khr,
    p_next: ?*c_void = null,
    present_id: Bool32 = FALSE,
};
pub const PresentIdKHR = extern struct {
    s_type: StructureType = .present_id_khr,
    p_next: ?*const c_void = null,
    swapchain_count: u32,
    p_present_ids: ?[*]const u64,
};
pub const PhysicalDevicePresentWaitFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_present_wait_features_khr,
    p_next: ?*c_void = null,
    present_wait: Bool32 = FALSE,
};
pub const HdrMetadataEXT = extern struct {
    s_type: StructureType = .hdr_metadata_ext,
    p_next: ?*const c_void = null,
    display_primary_red: XYColorEXT,
    display_primary_green: XYColorEXT,
    display_primary_blue: XYColorEXT,
    white_point: XYColorEXT,
    max_luminance: f32,
    min_luminance: f32,
    max_content_light_level: f32,
    max_frame_average_light_level: f32,
};
pub const DisplayNativeHdrSurfaceCapabilitiesAMD = extern struct {
    s_type: StructureType = .display_native_hdr_surface_capabilities_amd,
    p_next: ?*c_void = null,
    local_dimming_support: Bool32,
};
pub const SwapchainDisplayNativeHdrCreateInfoAMD = extern struct {
    s_type: StructureType = .swapchain_display_native_hdr_create_info_amd,
    p_next: ?*const c_void = null,
    local_dimming_enable: Bool32,
};
pub const RefreshCycleDurationGOOGLE = extern struct {
    refresh_duration: u64,
};
pub const PastPresentationTimingGOOGLE = extern struct {
    present_id: u32,
    desired_present_time: u64,
    actual_present_time: u64,
    earliest_present_time: u64,
    present_margin: u64,
};
pub const PresentTimesInfoGOOGLE = extern struct {
    s_type: StructureType = .present_times_info_google,
    p_next: ?*const c_void = null,
    swapchain_count: u32,
    p_times: ?[*]const PresentTimeGOOGLE,
};
pub const PresentTimeGOOGLE = extern struct {
    present_id: u32,
    desired_present_time: u64,
};
pub const IOSSurfaceCreateInfoMVK = extern struct {
    s_type: StructureType = .ios_surface_create_info_mvk,
    p_next: ?*const c_void = null,
    flags: IOSSurfaceCreateFlagsMVK,
    p_view: *const c_void,
};
pub const MacOSSurfaceCreateInfoMVK = extern struct {
    s_type: StructureType = .macos_surface_create_info_mvk,
    p_next: ?*const c_void = null,
    flags: MacOSSurfaceCreateFlagsMVK,
    p_view: *const c_void,
};
pub const MetalSurfaceCreateInfoEXT = extern struct {
    s_type: StructureType = .metal_surface_create_info_ext,
    p_next: ?*const c_void = null,
    flags: MetalSurfaceCreateFlagsEXT,
    p_layer: *const CAMetalLayer,
};
pub const ViewportWScalingNV = extern struct {
    xcoeff: f32,
    ycoeff: f32,
};
pub const PipelineViewportWScalingStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_w_scaling_state_create_info_nv,
    p_next: ?*const c_void = null,
    viewport_w_scaling_enable: Bool32,
    viewport_count: u32,
    p_viewport_w_scalings: ?[*]const ViewportWScalingNV,
};
pub const ViewportSwizzleNV = extern struct {
    x: ViewportCoordinateSwizzleNV,
    y: ViewportCoordinateSwizzleNV,
    z: ViewportCoordinateSwizzleNV,
    w: ViewportCoordinateSwizzleNV,
};
pub const PipelineViewportSwizzleStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_swizzle_state_create_info_nv,
    p_next: ?*const c_void = null,
    flags: PipelineViewportSwizzleStateCreateFlagsNV,
    viewport_count: u32,
    p_viewport_swizzles: [*]const ViewportSwizzleNV,
};
pub const PhysicalDeviceDiscardRectanglePropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_discard_rectangle_properties_ext,
    p_next: ?*c_void = null,
    max_discard_rectangles: u32,
};
pub const PipelineDiscardRectangleStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_discard_rectangle_state_create_info_ext,
    p_next: ?*const c_void = null,
    flags: PipelineDiscardRectangleStateCreateFlagsEXT,
    discard_rectangle_mode: DiscardRectangleModeEXT,
    discard_rectangle_count: u32,
    p_discard_rectangles: [*]const Rect2D,
};
pub const PhysicalDeviceMultiviewPerViewAttributesPropertiesNVX = extern struct {
    s_type: StructureType = .physical_device_multiview_per_view_attributes_properties_nvx,
    p_next: ?*c_void = null,
    per_view_position_all_components: Bool32,
};
pub const InputAttachmentAspectReference = extern struct {
    subpass: u32,
    input_attachment_index: u32,
    aspect_mask: ImageAspectFlags,
};
pub const InputAttachmentAspectReferenceKHR = InputAttachmentAspectReference;
pub const RenderPassInputAttachmentAspectCreateInfo = extern struct {
    s_type: StructureType = .render_pass_input_attachment_aspect_create_info,
    p_next: ?*const c_void = null,
    aspect_reference_count: u32,
    p_aspect_references: [*]const InputAttachmentAspectReference,
};
pub const RenderPassInputAttachmentAspectCreateInfoKHR = RenderPassInputAttachmentAspectCreateInfo;
pub const PhysicalDeviceSurfaceInfo2KHR = extern struct {
    s_type: StructureType = .physical_device_surface_info_2_khr,
    p_next: ?*const c_void = null,
    surface: SurfaceKHR,
};
pub const SurfaceCapabilities2KHR = extern struct {
    s_type: StructureType = .surface_capabilities_2_khr,
    p_next: ?*c_void = null,
    surface_capabilities: SurfaceCapabilitiesKHR,
};
pub const SurfaceFormat2KHR = extern struct {
    s_type: StructureType = .surface_format_2_khr,
    p_next: ?*c_void = null,
    surface_format: SurfaceFormatKHR,
};
pub const DisplayProperties2KHR = extern struct {
    s_type: StructureType = .display_properties_2_khr,
    p_next: ?*c_void = null,
    display_properties: DisplayPropertiesKHR,
};
pub const DisplayPlaneProperties2KHR = extern struct {
    s_type: StructureType = .display_plane_properties_2_khr,
    p_next: ?*c_void = null,
    display_plane_properties: DisplayPlanePropertiesKHR,
};
pub const DisplayModeProperties2KHR = extern struct {
    s_type: StructureType = .display_mode_properties_2_khr,
    p_next: ?*c_void = null,
    display_mode_properties: DisplayModePropertiesKHR,
};
pub const DisplayPlaneInfo2KHR = extern struct {
    s_type: StructureType = .display_plane_info_2_khr,
    p_next: ?*const c_void = null,
    mode: DisplayModeKHR,
    plane_index: u32,
};
pub const DisplayPlaneCapabilities2KHR = extern struct {
    s_type: StructureType = .display_plane_capabilities_2_khr,
    p_next: ?*c_void = null,
    capabilities: DisplayPlaneCapabilitiesKHR,
};
pub const SharedPresentSurfaceCapabilitiesKHR = extern struct {
    s_type: StructureType = .shared_present_surface_capabilities_khr,
    p_next: ?*c_void = null,
    shared_present_supported_usage_flags: ImageUsageFlags,
};
pub const PhysicalDevice16BitStorageFeatures = extern struct {
    s_type: StructureType = .physical_device_16bit_storage_features,
    p_next: ?*c_void = null,
    storage_buffer_16_bit_access: Bool32 = FALSE,
    uniform_and_storage_buffer_16_bit_access: Bool32 = FALSE,
    storage_push_constant_16: Bool32 = FALSE,
    storage_input_output_16: Bool32 = FALSE,
};
pub const PhysicalDevice16BitStorageFeaturesKHR = PhysicalDevice16BitStorageFeatures;
pub const PhysicalDeviceSubgroupProperties = extern struct {
    s_type: StructureType = .physical_device_subgroup_properties,
    p_next: ?*c_void = null,
    subgroup_size: u32,
    supported_stages: ShaderStageFlags,
    supported_operations: SubgroupFeatureFlags,
    quad_operations_in_all_stages: Bool32,
};
pub const PhysicalDeviceShaderSubgroupExtendedTypesFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_subgroup_extended_types_features,
    p_next: ?*c_void = null,
    shader_subgroup_extended_types: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderSubgroupExtendedTypesFeaturesKHR = PhysicalDeviceShaderSubgroupExtendedTypesFeatures;
pub const BufferMemoryRequirementsInfo2 = extern struct {
    s_type: StructureType = .buffer_memory_requirements_info_2,
    p_next: ?*const c_void = null,
    buffer: Buffer,
};
pub const BufferMemoryRequirementsInfo2KHR = BufferMemoryRequirementsInfo2;
pub const DeviceBufferMemoryRequirementsKHR = extern struct {
    s_type: StructureType = .device_buffer_memory_requirements_khr,
    p_next: ?*const c_void = null,
    p_create_info: *const BufferCreateInfo,
};
pub const ImageMemoryRequirementsInfo2 = extern struct {
    s_type: StructureType = .image_memory_requirements_info_2,
    p_next: ?*const c_void = null,
    image: Image,
};
pub const ImageMemoryRequirementsInfo2KHR = ImageMemoryRequirementsInfo2;
pub const ImageSparseMemoryRequirementsInfo2 = extern struct {
    s_type: StructureType = .image_sparse_memory_requirements_info_2,
    p_next: ?*const c_void = null,
    image: Image,
};
pub const ImageSparseMemoryRequirementsInfo2KHR = ImageSparseMemoryRequirementsInfo2;
pub const DeviceImageMemoryRequirementsKHR = extern struct {
    s_type: StructureType = .device_image_memory_requirements_khr,
    p_next: ?*const c_void = null,
    p_create_info: *const ImageCreateInfo,
    plane_aspect: ImageAspectFlags,
};
pub const MemoryRequirements2 = extern struct {
    s_type: StructureType = .memory_requirements_2,
    p_next: ?*c_void = null,
    memory_requirements: MemoryRequirements,
};
pub const MemoryRequirements2KHR = MemoryRequirements2;
pub const SparseImageMemoryRequirements2 = extern struct {
    s_type: StructureType = .sparse_image_memory_requirements_2,
    p_next: ?*c_void = null,
    memory_requirements: SparseImageMemoryRequirements,
};
pub const SparseImageMemoryRequirements2KHR = SparseImageMemoryRequirements2;
pub const PhysicalDevicePointClippingProperties = extern struct {
    s_type: StructureType = .physical_device_point_clipping_properties,
    p_next: ?*c_void = null,
    point_clipping_behavior: PointClippingBehavior,
};
pub const PhysicalDevicePointClippingPropertiesKHR = PhysicalDevicePointClippingProperties;
pub const MemoryDedicatedRequirements = extern struct {
    s_type: StructureType = .memory_dedicated_requirements,
    p_next: ?*c_void = null,
    prefers_dedicated_allocation: Bool32,
    requires_dedicated_allocation: Bool32,
};
pub const MemoryDedicatedRequirementsKHR = MemoryDedicatedRequirements;
pub const MemoryDedicatedAllocateInfo = extern struct {
    s_type: StructureType = .memory_dedicated_allocate_info,
    p_next: ?*const c_void = null,
    image: Image,
    buffer: Buffer,
};
pub const MemoryDedicatedAllocateInfoKHR = MemoryDedicatedAllocateInfo;
pub const ImageViewUsageCreateInfo = extern struct {
    s_type: StructureType = .image_view_usage_create_info,
    p_next: ?*const c_void = null,
    usage: ImageUsageFlags,
};
pub const ImageViewUsageCreateInfoKHR = ImageViewUsageCreateInfo;
pub const PipelineTessellationDomainOriginStateCreateInfo = extern struct {
    s_type: StructureType = .pipeline_tessellation_domain_origin_state_create_info,
    p_next: ?*const c_void = null,
    domain_origin: TessellationDomainOrigin,
};
pub const PipelineTessellationDomainOriginStateCreateInfoKHR = PipelineTessellationDomainOriginStateCreateInfo;
pub const SamplerYcbcrConversionInfo = extern struct {
    s_type: StructureType = .sampler_ycbcr_conversion_info,
    p_next: ?*const c_void = null,
    conversion: SamplerYcbcrConversion,
};
pub const SamplerYcbcrConversionInfoKHR = SamplerYcbcrConversionInfo;
pub const SamplerYcbcrConversionCreateInfo = extern struct {
    s_type: StructureType = .sampler_ycbcr_conversion_create_info,
    p_next: ?*const c_void = null,
    format: Format,
    ycbcr_model: SamplerYcbcrModelConversion,
    ycbcr_range: SamplerYcbcrRange,
    components: ComponentMapping,
    x_chroma_offset: ChromaLocation,
    y_chroma_offset: ChromaLocation,
    chroma_filter: Filter,
    force_explicit_reconstruction: Bool32,
};
pub const SamplerYcbcrConversionCreateInfoKHR = SamplerYcbcrConversionCreateInfo;
pub const BindImagePlaneMemoryInfo = extern struct {
    s_type: StructureType = .bind_image_plane_memory_info,
    p_next: ?*const c_void = null,
    plane_aspect: ImageAspectFlags,
};
pub const BindImagePlaneMemoryInfoKHR = BindImagePlaneMemoryInfo;
pub const ImagePlaneMemoryRequirementsInfo = extern struct {
    s_type: StructureType = .image_plane_memory_requirements_info,
    p_next: ?*const c_void = null,
    plane_aspect: ImageAspectFlags,
};
pub const ImagePlaneMemoryRequirementsInfoKHR = ImagePlaneMemoryRequirementsInfo;
pub const PhysicalDeviceSamplerYcbcrConversionFeatures = extern struct {
    s_type: StructureType = .physical_device_sampler_ycbcr_conversion_features,
    p_next: ?*c_void = null,
    sampler_ycbcr_conversion: Bool32 = FALSE,
};
pub const PhysicalDeviceSamplerYcbcrConversionFeaturesKHR = PhysicalDeviceSamplerYcbcrConversionFeatures;
pub const SamplerYcbcrConversionImageFormatProperties = extern struct {
    s_type: StructureType = .sampler_ycbcr_conversion_image_format_properties,
    p_next: ?*c_void = null,
    combined_image_sampler_descriptor_count: u32,
};
pub const SamplerYcbcrConversionImageFormatPropertiesKHR = SamplerYcbcrConversionImageFormatProperties;
pub const TextureLODGatherFormatPropertiesAMD = extern struct {
    s_type: StructureType = .texture_lod_gather_format_properties_amd,
    p_next: ?*c_void = null,
    supports_texture_gather_lod_bias_amd: Bool32,
};
pub const ConditionalRenderingBeginInfoEXT = extern struct {
    s_type: StructureType = .conditional_rendering_begin_info_ext,
    p_next: ?*const c_void = null,
    buffer: Buffer,
    offset: DeviceSize,
    flags: ConditionalRenderingFlagsEXT,
};
pub const ProtectedSubmitInfo = extern struct {
    s_type: StructureType = .protected_submit_info,
    p_next: ?*const c_void = null,
    protected_submit: Bool32,
};
pub const PhysicalDeviceProtectedMemoryFeatures = extern struct {
    s_type: StructureType = .physical_device_protected_memory_features,
    p_next: ?*c_void = null,
    protected_memory: Bool32 = FALSE,
};
pub const PhysicalDeviceProtectedMemoryProperties = extern struct {
    s_type: StructureType = .physical_device_protected_memory_properties,
    p_next: ?*c_void = null,
    protected_no_fault: Bool32,
};
pub const DeviceQueueInfo2 = extern struct {
    s_type: StructureType = .device_queue_info_2,
    p_next: ?*const c_void = null,
    flags: DeviceQueueCreateFlags,
    queue_family_index: u32,
    queue_index: u32,
};
pub const PipelineCoverageToColorStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_coverage_to_color_state_create_info_nv,
    p_next: ?*const c_void = null,
    flags: PipelineCoverageToColorStateCreateFlagsNV,
    coverage_to_color_enable: Bool32,
    coverage_to_color_location: u32,
};
pub const PhysicalDeviceSamplerFilterMinmaxProperties = extern struct {
    s_type: StructureType = .physical_device_sampler_filter_minmax_properties,
    p_next: ?*c_void = null,
    filter_minmax_single_component_formats: Bool32,
    filter_minmax_image_component_mapping: Bool32,
};
pub const PhysicalDeviceSamplerFilterMinmaxPropertiesEXT = PhysicalDeviceSamplerFilterMinmaxProperties;
pub const SampleLocationEXT = extern struct {
    x: f32,
    y: f32,
};
pub const SampleLocationsInfoEXT = extern struct {
    s_type: StructureType = .sample_locations_info_ext,
    p_next: ?*const c_void = null,
    sample_locations_per_pixel: SampleCountFlags,
    sample_location_grid_size: Extent2D,
    sample_locations_count: u32,
    p_sample_locations: [*]const SampleLocationEXT,
};
pub const AttachmentSampleLocationsEXT = extern struct {
    attachment_index: u32,
    sample_locations_info: SampleLocationsInfoEXT,
};
pub const SubpassSampleLocationsEXT = extern struct {
    subpass_index: u32,
    sample_locations_info: SampleLocationsInfoEXT,
};
pub const RenderPassSampleLocationsBeginInfoEXT = extern struct {
    s_type: StructureType = .render_pass_sample_locations_begin_info_ext,
    p_next: ?*const c_void = null,
    attachment_initial_sample_locations_count: u32,
    p_attachment_initial_sample_locations: [*]const AttachmentSampleLocationsEXT,
    post_subpass_sample_locations_count: u32,
    p_post_subpass_sample_locations: [*]const SubpassSampleLocationsEXT,
};
pub const PipelineSampleLocationsStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_sample_locations_state_create_info_ext,
    p_next: ?*const c_void = null,
    sample_locations_enable: Bool32,
    sample_locations_info: SampleLocationsInfoEXT,
};
pub const PhysicalDeviceSampleLocationsPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_sample_locations_properties_ext,
    p_next: ?*c_void = null,
    sample_location_sample_counts: SampleCountFlags,
    max_sample_location_grid_size: Extent2D,
    sample_location_coordinate_range: [2]f32,
    sample_location_sub_pixel_bits: u32,
    variable_sample_locations: Bool32,
};
pub const MultisamplePropertiesEXT = extern struct {
    s_type: StructureType = .multisample_properties_ext,
    p_next: ?*c_void = null,
    max_sample_location_grid_size: Extent2D,
};
pub const SamplerReductionModeCreateInfo = extern struct {
    s_type: StructureType = .sampler_reduction_mode_create_info,
    p_next: ?*const c_void = null,
    reduction_mode: SamplerReductionMode,
};
pub const SamplerReductionModeCreateInfoEXT = SamplerReductionModeCreateInfo;
pub const PhysicalDeviceBlendOperationAdvancedFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_blend_operation_advanced_features_ext,
    p_next: ?*c_void = null,
    advanced_blend_coherent_operations: Bool32 = FALSE,
};
pub const PhysicalDeviceMultiDrawFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_multi_draw_features_ext,
    p_next: ?*c_void = null,
    multi_draw: Bool32 = FALSE,
};
pub const PhysicalDeviceBlendOperationAdvancedPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_blend_operation_advanced_properties_ext,
    p_next: ?*c_void = null,
    advanced_blend_max_color_attachments: u32,
    advanced_blend_independent_blend: Bool32,
    advanced_blend_non_premultiplied_src_color: Bool32,
    advanced_blend_non_premultiplied_dst_color: Bool32,
    advanced_blend_correlated_overlap: Bool32,
    advanced_blend_all_operations: Bool32,
};
pub const PipelineColorBlendAdvancedStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_color_blend_advanced_state_create_info_ext,
    p_next: ?*const c_void = null,
    src_premultiplied: Bool32,
    dst_premultiplied: Bool32,
    blend_overlap: BlendOverlapEXT,
};
pub const PhysicalDeviceInlineUniformBlockFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_inline_uniform_block_features_ext,
    p_next: ?*c_void = null,
    inline_uniform_block: Bool32 = FALSE,
    descriptor_binding_inline_uniform_block_update_after_bind: Bool32 = FALSE,
};
pub const PhysicalDeviceInlineUniformBlockPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_inline_uniform_block_properties_ext,
    p_next: ?*c_void = null,
    max_inline_uniform_block_size: u32,
    max_per_stage_descriptor_inline_uniform_blocks: u32,
    max_per_stage_descriptor_update_after_bind_inline_uniform_blocks: u32,
    max_descriptor_set_inline_uniform_blocks: u32,
    max_descriptor_set_update_after_bind_inline_uniform_blocks: u32,
};
pub const WriteDescriptorSetInlineUniformBlockEXT = extern struct {
    s_type: StructureType = .write_descriptor_set_inline_uniform_block_ext,
    p_next: ?*const c_void = null,
    data_size: u32,
    p_data: *const c_void,
};
pub const DescriptorPoolInlineUniformBlockCreateInfoEXT = extern struct {
    s_type: StructureType = .descriptor_pool_inline_uniform_block_create_info_ext,
    p_next: ?*const c_void = null,
    max_inline_uniform_block_bindings: u32,
};
pub const PipelineCoverageModulationStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_coverage_modulation_state_create_info_nv,
    p_next: ?*const c_void = null,
    flags: PipelineCoverageModulationStateCreateFlagsNV,
    coverage_modulation_mode: CoverageModulationModeNV,
    coverage_modulation_table_enable: Bool32,
    coverage_modulation_table_count: u32,
    p_coverage_modulation_table: ?[*]const f32,
};
pub const ImageFormatListCreateInfo = extern struct {
    s_type: StructureType = .image_format_list_create_info,
    p_next: ?*const c_void = null,
    view_format_count: u32,
    p_view_formats: [*]const Format,
};
pub const ImageFormatListCreateInfoKHR = ImageFormatListCreateInfo;
pub const ValidationCacheCreateInfoEXT = extern struct {
    s_type: StructureType = .validation_cache_create_info_ext,
    p_next: ?*const c_void = null,
    flags: ValidationCacheCreateFlagsEXT,
    initial_data_size: usize,
    p_initial_data: *const c_void,
};
pub const ShaderModuleValidationCacheCreateInfoEXT = extern struct {
    s_type: StructureType = .shader_module_validation_cache_create_info_ext,
    p_next: ?*const c_void = null,
    validation_cache: ValidationCacheEXT,
};
pub const PhysicalDeviceMaintenance3Properties = extern struct {
    s_type: StructureType = .physical_device_maintenance_3_properties,
    p_next: ?*c_void = null,
    max_per_set_descriptors: u32,
    max_memory_allocation_size: DeviceSize,
};
pub const PhysicalDeviceMaintenance3PropertiesKHR = PhysicalDeviceMaintenance3Properties;
pub const PhysicalDeviceMaintenance4FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_maintenance_4_features_khr,
    p_next: ?*c_void = null,
    maintenance_4: Bool32 = FALSE,
};
pub const PhysicalDeviceMaintenance4PropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_maintenance_4_properties_khr,
    p_next: ?*c_void = null,
    max_buffer_size: DeviceSize,
};
pub const DescriptorSetLayoutSupport = extern struct {
    s_type: StructureType = .descriptor_set_layout_support,
    p_next: ?*c_void = null,
    supported: Bool32,
};
pub const DescriptorSetLayoutSupportKHR = DescriptorSetLayoutSupport;
pub const PhysicalDeviceShaderDrawParametersFeatures = extern struct {
    s_type: StructureType = .physical_device_shader_draw_parameters_features,
    p_next: ?*c_void = null,
    shader_draw_parameters: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderDrawParameterFeatures = PhysicalDeviceShaderDrawParametersFeatures;
pub const PhysicalDeviceShaderFloat16Int8Features = extern struct {
    s_type: StructureType = .physical_device_shader_float16_int8_features,
    p_next: ?*c_void = null,
    shader_float_16: Bool32 = FALSE,
    shader_int_8: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderFloat16Int8FeaturesKHR = PhysicalDeviceShaderFloat16Int8Features;
pub const PhysicalDeviceFloat16Int8FeaturesKHR = PhysicalDeviceShaderFloat16Int8Features;
pub const PhysicalDeviceFloatControlsProperties = extern struct {
    s_type: StructureType = .physical_device_float_controls_properties,
    p_next: ?*c_void = null,
    denorm_behavior_independence: ShaderFloatControlsIndependence,
    rounding_mode_independence: ShaderFloatControlsIndependence,
    shader_signed_zero_inf_nan_preserve_float_16: Bool32,
    shader_signed_zero_inf_nan_preserve_float_32: Bool32,
    shader_signed_zero_inf_nan_preserve_float_64: Bool32,
    shader_denorm_preserve_float_16: Bool32,
    shader_denorm_preserve_float_32: Bool32,
    shader_denorm_preserve_float_64: Bool32,
    shader_denorm_flush_to_zero_float_16: Bool32,
    shader_denorm_flush_to_zero_float_32: Bool32,
    shader_denorm_flush_to_zero_float_64: Bool32,
    shader_rounding_mode_rte_float_16: Bool32,
    shader_rounding_mode_rte_float_32: Bool32,
    shader_rounding_mode_rte_float_64: Bool32,
    shader_rounding_mode_rtz_float_16: Bool32,
    shader_rounding_mode_rtz_float_32: Bool32,
    shader_rounding_mode_rtz_float_64: Bool32,
};
pub const PhysicalDeviceFloatControlsPropertiesKHR = PhysicalDeviceFloatControlsProperties;
pub const PhysicalDeviceHostQueryResetFeatures = extern struct {
    s_type: StructureType = .physical_device_host_query_reset_features,
    p_next: ?*c_void = null,
    host_query_reset: Bool32 = FALSE,
};
pub const PhysicalDeviceHostQueryResetFeaturesEXT = PhysicalDeviceHostQueryResetFeatures;
pub const NativeBufferUsage2ANDROID = extern struct {
    consumer: u64,
    producer: u64,
};
pub const NativeBufferANDROID = extern struct {
    s_type: StructureType = .native_buffer_android,
    p_next: ?*const c_void = null,
    handle: *const c_void,
    stride: c_int,
    format: c_int,
    usage: c_int,
    usage_2: NativeBufferUsage2ANDROID,
};
pub const SwapchainImageCreateInfoANDROID = extern struct {
    s_type: StructureType = .swapchain_image_create_info_android,
    p_next: ?*const c_void = null,
    usage: SwapchainImageUsageFlagsANDROID,
};
pub const PhysicalDevicePresentationPropertiesANDROID = extern struct {
    s_type: StructureType = .physical_device_presentation_properties_android,
    p_next: ?*const c_void = null,
    shared_image: Bool32,
};
pub const ShaderResourceUsageAMD = extern struct {
    num_used_vgprs: u32,
    num_used_sgprs: u32,
    lds_size_per_local_work_group: u32,
    lds_usage_size_in_bytes: usize,
    scratch_mem_usage_in_bytes: usize,
};
pub const ShaderStatisticsInfoAMD = extern struct {
    shader_stage_mask: ShaderStageFlags,
    resource_usage: ShaderResourceUsageAMD,
    num_physical_vgprs: u32,
    num_physical_sgprs: u32,
    num_available_vgprs: u32,
    num_available_sgprs: u32,
    compute_work_group_size: [3]u32,
};
pub const DeviceQueueGlobalPriorityCreateInfoEXT = extern struct {
    s_type: StructureType = .device_queue_global_priority_create_info_ext,
    p_next: ?*const c_void = null,
    global_priority: QueueGlobalPriorityEXT,
};
pub const PhysicalDeviceGlobalPriorityQueryFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_global_priority_query_features_ext,
    p_next: ?*c_void = null,
    global_priority_query: Bool32 = FALSE,
};
pub const QueueFamilyGlobalPriorityPropertiesEXT = extern struct {
    s_type: StructureType = .queue_family_global_priority_properties_ext,
    p_next: ?*c_void = null,
    priority_count: u32,
    priorities: [MAX_GLOBAL_PRIORITY_SIZE_EXT]QueueGlobalPriorityEXT,
};
pub const DebugUtilsObjectNameInfoEXT = extern struct {
    s_type: StructureType = .debug_utils_object_name_info_ext,
    p_next: ?*const c_void = null,
    object_type: ObjectType,
    object_handle: u64,
    p_object_name: ?[*:0]const u8,
};
pub const DebugUtilsObjectTagInfoEXT = extern struct {
    s_type: StructureType = .debug_utils_object_tag_info_ext,
    p_next: ?*const c_void = null,
    object_type: ObjectType,
    object_handle: u64,
    tag_name: u64,
    tag_size: usize,
    p_tag: *const c_void,
};
pub const DebugUtilsLabelEXT = extern struct {
    s_type: StructureType = .debug_utils_label_ext,
    p_next: ?*const c_void = null,
    p_label_name: [*:0]const u8,
    color: [4]f32,
};
pub const DebugUtilsMessengerCreateInfoEXT = extern struct {
    s_type: StructureType = .debug_utils_messenger_create_info_ext,
    p_next: ?*const c_void = null,
    flags: DebugUtilsMessengerCreateFlagsEXT,
    message_severity: DebugUtilsMessageSeverityFlagsEXT,
    message_type: DebugUtilsMessageTypeFlagsEXT,
    pfn_user_callback: PfnDebugUtilsMessengerCallbackEXT,
    p_user_data: ?*c_void,
};
pub const DebugUtilsMessengerCallbackDataEXT = extern struct {
    s_type: StructureType = .debug_utils_messenger_callback_data_ext,
    p_next: ?*const c_void = null,
    flags: DebugUtilsMessengerCallbackDataFlagsEXT,
    p_message_id_name: ?[*:0]const u8,
    message_id_number: i32,
    p_message: [*:0]const u8,
    queue_label_count: u32,
    p_queue_labels: [*]const DebugUtilsLabelEXT,
    cmd_buf_label_count: u32,
    p_cmd_buf_labels: [*]const DebugUtilsLabelEXT,
    object_count: u32,
    p_objects: [*]const DebugUtilsObjectNameInfoEXT,
};
pub const PhysicalDeviceDeviceMemoryReportFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_device_memory_report_features_ext,
    p_next: ?*c_void = null,
    device_memory_report: Bool32 = FALSE,
};
pub const DeviceDeviceMemoryReportCreateInfoEXT = extern struct {
    s_type: StructureType = .device_device_memory_report_create_info_ext,
    p_next: ?*const c_void = null,
    flags: DeviceMemoryReportFlagsEXT,
    pfn_user_callback: PfnDeviceMemoryReportCallbackEXT,
    p_user_data: *c_void,
};
pub const DeviceMemoryReportCallbackDataEXT = extern struct {
    s_type: StructureType = .device_memory_report_callback_data_ext,
    p_next: ?*c_void = null,
    flags: DeviceMemoryReportFlagsEXT,
    @"type": DeviceMemoryReportEventTypeEXT,
    memory_object_id: u64,
    size: DeviceSize,
    object_type: ObjectType,
    object_handle: u64,
    heap_index: u32,
};
pub const ImportMemoryHostPointerInfoEXT = extern struct {
    s_type: StructureType = .import_memory_host_pointer_info_ext,
    p_next: ?*const c_void = null,
    handle_type: ExternalMemoryHandleTypeFlags,
    p_host_pointer: *c_void,
};
pub const MemoryHostPointerPropertiesEXT = extern struct {
    s_type: StructureType = .memory_host_pointer_properties_ext,
    p_next: ?*c_void = null,
    memory_type_bits: u32,
};
pub const PhysicalDeviceExternalMemoryHostPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_external_memory_host_properties_ext,
    p_next: ?*c_void = null,
    min_imported_host_pointer_alignment: DeviceSize,
};
pub const PhysicalDeviceConservativeRasterizationPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_conservative_rasterization_properties_ext,
    p_next: ?*c_void = null,
    primitive_overestimation_size: f32,
    max_extra_primitive_overestimation_size: f32,
    extra_primitive_overestimation_size_granularity: f32,
    primitive_underestimation: Bool32,
    conservative_point_and_line_rasterization: Bool32,
    degenerate_triangles_rasterized: Bool32,
    degenerate_lines_rasterized: Bool32,
    fully_covered_fragment_shader_input_variable: Bool32,
    conservative_rasterization_post_depth_coverage: Bool32,
};
pub const CalibratedTimestampInfoEXT = extern struct {
    s_type: StructureType = .calibrated_timestamp_info_ext,
    p_next: ?*const c_void = null,
    time_domain: TimeDomainEXT,
};
pub const PhysicalDeviceShaderCorePropertiesAMD = extern struct {
    s_type: StructureType = .physical_device_shader_core_properties_amd,
    p_next: ?*c_void = null,
    shader_engine_count: u32,
    shader_arrays_per_engine_count: u32,
    compute_units_per_shader_array: u32,
    simd_per_compute_unit: u32,
    wavefronts_per_simd: u32,
    wavefront_size: u32,
    sgprs_per_simd: u32,
    min_sgpr_allocation: u32,
    max_sgpr_allocation: u32,
    sgpr_allocation_granularity: u32,
    vgprs_per_simd: u32,
    min_vgpr_allocation: u32,
    max_vgpr_allocation: u32,
    vgpr_allocation_granularity: u32,
};
pub const PhysicalDeviceShaderCoreProperties2AMD = extern struct {
    s_type: StructureType = .physical_device_shader_core_properties_2_amd,
    p_next: ?*c_void = null,
    shader_core_features: ShaderCorePropertiesFlagsAMD,
    active_compute_unit_count: u32,
};
pub const PipelineRasterizationConservativeStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_conservative_state_create_info_ext,
    p_next: ?*const c_void = null,
    flags: PipelineRasterizationConservativeStateCreateFlagsEXT,
    conservative_rasterization_mode: ConservativeRasterizationModeEXT,
    extra_primitive_overestimation_size: f32,
};
pub const PhysicalDeviceDescriptorIndexingFeatures = extern struct {
    s_type: StructureType = .physical_device_descriptor_indexing_features,
    p_next: ?*c_void = null,
    shader_input_attachment_array_dynamic_indexing: Bool32 = FALSE,
    shader_uniform_texel_buffer_array_dynamic_indexing: Bool32 = FALSE,
    shader_storage_texel_buffer_array_dynamic_indexing: Bool32 = FALSE,
    shader_uniform_buffer_array_non_uniform_indexing: Bool32 = FALSE,
    shader_sampled_image_array_non_uniform_indexing: Bool32 = FALSE,
    shader_storage_buffer_array_non_uniform_indexing: Bool32 = FALSE,
    shader_storage_image_array_non_uniform_indexing: Bool32 = FALSE,
    shader_input_attachment_array_non_uniform_indexing: Bool32 = FALSE,
    shader_uniform_texel_buffer_array_non_uniform_indexing: Bool32 = FALSE,
    shader_storage_texel_buffer_array_non_uniform_indexing: Bool32 = FALSE,
    descriptor_binding_uniform_buffer_update_after_bind: Bool32 = FALSE,
    descriptor_binding_sampled_image_update_after_bind: Bool32 = FALSE,
    descriptor_binding_storage_image_update_after_bind: Bool32 = FALSE,
    descriptor_binding_storage_buffer_update_after_bind: Bool32 = FALSE,
    descriptor_binding_uniform_texel_buffer_update_after_bind: Bool32 = FALSE,
    descriptor_binding_storage_texel_buffer_update_after_bind: Bool32 = FALSE,
    descriptor_binding_update_unused_while_pending: Bool32 = FALSE,
    descriptor_binding_partially_bound: Bool32 = FALSE,
    descriptor_binding_variable_descriptor_count: Bool32 = FALSE,
    runtime_descriptor_array: Bool32 = FALSE,
};
pub const PhysicalDeviceDescriptorIndexingFeaturesEXT = PhysicalDeviceDescriptorIndexingFeatures;
pub const PhysicalDeviceDescriptorIndexingProperties = extern struct {
    s_type: StructureType = .physical_device_descriptor_indexing_properties,
    p_next: ?*c_void = null,
    max_update_after_bind_descriptors_in_all_pools: u32,
    shader_uniform_buffer_array_non_uniform_indexing_native: Bool32,
    shader_sampled_image_array_non_uniform_indexing_native: Bool32,
    shader_storage_buffer_array_non_uniform_indexing_native: Bool32,
    shader_storage_image_array_non_uniform_indexing_native: Bool32,
    shader_input_attachment_array_non_uniform_indexing_native: Bool32,
    robust_buffer_access_update_after_bind: Bool32,
    quad_divergent_implicit_lod: Bool32,
    max_per_stage_descriptor_update_after_bind_samplers: u32,
    max_per_stage_descriptor_update_after_bind_uniform_buffers: u32,
    max_per_stage_descriptor_update_after_bind_storage_buffers: u32,
    max_per_stage_descriptor_update_after_bind_sampled_images: u32,
    max_per_stage_descriptor_update_after_bind_storage_images: u32,
    max_per_stage_descriptor_update_after_bind_input_attachments: u32,
    max_per_stage_update_after_bind_resources: u32,
    max_descriptor_set_update_after_bind_samplers: u32,
    max_descriptor_set_update_after_bind_uniform_buffers: u32,
    max_descriptor_set_update_after_bind_uniform_buffers_dynamic: u32,
    max_descriptor_set_update_after_bind_storage_buffers: u32,
    max_descriptor_set_update_after_bind_storage_buffers_dynamic: u32,
    max_descriptor_set_update_after_bind_sampled_images: u32,
    max_descriptor_set_update_after_bind_storage_images: u32,
    max_descriptor_set_update_after_bind_input_attachments: u32,
};
pub const PhysicalDeviceDescriptorIndexingPropertiesEXT = PhysicalDeviceDescriptorIndexingProperties;
pub const DescriptorSetLayoutBindingFlagsCreateInfo = extern struct {
    s_type: StructureType = .descriptor_set_layout_binding_flags_create_info,
    p_next: ?*const c_void = null,
    binding_count: u32,
    p_binding_flags: [*]const DescriptorBindingFlags,
};
pub const DescriptorSetLayoutBindingFlagsCreateInfoEXT = DescriptorSetLayoutBindingFlagsCreateInfo;
pub const DescriptorSetVariableDescriptorCountAllocateInfo = extern struct {
    s_type: StructureType = .descriptor_set_variable_descriptor_count_allocate_info,
    p_next: ?*const c_void = null,
    descriptor_set_count: u32,
    p_descriptor_counts: [*]const u32,
};
pub const DescriptorSetVariableDescriptorCountAllocateInfoEXT = DescriptorSetVariableDescriptorCountAllocateInfo;
pub const DescriptorSetVariableDescriptorCountLayoutSupport = extern struct {
    s_type: StructureType = .descriptor_set_variable_descriptor_count_layout_support,
    p_next: ?*c_void = null,
    max_variable_descriptor_count: u32,
};
pub const DescriptorSetVariableDescriptorCountLayoutSupportEXT = DescriptorSetVariableDescriptorCountLayoutSupport;
pub const AttachmentDescription2 = extern struct {
    s_type: StructureType = .attachment_description_2,
    p_next: ?*const c_void = null,
    flags: AttachmentDescriptionFlags,
    format: Format,
    samples: SampleCountFlags,
    load_op: AttachmentLoadOp,
    store_op: AttachmentStoreOp,
    stencil_load_op: AttachmentLoadOp,
    stencil_store_op: AttachmentStoreOp,
    initial_layout: ImageLayout,
    final_layout: ImageLayout,
};
pub const AttachmentDescription2KHR = AttachmentDescription2;
pub const AttachmentReference2 = extern struct {
    s_type: StructureType = .attachment_reference_2,
    p_next: ?*const c_void = null,
    attachment: u32,
    layout: ImageLayout,
    aspect_mask: ImageAspectFlags,
};
pub const AttachmentReference2KHR = AttachmentReference2;
pub const SubpassDescription2 = extern struct {
    s_type: StructureType = .subpass_description_2,
    p_next: ?*const c_void = null,
    flags: SubpassDescriptionFlags,
    pipeline_bind_point: PipelineBindPoint,
    view_mask: u32,
    input_attachment_count: u32,
    p_input_attachments: [*]const AttachmentReference2,
    color_attachment_count: u32,
    p_color_attachments: [*]const AttachmentReference2,
    p_resolve_attachments: ?[*]const AttachmentReference2,
    p_depth_stencil_attachment: ?*const AttachmentReference2,
    preserve_attachment_count: u32,
    p_preserve_attachments: [*]const u32,
};
pub const SubpassDescription2KHR = SubpassDescription2;
pub const SubpassDependency2 = extern struct {
    s_type: StructureType = .subpass_dependency_2,
    p_next: ?*const c_void = null,
    src_subpass: u32,
    dst_subpass: u32,
    src_stage_mask: PipelineStageFlags,
    dst_stage_mask: PipelineStageFlags,
    src_access_mask: AccessFlags,
    dst_access_mask: AccessFlags,
    dependency_flags: DependencyFlags,
    view_offset: i32,
};
pub const SubpassDependency2KHR = SubpassDependency2;
pub const RenderPassCreateInfo2 = extern struct {
    s_type: StructureType = .render_pass_create_info_2,
    p_next: ?*const c_void = null,
    flags: RenderPassCreateFlags,
    attachment_count: u32,
    p_attachments: [*]const AttachmentDescription2,
    subpass_count: u32,
    p_subpasses: [*]const SubpassDescription2,
    dependency_count: u32,
    p_dependencies: [*]const SubpassDependency2,
    correlated_view_mask_count: u32,
    p_correlated_view_masks: [*]const u32,
};
pub const RenderPassCreateInfo2KHR = RenderPassCreateInfo2;
pub const SubpassBeginInfo = extern struct {
    s_type: StructureType = .subpass_begin_info,
    p_next: ?*const c_void = null,
    contents: SubpassContents,
};
pub const SubpassBeginInfoKHR = SubpassBeginInfo;
pub const SubpassEndInfo = extern struct {
    s_type: StructureType = .subpass_end_info,
    p_next: ?*const c_void = null,
};
pub const SubpassEndInfoKHR = SubpassEndInfo;
pub const PhysicalDeviceTimelineSemaphoreFeatures = extern struct {
    s_type: StructureType = .physical_device_timeline_semaphore_features,
    p_next: ?*c_void = null,
    timeline_semaphore: Bool32 = FALSE,
};
pub const PhysicalDeviceTimelineSemaphoreFeaturesKHR = PhysicalDeviceTimelineSemaphoreFeatures;
pub const PhysicalDeviceTimelineSemaphoreProperties = extern struct {
    s_type: StructureType = .physical_device_timeline_semaphore_properties,
    p_next: ?*c_void = null,
    max_timeline_semaphore_value_difference: u64,
};
pub const PhysicalDeviceTimelineSemaphorePropertiesKHR = PhysicalDeviceTimelineSemaphoreProperties;
pub const SemaphoreTypeCreateInfo = extern struct {
    s_type: StructureType = .semaphore_type_create_info,
    p_next: ?*const c_void = null,
    semaphore_type: SemaphoreType,
    initial_value: u64,
};
pub const SemaphoreTypeCreateInfoKHR = SemaphoreTypeCreateInfo;
pub const TimelineSemaphoreSubmitInfo = extern struct {
    s_type: StructureType = .timeline_semaphore_submit_info,
    p_next: ?*const c_void = null,
    wait_semaphore_value_count: u32,
    p_wait_semaphore_values: ?[*]const u64,
    signal_semaphore_value_count: u32,
    p_signal_semaphore_values: ?[*]const u64,
};
pub const TimelineSemaphoreSubmitInfoKHR = TimelineSemaphoreSubmitInfo;
pub const SemaphoreWaitInfo = extern struct {
    s_type: StructureType = .semaphore_wait_info,
    p_next: ?*const c_void = null,
    flags: SemaphoreWaitFlags,
    semaphore_count: u32,
    p_semaphores: [*]const Semaphore,
    p_values: [*]const u64,
};
pub const SemaphoreWaitInfoKHR = SemaphoreWaitInfo;
pub const SemaphoreSignalInfo = extern struct {
    s_type: StructureType = .semaphore_signal_info,
    p_next: ?*const c_void = null,
    semaphore: Semaphore,
    value: u64,
};
pub const SemaphoreSignalInfoKHR = SemaphoreSignalInfo;
pub const VertexInputBindingDivisorDescriptionEXT = extern struct {
    binding: u32,
    divisor: u32,
};
pub const PipelineVertexInputDivisorStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_vertex_input_divisor_state_create_info_ext,
    p_next: ?*const c_void = null,
    vertex_binding_divisor_count: u32,
    p_vertex_binding_divisors: [*]const VertexInputBindingDivisorDescriptionEXT,
};
pub const PhysicalDeviceVertexAttributeDivisorPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_vertex_attribute_divisor_properties_ext,
    p_next: ?*c_void = null,
    max_vertex_attrib_divisor: u32,
};
pub const PhysicalDevicePCIBusInfoPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_pci_bus_info_properties_ext,
    p_next: ?*c_void = null,
    pci_domain: u32,
    pci_bus: u32,
    pci_device: u32,
    pci_function: u32,
};
pub const ImportAndroidHardwareBufferInfoANDROID = extern struct {
    s_type: StructureType = .import_android_hardware_buffer_info_android,
    p_next: ?*const c_void = null,
    buffer: *AHardwareBuffer,
};
pub const AndroidHardwareBufferUsageANDROID = extern struct {
    s_type: StructureType = .android_hardware_buffer_usage_android,
    p_next: ?*c_void = null,
    android_hardware_buffer_usage: u64,
};
pub const AndroidHardwareBufferPropertiesANDROID = extern struct {
    s_type: StructureType = .android_hardware_buffer_properties_android,
    p_next: ?*c_void = null,
    allocation_size: DeviceSize,
    memory_type_bits: u32,
};
pub const MemoryGetAndroidHardwareBufferInfoANDROID = extern struct {
    s_type: StructureType = .memory_get_android_hardware_buffer_info_android,
    p_next: ?*const c_void = null,
    memory: DeviceMemory,
};
pub const AndroidHardwareBufferFormatPropertiesANDROID = extern struct {
    s_type: StructureType = .android_hardware_buffer_format_properties_android,
    p_next: ?*c_void = null,
    format: Format,
    external_format: u64,
    format_features: FormatFeatureFlags,
    sampler_ycbcr_conversion_components: ComponentMapping,
    suggested_ycbcr_model: SamplerYcbcrModelConversion,
    suggested_ycbcr_range: SamplerYcbcrRange,
    suggested_x_chroma_offset: ChromaLocation,
    suggested_y_chroma_offset: ChromaLocation,
};
pub const CommandBufferInheritanceConditionalRenderingInfoEXT = extern struct {
    s_type: StructureType = .command_buffer_inheritance_conditional_rendering_info_ext,
    p_next: ?*const c_void = null,
    conditional_rendering_enable: Bool32,
};
pub const ExternalFormatANDROID = extern struct {
    s_type: StructureType = .external_format_android,
    p_next: ?*c_void = null,
    external_format: u64,
};
pub const PhysicalDevice8BitStorageFeatures = extern struct {
    s_type: StructureType = .physical_device_8bit_storage_features,
    p_next: ?*c_void = null,
    storage_buffer_8_bit_access: Bool32 = FALSE,
    uniform_and_storage_buffer_8_bit_access: Bool32 = FALSE,
    storage_push_constant_8: Bool32 = FALSE,
};
pub const PhysicalDevice8BitStorageFeaturesKHR = PhysicalDevice8BitStorageFeatures;
pub const PhysicalDeviceConditionalRenderingFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_conditional_rendering_features_ext,
    p_next: ?*c_void = null,
    conditional_rendering: Bool32 = FALSE,
    inherited_conditional_rendering: Bool32 = FALSE,
};
pub const PhysicalDeviceVulkanMemoryModelFeatures = extern struct {
    s_type: StructureType = .physical_device_vulkan_memory_model_features,
    p_next: ?*c_void = null,
    vulkan_memory_model: Bool32 = FALSE,
    vulkan_memory_model_device_scope: Bool32 = FALSE,
    vulkan_memory_model_availability_visibility_chains: Bool32 = FALSE,
};
pub const PhysicalDeviceVulkanMemoryModelFeaturesKHR = PhysicalDeviceVulkanMemoryModelFeatures;
pub const PhysicalDeviceShaderAtomicInt64Features = extern struct {
    s_type: StructureType = .physical_device_shader_atomic_int64_features,
    p_next: ?*c_void = null,
    shader_buffer_int_64_atomics: Bool32 = FALSE,
    shader_shared_int_64_atomics: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderAtomicInt64FeaturesKHR = PhysicalDeviceShaderAtomicInt64Features;
pub const PhysicalDeviceShaderAtomicFloatFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_atomic_float_features_ext,
    p_next: ?*c_void = null,
    shader_buffer_float_32_atomics: Bool32 = FALSE,
    shader_buffer_float_32_atomic_add: Bool32 = FALSE,
    shader_buffer_float_64_atomics: Bool32 = FALSE,
    shader_buffer_float_64_atomic_add: Bool32 = FALSE,
    shader_shared_float_32_atomics: Bool32 = FALSE,
    shader_shared_float_32_atomic_add: Bool32 = FALSE,
    shader_shared_float_64_atomics: Bool32 = FALSE,
    shader_shared_float_64_atomic_add: Bool32 = FALSE,
    shader_image_float_32_atomics: Bool32 = FALSE,
    shader_image_float_32_atomic_add: Bool32 = FALSE,
    sparse_image_float_32_atomics: Bool32 = FALSE,
    sparse_image_float_32_atomic_add: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderAtomicFloat2FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_atomic_float_2_features_ext,
    p_next: ?*c_void = null,
    shader_buffer_float_16_atomics: Bool32 = FALSE,
    shader_buffer_float_16_atomic_add: Bool32 = FALSE,
    shader_buffer_float_16_atomic_min_max: Bool32 = FALSE,
    shader_buffer_float_32_atomic_min_max: Bool32 = FALSE,
    shader_buffer_float_64_atomic_min_max: Bool32 = FALSE,
    shader_shared_float_16_atomics: Bool32 = FALSE,
    shader_shared_float_16_atomic_add: Bool32 = FALSE,
    shader_shared_float_16_atomic_min_max: Bool32 = FALSE,
    shader_shared_float_32_atomic_min_max: Bool32 = FALSE,
    shader_shared_float_64_atomic_min_max: Bool32 = FALSE,
    shader_image_float_32_atomic_min_max: Bool32 = FALSE,
    sparse_image_float_32_atomic_min_max: Bool32 = FALSE,
};
pub const PhysicalDeviceVertexAttributeDivisorFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_vertex_attribute_divisor_features_ext,
    p_next: ?*c_void = null,
    vertex_attribute_instance_rate_divisor: Bool32 = FALSE,
    vertex_attribute_instance_rate_zero_divisor: Bool32 = FALSE,
};
pub const QueueFamilyCheckpointPropertiesNV = extern struct {
    s_type: StructureType = .queue_family_checkpoint_properties_nv,
    p_next: ?*c_void = null,
    checkpoint_execution_stage_mask: PipelineStageFlags,
};
pub const CheckpointDataNV = extern struct {
    s_type: StructureType = .checkpoint_data_nv,
    p_next: ?*c_void = null,
    stage: PipelineStageFlags,
    p_checkpoint_marker: *c_void,
};
pub const PhysicalDeviceDepthStencilResolveProperties = extern struct {
    s_type: StructureType = .physical_device_depth_stencil_resolve_properties,
    p_next: ?*c_void = null,
    supported_depth_resolve_modes: ResolveModeFlags,
    supported_stencil_resolve_modes: ResolveModeFlags,
    independent_resolve_none: Bool32,
    independent_resolve: Bool32,
};
pub const PhysicalDeviceDepthStencilResolvePropertiesKHR = PhysicalDeviceDepthStencilResolveProperties;
pub const SubpassDescriptionDepthStencilResolve = extern struct {
    s_type: StructureType = .subpass_description_depth_stencil_resolve,
    p_next: ?*const c_void = null,
    depth_resolve_mode: ResolveModeFlags,
    stencil_resolve_mode: ResolveModeFlags,
    p_depth_stencil_resolve_attachment: ?*const AttachmentReference2,
};
pub const SubpassDescriptionDepthStencilResolveKHR = SubpassDescriptionDepthStencilResolve;
pub const ImageViewASTCDecodeModeEXT = extern struct {
    s_type: StructureType = .image_view_astc_decode_mode_ext,
    p_next: ?*const c_void = null,
    decode_mode: Format,
};
pub const PhysicalDeviceASTCDecodeFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_astc_decode_features_ext,
    p_next: ?*c_void = null,
    decode_mode_shared_exponent: Bool32 = FALSE,
};
pub const PhysicalDeviceTransformFeedbackFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_transform_feedback_features_ext,
    p_next: ?*c_void = null,
    transform_feedback: Bool32 = FALSE,
    geometry_streams: Bool32 = FALSE,
};
pub const PhysicalDeviceTransformFeedbackPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_transform_feedback_properties_ext,
    p_next: ?*c_void = null,
    max_transform_feedback_streams: u32,
    max_transform_feedback_buffers: u32,
    max_transform_feedback_buffer_size: DeviceSize,
    max_transform_feedback_stream_data_size: u32,
    max_transform_feedback_buffer_data_size: u32,
    max_transform_feedback_buffer_data_stride: u32,
    transform_feedback_queries: Bool32,
    transform_feedback_streams_lines_triangles: Bool32,
    transform_feedback_rasterization_stream_select: Bool32,
    transform_feedback_draw: Bool32,
};
pub const PipelineRasterizationStateStreamCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_state_stream_create_info_ext,
    p_next: ?*const c_void = null,
    flags: PipelineRasterizationStateStreamCreateFlagsEXT,
    rasterization_stream: u32,
};
pub const PhysicalDeviceRepresentativeFragmentTestFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_representative_fragment_test_features_nv,
    p_next: ?*c_void = null,
    representative_fragment_test: Bool32 = FALSE,
};
pub const PipelineRepresentativeFragmentTestStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_representative_fragment_test_state_create_info_nv,
    p_next: ?*const c_void = null,
    representative_fragment_test_enable: Bool32,
};
pub const PhysicalDeviceExclusiveScissorFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_exclusive_scissor_features_nv,
    p_next: ?*c_void = null,
    exclusive_scissor: Bool32 = FALSE,
};
pub const PipelineViewportExclusiveScissorStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_exclusive_scissor_state_create_info_nv,
    p_next: ?*const c_void = null,
    exclusive_scissor_count: u32,
    p_exclusive_scissors: [*]const Rect2D,
};
pub const PhysicalDeviceCornerSampledImageFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_corner_sampled_image_features_nv,
    p_next: ?*c_void = null,
    corner_sampled_image: Bool32 = FALSE,
};
pub const PhysicalDeviceComputeShaderDerivativesFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_compute_shader_derivatives_features_nv,
    p_next: ?*c_void = null,
    compute_derivative_group_quads: Bool32 = FALSE,
    compute_derivative_group_linear: Bool32 = FALSE,
};
pub const PhysicalDeviceFragmentShaderBarycentricFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_fragment_shader_barycentric_features_nv,
    p_next: ?*c_void = null,
    fragment_shader_barycentric: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderImageFootprintFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_shader_image_footprint_features_nv,
    p_next: ?*c_void = null,
    image_footprint: Bool32 = FALSE,
};
pub const PhysicalDeviceDedicatedAllocationImageAliasingFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_dedicated_allocation_image_aliasing_features_nv,
    p_next: ?*c_void = null,
    dedicated_allocation_image_aliasing: Bool32 = FALSE,
};
pub const ShadingRatePaletteNV = extern struct {
    shading_rate_palette_entry_count: u32,
    p_shading_rate_palette_entries: [*]const ShadingRatePaletteEntryNV,
};
pub const PipelineViewportShadingRateImageStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_shading_rate_image_state_create_info_nv,
    p_next: ?*const c_void = null,
    shading_rate_image_enable: Bool32,
    viewport_count: u32,
    p_shading_rate_palettes: [*]const ShadingRatePaletteNV,
};
pub const PhysicalDeviceShadingRateImageFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_shading_rate_image_features_nv,
    p_next: ?*c_void = null,
    shading_rate_image: Bool32 = FALSE,
    shading_rate_coarse_sample_order: Bool32 = FALSE,
};
pub const PhysicalDeviceShadingRateImagePropertiesNV = extern struct {
    s_type: StructureType = .physical_device_shading_rate_image_properties_nv,
    p_next: ?*c_void = null,
    shading_rate_texel_size: Extent2D,
    shading_rate_palette_size: u32,
    shading_rate_max_coarse_samples: u32,
};
pub const PhysicalDeviceInvocationMaskFeaturesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_invocation_mask_features_huawei,
    p_next: ?*c_void = null,
    invocation_mask: Bool32 = FALSE,
};
pub const CoarseSampleLocationNV = extern struct {
    pixel_x: u32,
    pixel_y: u32,
    sample: u32,
};
pub const CoarseSampleOrderCustomNV = extern struct {
    shading_rate: ShadingRatePaletteEntryNV,
    sample_count: u32,
    sample_location_count: u32,
    p_sample_locations: [*]const CoarseSampleLocationNV,
};
pub const PipelineViewportCoarseSampleOrderStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_viewport_coarse_sample_order_state_create_info_nv,
    p_next: ?*const c_void = null,
    sample_order_type: CoarseSampleOrderTypeNV,
    custom_sample_order_count: u32,
    p_custom_sample_orders: [*]const CoarseSampleOrderCustomNV,
};
pub const PhysicalDeviceMeshShaderFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_mesh_shader_features_nv,
    p_next: ?*c_void = null,
    task_shader: Bool32 = FALSE,
    mesh_shader: Bool32 = FALSE,
};
pub const PhysicalDeviceMeshShaderPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_mesh_shader_properties_nv,
    p_next: ?*c_void = null,
    max_draw_mesh_tasks_count: u32,
    max_task_work_group_invocations: u32,
    max_task_work_group_size: [3]u32,
    max_task_total_memory_size: u32,
    max_task_output_count: u32,
    max_mesh_work_group_invocations: u32,
    max_mesh_work_group_size: [3]u32,
    max_mesh_total_memory_size: u32,
    max_mesh_output_vertices: u32,
    max_mesh_output_primitives: u32,
    max_mesh_multiview_view_count: u32,
    mesh_output_per_vertex_granularity: u32,
    mesh_output_per_primitive_granularity: u32,
};
pub const DrawMeshTasksIndirectCommandNV = extern struct {
    task_count: u32,
    first_task: u32,
};
pub const RayTracingShaderGroupCreateInfoNV = extern struct {
    s_type: StructureType = .ray_tracing_shader_group_create_info_nv,
    p_next: ?*const c_void = null,
    @"type": RayTracingShaderGroupTypeKHR,
    general_shader: u32,
    closest_hit_shader: u32,
    any_hit_shader: u32,
    intersection_shader: u32,
};
pub const RayTracingShaderGroupCreateInfoKHR = extern struct {
    s_type: StructureType = .ray_tracing_shader_group_create_info_khr,
    p_next: ?*const c_void = null,
    @"type": RayTracingShaderGroupTypeKHR,
    general_shader: u32,
    closest_hit_shader: u32,
    any_hit_shader: u32,
    intersection_shader: u32,
    p_shader_group_capture_replay_handle: ?*const c_void,
};
pub const RayTracingPipelineCreateInfoNV = extern struct {
    s_type: StructureType = .ray_tracing_pipeline_create_info_nv,
    p_next: ?*const c_void = null,
    flags: PipelineCreateFlags,
    stage_count: u32,
    p_stages: [*]const PipelineShaderStageCreateInfo,
    group_count: u32,
    p_groups: [*]const RayTracingShaderGroupCreateInfoNV,
    max_recursion_depth: u32,
    layout: PipelineLayout,
    base_pipeline_handle: Pipeline,
    base_pipeline_index: i32,
};
pub const RayTracingPipelineCreateInfoKHR = extern struct {
    s_type: StructureType = .ray_tracing_pipeline_create_info_khr,
    p_next: ?*const c_void = null,
    flags: PipelineCreateFlags,
    stage_count: u32,
    p_stages: [*]const PipelineShaderStageCreateInfo,
    group_count: u32,
    p_groups: [*]const RayTracingShaderGroupCreateInfoKHR,
    max_pipeline_ray_recursion_depth: u32,
    p_library_info: ?*const PipelineLibraryCreateInfoKHR,
    p_library_interface: ?*const RayTracingPipelineInterfaceCreateInfoKHR,
    p_dynamic_state: ?*const PipelineDynamicStateCreateInfo,
    layout: PipelineLayout,
    base_pipeline_handle: Pipeline,
    base_pipeline_index: i32,
};
pub const GeometryTrianglesNV = extern struct {
    s_type: StructureType = .geometry_triangles_nv,
    p_next: ?*const c_void = null,
    vertex_data: Buffer,
    vertex_offset: DeviceSize,
    vertex_count: u32,
    vertex_stride: DeviceSize,
    vertex_format: Format,
    index_data: Buffer,
    index_offset: DeviceSize,
    index_count: u32,
    index_type: IndexType,
    transform_data: Buffer,
    transform_offset: DeviceSize,
};
pub const GeometryAABBNV = extern struct {
    s_type: StructureType = .geometry_aabb_nv,
    p_next: ?*const c_void = null,
    aabb_data: Buffer,
    num_aab_bs: u32,
    stride: u32,
    offset: DeviceSize,
};
pub const GeometryDataNV = extern struct {
    triangles: GeometryTrianglesNV,
    aabbs: GeometryAABBNV,
};
pub const GeometryNV = extern struct {
    s_type: StructureType = .geometry_nv,
    p_next: ?*const c_void = null,
    geometry_type: GeometryTypeKHR,
    geometry: GeometryDataNV,
    flags: GeometryFlagsKHR,
};
pub const AccelerationStructureInfoNV = extern struct {
    s_type: StructureType = .acceleration_structure_info_nv,
    p_next: ?*const c_void = null,
    @"type": AccelerationStructureTypeNV,
    flags: BuildAccelerationStructureFlagsNV,
    instance_count: u32,
    geometry_count: u32,
    p_geometries: [*]const GeometryNV,
};
pub const AccelerationStructureCreateInfoNV = extern struct {
    s_type: StructureType = .acceleration_structure_create_info_nv,
    p_next: ?*const c_void = null,
    compacted_size: DeviceSize,
    info: AccelerationStructureInfoNV,
};
pub const BindAccelerationStructureMemoryInfoNV = extern struct {
    s_type: StructureType = .bind_acceleration_structure_memory_info_nv,
    p_next: ?*const c_void = null,
    acceleration_structure: AccelerationStructureNV,
    memory: DeviceMemory,
    memory_offset: DeviceSize,
    device_index_count: u32,
    p_device_indices: [*]const u32,
};
pub const WriteDescriptorSetAccelerationStructureKHR = extern struct {
    s_type: StructureType = .write_descriptor_set_acceleration_structure_khr,
    p_next: ?*const c_void = null,
    acceleration_structure_count: u32,
    p_acceleration_structures: [*]const AccelerationStructureKHR,
};
pub const WriteDescriptorSetAccelerationStructureNV = extern struct {
    s_type: StructureType = .write_descriptor_set_acceleration_structure_nv,
    p_next: ?*const c_void = null,
    acceleration_structure_count: u32,
    p_acceleration_structures: [*]const AccelerationStructureNV,
};
pub const AccelerationStructureMemoryRequirementsInfoNV = extern struct {
    s_type: StructureType = .acceleration_structure_memory_requirements_info_nv,
    p_next: ?*const c_void = null,
    @"type": AccelerationStructureMemoryRequirementsTypeNV,
    acceleration_structure: AccelerationStructureNV,
};
pub const PhysicalDeviceAccelerationStructureFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_acceleration_structure_features_khr,
    p_next: ?*c_void = null,
    acceleration_structure: Bool32 = FALSE,
    acceleration_structure_capture_replay: Bool32 = FALSE,
    acceleration_structure_indirect_build: Bool32 = FALSE,
    acceleration_structure_host_commands: Bool32 = FALSE,
    descriptor_binding_acceleration_structure_update_after_bind: Bool32 = FALSE,
};
pub const PhysicalDeviceRayTracingPipelineFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_pipeline_features_khr,
    p_next: ?*c_void = null,
    ray_tracing_pipeline: Bool32 = FALSE,
    ray_tracing_pipeline_shader_group_handle_capture_replay: Bool32 = FALSE,
    ray_tracing_pipeline_shader_group_handle_capture_replay_mixed: Bool32 = FALSE,
    ray_tracing_pipeline_trace_rays_indirect: Bool32 = FALSE,
    ray_traversal_primitive_culling: Bool32 = FALSE,
};
pub const PhysicalDeviceRayQueryFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_ray_query_features_khr,
    p_next: ?*c_void = null,
    ray_query: Bool32 = FALSE,
};
pub const PhysicalDeviceAccelerationStructurePropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_acceleration_structure_properties_khr,
    p_next: ?*c_void = null,
    max_geometry_count: u64,
    max_instance_count: u64,
    max_primitive_count: u64,
    max_per_stage_descriptor_acceleration_structures: u32,
    max_per_stage_descriptor_update_after_bind_acceleration_structures: u32,
    max_descriptor_set_acceleration_structures: u32,
    max_descriptor_set_update_after_bind_acceleration_structures: u32,
    min_acceleration_structure_scratch_offset_alignment: u32,
};
pub const PhysicalDeviceRayTracingPipelinePropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_pipeline_properties_khr,
    p_next: ?*c_void = null,
    shader_group_handle_size: u32,
    max_ray_recursion_depth: u32,
    max_shader_group_stride: u32,
    shader_group_base_alignment: u32,
    shader_group_handle_capture_replay_size: u32,
    max_ray_dispatch_invocation_count: u32,
    shader_group_handle_alignment: u32,
    max_ray_hit_attribute_size: u32,
};
pub const PhysicalDeviceRayTracingPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_properties_nv,
    p_next: ?*c_void = null,
    shader_group_handle_size: u32,
    max_recursion_depth: u32,
    max_shader_group_stride: u32,
    shader_group_base_alignment: u32,
    max_geometry_count: u64,
    max_instance_count: u64,
    max_triangle_count: u64,
    max_descriptor_set_acceleration_structures: u32,
};
pub const StridedDeviceAddressRegionKHR = extern struct {
    device_address: DeviceAddress,
    stride: DeviceSize,
    size: DeviceSize,
};
pub const TraceRaysIndirectCommandKHR = extern struct {
    width: u32,
    height: u32,
    depth: u32,
};
pub const DrmFormatModifierPropertiesListEXT = extern struct {
    s_type: StructureType = .drm_format_modifier_properties_list_ext,
    p_next: ?*c_void = null,
    drm_format_modifier_count: u32,
    p_drm_format_modifier_properties: ?[*]DrmFormatModifierPropertiesEXT,
};
pub const DrmFormatModifierPropertiesEXT = extern struct {
    drm_format_modifier: u64,
    drm_format_modifier_plane_count: u32,
    drm_format_modifier_tiling_features: FormatFeatureFlags,
};
pub const PhysicalDeviceImageDrmFormatModifierInfoEXT = extern struct {
    s_type: StructureType = .physical_device_image_drm_format_modifier_info_ext,
    p_next: ?*const c_void = null,
    drm_format_modifier: u64,
    sharing_mode: SharingMode,
    queue_family_index_count: u32,
    p_queue_family_indices: [*]const u32,
};
pub const ImageDrmFormatModifierListCreateInfoEXT = extern struct {
    s_type: StructureType = .image_drm_format_modifier_list_create_info_ext,
    p_next: ?*const c_void = null,
    drm_format_modifier_count: u32,
    p_drm_format_modifiers: [*]const u64,
};
pub const ImageDrmFormatModifierExplicitCreateInfoEXT = extern struct {
    s_type: StructureType = .image_drm_format_modifier_explicit_create_info_ext,
    p_next: ?*const c_void = null,
    drm_format_modifier: u64,
    drm_format_modifier_plane_count: u32,
    p_plane_layouts: [*]const SubresourceLayout,
};
pub const ImageDrmFormatModifierPropertiesEXT = extern struct {
    s_type: StructureType = .image_drm_format_modifier_properties_ext,
    p_next: ?*c_void = null,
    drm_format_modifier: u64,
};
pub const ImageStencilUsageCreateInfo = extern struct {
    s_type: StructureType = .image_stencil_usage_create_info,
    p_next: ?*const c_void = null,
    stencil_usage: ImageUsageFlags,
};
pub const ImageStencilUsageCreateInfoEXT = ImageStencilUsageCreateInfo;
pub const DeviceMemoryOverallocationCreateInfoAMD = extern struct {
    s_type: StructureType = .device_memory_overallocation_create_info_amd,
    p_next: ?*const c_void = null,
    overallocation_behavior: MemoryOverallocationBehaviorAMD,
};
pub const PhysicalDeviceFragmentDensityMapFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_features_ext,
    p_next: ?*c_void = null,
    fragment_density_map: Bool32 = FALSE,
    fragment_density_map_dynamic: Bool32 = FALSE,
    fragment_density_map_non_subsampled_images: Bool32 = FALSE,
};
pub const PhysicalDeviceFragmentDensityMap2FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_2_features_ext,
    p_next: ?*c_void = null,
    fragment_density_map_deferred: Bool32 = FALSE,
};
pub const PhysicalDeviceFragmentDensityMapPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_properties_ext,
    p_next: ?*c_void = null,
    min_fragment_density_texel_size: Extent2D,
    max_fragment_density_texel_size: Extent2D,
    fragment_density_invocations: Bool32,
};
pub const PhysicalDeviceFragmentDensityMap2PropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_density_map_2_properties_ext,
    p_next: ?*c_void = null,
    subsampled_loads: Bool32,
    subsampled_coarse_reconstruction_early_access: Bool32,
    max_subsampled_array_layers: u32,
    max_descriptor_set_subsampled_samplers: u32,
};
pub const RenderPassFragmentDensityMapCreateInfoEXT = extern struct {
    s_type: StructureType = .render_pass_fragment_density_map_create_info_ext,
    p_next: ?*const c_void = null,
    fragment_density_map_attachment: AttachmentReference,
};
pub const PhysicalDeviceScalarBlockLayoutFeatures = extern struct {
    s_type: StructureType = .physical_device_scalar_block_layout_features,
    p_next: ?*c_void = null,
    scalar_block_layout: Bool32 = FALSE,
};
pub const PhysicalDeviceScalarBlockLayoutFeaturesEXT = PhysicalDeviceScalarBlockLayoutFeatures;
pub const SurfaceProtectedCapabilitiesKHR = extern struct {
    s_type: StructureType = .surface_protected_capabilities_khr,
    p_next: ?*const c_void = null,
    supports_protected: Bool32,
};
pub const PhysicalDeviceUniformBufferStandardLayoutFeatures = extern struct {
    s_type: StructureType = .physical_device_uniform_buffer_standard_layout_features,
    p_next: ?*c_void = null,
    uniform_buffer_standard_layout: Bool32 = FALSE,
};
pub const PhysicalDeviceUniformBufferStandardLayoutFeaturesKHR = PhysicalDeviceUniformBufferStandardLayoutFeatures;
pub const PhysicalDeviceDepthClipEnableFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_depth_clip_enable_features_ext,
    p_next: ?*c_void = null,
    depth_clip_enable: Bool32 = FALSE,
};
pub const PipelineRasterizationDepthClipStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_depth_clip_state_create_info_ext,
    p_next: ?*const c_void = null,
    flags: PipelineRasterizationDepthClipStateCreateFlagsEXT,
    depth_clip_enable: Bool32,
};
pub const PhysicalDeviceMemoryBudgetPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_memory_budget_properties_ext,
    p_next: ?*c_void = null,
    heap_budget: [MAX_MEMORY_HEAPS]DeviceSize,
    heap_usage: [MAX_MEMORY_HEAPS]DeviceSize,
};
pub const PhysicalDeviceMemoryPriorityFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_memory_priority_features_ext,
    p_next: ?*c_void = null,
    memory_priority: Bool32 = FALSE,
};
pub const MemoryPriorityAllocateInfoEXT = extern struct {
    s_type: StructureType = .memory_priority_allocate_info_ext,
    p_next: ?*const c_void = null,
    priority: f32,
};
pub const PhysicalDevicePageableDeviceLocalMemoryFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_pageable_device_local_memory_features_ext,
    p_next: ?*c_void = null,
    pageable_device_local_memory: Bool32 = FALSE,
};
pub const PhysicalDeviceBufferDeviceAddressFeatures = extern struct {
    s_type: StructureType = .physical_device_buffer_device_address_features,
    p_next: ?*c_void = null,
    buffer_device_address: Bool32 = FALSE,
    buffer_device_address_capture_replay: Bool32 = FALSE,
    buffer_device_address_multi_device: Bool32 = FALSE,
};
pub const PhysicalDeviceBufferDeviceAddressFeaturesKHR = PhysicalDeviceBufferDeviceAddressFeatures;
pub const PhysicalDeviceBufferDeviceAddressFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_buffer_device_address_features_ext,
    p_next: ?*c_void = null,
    buffer_device_address: Bool32 = FALSE,
    buffer_device_address_capture_replay: Bool32 = FALSE,
    buffer_device_address_multi_device: Bool32 = FALSE,
};
pub const PhysicalDeviceBufferAddressFeaturesEXT = PhysicalDeviceBufferDeviceAddressFeaturesEXT;
pub const BufferDeviceAddressInfo = extern struct {
    s_type: StructureType = .buffer_device_address_info,
    p_next: ?*const c_void = null,
    buffer: Buffer,
};
pub const BufferDeviceAddressInfoKHR = BufferDeviceAddressInfo;
pub const BufferDeviceAddressInfoEXT = BufferDeviceAddressInfo;
pub const BufferOpaqueCaptureAddressCreateInfo = extern struct {
    s_type: StructureType = .buffer_opaque_capture_address_create_info,
    p_next: ?*const c_void = null,
    opaque_capture_address: u64,
};
pub const BufferOpaqueCaptureAddressCreateInfoKHR = BufferOpaqueCaptureAddressCreateInfo;
pub const BufferDeviceAddressCreateInfoEXT = extern struct {
    s_type: StructureType = .buffer_device_address_create_info_ext,
    p_next: ?*const c_void = null,
    device_address: DeviceAddress,
};
pub const PhysicalDeviceImageViewImageFormatInfoEXT = extern struct {
    s_type: StructureType = .physical_device_image_view_image_format_info_ext,
    p_next: ?*c_void = null,
    image_view_type: ImageViewType,
};
pub const FilterCubicImageViewImageFormatPropertiesEXT = extern struct {
    s_type: StructureType = .filter_cubic_image_view_image_format_properties_ext,
    p_next: ?*c_void = null,
    filter_cubic: Bool32,
    filter_cubic_minmax: Bool32,
};
pub const PhysicalDeviceImagelessFramebufferFeatures = extern struct {
    s_type: StructureType = .physical_device_imageless_framebuffer_features,
    p_next: ?*c_void = null,
    imageless_framebuffer: Bool32 = FALSE,
};
pub const PhysicalDeviceImagelessFramebufferFeaturesKHR = PhysicalDeviceImagelessFramebufferFeatures;
pub const FramebufferAttachmentsCreateInfo = extern struct {
    s_type: StructureType = .framebuffer_attachments_create_info,
    p_next: ?*const c_void = null,
    attachment_image_info_count: u32,
    p_attachment_image_infos: [*]const FramebufferAttachmentImageInfo,
};
pub const FramebufferAttachmentsCreateInfoKHR = FramebufferAttachmentsCreateInfo;
pub const FramebufferAttachmentImageInfo = extern struct {
    s_type: StructureType = .framebuffer_attachment_image_info,
    p_next: ?*const c_void = null,
    flags: ImageCreateFlags,
    usage: ImageUsageFlags,
    width: u32,
    height: u32,
    layer_count: u32,
    view_format_count: u32,
    p_view_formats: [*]const Format,
};
pub const FramebufferAttachmentImageInfoKHR = FramebufferAttachmentImageInfo;
pub const RenderPassAttachmentBeginInfo = extern struct {
    s_type: StructureType = .render_pass_attachment_begin_info,
    p_next: ?*const c_void = null,
    attachment_count: u32,
    p_attachments: [*]const ImageView,
};
pub const RenderPassAttachmentBeginInfoKHR = RenderPassAttachmentBeginInfo;
pub const PhysicalDeviceTextureCompressionASTCHDRFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_texture_compression_astc_hdr_features_ext,
    p_next: ?*c_void = null,
    texture_compression_astc_hdr: Bool32 = FALSE,
};
pub const PhysicalDeviceCooperativeMatrixFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_cooperative_matrix_features_nv,
    p_next: ?*c_void = null,
    cooperative_matrix: Bool32 = FALSE,
    cooperative_matrix_robust_buffer_access: Bool32 = FALSE,
};
pub const PhysicalDeviceCooperativeMatrixPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_cooperative_matrix_properties_nv,
    p_next: ?*c_void = null,
    cooperative_matrix_supported_stages: ShaderStageFlags,
};
pub const CooperativeMatrixPropertiesNV = extern struct {
    s_type: StructureType = .cooperative_matrix_properties_nv,
    p_next: ?*c_void = null,
    m_size: u32,
    n_size: u32,
    k_size: u32,
    a_type: ComponentTypeNV,
    b_type: ComponentTypeNV,
    c_type: ComponentTypeNV,
    d_type: ComponentTypeNV,
    scope: ScopeNV,
};
pub const PhysicalDeviceYcbcrImageArraysFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_ycbcr_image_arrays_features_ext,
    p_next: ?*c_void = null,
    ycbcr_image_arrays: Bool32 = FALSE,
};
pub const ImageViewHandleInfoNVX = extern struct {
    s_type: StructureType = .image_view_handle_info_nvx,
    p_next: ?*const c_void = null,
    image_view: ImageView,
    descriptor_type: DescriptorType,
    sampler: Sampler,
};
pub const ImageViewAddressPropertiesNVX = extern struct {
    s_type: StructureType = .image_view_address_properties_nvx,
    p_next: ?*c_void = null,
    device_address: DeviceAddress,
    size: DeviceSize,
};
pub const PresentFrameTokenGGP = extern struct {
    s_type: StructureType = .present_frame_token_ggp,
    p_next: ?*const c_void = null,
    frame_token: GgpFrameToken,
};
pub const PipelineCreationFeedbackEXT = extern struct {
    flags: PipelineCreationFeedbackFlagsEXT,
    duration: u64,
};
pub const PipelineCreationFeedbackCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_creation_feedback_create_info_ext,
    p_next: ?*const c_void = null,
    p_pipeline_creation_feedback: *PipelineCreationFeedbackEXT,
    pipeline_stage_creation_feedback_count: u32,
    p_pipeline_stage_creation_feedbacks: [*]PipelineCreationFeedbackEXT,
};
pub const SurfaceFullScreenExclusiveInfoEXT = extern struct {
    s_type: StructureType = .surface_full_screen_exclusive_info_ext,
    p_next: ?*c_void = null,
    full_screen_exclusive: FullScreenExclusiveEXT,
};
pub const SurfaceFullScreenExclusiveWin32InfoEXT = extern struct {
    s_type: StructureType = .surface_full_screen_exclusive_win32_info_ext,
    p_next: ?*const c_void = null,
    hmonitor: HMONITOR,
};
pub const SurfaceCapabilitiesFullScreenExclusiveEXT = extern struct {
    s_type: StructureType = .surface_capabilities_full_screen_exclusive_ext,
    p_next: ?*c_void = null,
    full_screen_exclusive_supported: Bool32,
};
pub const PhysicalDevicePerformanceQueryFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_performance_query_features_khr,
    p_next: ?*c_void = null,
    performance_counter_query_pools: Bool32 = FALSE,
    performance_counter_multiple_query_pools: Bool32 = FALSE,
};
pub const PhysicalDevicePerformanceQueryPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_performance_query_properties_khr,
    p_next: ?*c_void = null,
    allow_command_buffer_query_copies: Bool32,
};
pub const PerformanceCounterKHR = extern struct {
    s_type: StructureType = .performance_counter_khr,
    p_next: ?*c_void = null,
    unit: PerformanceCounterUnitKHR,
    scope: PerformanceCounterScopeKHR,
    storage: PerformanceCounterStorageKHR,
    uuid: [UUID_SIZE]u8,
};
pub const PerformanceCounterDescriptionKHR = extern struct {
    s_type: StructureType = .performance_counter_description_khr,
    p_next: ?*c_void = null,
    flags: PerformanceCounterDescriptionFlagsKHR,
    name: [MAX_DESCRIPTION_SIZE]u8,
    category: [MAX_DESCRIPTION_SIZE]u8,
    description: [MAX_DESCRIPTION_SIZE]u8,
};
pub const QueryPoolPerformanceCreateInfoKHR = extern struct {
    s_type: StructureType = .query_pool_performance_create_info_khr,
    p_next: ?*const c_void = null,
    queue_family_index: u32,
    counter_index_count: u32,
    p_counter_indices: [*]const u32,
};
pub const PerformanceCounterResultKHR = extern union {
    int_32: i32,
    int_64: i64,
    uint_32: u32,
    uint_64: u64,
    float_32: f32,
    float_64: f64,
};
pub const AcquireProfilingLockInfoKHR = extern struct {
    s_type: StructureType = .acquire_profiling_lock_info_khr,
    p_next: ?*const c_void = null,
    flags: AcquireProfilingLockFlagsKHR,
    timeout: u64,
};
pub const PerformanceQuerySubmitInfoKHR = extern struct {
    s_type: StructureType = .performance_query_submit_info_khr,
    p_next: ?*const c_void = null,
    counter_pass_index: u32,
};
pub const HeadlessSurfaceCreateInfoEXT = extern struct {
    s_type: StructureType = .headless_surface_create_info_ext,
    p_next: ?*const c_void = null,
    flags: HeadlessSurfaceCreateFlagsEXT,
};
pub const PhysicalDeviceCoverageReductionModeFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_coverage_reduction_mode_features_nv,
    p_next: ?*c_void = null,
    coverage_reduction_mode: Bool32 = FALSE,
};
pub const PipelineCoverageReductionStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_coverage_reduction_state_create_info_nv,
    p_next: ?*const c_void = null,
    flags: PipelineCoverageReductionStateCreateFlagsNV,
    coverage_reduction_mode: CoverageReductionModeNV,
};
pub const FramebufferMixedSamplesCombinationNV = extern struct {
    s_type: StructureType = .framebuffer_mixed_samples_combination_nv,
    p_next: ?*c_void = null,
    coverage_reduction_mode: CoverageReductionModeNV,
    rasterization_samples: SampleCountFlags,
    depth_stencil_samples: SampleCountFlags,
    color_samples: SampleCountFlags,
};
pub const PhysicalDeviceShaderIntegerFunctions2FeaturesINTEL = extern struct {
    s_type: StructureType = .physical_device_shader_integer_functions_2_features_intel,
    p_next: ?*c_void = null,
    shader_integer_functions_2: Bool32 = FALSE,
};
pub const PerformanceValueDataINTEL = extern union {
    value_32: u32,
    value_64: u64,
    value_float: f32,
    value_bool: Bool32,
    value_string: [*:0]const u8,
};
pub const PerformanceValueINTEL = extern struct {
    @"type": PerformanceValueTypeINTEL,
    data: PerformanceValueDataINTEL,
};
pub const InitializePerformanceApiInfoINTEL = extern struct {
    s_type: StructureType = .initialize_performance_api_info_intel,
    p_next: ?*const c_void = null,
    p_user_data: ?*c_void,
};
pub const QueryPoolPerformanceQueryCreateInfoINTEL = extern struct {
    s_type: StructureType = .query_pool_performance_query_create_info_intel,
    p_next: ?*const c_void = null,
    performance_counters_sampling: QueryPoolSamplingModeINTEL,
};
pub const QueryPoolCreateInfoINTEL = QueryPoolPerformanceQueryCreateInfoINTEL;
pub const PerformanceMarkerInfoINTEL = extern struct {
    s_type: StructureType = .performance_marker_info_intel,
    p_next: ?*const c_void = null,
    marker: u64,
};
pub const PerformanceStreamMarkerInfoINTEL = extern struct {
    s_type: StructureType = .performance_stream_marker_info_intel,
    p_next: ?*const c_void = null,
    marker: u32,
};
pub const PerformanceOverrideInfoINTEL = extern struct {
    s_type: StructureType = .performance_override_info_intel,
    p_next: ?*const c_void = null,
    @"type": PerformanceOverrideTypeINTEL,
    enable: Bool32,
    parameter: u64,
};
pub const PerformanceConfigurationAcquireInfoINTEL = extern struct {
    s_type: StructureType = .performance_configuration_acquire_info_intel,
    p_next: ?*const c_void = null,
    @"type": PerformanceConfigurationTypeINTEL,
};
pub const PhysicalDeviceShaderClockFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_clock_features_khr,
    p_next: ?*c_void = null,
    shader_subgroup_clock: Bool32 = FALSE,
    shader_device_clock: Bool32 = FALSE,
};
pub const PhysicalDeviceIndexTypeUint8FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_index_type_uint8_features_ext,
    p_next: ?*c_void = null,
    index_type_uint_8: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderSMBuiltinsPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_shader_sm_builtins_properties_nv,
    p_next: ?*c_void = null,
    shader_sm_count: u32,
    shader_warps_per_sm: u32,
};
pub const PhysicalDeviceShaderSMBuiltinsFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_shader_sm_builtins_features_nv,
    p_next: ?*c_void = null,
    shader_sm_builtins: Bool32 = FALSE,
};
pub const PhysicalDeviceFragmentShaderInterlockFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_fragment_shader_interlock_features_ext,
    p_next: ?*c_void = null,
    fragment_shader_sample_interlock: Bool32 = FALSE,
    fragment_shader_pixel_interlock: Bool32 = FALSE,
    fragment_shader_shading_rate_interlock: Bool32 = FALSE,
};
pub const PhysicalDeviceSeparateDepthStencilLayoutsFeatures = extern struct {
    s_type: StructureType = .physical_device_separate_depth_stencil_layouts_features,
    p_next: ?*c_void = null,
    separate_depth_stencil_layouts: Bool32 = FALSE,
};
pub const PhysicalDeviceSeparateDepthStencilLayoutsFeaturesKHR = PhysicalDeviceSeparateDepthStencilLayoutsFeatures;
pub const AttachmentReferenceStencilLayout = extern struct {
    s_type: StructureType = .attachment_reference_stencil_layout,
    p_next: ?*c_void = null,
    stencil_layout: ImageLayout,
};
pub const PhysicalDevicePrimitiveTopologyListRestartFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_primitive_topology_list_restart_features_ext,
    p_next: ?*c_void = null,
    primitive_topology_list_restart: Bool32 = FALSE,
    primitive_topology_patch_list_restart: Bool32 = FALSE,
};
pub const AttachmentReferenceStencilLayoutKHR = AttachmentReferenceStencilLayout;
pub const AttachmentDescriptionStencilLayout = extern struct {
    s_type: StructureType = .attachment_description_stencil_layout,
    p_next: ?*c_void = null,
    stencil_initial_layout: ImageLayout,
    stencil_final_layout: ImageLayout,
};
pub const AttachmentDescriptionStencilLayoutKHR = AttachmentDescriptionStencilLayout;
pub const PhysicalDevicePipelineExecutablePropertiesFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_pipeline_executable_properties_features_khr,
    p_next: ?*c_void = null,
    pipeline_executable_info: Bool32 = FALSE,
};
pub const PipelineInfoKHR = extern struct {
    s_type: StructureType = .pipeline_info_khr,
    p_next: ?*const c_void = null,
    pipeline: Pipeline,
};
pub const PipelineExecutablePropertiesKHR = extern struct {
    s_type: StructureType = .pipeline_executable_properties_khr,
    p_next: ?*c_void = null,
    stages: ShaderStageFlags,
    name: [MAX_DESCRIPTION_SIZE]u8,
    description: [MAX_DESCRIPTION_SIZE]u8,
    subgroup_size: u32,
};
pub const PipelineExecutableInfoKHR = extern struct {
    s_type: StructureType = .pipeline_executable_info_khr,
    p_next: ?*const c_void = null,
    pipeline: Pipeline,
    executable_index: u32,
};
pub const PipelineExecutableStatisticValueKHR = extern union {
    b_32: Bool32,
    i_64: i64,
    u_64: u64,
    f_64: f64,
};
pub const PipelineExecutableStatisticKHR = extern struct {
    s_type: StructureType = .pipeline_executable_statistic_khr,
    p_next: ?*c_void = null,
    name: [MAX_DESCRIPTION_SIZE]u8,
    description: [MAX_DESCRIPTION_SIZE]u8,
    format: PipelineExecutableStatisticFormatKHR,
    value: PipelineExecutableStatisticValueKHR,
};
pub const PipelineExecutableInternalRepresentationKHR = extern struct {
    s_type: StructureType = .pipeline_executable_internal_representation_khr,
    p_next: ?*c_void = null,
    name: [MAX_DESCRIPTION_SIZE]u8,
    description: [MAX_DESCRIPTION_SIZE]u8,
    is_text: Bool32,
    data_size: usize,
    p_data: ?*c_void,
};
pub const PhysicalDeviceShaderDemoteToHelperInvocationFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_demote_to_helper_invocation_features_ext,
    p_next: ?*c_void = null,
    shader_demote_to_helper_invocation: Bool32 = FALSE,
};
pub const PhysicalDeviceTexelBufferAlignmentFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_texel_buffer_alignment_features_ext,
    p_next: ?*c_void = null,
    texel_buffer_alignment: Bool32 = FALSE,
};
pub const PhysicalDeviceTexelBufferAlignmentPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_texel_buffer_alignment_properties_ext,
    p_next: ?*c_void = null,
    storage_texel_buffer_offset_alignment_bytes: DeviceSize,
    storage_texel_buffer_offset_single_texel_alignment: Bool32,
    uniform_texel_buffer_offset_alignment_bytes: DeviceSize,
    uniform_texel_buffer_offset_single_texel_alignment: Bool32,
};
pub const PhysicalDeviceSubgroupSizeControlFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_subgroup_size_control_features_ext,
    p_next: ?*c_void = null,
    subgroup_size_control: Bool32 = FALSE,
    compute_full_subgroups: Bool32 = FALSE,
};
pub const PhysicalDeviceSubgroupSizeControlPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_subgroup_size_control_properties_ext,
    p_next: ?*c_void = null,
    min_subgroup_size: u32,
    max_subgroup_size: u32,
    max_compute_workgroup_subgroups: u32,
    required_subgroup_size_stages: ShaderStageFlags,
};
pub const PipelineShaderStageRequiredSubgroupSizeCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_shader_stage_required_subgroup_size_create_info_ext,
    p_next: ?*c_void = null,
    required_subgroup_size: u32,
};
pub const SubpassShadingPipelineCreateInfoHUAWEI = extern struct {
    s_type: StructureType = .subpass_shading_pipeline_create_info_huawei,
    p_next: ?*c_void = null,
    render_pass: RenderPass,
    subpass: u32,
};
pub const PhysicalDeviceSubpassShadingPropertiesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_subpass_shading_properties_huawei,
    p_next: ?*c_void = null,
    max_subpass_shading_workgroup_size_aspect_ratio: u32,
};
pub const MemoryOpaqueCaptureAddressAllocateInfo = extern struct {
    s_type: StructureType = .memory_opaque_capture_address_allocate_info,
    p_next: ?*const c_void = null,
    opaque_capture_address: u64,
};
pub const MemoryOpaqueCaptureAddressAllocateInfoKHR = MemoryOpaqueCaptureAddressAllocateInfo;
pub const DeviceMemoryOpaqueCaptureAddressInfo = extern struct {
    s_type: StructureType = .device_memory_opaque_capture_address_info,
    p_next: ?*const c_void = null,
    memory: DeviceMemory,
};
pub const DeviceMemoryOpaqueCaptureAddressInfoKHR = DeviceMemoryOpaqueCaptureAddressInfo;
pub const PhysicalDeviceLineRasterizationFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_line_rasterization_features_ext,
    p_next: ?*c_void = null,
    rectangular_lines: Bool32 = FALSE,
    bresenham_lines: Bool32 = FALSE,
    smooth_lines: Bool32 = FALSE,
    stippled_rectangular_lines: Bool32 = FALSE,
    stippled_bresenham_lines: Bool32 = FALSE,
    stippled_smooth_lines: Bool32 = FALSE,
};
pub const PhysicalDeviceLineRasterizationPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_line_rasterization_properties_ext,
    p_next: ?*c_void = null,
    line_sub_pixel_precision_bits: u32,
};
pub const PipelineRasterizationLineStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_line_state_create_info_ext,
    p_next: ?*const c_void = null,
    line_rasterization_mode: LineRasterizationModeEXT,
    stippled_line_enable: Bool32,
    line_stipple_factor: u32,
    line_stipple_pattern: u16,
};
pub const PhysicalDevicePipelineCreationCacheControlFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_pipeline_creation_cache_control_features_ext,
    p_next: ?*c_void = null,
    pipeline_creation_cache_control: Bool32 = FALSE,
};
pub const PhysicalDeviceVulkan11Features = extern struct {
    s_type: StructureType = .physical_device_vulkan_1_1_features,
    p_next: ?*c_void = null,
    storage_buffer_16_bit_access: Bool32 = FALSE,
    uniform_and_storage_buffer_16_bit_access: Bool32 = FALSE,
    storage_push_constant_16: Bool32 = FALSE,
    storage_input_output_16: Bool32 = FALSE,
    multiview: Bool32 = FALSE,
    multiview_geometry_shader: Bool32 = FALSE,
    multiview_tessellation_shader: Bool32 = FALSE,
    variable_pointers_storage_buffer: Bool32 = FALSE,
    variable_pointers: Bool32 = FALSE,
    protected_memory: Bool32 = FALSE,
    sampler_ycbcr_conversion: Bool32 = FALSE,
    shader_draw_parameters: Bool32 = FALSE,
};
pub const PhysicalDeviceVulkan11Properties = extern struct {
    s_type: StructureType = .physical_device_vulkan_1_1_properties,
    p_next: ?*c_void = null,
    device_uuid: [UUID_SIZE]u8,
    driver_uuid: [UUID_SIZE]u8,
    device_luid: [LUID_SIZE]u8,
    device_node_mask: u32,
    device_luid_valid: Bool32,
    subgroup_size: u32,
    subgroup_supported_stages: ShaderStageFlags,
    subgroup_supported_operations: SubgroupFeatureFlags,
    subgroup_quad_operations_in_all_stages: Bool32,
    point_clipping_behavior: PointClippingBehavior,
    max_multiview_view_count: u32,
    max_multiview_instance_index: u32,
    protected_no_fault: Bool32,
    max_per_set_descriptors: u32,
    max_memory_allocation_size: DeviceSize,
};
pub const PhysicalDeviceVulkan12Features = extern struct {
    s_type: StructureType = .physical_device_vulkan_1_2_features,
    p_next: ?*c_void = null,
    sampler_mirror_clamp_to_edge: Bool32 = FALSE,
    draw_indirect_count: Bool32 = FALSE,
    storage_buffer_8_bit_access: Bool32 = FALSE,
    uniform_and_storage_buffer_8_bit_access: Bool32 = FALSE,
    storage_push_constant_8: Bool32 = FALSE,
    shader_buffer_int_64_atomics: Bool32 = FALSE,
    shader_shared_int_64_atomics: Bool32 = FALSE,
    shader_float_16: Bool32 = FALSE,
    shader_int_8: Bool32 = FALSE,
    descriptor_indexing: Bool32 = FALSE,
    shader_input_attachment_array_dynamic_indexing: Bool32 = FALSE,
    shader_uniform_texel_buffer_array_dynamic_indexing: Bool32 = FALSE,
    shader_storage_texel_buffer_array_dynamic_indexing: Bool32 = FALSE,
    shader_uniform_buffer_array_non_uniform_indexing: Bool32 = FALSE,
    shader_sampled_image_array_non_uniform_indexing: Bool32 = FALSE,
    shader_storage_buffer_array_non_uniform_indexing: Bool32 = FALSE,
    shader_storage_image_array_non_uniform_indexing: Bool32 = FALSE,
    shader_input_attachment_array_non_uniform_indexing: Bool32 = FALSE,
    shader_uniform_texel_buffer_array_non_uniform_indexing: Bool32 = FALSE,
    shader_storage_texel_buffer_array_non_uniform_indexing: Bool32 = FALSE,
    descriptor_binding_uniform_buffer_update_after_bind: Bool32 = FALSE,
    descriptor_binding_sampled_image_update_after_bind: Bool32 = FALSE,
    descriptor_binding_storage_image_update_after_bind: Bool32 = FALSE,
    descriptor_binding_storage_buffer_update_after_bind: Bool32 = FALSE,
    descriptor_binding_uniform_texel_buffer_update_after_bind: Bool32 = FALSE,
    descriptor_binding_storage_texel_buffer_update_after_bind: Bool32 = FALSE,
    descriptor_binding_update_unused_while_pending: Bool32 = FALSE,
    descriptor_binding_partially_bound: Bool32 = FALSE,
    descriptor_binding_variable_descriptor_count: Bool32 = FALSE,
    runtime_descriptor_array: Bool32 = FALSE,
    sampler_filter_minmax: Bool32 = FALSE,
    scalar_block_layout: Bool32 = FALSE,
    imageless_framebuffer: Bool32 = FALSE,
    uniform_buffer_standard_layout: Bool32 = FALSE,
    shader_subgroup_extended_types: Bool32 = FALSE,
    separate_depth_stencil_layouts: Bool32 = FALSE,
    host_query_reset: Bool32 = FALSE,
    timeline_semaphore: Bool32 = FALSE,
    buffer_device_address: Bool32 = FALSE,
    buffer_device_address_capture_replay: Bool32 = FALSE,
    buffer_device_address_multi_device: Bool32 = FALSE,
    vulkan_memory_model: Bool32 = FALSE,
    vulkan_memory_model_device_scope: Bool32 = FALSE,
    vulkan_memory_model_availability_visibility_chains: Bool32 = FALSE,
    shader_output_viewport_index: Bool32 = FALSE,
    shader_output_layer: Bool32 = FALSE,
    subgroup_broadcast_dynamic_id: Bool32 = FALSE,
};
pub const PhysicalDeviceVulkan12Properties = extern struct {
    s_type: StructureType = .physical_device_vulkan_1_2_properties,
    p_next: ?*c_void = null,
    driver_id: DriverId,
    driver_name: [MAX_DRIVER_NAME_SIZE]u8,
    driver_info: [MAX_DRIVER_INFO_SIZE]u8,
    conformance_version: ConformanceVersion,
    denorm_behavior_independence: ShaderFloatControlsIndependence,
    rounding_mode_independence: ShaderFloatControlsIndependence,
    shader_signed_zero_inf_nan_preserve_float_16: Bool32,
    shader_signed_zero_inf_nan_preserve_float_32: Bool32,
    shader_signed_zero_inf_nan_preserve_float_64: Bool32,
    shader_denorm_preserve_float_16: Bool32,
    shader_denorm_preserve_float_32: Bool32,
    shader_denorm_preserve_float_64: Bool32,
    shader_denorm_flush_to_zero_float_16: Bool32,
    shader_denorm_flush_to_zero_float_32: Bool32,
    shader_denorm_flush_to_zero_float_64: Bool32,
    shader_rounding_mode_rte_float_16: Bool32,
    shader_rounding_mode_rte_float_32: Bool32,
    shader_rounding_mode_rte_float_64: Bool32,
    shader_rounding_mode_rtz_float_16: Bool32,
    shader_rounding_mode_rtz_float_32: Bool32,
    shader_rounding_mode_rtz_float_64: Bool32,
    max_update_after_bind_descriptors_in_all_pools: u32,
    shader_uniform_buffer_array_non_uniform_indexing_native: Bool32,
    shader_sampled_image_array_non_uniform_indexing_native: Bool32,
    shader_storage_buffer_array_non_uniform_indexing_native: Bool32,
    shader_storage_image_array_non_uniform_indexing_native: Bool32,
    shader_input_attachment_array_non_uniform_indexing_native: Bool32,
    robust_buffer_access_update_after_bind: Bool32,
    quad_divergent_implicit_lod: Bool32,
    max_per_stage_descriptor_update_after_bind_samplers: u32,
    max_per_stage_descriptor_update_after_bind_uniform_buffers: u32,
    max_per_stage_descriptor_update_after_bind_storage_buffers: u32,
    max_per_stage_descriptor_update_after_bind_sampled_images: u32,
    max_per_stage_descriptor_update_after_bind_storage_images: u32,
    max_per_stage_descriptor_update_after_bind_input_attachments: u32,
    max_per_stage_update_after_bind_resources: u32,
    max_descriptor_set_update_after_bind_samplers: u32,
    max_descriptor_set_update_after_bind_uniform_buffers: u32,
    max_descriptor_set_update_after_bind_uniform_buffers_dynamic: u32,
    max_descriptor_set_update_after_bind_storage_buffers: u32,
    max_descriptor_set_update_after_bind_storage_buffers_dynamic: u32,
    max_descriptor_set_update_after_bind_sampled_images: u32,
    max_descriptor_set_update_after_bind_storage_images: u32,
    max_descriptor_set_update_after_bind_input_attachments: u32,
    supported_depth_resolve_modes: ResolveModeFlags,
    supported_stencil_resolve_modes: ResolveModeFlags,
    independent_resolve_none: Bool32,
    independent_resolve: Bool32,
    filter_minmax_single_component_formats: Bool32,
    filter_minmax_image_component_mapping: Bool32,
    max_timeline_semaphore_value_difference: u64,
    framebuffer_integer_color_sample_counts: SampleCountFlags,
};
pub const PipelineCompilerControlCreateInfoAMD = extern struct {
    s_type: StructureType = .pipeline_compiler_control_create_info_amd,
    p_next: ?*const c_void = null,
    compiler_control_flags: PipelineCompilerControlFlagsAMD,
};
pub const PhysicalDeviceCoherentMemoryFeaturesAMD = extern struct {
    s_type: StructureType = .physical_device_coherent_memory_features_amd,
    p_next: ?*c_void = null,
    device_coherent_memory: Bool32 = FALSE,
};
pub const PhysicalDeviceToolPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_tool_properties_ext,
    p_next: ?*c_void = null,
    name: [MAX_EXTENSION_NAME_SIZE]u8,
    version: [MAX_EXTENSION_NAME_SIZE]u8,
    purposes: ToolPurposeFlagsEXT,
    description: [MAX_DESCRIPTION_SIZE]u8,
    layer: [MAX_EXTENSION_NAME_SIZE]u8,
};
pub const SamplerCustomBorderColorCreateInfoEXT = extern struct {
    s_type: StructureType = .sampler_custom_border_color_create_info_ext,
    p_next: ?*const c_void = null,
    custom_border_color: ClearColorValue,
    format: Format,
};
pub const PhysicalDeviceCustomBorderColorPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_custom_border_color_properties_ext,
    p_next: ?*c_void = null,
    max_custom_border_color_samplers: u32,
};
pub const PhysicalDeviceCustomBorderColorFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_custom_border_color_features_ext,
    p_next: ?*c_void = null,
    custom_border_colors: Bool32 = FALSE,
    custom_border_color_without_format: Bool32 = FALSE,
};
pub const SamplerBorderColorComponentMappingCreateInfoEXT = extern struct {
    s_type: StructureType = .sampler_border_color_component_mapping_create_info_ext,
    p_next: ?*const c_void = null,
    components: ComponentMapping,
    srgb: Bool32,
};
pub const PhysicalDeviceBorderColorSwizzleFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_border_color_swizzle_features_ext,
    p_next: ?*c_void = null,
    border_color_swizzle: Bool32 = FALSE,
    border_color_swizzle_from_image: Bool32 = FALSE,
};
pub const DeviceOrHostAddressKHR = extern union {
    device_address: DeviceAddress,
    host_address: *c_void,
};
pub const DeviceOrHostAddressConstKHR = extern union {
    device_address: DeviceAddress,
    host_address: *const c_void,
};
pub const AccelerationStructureGeometryTrianglesDataKHR = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_triangles_data_khr,
    p_next: ?*const c_void = null,
    vertex_format: Format,
    vertex_data: DeviceOrHostAddressConstKHR,
    vertex_stride: DeviceSize,
    max_vertex: u32,
    index_type: IndexType,
    index_data: DeviceOrHostAddressConstKHR,
    transform_data: DeviceOrHostAddressConstKHR,
};
pub const AccelerationStructureGeometryAabbsDataKHR = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_aabbs_data_khr,
    p_next: ?*const c_void = null,
    data: DeviceOrHostAddressConstKHR,
    stride: DeviceSize,
};
pub const AccelerationStructureGeometryInstancesDataKHR = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_instances_data_khr,
    p_next: ?*const c_void = null,
    array_of_pointers: Bool32,
    data: DeviceOrHostAddressConstKHR,
};
pub const AccelerationStructureGeometryDataKHR = extern union {
    triangles: AccelerationStructureGeometryTrianglesDataKHR,
    aabbs: AccelerationStructureGeometryAabbsDataKHR,
    instances: AccelerationStructureGeometryInstancesDataKHR,
};
pub const AccelerationStructureGeometryKHR = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_khr,
    p_next: ?*const c_void = null,
    geometry_type: GeometryTypeKHR,
    geometry: AccelerationStructureGeometryDataKHR,
    flags: GeometryFlagsKHR,
};
pub const AccelerationStructureBuildGeometryInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_build_geometry_info_khr,
    p_next: ?*const c_void = null,
    @"type": AccelerationStructureTypeKHR,
    flags: BuildAccelerationStructureFlagsKHR,
    mode: BuildAccelerationStructureModeKHR,
    src_acceleration_structure: AccelerationStructureKHR,
    dst_acceleration_structure: AccelerationStructureKHR,
    geometry_count: u32,
    p_geometries: ?[*]const AccelerationStructureGeometryKHR,
    pp_geometries: ?[*]const [*]const AccelerationStructureGeometryKHR,
    scratch_data: DeviceOrHostAddressKHR,
};
pub const AccelerationStructureBuildRangeInfoKHR = extern struct {
    primitive_count: u32,
    primitive_offset: u32,
    first_vertex: u32,
    transform_offset: u32,
};
pub const AccelerationStructureCreateInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_create_info_khr,
    p_next: ?*const c_void = null,
    create_flags: AccelerationStructureCreateFlagsKHR,
    buffer: Buffer,
    offset: DeviceSize,
    size: DeviceSize,
    @"type": AccelerationStructureTypeKHR,
    device_address: DeviceAddress,
};
pub const AabbPositionsKHR = extern struct {
    min_x: f32,
    min_y: f32,
    min_z: f32,
    max_x: f32,
    max_y: f32,
    max_z: f32,
};
pub const AabbPositionsNV = AabbPositionsKHR;
pub const TransformMatrixKHR = extern struct {
    matrix: [3][4]f32,
};
pub const TransformMatrixNV = TransformMatrixKHR;
pub const AccelerationStructureInstanceKHR = packed struct {
    transform: TransformMatrixKHR,
    instance_custom_index: u24,
    mask: u8,
    instance_shader_binding_table_record_offset: u24,
    flags: u8, // GeometryInstanceFlagsKHR
    acceleration_structure_reference: u64,
};
pub const AccelerationStructureInstanceNV = AccelerationStructureInstanceKHR;
pub const AccelerationStructureDeviceAddressInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_device_address_info_khr,
    p_next: ?*const c_void = null,
    acceleration_structure: AccelerationStructureKHR,
};
pub const AccelerationStructureVersionInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_version_info_khr,
    p_next: ?*const c_void = null,
    p_version_data: [*]const u8,
};
pub const CopyAccelerationStructureInfoKHR = extern struct {
    s_type: StructureType = .copy_acceleration_structure_info_khr,
    p_next: ?*const c_void = null,
    src: AccelerationStructureKHR,
    dst: AccelerationStructureKHR,
    mode: CopyAccelerationStructureModeKHR,
};
pub const CopyAccelerationStructureToMemoryInfoKHR = extern struct {
    s_type: StructureType = .copy_acceleration_structure_to_memory_info_khr,
    p_next: ?*const c_void = null,
    src: AccelerationStructureKHR,
    dst: DeviceOrHostAddressKHR,
    mode: CopyAccelerationStructureModeKHR,
};
pub const CopyMemoryToAccelerationStructureInfoKHR = extern struct {
    s_type: StructureType = .copy_memory_to_acceleration_structure_info_khr,
    p_next: ?*const c_void = null,
    src: DeviceOrHostAddressConstKHR,
    dst: AccelerationStructureKHR,
    mode: CopyAccelerationStructureModeKHR,
};
pub const RayTracingPipelineInterfaceCreateInfoKHR = extern struct {
    s_type: StructureType = .ray_tracing_pipeline_interface_create_info_khr,
    p_next: ?*const c_void = null,
    max_pipeline_ray_payload_size: u32,
    max_pipeline_ray_hit_attribute_size: u32,
};
pub const PipelineLibraryCreateInfoKHR = extern struct {
    s_type: StructureType = .pipeline_library_create_info_khr,
    p_next: ?*const c_void = null,
    library_count: u32,
    p_libraries: [*]const Pipeline,
};
pub const PhysicalDeviceExtendedDynamicStateFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_extended_dynamic_state_features_ext,
    p_next: ?*c_void = null,
    extended_dynamic_state: Bool32 = FALSE,
};
pub const PhysicalDeviceExtendedDynamicState2FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_extended_dynamic_state_2_features_ext,
    p_next: ?*c_void = null,
    extended_dynamic_state_2: Bool32 = FALSE,
    extended_dynamic_state_2_logic_op: Bool32 = FALSE,
    extended_dynamic_state_2_patch_control_points: Bool32 = FALSE,
};
pub const RenderPassTransformBeginInfoQCOM = extern struct {
    s_type: StructureType = .render_pass_transform_begin_info_qcom,
    p_next: ?*c_void = null,
    transform: SurfaceTransformFlagsKHR,
};
pub const CopyCommandTransformInfoQCOM = extern struct {
    s_type: StructureType = .copy_command_transform_info_qcom,
    p_next: ?*const c_void = null,
    transform: SurfaceTransformFlagsKHR,
};
pub const CommandBufferInheritanceRenderPassTransformInfoQCOM = extern struct {
    s_type: StructureType = .command_buffer_inheritance_render_pass_transform_info_qcom,
    p_next: ?*c_void = null,
    transform: SurfaceTransformFlagsKHR,
    render_area: Rect2D,
};
pub const PhysicalDeviceDiagnosticsConfigFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_diagnostics_config_features_nv,
    p_next: ?*c_void = null,
    diagnostics_config: Bool32 = FALSE,
};
pub const DeviceDiagnosticsConfigCreateInfoNV = extern struct {
    s_type: StructureType = .device_diagnostics_config_create_info_nv,
    p_next: ?*const c_void = null,
    flags: DeviceDiagnosticsConfigFlagsNV,
};
pub const PhysicalDeviceZeroInitializeWorkgroupMemoryFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_zero_initialize_workgroup_memory_features_khr,
    p_next: ?*c_void = null,
    shader_zero_initialize_workgroup_memory: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderSubgroupUniformControlFlowFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_subgroup_uniform_control_flow_features_khr,
    p_next: ?*c_void = null,
    shader_subgroup_uniform_control_flow: Bool32 = FALSE,
};
pub const PhysicalDeviceRobustness2FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_robustness_2_features_ext,
    p_next: ?*c_void = null,
    robust_buffer_access_2: Bool32 = FALSE,
    robust_image_access_2: Bool32 = FALSE,
    null_descriptor: Bool32 = FALSE,
};
pub const PhysicalDeviceRobustness2PropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_robustness_2_properties_ext,
    p_next: ?*c_void = null,
    robust_storage_buffer_access_size_alignment: DeviceSize,
    robust_uniform_buffer_access_size_alignment: DeviceSize,
};
pub const PhysicalDeviceImageRobustnessFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_image_robustness_features_ext,
    p_next: ?*c_void = null,
    robust_image_access: Bool32 = FALSE,
};
pub const PhysicalDeviceWorkgroupMemoryExplicitLayoutFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_workgroup_memory_explicit_layout_features_khr,
    p_next: ?*c_void = null,
    workgroup_memory_explicit_layout: Bool32 = FALSE,
    workgroup_memory_explicit_layout_scalar_block_layout: Bool32 = FALSE,
    workgroup_memory_explicit_layout_8_bit_access: Bool32 = FALSE,
    workgroup_memory_explicit_layout_16_bit_access: Bool32 = FALSE,
};
pub const PhysicalDevicePortabilitySubsetFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_portability_subset_features_khr,
    p_next: ?*c_void = null,
    constant_alpha_color_blend_factors: Bool32 = FALSE,
    events: Bool32 = FALSE,
    image_view_format_reinterpretation: Bool32 = FALSE,
    image_view_format_swizzle: Bool32 = FALSE,
    image_view_2d_on_3d_image: Bool32 = FALSE,
    multisample_array_image: Bool32 = FALSE,
    mutable_comparison_samplers: Bool32 = FALSE,
    point_polygons: Bool32 = FALSE,
    sampler_mip_lod_bias: Bool32 = FALSE,
    separate_stencil_mask_ref: Bool32 = FALSE,
    shader_sample_rate_interpolation_functions: Bool32 = FALSE,
    tessellation_isolines: Bool32 = FALSE,
    tessellation_point_mode: Bool32 = FALSE,
    triangle_fans: Bool32 = FALSE,
    vertex_attribute_access_beyond_stride: Bool32 = FALSE,
};
pub const PhysicalDevicePortabilitySubsetPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_portability_subset_properties_khr,
    p_next: ?*c_void = null,
    min_vertex_input_binding_stride_alignment: u32,
};
pub const PhysicalDevice4444FormatsFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_4444_formats_features_ext,
    p_next: ?*c_void = null,
    format_a4r4g4b4: Bool32 = FALSE,
    format_a4b4g4r4: Bool32 = FALSE,
};
pub const PhysicalDeviceSubpassShadingFeaturesHUAWEI = extern struct {
    s_type: StructureType = .physical_device_subpass_shading_features_huawei,
    p_next: ?*c_void = null,
    subpass_shading: Bool32 = FALSE,
};
pub const BufferCopy2KHR = extern struct {
    s_type: StructureType = .buffer_copy_2_khr,
    p_next: ?*const c_void = null,
    src_offset: DeviceSize,
    dst_offset: DeviceSize,
    size: DeviceSize,
};
pub const ImageCopy2KHR = extern struct {
    s_type: StructureType = .image_copy_2_khr,
    p_next: ?*const c_void = null,
    src_subresource: ImageSubresourceLayers,
    src_offset: Offset3D,
    dst_subresource: ImageSubresourceLayers,
    dst_offset: Offset3D,
    extent: Extent3D,
};
pub const ImageBlit2KHR = extern struct {
    s_type: StructureType = .image_blit_2_khr,
    p_next: ?*const c_void = null,
    src_subresource: ImageSubresourceLayers,
    src_offsets: [2]Offset3D,
    dst_subresource: ImageSubresourceLayers,
    dst_offsets: [2]Offset3D,
};
pub const BufferImageCopy2KHR = extern struct {
    s_type: StructureType = .buffer_image_copy_2_khr,
    p_next: ?*const c_void = null,
    buffer_offset: DeviceSize,
    buffer_row_length: u32,
    buffer_image_height: u32,
    image_subresource: ImageSubresourceLayers,
    image_offset: Offset3D,
    image_extent: Extent3D,
};
pub const ImageResolve2KHR = extern struct {
    s_type: StructureType = .image_resolve_2_khr,
    p_next: ?*const c_void = null,
    src_subresource: ImageSubresourceLayers,
    src_offset: Offset3D,
    dst_subresource: ImageSubresourceLayers,
    dst_offset: Offset3D,
    extent: Extent3D,
};
pub const CopyBufferInfo2KHR = extern struct {
    s_type: StructureType = .copy_buffer_info_2_khr,
    p_next: ?*const c_void = null,
    src_buffer: Buffer,
    dst_buffer: Buffer,
    region_count: u32,
    p_regions: [*]const BufferCopy2KHR,
};
pub const CopyImageInfo2KHR = extern struct {
    s_type: StructureType = .copy_image_info_2_khr,
    p_next: ?*const c_void = null,
    src_image: Image,
    src_image_layout: ImageLayout,
    dst_image: Image,
    dst_image_layout: ImageLayout,
    region_count: u32,
    p_regions: [*]const ImageCopy2KHR,
};
pub const BlitImageInfo2KHR = extern struct {
    s_type: StructureType = .blit_image_info_2_khr,
    p_next: ?*const c_void = null,
    src_image: Image,
    src_image_layout: ImageLayout,
    dst_image: Image,
    dst_image_layout: ImageLayout,
    region_count: u32,
    p_regions: [*]const ImageBlit2KHR,
    filter: Filter,
};
pub const CopyBufferToImageInfo2KHR = extern struct {
    s_type: StructureType = .copy_buffer_to_image_info_2_khr,
    p_next: ?*const c_void = null,
    src_buffer: Buffer,
    dst_image: Image,
    dst_image_layout: ImageLayout,
    region_count: u32,
    p_regions: [*]const BufferImageCopy2KHR,
};
pub const CopyImageToBufferInfo2KHR = extern struct {
    s_type: StructureType = .copy_image_to_buffer_info_2_khr,
    p_next: ?*const c_void = null,
    src_image: Image,
    src_image_layout: ImageLayout,
    dst_buffer: Buffer,
    region_count: u32,
    p_regions: [*]const BufferImageCopy2KHR,
};
pub const ResolveImageInfo2KHR = extern struct {
    s_type: StructureType = .resolve_image_info_2_khr,
    p_next: ?*const c_void = null,
    src_image: Image,
    src_image_layout: ImageLayout,
    dst_image: Image,
    dst_image_layout: ImageLayout,
    region_count: u32,
    p_regions: [*]const ImageResolve2KHR,
};
pub const PhysicalDeviceShaderImageAtomicInt64FeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_shader_image_atomic_int64_features_ext,
    p_next: ?*c_void = null,
    shader_image_int_64_atomics: Bool32 = FALSE,
    sparse_image_int_64_atomics: Bool32 = FALSE,
};
pub const FragmentShadingRateAttachmentInfoKHR = extern struct {
    s_type: StructureType = .fragment_shading_rate_attachment_info_khr,
    p_next: ?*const c_void = null,
    p_fragment_shading_rate_attachment: ?*const AttachmentReference2,
    shading_rate_attachment_texel_size: Extent2D,
};
pub const PipelineFragmentShadingRateStateCreateInfoKHR = extern struct {
    s_type: StructureType = .pipeline_fragment_shading_rate_state_create_info_khr,
    p_next: ?*const c_void = null,
    fragment_size: Extent2D,
    combiner_ops: [2]FragmentShadingRateCombinerOpKHR,
};
pub const PhysicalDeviceFragmentShadingRateFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_features_khr,
    p_next: ?*c_void = null,
    pipeline_fragment_shading_rate: Bool32 = FALSE,
    primitive_fragment_shading_rate: Bool32 = FALSE,
    attachment_fragment_shading_rate: Bool32 = FALSE,
};
pub const PhysicalDeviceFragmentShadingRatePropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_properties_khr,
    p_next: ?*c_void = null,
    min_fragment_shading_rate_attachment_texel_size: Extent2D,
    max_fragment_shading_rate_attachment_texel_size: Extent2D,
    max_fragment_shading_rate_attachment_texel_size_aspect_ratio: u32,
    primitive_fragment_shading_rate_with_multiple_viewports: Bool32,
    layered_shading_rate_attachments: Bool32,
    fragment_shading_rate_non_trivial_combiner_ops: Bool32,
    max_fragment_size: Extent2D,
    max_fragment_size_aspect_ratio: u32,
    max_fragment_shading_rate_coverage_samples: u32,
    max_fragment_shading_rate_rasterization_samples: SampleCountFlags,
    fragment_shading_rate_with_shader_depth_stencil_writes: Bool32,
    fragment_shading_rate_with_sample_mask: Bool32,
    fragment_shading_rate_with_shader_sample_mask: Bool32,
    fragment_shading_rate_with_conservative_rasterization: Bool32,
    fragment_shading_rate_with_fragment_shader_interlock: Bool32,
    fragment_shading_rate_with_custom_sample_locations: Bool32,
    fragment_shading_rate_strict_multiply_combiner: Bool32,
};
pub const PhysicalDeviceFragmentShadingRateKHR = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_khr,
    p_next: ?*c_void = null,
    sample_counts: SampleCountFlags,
    fragment_size: Extent2D,
};
pub const PhysicalDeviceShaderTerminateInvocationFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_terminate_invocation_features_khr,
    p_next: ?*c_void = null,
    shader_terminate_invocation: Bool32 = FALSE,
};
pub const PhysicalDeviceFragmentShadingRateEnumsFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_enums_features_nv,
    p_next: ?*c_void = null,
    fragment_shading_rate_enums: Bool32 = FALSE,
    supersample_fragment_shading_rates: Bool32 = FALSE,
    no_invocation_fragment_shading_rates: Bool32 = FALSE,
};
pub const PhysicalDeviceFragmentShadingRateEnumsPropertiesNV = extern struct {
    s_type: StructureType = .physical_device_fragment_shading_rate_enums_properties_nv,
    p_next: ?*c_void = null,
    max_fragment_shading_rate_invocation_count: SampleCountFlags,
};
pub const PipelineFragmentShadingRateEnumStateCreateInfoNV = extern struct {
    s_type: StructureType = .pipeline_fragment_shading_rate_enum_state_create_info_nv,
    p_next: ?*const c_void = null,
    shading_rate_type: FragmentShadingRateTypeNV,
    shading_rate: FragmentShadingRateNV,
    combiner_ops: [2]FragmentShadingRateCombinerOpKHR,
};
pub const AccelerationStructureBuildSizesInfoKHR = extern struct {
    s_type: StructureType = .acceleration_structure_build_sizes_info_khr,
    p_next: ?*const c_void = null,
    acceleration_structure_size: DeviceSize,
    update_scratch_size: DeviceSize,
    build_scratch_size: DeviceSize,
};
pub const PhysicalDeviceMutableDescriptorTypeFeaturesVALVE = extern struct {
    s_type: StructureType = .physical_device_mutable_descriptor_type_features_valve,
    p_next: ?*c_void = null,
    mutable_descriptor_type: Bool32 = FALSE,
};
pub const MutableDescriptorTypeListVALVE = extern struct {
    descriptor_type_count: u32,
    p_descriptor_types: [*]const DescriptorType,
};
pub const MutableDescriptorTypeCreateInfoVALVE = extern struct {
    s_type: StructureType = .mutable_descriptor_type_create_info_valve,
    p_next: ?*const c_void = null,
    mutable_descriptor_type_list_count: u32,
    p_mutable_descriptor_type_lists: [*]const MutableDescriptorTypeListVALVE,
};
pub const PhysicalDeviceVertexInputDynamicStateFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_vertex_input_dynamic_state_features_ext,
    p_next: ?*c_void = null,
    vertex_input_dynamic_state: Bool32 = FALSE,
};
pub const PhysicalDeviceExternalMemoryRDMAFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_external_memory_rdma_features_nv,
    p_next: ?*c_void = null,
    external_memory_rdma: Bool32 = FALSE,
};
pub const VertexInputBindingDescription2EXT = extern struct {
    s_type: StructureType = .vertex_input_binding_description_2_ext,
    p_next: ?*c_void = null,
    binding: u32,
    stride: u32,
    input_rate: VertexInputRate,
    divisor: u32,
};
pub const VertexInputAttributeDescription2EXT = extern struct {
    s_type: StructureType = .vertex_input_attribute_description_2_ext,
    p_next: ?*c_void = null,
    location: u32,
    binding: u32,
    format: Format,
    offset: u32,
};
pub const PhysicalDeviceColorWriteEnableFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_color_write_enable_features_ext,
    p_next: ?*c_void = null,
    color_write_enable: Bool32 = FALSE,
};
pub const PipelineColorWriteCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_color_write_create_info_ext,
    p_next: ?*const c_void = null,
    attachment_count: u32,
    p_color_write_enables: [*]const Bool32,
};
pub const MemoryBarrier2KHR = extern struct {
    s_type: StructureType = .memory_barrier_2_khr,
    p_next: ?*const c_void = null,
    src_stage_mask: PipelineStageFlags2KHR,
    src_access_mask: AccessFlags2KHR,
    dst_stage_mask: PipelineStageFlags2KHR,
    dst_access_mask: AccessFlags2KHR,
};
pub const ImageMemoryBarrier2KHR = extern struct {
    s_type: StructureType = .image_memory_barrier_2_khr,
    p_next: ?*const c_void = null,
    src_stage_mask: PipelineStageFlags2KHR,
    src_access_mask: AccessFlags2KHR,
    dst_stage_mask: PipelineStageFlags2KHR,
    dst_access_mask: AccessFlags2KHR,
    old_layout: ImageLayout,
    new_layout: ImageLayout,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    image: Image,
    subresource_range: ImageSubresourceRange,
};
pub const BufferMemoryBarrier2KHR = extern struct {
    s_type: StructureType = .buffer_memory_barrier_2_khr,
    p_next: ?*const c_void = null,
    src_stage_mask: PipelineStageFlags2KHR,
    src_access_mask: AccessFlags2KHR,
    dst_stage_mask: PipelineStageFlags2KHR,
    dst_access_mask: AccessFlags2KHR,
    src_queue_family_index: u32,
    dst_queue_family_index: u32,
    buffer: Buffer,
    offset: DeviceSize,
    size: DeviceSize,
};
pub const DependencyInfoKHR = extern struct {
    s_type: StructureType = .dependency_info_khr,
    p_next: ?*const c_void = null,
    dependency_flags: DependencyFlags,
    memory_barrier_count: u32,
    p_memory_barriers: [*]const MemoryBarrier2KHR,
    buffer_memory_barrier_count: u32,
    p_buffer_memory_barriers: [*]const BufferMemoryBarrier2KHR,
    image_memory_barrier_count: u32,
    p_image_memory_barriers: [*]const ImageMemoryBarrier2KHR,
};
pub const SemaphoreSubmitInfoKHR = extern struct {
    s_type: StructureType = .semaphore_submit_info_khr,
    p_next: ?*const c_void = null,
    semaphore: Semaphore,
    value: u64,
    stage_mask: PipelineStageFlags2KHR,
    device_index: u32,
};
pub const CommandBufferSubmitInfoKHR = extern struct {
    s_type: StructureType = .command_buffer_submit_info_khr,
    p_next: ?*const c_void = null,
    command_buffer: CommandBuffer,
    device_mask: u32,
};
pub const SubmitInfo2KHR = extern struct {
    s_type: StructureType = .submit_info_2_khr,
    p_next: ?*const c_void = null,
    flags: SubmitFlagsKHR,
    wait_semaphore_info_count: u32,
    p_wait_semaphore_infos: [*]const SemaphoreSubmitInfoKHR,
    command_buffer_info_count: u32,
    p_command_buffer_infos: [*]const CommandBufferSubmitInfoKHR,
    signal_semaphore_info_count: u32,
    p_signal_semaphore_infos: [*]const SemaphoreSubmitInfoKHR,
};
pub const QueueFamilyCheckpointProperties2NV = extern struct {
    s_type: StructureType = .queue_family_checkpoint_properties_2_nv,
    p_next: ?*c_void = null,
    checkpoint_execution_stage_mask: PipelineStageFlags2KHR,
};
pub const CheckpointData2NV = extern struct {
    s_type: StructureType = .checkpoint_data_2_nv,
    p_next: ?*c_void = null,
    stage: PipelineStageFlags2KHR,
    p_checkpoint_marker: *c_void,
};
pub const PhysicalDeviceSynchronization2FeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_synchronization_2_features_khr,
    p_next: ?*c_void = null,
    synchronization_2: Bool32 = FALSE,
};
pub const VideoQueueFamilyProperties2KHR = extern struct {
    s_type: StructureType = .video_queue_family_properties_2_khr,
    p_next: ?*c_void = null,
    video_codec_operations: VideoCodecOperationFlagsKHR,
};
pub const VideoProfilesKHR = extern struct {
    s_type: StructureType = .video_profiles_khr,
    p_next: ?*c_void = null,
    profile_count: u32,
    p_profiles: *const VideoProfileKHR,
};
pub const PhysicalDeviceVideoFormatInfoKHR = extern struct {
    s_type: StructureType = .physical_device_video_format_info_khr,
    p_next: ?*c_void = null,
    image_usage: ImageUsageFlags,
    p_video_profiles: *const VideoProfilesKHR,
};
pub const VideoFormatPropertiesKHR = extern struct {
    s_type: StructureType = .video_format_properties_khr,
    p_next: ?*c_void = null,
    format: Format,
};
pub const VideoProfileKHR = extern struct {
    s_type: StructureType = .video_profile_khr,
    p_next: ?*c_void = null,
    video_codec_operation: VideoCodecOperationFlagsKHR,
    chroma_subsampling: VideoChromaSubsamplingFlagsKHR,
    luma_bit_depth: VideoComponentBitDepthFlagsKHR,
    chroma_bit_depth: VideoComponentBitDepthFlagsKHR,
};
pub const VideoCapabilitiesKHR = extern struct {
    s_type: StructureType = .video_capabilities_khr,
    p_next: ?*c_void = null,
    capability_flags: VideoCapabilityFlagsKHR,
    min_bitstream_buffer_offset_alignment: DeviceSize,
    min_bitstream_buffer_size_alignment: DeviceSize,
    video_picture_extent_granularity: Extent2D,
    min_extent: Extent2D,
    max_extent: Extent2D,
    max_reference_pictures_slots_count: u32,
    max_reference_pictures_active_count: u32,
};
pub const VideoGetMemoryPropertiesKHR = extern struct {
    s_type: StructureType = .video_get_memory_properties_khr,
    p_next: ?*const c_void = null,
    memory_bind_index: u32,
    p_memory_requirements: *MemoryRequirements2,
};
pub const VideoBindMemoryKHR = extern struct {
    s_type: StructureType = .video_bind_memory_khr,
    p_next: ?*const c_void = null,
    memory_bind_index: u32,
    memory: DeviceMemory,
    memory_offset: DeviceSize,
    memory_size: DeviceSize,
};
pub const VideoPictureResourceKHR = extern struct {
    s_type: StructureType = .video_picture_resource_khr,
    p_next: ?*const c_void = null,
    coded_offset: Offset2D,
    coded_extent: Extent2D,
    base_array_layer: u32,
    image_view_binding: ImageView,
};
pub const VideoReferenceSlotKHR = extern struct {
    s_type: StructureType = .video_reference_slot_khr,
    p_next: ?*const c_void = null,
    slot_index: i8,
    p_picture_resource: *const VideoPictureResourceKHR,
};
pub const VideoDecodeInfoKHR = extern struct {
    s_type: StructureType = .video_decode_info_khr,
    p_next: ?*const c_void = null,
    flags: VideoDecodeFlagsKHR,
    coded_offset: Offset2D,
    coded_extent: Extent2D,
    src_buffer: Buffer,
    src_buffer_offset: DeviceSize,
    src_buffer_range: DeviceSize,
    dst_picture_resource: VideoPictureResourceKHR,
    p_setup_reference_slot: *const VideoReferenceSlotKHR,
    reference_slot_count: u32,
    p_reference_slots: [*]const VideoReferenceSlotKHR,
};
pub const StdVideoH264ProfileIdc = if (@hasDecl(root, "StdVideoH264ProfileIdc")) root.StdVideoH264ProfileIdc else @compileError("Missing type definition of 'StdVideoH264ProfileIdc'");
pub const StdVideoH264Level = if (@hasDecl(root, "StdVideoH264Level")) root.StdVideoH264Level else @compileError("Missing type definition of 'StdVideoH264Level'");
pub const StdVideoH264ChromaFormatIdc = if (@hasDecl(root, "StdVideoH264ChromaFormatIdc")) root.StdVideoH264ChromaFormatIdc else @compileError("Missing type definition of 'StdVideoH264ChromaFormatIdc'");
pub const StdVideoH264PocType = if (@hasDecl(root, "StdVideoH264PocType")) root.StdVideoH264PocType else @compileError("Missing type definition of 'StdVideoH264PocType'");
pub const StdVideoH264SpsFlags = if (@hasDecl(root, "StdVideoH264SpsFlags")) root.StdVideoH264SpsFlags else @compileError("Missing type definition of 'StdVideoH264SpsFlags'");
pub const StdVideoH264ScalingLists = if (@hasDecl(root, "StdVideoH264ScalingLists")) root.StdVideoH264ScalingLists else @compileError("Missing type definition of 'StdVideoH264ScalingLists'");
pub const StdVideoH264SequenceParameterSetVui = if (@hasDecl(root, "StdVideoH264SequenceParameterSetVui")) root.StdVideoH264SequenceParameterSetVui else @compileError("Missing type definition of 'StdVideoH264SequenceParameterSetVui'");
pub const StdVideoH264AspectRatioIdc = if (@hasDecl(root, "StdVideoH264AspectRatioIdc")) root.StdVideoH264AspectRatioIdc else @compileError("Missing type definition of 'StdVideoH264AspectRatioIdc'");
pub const StdVideoH264HrdParameters = if (@hasDecl(root, "StdVideoH264HrdParameters")) root.StdVideoH264HrdParameters else @compileError("Missing type definition of 'StdVideoH264HrdParameters'");
pub const StdVideoH264SpsVuiFlags = if (@hasDecl(root, "StdVideoH264SpsVuiFlags")) root.StdVideoH264SpsVuiFlags else @compileError("Missing type definition of 'StdVideoH264SpsVuiFlags'");
pub const StdVideoH264WeightedBipredIdc = if (@hasDecl(root, "StdVideoH264WeightedBipredIdc")) root.StdVideoH264WeightedBipredIdc else @compileError("Missing type definition of 'StdVideoH264WeightedBipredIdc'");
pub const StdVideoH264PpsFlags = if (@hasDecl(root, "StdVideoH264PpsFlags")) root.StdVideoH264PpsFlags else @compileError("Missing type definition of 'StdVideoH264PpsFlags'");
pub const StdVideoH264SliceType = if (@hasDecl(root, "StdVideoH264SliceType")) root.StdVideoH264SliceType else @compileError("Missing type definition of 'StdVideoH264SliceType'");
pub const StdVideoH264CabacInitIdc = if (@hasDecl(root, "StdVideoH264CabacInitIdc")) root.StdVideoH264CabacInitIdc else @compileError("Missing type definition of 'StdVideoH264CabacInitIdc'");
pub const StdVideoH264DisableDeblockingFilterIdc = if (@hasDecl(root, "StdVideoH264DisableDeblockingFilterIdc")) root.StdVideoH264DisableDeblockingFilterIdc else @compileError("Missing type definition of 'StdVideoH264DisableDeblockingFilterIdc'");
pub const StdVideoH264PictureType = if (@hasDecl(root, "StdVideoH264PictureType")) root.StdVideoH264PictureType else @compileError("Missing type definition of 'StdVideoH264PictureType'");
pub const StdVideoH264ModificationOfPicNumsIdc = if (@hasDecl(root, "StdVideoH264ModificationOfPicNumsIdc")) root.StdVideoH264ModificationOfPicNumsIdc else @compileError("Missing type definition of 'StdVideoH264ModificationOfPicNumsIdc'");
pub const StdVideoH264MemMgmtControlOp = if (@hasDecl(root, "StdVideoH264MemMgmtControlOp")) root.StdVideoH264MemMgmtControlOp else @compileError("Missing type definition of 'StdVideoH264MemMgmtControlOp'");
pub const StdVideoDecodeH264PictureInfo = if (@hasDecl(root, "StdVideoDecodeH264PictureInfo")) root.StdVideoDecodeH264PictureInfo else @compileError("Missing type definition of 'StdVideoDecodeH264PictureInfo'");
pub const StdVideoDecodeH264ReferenceInfo = if (@hasDecl(root, "StdVideoDecodeH264ReferenceInfo")) root.StdVideoDecodeH264ReferenceInfo else @compileError("Missing type definition of 'StdVideoDecodeH264ReferenceInfo'");
pub const StdVideoDecodeH264Mvc = if (@hasDecl(root, "StdVideoDecodeH264Mvc")) root.StdVideoDecodeH264Mvc else @compileError("Missing type definition of 'StdVideoDecodeH264Mvc'");
pub const StdVideoDecodeH264PictureInfoFlags = if (@hasDecl(root, "StdVideoDecodeH264PictureInfoFlags")) root.StdVideoDecodeH264PictureInfoFlags else @compileError("Missing type definition of 'StdVideoDecodeH264PictureInfoFlags'");
pub const StdVideoDecodeH264ReferenceInfoFlags = if (@hasDecl(root, "StdVideoDecodeH264ReferenceInfoFlags")) root.StdVideoDecodeH264ReferenceInfoFlags else @compileError("Missing type definition of 'StdVideoDecodeH264ReferenceInfoFlags'");
pub const StdVideoDecodeH264MvcElement = if (@hasDecl(root, "StdVideoDecodeH264MvcElement")) root.StdVideoDecodeH264MvcElement else @compileError("Missing type definition of 'StdVideoDecodeH264MvcElement'");
pub const StdVideoDecodeH264MvcElementFlags = if (@hasDecl(root, "StdVideoDecodeH264MvcElementFlags")) root.StdVideoDecodeH264MvcElementFlags else @compileError("Missing type definition of 'StdVideoDecodeH264MvcElementFlags'");
pub const VideoDecodeH264ProfileEXT = extern struct {
    s_type: StructureType = .video_decode_h264_profile_ext,
    p_next: ?*const c_void = null,
    std_profile_idc: StdVideoH264ProfileIdc,
    picture_layout: VideoDecodeH264PictureLayoutFlagsEXT,
};
pub const VideoDecodeH264CapabilitiesEXT = extern struct {
    s_type: StructureType = .video_decode_h264_capabilities_ext,
    p_next: ?*c_void = null,
    max_level: u32,
    field_offset_granularity: Offset2D,
    std_extension_version: ExtensionProperties,
};
pub const VideoDecodeH264SessionCreateInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h264_session_create_info_ext,
    p_next: ?*const c_void = null,
    flags: VideoDecodeH264CreateFlagsEXT,
    p_std_extension_version: *const ExtensionProperties,
};
pub const StdVideoH264SequenceParameterSet = if (@hasDecl(root, "StdVideoH264SequenceParameterSet")) root.StdVideoH264SequenceParameterSet else @compileError("Missing type definition of 'StdVideoH264SequenceParameterSet'");
pub const StdVideoH264PictureParameterSet = if (@hasDecl(root, "StdVideoH264PictureParameterSet")) root.StdVideoH264PictureParameterSet else @compileError("Missing type definition of 'StdVideoH264PictureParameterSet'");
pub const VideoDecodeH264SessionParametersAddInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h264_session_parameters_add_info_ext,
    p_next: ?*const c_void = null,
    sps_std_count: u32,
    p_sps_std: ?[*]const StdVideoH264SequenceParameterSet,
    pps_std_count: u32,
    p_pps_std: ?[*]const StdVideoH264PictureParameterSet,
};
pub const VideoDecodeH264SessionParametersCreateInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h264_session_parameters_create_info_ext,
    p_next: ?*const c_void = null,
    max_sps_std_count: u32,
    max_pps_std_count: u32,
    p_parameters_add_info: ?*const VideoDecodeH264SessionParametersAddInfoEXT,
};
pub const VideoDecodeH264PictureInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h264_picture_info_ext,
    p_next: ?*const c_void = null,
    p_std_picture_info: *const StdVideoDecodeH264PictureInfo,
    slices_count: u32,
    p_slices_data_offsets: [*]const u32,
};
pub const VideoDecodeH264DpbSlotInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h264_dpb_slot_info_ext,
    p_next: ?*const c_void = null,
    p_std_reference_info: *const StdVideoDecodeH264ReferenceInfo,
};
pub const VideoDecodeH264MvcEXT = extern struct {
    s_type: StructureType = .video_decode_h264_mvc_ext,
    p_next: ?*const c_void = null,
    p_std_mvc: *const StdVideoDecodeH264Mvc,
};
pub const StdVideoH265ProfileIdc = if (@hasDecl(root, "StdVideoH265ProfileIdc")) root.StdVideoH265ProfileIdc else @compileError("Missing type definition of 'StdVideoH265ProfileIdc'");
pub const StdVideoH265VideoParameterSet = if (@hasDecl(root, "StdVideoH265VideoParameterSet")) root.StdVideoH265VideoParameterSet else @compileError("Missing type definition of 'StdVideoH265VideoParameterSet'");
pub const StdVideoH265SequenceParameterSet = if (@hasDecl(root, "StdVideoH265SequenceParameterSet")) root.StdVideoH265SequenceParameterSet else @compileError("Missing type definition of 'StdVideoH265SequenceParameterSet'");
pub const StdVideoH265PictureParameterSet = if (@hasDecl(root, "StdVideoH265PictureParameterSet")) root.StdVideoH265PictureParameterSet else @compileError("Missing type definition of 'StdVideoH265PictureParameterSet'");
pub const StdVideoH265DecPicBufMgr = if (@hasDecl(root, "StdVideoH265DecPicBufMgr")) root.StdVideoH265DecPicBufMgr else @compileError("Missing type definition of 'StdVideoH265DecPicBufMgr'");
pub const StdVideoH265HrdParameters = if (@hasDecl(root, "StdVideoH265HrdParameters")) root.StdVideoH265HrdParameters else @compileError("Missing type definition of 'StdVideoH265HrdParameters'");
pub const StdVideoH265VpsFlags = if (@hasDecl(root, "StdVideoH265VpsFlags")) root.StdVideoH265VpsFlags else @compileError("Missing type definition of 'StdVideoH265VpsFlags'");
pub const StdVideoH265Level = if (@hasDecl(root, "StdVideoH265Level")) root.StdVideoH265Level else @compileError("Missing type definition of 'StdVideoH265Level'");
pub const StdVideoH265SpsFlags = if (@hasDecl(root, "StdVideoH265SpsFlags")) root.StdVideoH265SpsFlags else @compileError("Missing type definition of 'StdVideoH265SpsFlags'");
pub const StdVideoH265ScalingLists = if (@hasDecl(root, "StdVideoH265ScalingLists")) root.StdVideoH265ScalingLists else @compileError("Missing type definition of 'StdVideoH265ScalingLists'");
pub const StdVideoH265SequenceParameterSetVui = if (@hasDecl(root, "StdVideoH265SequenceParameterSetVui")) root.StdVideoH265SequenceParameterSetVui else @compileError("Missing type definition of 'StdVideoH265SequenceParameterSetVui'");
pub const StdVideoH265PredictorPaletteEntries = if (@hasDecl(root, "StdVideoH265PredictorPaletteEntries")) root.StdVideoH265PredictorPaletteEntries else @compileError("Missing type definition of 'StdVideoH265PredictorPaletteEntries'");
pub const StdVideoH265PpsFlags = if (@hasDecl(root, "StdVideoH265PpsFlags")) root.StdVideoH265PpsFlags else @compileError("Missing type definition of 'StdVideoH265PpsFlags'");
pub const StdVideoH265SubLayerHrdParameters = if (@hasDecl(root, "StdVideoH265SubLayerHrdParameters")) root.StdVideoH265SubLayerHrdParameters else @compileError("Missing type definition of 'StdVideoH265SubLayerHrdParameters'");
pub const StdVideoH265HrdFlags = if (@hasDecl(root, "StdVideoH265HrdFlags")) root.StdVideoH265HrdFlags else @compileError("Missing type definition of 'StdVideoH265HrdFlags'");
pub const StdVideoH265SpsVuiFlags = if (@hasDecl(root, "StdVideoH265SpsVuiFlags")) root.StdVideoH265SpsVuiFlags else @compileError("Missing type definition of 'StdVideoH265SpsVuiFlags'");
pub const StdVideoH265SliceType = if (@hasDecl(root, "StdVideoH265SliceType")) root.StdVideoH265SliceType else @compileError("Missing type definition of 'StdVideoH265SliceType'");
pub const StdVideoH265PictureType = if (@hasDecl(root, "StdVideoH265PictureType")) root.StdVideoH265PictureType else @compileError("Missing type definition of 'StdVideoH265PictureType'");
pub const StdVideoDecodeH265PictureInfo = if (@hasDecl(root, "StdVideoDecodeH265PictureInfo")) root.StdVideoDecodeH265PictureInfo else @compileError("Missing type definition of 'StdVideoDecodeH265PictureInfo'");
pub const StdVideoDecodeH265ReferenceInfo = if (@hasDecl(root, "StdVideoDecodeH265ReferenceInfo")) root.StdVideoDecodeH265ReferenceInfo else @compileError("Missing type definition of 'StdVideoDecodeH265ReferenceInfo'");
pub const StdVideoDecodeH265PictureInfoFlags = if (@hasDecl(root, "StdVideoDecodeH265PictureInfoFlags")) root.StdVideoDecodeH265PictureInfoFlags else @compileError("Missing type definition of 'StdVideoDecodeH265PictureInfoFlags'");
pub const StdVideoDecodeH265ReferenceInfoFlags = if (@hasDecl(root, "StdVideoDecodeH265ReferenceInfoFlags")) root.StdVideoDecodeH265ReferenceInfoFlags else @compileError("Missing type definition of 'StdVideoDecodeH265ReferenceInfoFlags'");
pub const VideoDecodeH265ProfileEXT = extern struct {
    s_type: StructureType = .video_decode_h265_profile_ext,
    p_next: ?*const c_void = null,
    std_profile_idc: StdVideoH265ProfileIdc,
};
pub const VideoDecodeH265CapabilitiesEXT = extern struct {
    s_type: StructureType = .video_decode_h265_capabilities_ext,
    p_next: ?*c_void = null,
    max_level: u32,
    std_extension_version: ExtensionProperties,
};
pub const VideoDecodeH265SessionCreateInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h265_session_create_info_ext,
    p_next: ?*const c_void = null,
    flags: VideoDecodeH265CreateFlagsEXT,
    p_std_extension_version: *const ExtensionProperties,
};
pub const VideoDecodeH265SessionParametersAddInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h265_session_parameters_add_info_ext,
    p_next: ?*const c_void = null,
    sps_std_count: u32,
    p_sps_std: ?[*]const StdVideoH265SequenceParameterSet,
    pps_std_count: u32,
    p_pps_std: ?[*]const StdVideoH265PictureParameterSet,
};
pub const VideoDecodeH265SessionParametersCreateInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h265_session_parameters_create_info_ext,
    p_next: ?*const c_void = null,
    max_sps_std_count: u32,
    max_pps_std_count: u32,
    p_parameters_add_info: ?*const VideoDecodeH265SessionParametersAddInfoEXT,
};
pub const VideoDecodeH265PictureInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h265_picture_info_ext,
    p_next: ?*const c_void = null,
    p_std_picture_info: *StdVideoDecodeH265PictureInfo,
    slices_count: u32,
    p_slices_data_offsets: [*]const u32,
};
pub const VideoDecodeH265DpbSlotInfoEXT = extern struct {
    s_type: StructureType = .video_decode_h265_dpb_slot_info_ext,
    p_next: ?*const c_void = null,
    p_std_reference_info: *const StdVideoDecodeH265ReferenceInfo,
};
pub const VideoSessionCreateInfoKHR = extern struct {
    s_type: StructureType = .video_session_create_info_khr,
    p_next: ?*const c_void = null,
    queue_family_index: u32,
    flags: VideoSessionCreateFlagsKHR,
    p_video_profile: *const VideoProfileKHR,
    picture_format: Format,
    max_coded_extent: Extent2D,
    reference_pictures_format: Format,
    max_reference_pictures_slots_count: u32,
    max_reference_pictures_active_count: u32,
};
pub const VideoSessionParametersCreateInfoKHR = extern struct {
    s_type: StructureType = .video_session_parameters_create_info_khr,
    p_next: ?*const c_void = null,
    video_session_parameters_template: VideoSessionParametersKHR,
    video_session: VideoSessionKHR,
};
pub const VideoSessionParametersUpdateInfoKHR = extern struct {
    s_type: StructureType = .video_session_parameters_update_info_khr,
    p_next: ?*const c_void = null,
    update_sequence_count: u32,
};
pub const VideoBeginCodingInfoKHR = extern struct {
    s_type: StructureType = .video_begin_coding_info_khr,
    p_next: ?*const c_void = null,
    flags: VideoBeginCodingFlagsKHR,
    codec_quality_preset: VideoCodingQualityPresetFlagsKHR,
    video_session: VideoSessionKHR,
    video_session_parameters: VideoSessionParametersKHR,
    reference_slot_count: u32,
    p_reference_slots: [*]const VideoReferenceSlotKHR,
};
pub const VideoEndCodingInfoKHR = extern struct {
    s_type: StructureType = .video_end_coding_info_khr,
    p_next: ?*const c_void = null,
    flags: VideoEndCodingFlagsKHR,
};
pub const VideoCodingControlInfoKHR = extern struct {
    s_type: StructureType = .video_coding_control_info_khr,
    p_next: ?*const c_void = null,
    flags: VideoCodingControlFlagsKHR,
};
pub const VideoEncodeInfoKHR = extern struct {
    s_type: StructureType = .video_encode_info_khr,
    p_next: ?*const c_void = null,
    flags: VideoEncodeFlagsKHR,
    quality_level: u32,
    coded_extent: Extent2D,
    dst_bitstream_buffer: Buffer,
    dst_bitstream_buffer_offset: DeviceSize,
    dst_bitstream_buffer_max_range: DeviceSize,
    src_picture_resource: VideoPictureResourceKHR,
    p_setup_reference_slot: *const VideoReferenceSlotKHR,
    reference_slot_count: u32,
    p_reference_slots: [*]const VideoReferenceSlotKHR,
};
pub const VideoEncodeRateControlInfoKHR = extern struct {
    s_type: StructureType = .video_encode_rate_control_info_khr,
    p_next: ?*const c_void = null,
    flags: VideoEncodeRateControlFlagsKHR,
    rate_control_mode: VideoEncodeRateControlModeFlagsKHR,
    average_bitrate: u32,
    peak_to_average_bitrate_ratio: u16,
    frame_rate_numerator: u16,
    frame_rate_denominator: u16,
    virtual_buffer_size_in_ms: u32,
};
pub const VideoEncodeH264CapabilitiesEXT = extern struct {
    s_type: StructureType = .video_encode_h264_capabilities_ext,
    p_next: ?*const c_void = null,
    flags: VideoEncodeH264CapabilityFlagsEXT,
    input_mode_flags: VideoEncodeH264InputModeFlagsEXT,
    output_mode_flags: VideoEncodeH264OutputModeFlagsEXT,
    min_picture_size_in_mbs: Extent2D,
    max_picture_size_in_mbs: Extent2D,
    input_image_data_alignment: Extent2D,
    max_num_l0_reference_for_p: u8,
    max_num_l0_reference_for_b: u8,
    max_num_l1_reference: u8,
    quality_level_count: u8,
    std_extension_version: ExtensionProperties,
};
pub const VideoEncodeH264SessionCreateInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h264_session_create_info_ext,
    p_next: ?*const c_void = null,
    flags: VideoEncodeH264CreateFlagsEXT,
    max_picture_size_in_mbs: Extent2D,
    p_std_extension_version: *const ExtensionProperties,
};
pub const StdVideoEncodeH264SliceHeader = if (@hasDecl(root, "StdVideoEncodeH264SliceHeader")) root.StdVideoEncodeH264SliceHeader else @compileError("Missing type definition of 'StdVideoEncodeH264SliceHeader'");
pub const StdVideoEncodeH264PictureInfo = if (@hasDecl(root, "StdVideoEncodeH264PictureInfo")) root.StdVideoEncodeH264PictureInfo else @compileError("Missing type definition of 'StdVideoEncodeH264PictureInfo'");
pub const StdVideoEncodeH264SliceHeaderFlags = if (@hasDecl(root, "StdVideoEncodeH264SliceHeaderFlags")) root.StdVideoEncodeH264SliceHeaderFlags else @compileError("Missing type definition of 'StdVideoEncodeH264SliceHeaderFlags'");
pub const StdVideoEncodeH264RefMemMgmtCtrlOperations = if (@hasDecl(root, "StdVideoEncodeH264RefMemMgmtCtrlOperations")) root.StdVideoEncodeH264RefMemMgmtCtrlOperations else @compileError("Missing type definition of 'StdVideoEncodeH264RefMemMgmtCtrlOperations'");
pub const StdVideoEncodeH264PictureInfoFlags = if (@hasDecl(root, "StdVideoEncodeH264PictureInfoFlags")) root.StdVideoEncodeH264PictureInfoFlags else @compileError("Missing type definition of 'StdVideoEncodeH264PictureInfoFlags'");
pub const StdVideoEncodeH264RefMgmtFlags = if (@hasDecl(root, "StdVideoEncodeH264RefMgmtFlags")) root.StdVideoEncodeH264RefMgmtFlags else @compileError("Missing type definition of 'StdVideoEncodeH264RefMgmtFlags'");
pub const StdVideoEncodeH264RefListModEntry = if (@hasDecl(root, "StdVideoEncodeH264RefListModEntry")) root.StdVideoEncodeH264RefListModEntry else @compileError("Missing type definition of 'StdVideoEncodeH264RefListModEntry'");
pub const StdVideoEncodeH264RefPicMarkingEntry = if (@hasDecl(root, "StdVideoEncodeH264RefPicMarkingEntry")) root.StdVideoEncodeH264RefPicMarkingEntry else @compileError("Missing type definition of 'StdVideoEncodeH264RefPicMarkingEntry'");
pub const VideoEncodeH264SessionParametersAddInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h264_session_parameters_add_info_ext,
    p_next: ?*const c_void = null,
    sps_std_count: u32,
    p_sps_std: ?[*]const StdVideoH264SequenceParameterSet,
    pps_std_count: u32,
    p_pps_std: ?[*]const StdVideoH264PictureParameterSet,
};
pub const VideoEncodeH264SessionParametersCreateInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h264_session_parameters_create_info_ext,
    p_next: ?*const c_void = null,
    max_sps_std_count: u32,
    max_pps_std_count: u32,
    p_parameters_add_info: ?*const VideoEncodeH264SessionParametersAddInfoEXT,
};
pub const VideoEncodeH264DpbSlotInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h264_dpb_slot_info_ext,
    p_next: ?*const c_void = null,
    slot_index: i8,
    p_std_picture_info: *const StdVideoEncodeH264PictureInfo,
};
pub const VideoEncodeH264VclFrameInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h264_vcl_frame_info_ext,
    p_next: ?*const c_void = null,
    ref_default_final_list_0_entry_count: u8,
    p_ref_default_final_list_0_entries: [*]const VideoEncodeH264DpbSlotInfoEXT,
    ref_default_final_list_1_entry_count: u8,
    p_ref_default_final_list_1_entries: [*]const VideoEncodeH264DpbSlotInfoEXT,
    nalu_slice_entry_count: u32,
    p_nalu_slice_entries: [*]const VideoEncodeH264NaluSliceEXT,
    p_current_picture_info: *const VideoEncodeH264DpbSlotInfoEXT,
};
pub const VideoEncodeH264EmitPictureParametersEXT = extern struct {
    s_type: StructureType = .video_encode_h264_emit_picture_parameters_ext,
    p_next: ?*const c_void = null,
    sps_id: u8,
    emit_sps_enable: Bool32,
    pps_id_entry_count: u32,
    pps_id_entries: [*]const u8,
};
pub const VideoEncodeH264ProfileEXT = extern struct {
    s_type: StructureType = .video_encode_h264_profile_ext,
    p_next: ?*const c_void = null,
    std_profile_idc: StdVideoH264ProfileIdc,
};
pub const VideoEncodeH264NaluSliceEXT = extern struct {
    s_type: StructureType = .video_encode_h264_nalu_slice_ext,
    p_next: ?*const c_void = null,
    p_slice_header_std: *const StdVideoEncodeH264SliceHeader,
    mb_count: u32,
    ref_final_list_0_entry_count: u8,
    p_ref_final_list_0_entries: [*]const VideoEncodeH264DpbSlotInfoEXT,
    ref_final_list_1_entry_count: u8,
    p_ref_final_list_1_entries: [*]const VideoEncodeH264DpbSlotInfoEXT,
    preceding_nalu_bytes: u32,
    min_qp: u8,
    max_qp: u8,
};
pub const VideoEncodeH265CapabilitiesEXT = extern struct {
    s_type: StructureType = .video_encode_h265_capabilities_ext,
    p_next: ?*const c_void = null,
    flags: VideoEncodeH265CapabilityFlagsEXT,
    input_mode_flags: VideoEncodeH265InputModeFlagsEXT,
    output_mode_flags: VideoEncodeH265OutputModeFlagsEXT,
    ctb_sizes: VideoEncodeH265CtbSizeFlagsEXT,
    input_image_data_alignment: Extent2D,
    max_num_l0_reference_for_p: u8,
    max_num_l0_reference_for_b: u8,
    max_num_l1_reference: u8,
    max_num_sub_layers: u8,
    quality_level_count: u8,
    std_extension_version: ExtensionProperties,
};
pub const VideoEncodeH265SessionCreateInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h265_session_create_info_ext,
    p_next: ?*const c_void = null,
    flags: VideoEncodeH265CreateFlagsEXT,
    p_std_extension_version: *const ExtensionProperties,
};
pub const StdVideoEncodeH265PictureInfoFlags = if (@hasDecl(root, "StdVideoEncodeH265PictureInfoFlags")) root.StdVideoEncodeH265PictureInfoFlags else @compileError("Missing type definition of 'StdVideoEncodeH265PictureInfoFlags'");
pub const StdVideoEncodeH265SliceSegmentHeader = if (@hasDecl(root, "StdVideoEncodeH265SliceSegmentHeader")) root.StdVideoEncodeH265SliceSegmentHeader else @compileError("Missing type definition of 'StdVideoEncodeH265SliceSegmentHeader'");
pub const StdVideoEncodeH265PictureInfo = if (@hasDecl(root, "StdVideoEncodeH265PictureInfo")) root.StdVideoEncodeH265PictureInfo else @compileError("Missing type definition of 'StdVideoEncodeH265PictureInfo'");
pub const StdVideoEncodeH265SliceHeader = if (@hasDecl(root, "StdVideoEncodeH265SliceHeader")) root.StdVideoEncodeH265SliceHeader else @compileError("Missing type definition of 'StdVideoEncodeH265SliceHeader'");
pub const StdVideoEncodeH265ReferenceInfo = if (@hasDecl(root, "StdVideoEncodeH265ReferenceInfo")) root.StdVideoEncodeH265ReferenceInfo else @compileError("Missing type definition of 'StdVideoEncodeH265ReferenceInfo'");
pub const StdVideoEncodeH265ReferenceModifications = if (@hasDecl(root, "StdVideoEncodeH265ReferenceModifications")) root.StdVideoEncodeH265ReferenceModifications else @compileError("Missing type definition of 'StdVideoEncodeH265ReferenceModifications'");
pub const StdVideoEncodeH265SliceHeaderFlags = if (@hasDecl(root, "StdVideoEncodeH265SliceHeaderFlags")) root.StdVideoEncodeH265SliceHeaderFlags else @compileError("Missing type definition of 'StdVideoEncodeH265SliceHeaderFlags'");
pub const StdVideoEncodeH265ReferenceInfoFlags = if (@hasDecl(root, "StdVideoEncodeH265ReferenceInfoFlags")) root.StdVideoEncodeH265ReferenceInfoFlags else @compileError("Missing type definition of 'StdVideoEncodeH265ReferenceInfoFlags'");
pub const StdVideoEncodeH265ReferenceModificationFlags = if (@hasDecl(root, "StdVideoEncodeH265ReferenceModificationFlags")) root.StdVideoEncodeH265ReferenceModificationFlags else @compileError("Missing type definition of 'StdVideoEncodeH265ReferenceModificationFlags'");
pub const VideoEncodeH265SessionParametersAddInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h265_session_parameters_add_info_ext,
    p_next: ?*const c_void = null,
    vps_std_count: u32,
    p_vps_std: ?[*]const StdVideoH265VideoParameterSet,
    sps_std_count: u32,
    p_sps_std: ?[*]const StdVideoH265SequenceParameterSet,
    pps_std_count: u32,
    p_pps_std: ?[*]const StdVideoH265PictureParameterSet,
};
pub const VideoEncodeH265SessionParametersCreateInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h265_session_parameters_create_info_ext,
    p_next: ?*const c_void = null,
    max_vps_std_count: u32,
    max_sps_std_count: u32,
    max_pps_std_count: u32,
    p_parameters_add_info: ?*const VideoEncodeH265SessionParametersAddInfoEXT,
};
pub const VideoEncodeH265VclFrameInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h265_vcl_frame_info_ext,
    p_next: ?*const c_void = null,
    p_reference_final_lists: ?*const VideoEncodeH265ReferenceListsEXT,
    nalu_slice_entry_count: u32,
    p_nalu_slice_entries: [*]const VideoEncodeH265NaluSliceEXT,
    p_current_picture_info: *const StdVideoEncodeH265PictureInfo,
};
pub const VideoEncodeH265EmitPictureParametersEXT = extern struct {
    s_type: StructureType = .video_encode_h265_emit_picture_parameters_ext,
    p_next: ?*const c_void = null,
    vps_id: u8,
    sps_id: u8,
    emit_vps_enable: Bool32,
    emit_sps_enable: Bool32,
    pps_id_entry_count: u32,
    pps_id_entries: [*]const u8,
};
pub const VideoEncodeH265NaluSliceEXT = extern struct {
    s_type: StructureType = .video_encode_h265_nalu_slice_ext,
    p_next: ?*const c_void = null,
    ctb_count: u32,
    p_reference_final_lists: ?*const VideoEncodeH265ReferenceListsEXT,
    p_slice_header_std: *const StdVideoEncodeH265SliceHeader,
};
pub const VideoEncodeH265ProfileEXT = extern struct {
    s_type: StructureType = .video_encode_h265_profile_ext,
    p_next: ?*const c_void = null,
    std_profile_idc: StdVideoH265ProfileIdc,
};
pub const VideoEncodeH265DpbSlotInfoEXT = extern struct {
    s_type: StructureType = .video_encode_h265_dpb_slot_info_ext,
    p_next: ?*const c_void = null,
    slot_index: i8,
    p_std_reference_info: *const StdVideoEncodeH265ReferenceInfo,
};
pub const VideoEncodeH265ReferenceListsEXT = extern struct {
    s_type: StructureType = .video_encode_h265_reference_lists_ext,
    p_next: ?*const c_void = null,
    reference_list_0_entry_count: u8,
    p_reference_list_0_entries: [*]const VideoEncodeH265DpbSlotInfoEXT,
    reference_list_1_entry_count: u8,
    p_reference_list_1_entries: [*]const VideoEncodeH265DpbSlotInfoEXT,
    p_reference_modifications: *const StdVideoEncodeH265ReferenceModifications,
};
pub const PhysicalDeviceInheritedViewportScissorFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_inherited_viewport_scissor_features_nv,
    p_next: ?*c_void = null,
    inherited_viewport_scissor_2d: Bool32 = FALSE,
};
pub const CommandBufferInheritanceViewportScissorInfoNV = extern struct {
    s_type: StructureType = .command_buffer_inheritance_viewport_scissor_info_nv,
    p_next: ?*const c_void = null,
    viewport_scissor_2d: Bool32,
    viewport_depth_count: u32,
    p_viewport_depths: *const Viewport,
};
pub const PhysicalDeviceYcbcr2Plane444FormatsFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_ycbcr_2_plane_444_formats_features_ext,
    p_next: ?*c_void = null,
    ycbcr_2plane_444_formats: Bool32 = FALSE,
};
pub const PhysicalDeviceProvokingVertexFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_provoking_vertex_features_ext,
    p_next: ?*c_void = null,
    provoking_vertex_last: Bool32 = FALSE,
    transform_feedback_preserves_provoking_vertex: Bool32 = FALSE,
};
pub const PhysicalDeviceProvokingVertexPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_provoking_vertex_properties_ext,
    p_next: ?*c_void = null,
    provoking_vertex_mode_per_pipeline: Bool32,
    transform_feedback_preserves_triangle_fan_provoking_vertex: Bool32,
};
pub const PipelineRasterizationProvokingVertexStateCreateInfoEXT = extern struct {
    s_type: StructureType = .pipeline_rasterization_provoking_vertex_state_create_info_ext,
    p_next: ?*const c_void = null,
    provoking_vertex_mode: ProvokingVertexModeEXT,
};
pub const CuModuleCreateInfoNVX = extern struct {
    s_type: StructureType = .cu_module_create_info_nvx,
    p_next: ?*const c_void = null,
    data_size: usize,
    p_data: *const c_void,
};
pub const CuFunctionCreateInfoNVX = extern struct {
    s_type: StructureType = .cu_function_create_info_nvx,
    p_next: ?*const c_void = null,
    module: CuModuleNVX,
    p_name: [*:0]const u8,
};
pub const CuLaunchInfoNVX = extern struct {
    s_type: StructureType = .cu_launch_info_nvx,
    p_next: ?*const c_void = null,
    function: CuFunctionNVX,
    grid_dim_x: u32,
    grid_dim_y: u32,
    grid_dim_z: u32,
    block_dim_x: u32,
    block_dim_y: u32,
    block_dim_z: u32,
    shared_mem_bytes: u32,
    param_count: usize,
    p_params: [*]const *const c_void,
    extra_count: usize,
    p_extras: [*]const *const c_void,
};
pub const PhysicalDeviceShaderIntegerDotProductFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_integer_dot_product_features_khr,
    p_next: ?*c_void = null,
    shader_integer_dot_product: Bool32 = FALSE,
};
pub const PhysicalDeviceShaderIntegerDotProductPropertiesKHR = extern struct {
    s_type: StructureType = .physical_device_shader_integer_dot_product_properties_khr,
    p_next: ?*c_void = null,
    integer_dot_product_8_bit_unsigned_accelerated: Bool32,
    integer_dot_product_8_bit_signed_accelerated: Bool32,
    integer_dot_product_8_bit_mixed_signedness_accelerated: Bool32,
    integer_dot_product_4x_8_bit_packed_unsigned_accelerated: Bool32,
    integer_dot_product_4x_8_bit_packed_signed_accelerated: Bool32,
    integer_dot_product_4x_8_bit_packed_mixed_signedness_accelerated: Bool32,
    integer_dot_product_16_bit_unsigned_accelerated: Bool32,
    integer_dot_product_16_bit_signed_accelerated: Bool32,
    integer_dot_product_16_bit_mixed_signedness_accelerated: Bool32,
    integer_dot_product_32_bit_unsigned_accelerated: Bool32,
    integer_dot_product_32_bit_signed_accelerated: Bool32,
    integer_dot_product_32_bit_mixed_signedness_accelerated: Bool32,
    integer_dot_product_64_bit_unsigned_accelerated: Bool32,
    integer_dot_product_64_bit_signed_accelerated: Bool32,
    integer_dot_product_64_bit_mixed_signedness_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_8_bit_unsigned_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_8_bit_signed_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_8_bit_mixed_signedness_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_4x_8_bit_packed_unsigned_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_4x_8_bit_packed_signed_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_4x_8_bit_packed_mixed_signedness_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_16_bit_unsigned_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_16_bit_signed_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_16_bit_mixed_signedness_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_32_bit_unsigned_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_32_bit_signed_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_32_bit_mixed_signedness_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_64_bit_unsigned_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_64_bit_signed_accelerated: Bool32,
    integer_dot_product_accumulating_saturating_64_bit_mixed_signedness_accelerated: Bool32,
};
pub const PhysicalDeviceDrmPropertiesEXT = extern struct {
    s_type: StructureType = .physical_device_drm_properties_ext,
    p_next: ?*c_void = null,
    has_primary: Bool32,
    has_render: Bool32,
    primary_major: i64,
    primary_minor: i64,
    render_major: i64,
    render_minor: i64,
};
pub const PhysicalDeviceRayTracingMotionBlurFeaturesNV = extern struct {
    s_type: StructureType = .physical_device_ray_tracing_motion_blur_features_nv,
    p_next: ?*c_void = null,
    ray_tracing_motion_blur: Bool32 = FALSE,
    ray_tracing_motion_blur_pipeline_trace_rays_indirect: Bool32 = FALSE,
};
pub const AccelerationStructureGeometryMotionTrianglesDataNV = extern struct {
    s_type: StructureType = .acceleration_structure_geometry_motion_triangles_data_nv,
    p_next: ?*const c_void = null,
    vertex_data: DeviceOrHostAddressConstKHR,
};
pub const AccelerationStructureMotionInfoNV = extern struct {
    s_type: StructureType = .acceleration_structure_motion_info_nv,
    p_next: ?*const c_void = null,
    max_instances: u32,
    flags: AccelerationStructureMotionInfoFlagsNV,
};
pub const SRTDataNV = extern struct {
    sx: f32,
    a: f32,
    b: f32,
    pvx: f32,
    sy: f32,
    c: f32,
    pvy: f32,
    sz: f32,
    pvz: f32,
    qx: f32,
    qy: f32,
    qz: f32,
    qw: f32,
    tx: f32,
    ty: f32,
    tz: f32,
};
pub const AccelerationStructureSRTMotionInstanceNV = packed struct {
    transform_t0: SRTDataNV,
    transform_t1: SRTDataNV,
    instance_custom_index: u24,
    mask: u8,
    instance_shader_binding_table_record_offset: u24,
    flags: u8, // GeometryInstanceFlagsKHR
    acceleration_structure_reference: u64,
};
pub const AccelerationStructureMatrixMotionInstanceNV = packed struct {
    transform_t0: TransformMatrixKHR,
    transform_t1: TransformMatrixKHR,
    instance_custom_index: u24,
    mask: u8,
    instance_shader_binding_table_record_offset: u24,
    flags: u8, // GeometryInstanceFlagsKHR
    acceleration_structure_reference: u64,
};
pub const AccelerationStructureMotionInstanceDataNV = extern union {
    static_instance: AccelerationStructureInstanceKHR,
    matrix_motion_instance: AccelerationStructureMatrixMotionInstanceNV,
    srt_motion_instance: AccelerationStructureSRTMotionInstanceNV,
};
pub const AccelerationStructureMotionInstanceNV = extern struct {
    @"type": AccelerationStructureMotionInstanceTypeNV,
    flags: AccelerationStructureMotionInstanceFlagsNV,
    data: AccelerationStructureMotionInstanceDataNV,
};
pub const RemoteAddressNV = *c_void;
pub const MemoryGetRemoteAddressInfoNV = extern struct {
    s_type: StructureType = .memory_get_remote_address_info_nv,
    p_next: ?*const c_void = null,
    memory: DeviceMemory,
    handle_type: ExternalMemoryHandleTypeFlags,
};
pub const ImportMemoryBufferCollectionFUCHSIA = extern struct {
    s_type: StructureType = .import_memory_buffer_collection_fuchsia,
    p_next: ?*const c_void = null,
    collection: BufferCollectionFUCHSIA,
    index: u32,
};
pub const BufferCollectionImageCreateInfoFUCHSIA = extern struct {
    s_type: StructureType = .buffer_collection_image_create_info_fuchsia,
    p_next: ?*const c_void = null,
    collection: BufferCollectionFUCHSIA,
    index: u32,
};
pub const BufferCollectionBufferCreateInfoFUCHSIA = extern struct {
    s_type: StructureType = .buffer_collection_buffer_create_info_fuchsia,
    p_next: ?*const c_void = null,
    collection: BufferCollectionFUCHSIA,
    index: u32,
};
pub const BufferCollectionCreateInfoFUCHSIA = extern struct {
    s_type: StructureType = .buffer_collection_create_info_fuchsia,
    p_next: ?*const c_void = null,
    collection_token: zx_handle_t,
};
pub const BufferCollectionPropertiesFUCHSIA = extern struct {
    s_type: StructureType = .buffer_collection_properties_fuchsia,
    p_next: ?*c_void = null,
    memory_type_bits: u32,
    buffer_count: u32,
    create_info_index: u32,
    sysmem_pixel_format: u64,
    format_features: FormatFeatureFlags,
    sysmem_color_space_index: SysmemColorSpaceFUCHSIA,
    sampler_ycbcr_conversion_components: ComponentMapping,
    suggested_ycbcr_model: SamplerYcbcrModelConversion,
    suggested_ycbcr_range: SamplerYcbcrRange,
    suggested_x_chroma_offset: ChromaLocation,
    suggested_y_chroma_offset: ChromaLocation,
};
pub const BufferConstraintsInfoFUCHSIA = extern struct {
    s_type: StructureType = .buffer_constraints_info_fuchsia,
    p_next: ?*const c_void = null,
    create_info: BufferCreateInfo,
    required_format_features: FormatFeatureFlags,
    buffer_collection_constraints: BufferCollectionConstraintsInfoFUCHSIA,
};
pub const SysmemColorSpaceFUCHSIA = extern struct {
    s_type: StructureType = .sysmem_color_space_fuchsia,
    p_next: ?*const c_void = null,
    color_space: u32,
};
pub const ImageFormatConstraintsInfoFUCHSIA = extern struct {
    s_type: StructureType = .image_format_constraints_info_fuchsia,
    p_next: ?*const c_void = null,
    image_create_info: ImageCreateInfo,
    required_format_features: FormatFeatureFlags,
    flags: ImageFormatConstraintsFlagsFUCHSIA,
    sysmem_pixel_format: u64,
    color_space_count: u32,
    p_color_spaces: *const SysmemColorSpaceFUCHSIA,
};
pub const ImageConstraintsInfoFUCHSIA = extern struct {
    s_type: StructureType = .image_constraints_info_fuchsia,
    p_next: ?*const c_void = null,
    format_constraints_count: u32,
    p_format_constraints: [*]const ImageFormatConstraintsInfoFUCHSIA,
    buffer_collection_constraints: BufferCollectionConstraintsInfoFUCHSIA,
    flags: ImageConstraintsInfoFlagsFUCHSIA,
};
pub const BufferCollectionConstraintsInfoFUCHSIA = extern struct {
    s_type: StructureType = .buffer_collection_constraints_info_fuchsia,
    p_next: ?*const c_void = null,
    min_buffer_count: u32,
    max_buffer_count: u32,
    min_buffer_count_for_camping: u32,
    min_buffer_count_for_dedicated_slack: u32,
    min_buffer_count_for_shared_slack: u32,
};
pub const PhysicalDeviceRGBA10X6FormatsFeaturesEXT = extern struct {
    s_type: StructureType = .physical_device_rgba10x6_formats_features_ext,
    p_next: ?*c_void = null,
    format_rgba_1_0x_6_without_y_cb_cr_sampler: Bool32 = FALSE,
};
pub const FormatProperties3KHR = extern struct {
    s_type: StructureType = .format_properties_3_khr,
    p_next: ?*c_void = null,
    linear_tiling_features: FormatFeatureFlags2KHR,
    optimal_tiling_features: FormatFeatureFlags2KHR,
    buffer_features: FormatFeatureFlags2KHR,
};
pub const DrmFormatModifierPropertiesList2EXT = extern struct {
    s_type: StructureType = .drm_format_modifier_properties_list_2_ext,
    p_next: ?*c_void = null,
    drm_format_modifier_count: u32,
    p_drm_format_modifier_properties: ?[*]DrmFormatModifierProperties2EXT,
};
pub const DrmFormatModifierProperties2EXT = extern struct {
    drm_format_modifier: u64,
    drm_format_modifier_plane_count: u32,
    drm_format_modifier_tiling_features: FormatFeatureFlags2KHR,
};
pub const AndroidHardwareBufferFormatProperties2ANDROID = extern struct {
    s_type: StructureType = .android_hardware_buffer_format_properties_2_android,
    p_next: ?*c_void = null,
    format: Format,
    external_format: u64,
    format_features: FormatFeatureFlags2KHR,
    sampler_ycbcr_conversion_components: ComponentMapping,
    suggested_ycbcr_model: SamplerYcbcrModelConversion,
    suggested_ycbcr_range: SamplerYcbcrRange,
    suggested_x_chroma_offset: ChromaLocation,
    suggested_y_chroma_offset: ChromaLocation,
};
pub const PipelineRenderingCreateInfoKHR = extern struct {
    s_type: StructureType = .pipeline_rendering_create_info_khr,
    p_next: ?*const c_void = null,
    view_mask: u32,
    color_attachment_count: u32,
    p_color_attachment_formats: [*]const Format,
    depth_attachment_format: Format,
    stencil_attachment_format: Format,
};
pub const RenderingInfoKHR = extern struct {
    s_type: StructureType = .rendering_info_khr,
    p_next: ?*const c_void = null,
    flags: RenderingFlagsKHR,
    render_area: Rect2D,
    layer_count: u32,
    view_mask: u32,
    color_attachment_count: u32,
    p_color_attachments: [*]const RenderingAttachmentInfoKHR,
    p_depth_attachment: ?*const RenderingAttachmentInfoKHR,
    p_stencil_attachment: ?*const RenderingAttachmentInfoKHR,
};
pub const RenderingAttachmentInfoKHR = extern struct {
    s_type: StructureType = .rendering_attachment_info_khr,
    p_next: ?*const c_void = null,
    image_view: ImageView,
    image_layout: ImageLayout,
    resolve_mode: ResolveModeFlags,
    resolve_image_view: ImageView,
    resolve_image_layout: ImageLayout,
    load_op: AttachmentLoadOp,
    store_op: AttachmentStoreOp,
    clear_value: ClearValue,
};
pub const RenderingFragmentShadingRateAttachmentInfoKHR = extern struct {
    s_type: StructureType = .rendering_fragment_shading_rate_attachment_info_khr,
    p_next: ?*const c_void = null,
    image_view: ImageView,
    image_layout: ImageLayout,
    shading_rate_attachment_texel_size: Extent2D,
};
pub const RenderingFragmentDensityMapAttachmentInfoEXT = extern struct {
    s_type: StructureType = .rendering_fragment_density_map_attachment_info_ext,
    p_next: ?*const c_void = null,
    image_view: ImageView,
    image_layout: ImageLayout,
};
pub const PhysicalDeviceDynamicRenderingFeaturesKHR = extern struct {
    s_type: StructureType = .physical_device_dynamic_rendering_features_khr,
    p_next: ?*c_void = null,
    dynamic_rendering: Bool32 = FALSE,
};
pub const CommandBufferInheritanceRenderingInfoKHR = extern struct {
    s_type: StructureType = .command_buffer_inheritance_rendering_info_khr,
    p_next: ?*const c_void = null,
    flags: RenderingFlagsKHR,
    view_mask: u32,
    color_attachment_count: u32,
    p_color_attachment_formats: [*]const Format,
    depth_attachment_format: Format,
    stencil_attachment_format: Format,
    rasterization_samples: SampleCountFlags,
};
pub const AttachmentSampleCountInfoAMD = extern struct {
    s_type: StructureType = .attachment_sample_count_info_amd,
    p_next: ?*const c_void = null,
    color_attachment_count: u32,
    p_color_attachment_samples: [*]const SampleCountFlags,
    depth_stencil_attachment_samples: SampleCountFlags,
};
pub const AttachmentSampleCountInfoNV = AttachmentSampleCountInfoAMD;
pub const MultiviewPerViewAttributesInfoNVX = extern struct {
    s_type: StructureType = .multiview_per_view_attributes_info_nvx,
    p_next: ?*const c_void = null,
    per_view_attributes: Bool32,
    per_view_attributes_position_x_only: Bool32,
};
pub const ImageLayout = enum(c_int) {
    @"undefined" = 0,
    general = 1,
    color_attachment_optimal = 2,
    depth_stencil_attachment_optimal = 3,
    depth_stencil_read_only_optimal = 4,
    shader_read_only_optimal = 5,
    transfer_src_optimal = 6,
    transfer_dst_optimal = 7,
    preinitialized = 8,
    depth_read_only_stencil_attachment_optimal = 1000117000,
    depth_attachment_stencil_read_only_optimal = 1000117001,
    depth_attachment_optimal = 1000241000,
    depth_read_only_optimal = 1000241001,
    stencil_attachment_optimal = 1000241002,
    stencil_read_only_optimal = 1000241003,
    present_src_khr = 1000001002,
    video_decode_dst_khr = 1000024000,
    video_decode_src_khr = 1000024001,
    video_decode_dpb_khr = 1000024002,
    shared_present_khr = 1000111000,
    fragment_density_map_optimal_ext = 1000218000,
    fragment_shading_rate_attachment_optimal_khr = 1000164003,
    video_encode_dst_khr = 1000299000,
    video_encode_src_khr = 1000299001,
    video_encode_dpb_khr = 1000299002,
    read_only_optimal_khr = 1000314000,
    attachment_optimal_khr = 1000314001,
    _,
    pub const depth_read_only_stencil_attachment_optimal_khr = ImageLayout.depth_read_only_stencil_attachment_optimal;
    pub const depth_attachment_stencil_read_only_optimal_khr = ImageLayout.depth_attachment_stencil_read_only_optimal;
    pub const shading_rate_optimal_nv = ImageLayout.fragment_shading_rate_attachment_optimal_khr;
    pub const depth_attachment_optimal_khr = ImageLayout.depth_attachment_optimal;
    pub const depth_read_only_optimal_khr = ImageLayout.depth_read_only_optimal;
    pub const stencil_attachment_optimal_khr = ImageLayout.stencil_attachment_optimal;
    pub const stencil_read_only_optimal_khr = ImageLayout.stencil_read_only_optimal;
};
pub const AttachmentLoadOp = enum(c_int) {
    load = 0,
    clear = 1,
    dont_care = 2,
    none_ext = 1000400000,
    _,
};
pub const AttachmentStoreOp = enum(c_int) {
    store = 0,
    dont_care = 1,
    none_khr = 1000301000,
    _,
    pub const none_qcom = AttachmentStoreOp.none_khr;
    pub const none_ext = AttachmentStoreOp.none_khr;
};
pub const ImageType = enum(c_int) {
    @"1d" = 0,
    @"2d" = 1,
    @"3d" = 2,
    _,
};
pub const ImageTiling = enum(c_int) {
    optimal = 0,
    linear = 1,
    drm_format_modifier_ext = 1000158000,
    _,
};
pub const ImageViewType = enum(c_int) {
    @"1d" = 0,
    @"2d" = 1,
    @"3d" = 2,
    cube = 3,
    @"1d_array" = 4,
    @"2d_array" = 5,
    cube_array = 6,
    _,
};
pub const CommandBufferLevel = enum(c_int) {
    primary = 0,
    secondary = 1,
    _,
};
pub const ComponentSwizzle = enum(c_int) {
    identity = 0,
    zero = 1,
    one = 2,
    r = 3,
    g = 4,
    b = 5,
    a = 6,
    _,
};
pub const DescriptorType = enum(c_int) {
    sampler = 0,
    combined_image_sampler = 1,
    sampled_image = 2,
    storage_image = 3,
    uniform_texel_buffer = 4,
    storage_texel_buffer = 5,
    uniform_buffer = 6,
    storage_buffer = 7,
    uniform_buffer_dynamic = 8,
    storage_buffer_dynamic = 9,
    input_attachment = 10,
    inline_uniform_block_ext = 1000138000,
    acceleration_structure_khr = 1000150000,
    acceleration_structure_nv = 1000165000,
    mutable_valve = 1000351000,
    _,
};
pub const QueryType = enum(c_int) {
    occlusion = 0,
    pipeline_statistics = 1,
    timestamp = 2,
    result_status_only_khr = 1000023000,
    transform_feedback_stream_ext = 1000028004,
    performance_query_khr = 1000116000,
    acceleration_structure_compacted_size_khr = 1000150000,
    acceleration_structure_serialization_size_khr = 1000150001,
    acceleration_structure_compacted_size_nv = 1000165000,
    performance_query_intel = 1000210000,
    video_encode_bitstream_buffer_range_khr = 1000299000,
    _,
};
pub const BorderColor = enum(c_int) {
    float_transparent_black = 0,
    int_transparent_black = 1,
    float_opaque_black = 2,
    int_opaque_black = 3,
    float_opaque_white = 4,
    int_opaque_white = 5,
    float_custom_ext = 1000287003,
    int_custom_ext = 1000287004,
    _,
};
pub const PipelineBindPoint = enum(c_int) {
    graphics = 0,
    compute = 1,
    ray_tracing_khr = 1000165000,
    subpass_shading_huawei = 1000369003,
    _,
    pub const ray_tracing_nv = PipelineBindPoint.ray_tracing_khr;
};
pub const PipelineCacheHeaderVersion = enum(c_int) {
    one = 1,
    _,
};
pub const PipelineCacheCreateFlags = packed struct {
    externally_synchronized_bit_ext: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(PipelineCacheCreateFlags, Flags);
};
pub const PrimitiveTopology = enum(c_int) {
    point_list = 0,
    line_list = 1,
    line_strip = 2,
    triangle_list = 3,
    triangle_strip = 4,
    triangle_fan = 5,
    line_list_with_adjacency = 6,
    line_strip_with_adjacency = 7,
    triangle_list_with_adjacency = 8,
    triangle_strip_with_adjacency = 9,
    patch_list = 10,
    _,
};
pub const SharingMode = enum(c_int) {
    exclusive = 0,
    concurrent = 1,
    _,
};
pub const IndexType = enum(c_int) {
    uint16 = 0,
    uint32 = 1,
    none_khr = 1000165000,
    uint8_ext = 1000265000,
    _,
    pub const none_nv = IndexType.none_khr;
};
pub const Filter = enum(c_int) {
    nearest = 0,
    linear = 1,
    cubic_img = 1000015000,
    _,
    pub const cubic_ext = Filter.cubic_img;
};
pub const SamplerMipmapMode = enum(c_int) {
    nearest = 0,
    linear = 1,
    _,
};
pub const SamplerAddressMode = enum(c_int) {
    repeat = 0,
    mirrored_repeat = 1,
    clamp_to_edge = 2,
    clamp_to_border = 3,
    mirror_clamp_to_edge = 4,
    _,
    pub const mirror_clamp_to_edge_khr = SamplerAddressMode.mirror_clamp_to_edge;
};
pub const CompareOp = enum(c_int) {
    never = 0,
    less = 1,
    equal = 2,
    less_or_equal = 3,
    greater = 4,
    not_equal = 5,
    greater_or_equal = 6,
    always = 7,
    _,
};
pub const PolygonMode = enum(c_int) {
    fill = 0,
    line = 1,
    point = 2,
    fill_rectangle_nv = 1000153000,
    _,
};
pub const FrontFace = enum(c_int) {
    counter_clockwise = 0,
    clockwise = 1,
    _,
};
pub const BlendFactor = enum(c_int) {
    zero = 0,
    one = 1,
    src_color = 2,
    one_minus_src_color = 3,
    dst_color = 4,
    one_minus_dst_color = 5,
    src_alpha = 6,
    one_minus_src_alpha = 7,
    dst_alpha = 8,
    one_minus_dst_alpha = 9,
    constant_color = 10,
    one_minus_constant_color = 11,
    constant_alpha = 12,
    one_minus_constant_alpha = 13,
    src_alpha_saturate = 14,
    src1_color = 15,
    one_minus_src1_color = 16,
    src1_alpha = 17,
    one_minus_src1_alpha = 18,
    _,
};
pub const BlendOp = enum(c_int) {
    add = 0,
    subtract = 1,
    reverse_subtract = 2,
    min = 3,
    max = 4,
    zero_ext = 1000148000,
    src_ext = 1000148001,
    dst_ext = 1000148002,
    src_over_ext = 1000148003,
    dst_over_ext = 1000148004,
    src_in_ext = 1000148005,
    dst_in_ext = 1000148006,
    src_out_ext = 1000148007,
    dst_out_ext = 1000148008,
    src_atop_ext = 1000148009,
    dst_atop_ext = 1000148010,
    xor_ext = 1000148011,
    multiply_ext = 1000148012,
    screen_ext = 1000148013,
    overlay_ext = 1000148014,
    darken_ext = 1000148015,
    lighten_ext = 1000148016,
    colordodge_ext = 1000148017,
    colorburn_ext = 1000148018,
    hardlight_ext = 1000148019,
    softlight_ext = 1000148020,
    difference_ext = 1000148021,
    exclusion_ext = 1000148022,
    invert_ext = 1000148023,
    invert_rgb_ext = 1000148024,
    lineardodge_ext = 1000148025,
    linearburn_ext = 1000148026,
    vividlight_ext = 1000148027,
    linearlight_ext = 1000148028,
    pinlight_ext = 1000148029,
    hardmix_ext = 1000148030,
    hsl_hue_ext = 1000148031,
    hsl_saturation_ext = 1000148032,
    hsl_color_ext = 1000148033,
    hsl_luminosity_ext = 1000148034,
    plus_ext = 1000148035,
    plus_clamped_ext = 1000148036,
    plus_clamped_alpha_ext = 1000148037,
    plus_darker_ext = 1000148038,
    minus_ext = 1000148039,
    minus_clamped_ext = 1000148040,
    contrast_ext = 1000148041,
    invert_ovg_ext = 1000148042,
    red_ext = 1000148043,
    green_ext = 1000148044,
    blue_ext = 1000148045,
    _,
};
pub const StencilOp = enum(c_int) {
    keep = 0,
    zero = 1,
    replace = 2,
    increment_and_clamp = 3,
    decrement_and_clamp = 4,
    invert = 5,
    increment_and_wrap = 6,
    decrement_and_wrap = 7,
    _,
};
pub const LogicOp = enum(c_int) {
    clear = 0,
    @"and" = 1,
    and_reverse = 2,
    copy = 3,
    and_inverted = 4,
    no_op = 5,
    xor = 6,
    @"or" = 7,
    nor = 8,
    equivalent = 9,
    invert = 10,
    or_reverse = 11,
    copy_inverted = 12,
    or_inverted = 13,
    nand = 14,
    set = 15,
    _,
};
pub const InternalAllocationType = enum(c_int) {
    executable = 0,
    _,
};
pub const SystemAllocationScope = enum(c_int) {
    command = 0,
    object = 1,
    cache = 2,
    device = 3,
    instance = 4,
    _,
};
pub const PhysicalDeviceType = enum(c_int) {
    other = 0,
    integrated_gpu = 1,
    discrete_gpu = 2,
    virtual_gpu = 3,
    cpu = 4,
    _,
};
pub const VertexInputRate = enum(c_int) {
    vertex = 0,
    instance = 1,
    _,
};
pub const Format = enum(c_int) {
    @"undefined" = 0,
    r4g4_unorm_pack8 = 1,
    r4g4b4a4_unorm_pack16 = 2,
    b4g4r4a4_unorm_pack16 = 3,
    r5g6b5_unorm_pack16 = 4,
    b5g6r5_unorm_pack16 = 5,
    r5g5b5a1_unorm_pack16 = 6,
    b5g5r5a1_unorm_pack16 = 7,
    a1r5g5b5_unorm_pack16 = 8,
    r8_unorm = 9,
    r8_snorm = 10,
    r8_uscaled = 11,
    r8_sscaled = 12,
    r8_uint = 13,
    r8_sint = 14,
    r8_srgb = 15,
    r8g8_unorm = 16,
    r8g8_snorm = 17,
    r8g8_uscaled = 18,
    r8g8_sscaled = 19,
    r8g8_uint = 20,
    r8g8_sint = 21,
    r8g8_srgb = 22,
    r8g8b8_unorm = 23,
    r8g8b8_snorm = 24,
    r8g8b8_uscaled = 25,
    r8g8b8_sscaled = 26,
    r8g8b8_uint = 27,
    r8g8b8_sint = 28,
    r8g8b8_srgb = 29,
    b8g8r8_unorm = 30,
    b8g8r8_snorm = 31,
    b8g8r8_uscaled = 32,
    b8g8r8_sscaled = 33,
    b8g8r8_uint = 34,
    b8g8r8_sint = 35,
    b8g8r8_srgb = 36,
    r8g8b8a8_unorm = 37,
    r8g8b8a8_snorm = 38,
    r8g8b8a8_uscaled = 39,
    r8g8b8a8_sscaled = 40,
    r8g8b8a8_uint = 41,
    r8g8b8a8_sint = 42,
    r8g8b8a8_srgb = 43,
    b8g8r8a8_unorm = 44,
    b8g8r8a8_snorm = 45,
    b8g8r8a8_uscaled = 46,
    b8g8r8a8_sscaled = 47,
    b8g8r8a8_uint = 48,
    b8g8r8a8_sint = 49,
    b8g8r8a8_srgb = 50,
    a8b8g8r8_unorm_pack32 = 51,
    a8b8g8r8_snorm_pack32 = 52,
    a8b8g8r8_uscaled_pack32 = 53,
    a8b8g8r8_sscaled_pack32 = 54,
    a8b8g8r8_uint_pack32 = 55,
    a8b8g8r8_sint_pack32 = 56,
    a8b8g8r8_srgb_pack32 = 57,
    a2r10g10b10_unorm_pack32 = 58,
    a2r10g10b10_snorm_pack32 = 59,
    a2r10g10b10_uscaled_pack32 = 60,
    a2r10g10b10_sscaled_pack32 = 61,
    a2r10g10b10_uint_pack32 = 62,
    a2r10g10b10_sint_pack32 = 63,
    a2b10g10r10_unorm_pack32 = 64,
    a2b10g10r10_snorm_pack32 = 65,
    a2b10g10r10_uscaled_pack32 = 66,
    a2b10g10r10_sscaled_pack32 = 67,
    a2b10g10r10_uint_pack32 = 68,
    a2b10g10r10_sint_pack32 = 69,
    r16_unorm = 70,
    r16_snorm = 71,
    r16_uscaled = 72,
    r16_sscaled = 73,
    r16_uint = 74,
    r16_sint = 75,
    r16_sfloat = 76,
    r16g16_unorm = 77,
    r16g16_snorm = 78,
    r16g16_uscaled = 79,
    r16g16_sscaled = 80,
    r16g16_uint = 81,
    r16g16_sint = 82,
    r16g16_sfloat = 83,
    r16g16b16_unorm = 84,
    r16g16b16_snorm = 85,
    r16g16b16_uscaled = 86,
    r16g16b16_sscaled = 87,
    r16g16b16_uint = 88,
    r16g16b16_sint = 89,
    r16g16b16_sfloat = 90,
    r16g16b16a16_unorm = 91,
    r16g16b16a16_snorm = 92,
    r16g16b16a16_uscaled = 93,
    r16g16b16a16_sscaled = 94,
    r16g16b16a16_uint = 95,
    r16g16b16a16_sint = 96,
    r16g16b16a16_sfloat = 97,
    r32_uint = 98,
    r32_sint = 99,
    r32_sfloat = 100,
    r32g32_uint = 101,
    r32g32_sint = 102,
    r32g32_sfloat = 103,
    r32g32b32_uint = 104,
    r32g32b32_sint = 105,
    r32g32b32_sfloat = 106,
    r32g32b32a32_uint = 107,
    r32g32b32a32_sint = 108,
    r32g32b32a32_sfloat = 109,
    r64_uint = 110,
    r64_sint = 111,
    r64_sfloat = 112,
    r64g64_uint = 113,
    r64g64_sint = 114,
    r64g64_sfloat = 115,
    r64g64b64_uint = 116,
    r64g64b64_sint = 117,
    r64g64b64_sfloat = 118,
    r64g64b64a64_uint = 119,
    r64g64b64a64_sint = 120,
    r64g64b64a64_sfloat = 121,
    b10g11r11_ufloat_pack32 = 122,
    e5b9g9r9_ufloat_pack32 = 123,
    d16_unorm = 124,
    x8_d24_unorm_pack32 = 125,
    d32_sfloat = 126,
    s8_uint = 127,
    d16_unorm_s8_uint = 128,
    d24_unorm_s8_uint = 129,
    d32_sfloat_s8_uint = 130,
    bc1_rgb_unorm_block = 131,
    bc1_rgb_srgb_block = 132,
    bc1_rgba_unorm_block = 133,
    bc1_rgba_srgb_block = 134,
    bc2_unorm_block = 135,
    bc2_srgb_block = 136,
    bc3_unorm_block = 137,
    bc3_srgb_block = 138,
    bc4_unorm_block = 139,
    bc4_snorm_block = 140,
    bc5_unorm_block = 141,
    bc5_snorm_block = 142,
    bc6h_ufloat_block = 143,
    bc6h_sfloat_block = 144,
    bc7_unorm_block = 145,
    bc7_srgb_block = 146,
    etc2_r8g8b8_unorm_block = 147,
    etc2_r8g8b8_srgb_block = 148,
    etc2_r8g8b8a1_unorm_block = 149,
    etc2_r8g8b8a1_srgb_block = 150,
    etc2_r8g8b8a8_unorm_block = 151,
    etc2_r8g8b8a8_srgb_block = 152,
    eac_r11_unorm_block = 153,
    eac_r11_snorm_block = 154,
    eac_r11g11_unorm_block = 155,
    eac_r11g11_snorm_block = 156,
    astc_4x_4_unorm_block = 157,
    astc_4x_4_srgb_block = 158,
    astc_5x_4_unorm_block = 159,
    astc_5x_4_srgb_block = 160,
    astc_5x_5_unorm_block = 161,
    astc_5x_5_srgb_block = 162,
    astc_6x_5_unorm_block = 163,
    astc_6x_5_srgb_block = 164,
    astc_6x_6_unorm_block = 165,
    astc_6x_6_srgb_block = 166,
    astc_8x_5_unorm_block = 167,
    astc_8x_5_srgb_block = 168,
    astc_8x_6_unorm_block = 169,
    astc_8x_6_srgb_block = 170,
    astc_8x_8_unorm_block = 171,
    astc_8x_8_srgb_block = 172,
    astc_1_0x_5_unorm_block = 173,
    astc_1_0x_5_srgb_block = 174,
    astc_1_0x_6_unorm_block = 175,
    astc_1_0x_6_srgb_block = 176,
    astc_1_0x_8_unorm_block = 177,
    astc_1_0x_8_srgb_block = 178,
    astc_1_0x_10_unorm_block = 179,
    astc_1_0x_10_srgb_block = 180,
    astc_1_2x_10_unorm_block = 181,
    astc_1_2x_10_srgb_block = 182,
    astc_1_2x_12_unorm_block = 183,
    astc_1_2x_12_srgb_block = 184,
    g8b8g8r8_422_unorm = 1000156000,
    b8g8r8g8_422_unorm = 1000156001,
    g8_b8_r8_3plane_420_unorm = 1000156002,
    g8_b8r8_2plane_420_unorm = 1000156003,
    g8_b8_r8_3plane_422_unorm = 1000156004,
    g8_b8r8_2plane_422_unorm = 1000156005,
    g8_b8_r8_3plane_444_unorm = 1000156006,
    r10x6_unorm_pack16 = 1000156007,
    r10x6g10x6_unorm_2pack16 = 1000156008,
    r10x6g10x6b10x6a10x6_unorm_4pack16 = 1000156009,
    g10x6b10x6g10x6r10x6_422_unorm_4pack16 = 1000156010,
    b10x6g10x6r10x6g10x6_422_unorm_4pack16 = 1000156011,
    g10x6_b10x6_r10x6_3plane_420_unorm_3pack16 = 1000156012,
    g10x6_b10x6r10x6_2plane_420_unorm_3pack16 = 1000156013,
    g10x6_b10x6_r10x6_3plane_422_unorm_3pack16 = 1000156014,
    g10x6_b10x6r10x6_2plane_422_unorm_3pack16 = 1000156015,
    g10x6_b10x6_r10x6_3plane_444_unorm_3pack16 = 1000156016,
    r12x4_unorm_pack16 = 1000156017,
    r12x4g12x4_unorm_2pack16 = 1000156018,
    r12x4g12x4b12x4a12x4_unorm_4pack16 = 1000156019,
    g12x4b12x4g12x4r12x4_422_unorm_4pack16 = 1000156020,
    b12x4g12x4r12x4g12x4_422_unorm_4pack16 = 1000156021,
    g12x4_b12x4_r12x4_3plane_420_unorm_3pack16 = 1000156022,
    g12x4_b12x4r12x4_2plane_420_unorm_3pack16 = 1000156023,
    g12x4_b12x4_r12x4_3plane_422_unorm_3pack16 = 1000156024,
    g12x4_b12x4r12x4_2plane_422_unorm_3pack16 = 1000156025,
    g12x4_b12x4_r12x4_3plane_444_unorm_3pack16 = 1000156026,
    g16b16g16r16_422_unorm = 1000156027,
    b16g16r16g16_422_unorm = 1000156028,
    g16_b16_r16_3plane_420_unorm = 1000156029,
    g16_b16r16_2plane_420_unorm = 1000156030,
    g16_b16_r16_3plane_422_unorm = 1000156031,
    g16_b16r16_2plane_422_unorm = 1000156032,
    g16_b16_r16_3plane_444_unorm = 1000156033,
    pvrtc1_2bpp_unorm_block_img = 1000054000,
    pvrtc1_4bpp_unorm_block_img = 1000054001,
    pvrtc2_2bpp_unorm_block_img = 1000054002,
    pvrtc2_4bpp_unorm_block_img = 1000054003,
    pvrtc1_2bpp_srgb_block_img = 1000054004,
    pvrtc1_4bpp_srgb_block_img = 1000054005,
    pvrtc2_2bpp_srgb_block_img = 1000054006,
    pvrtc2_4bpp_srgb_block_img = 1000054007,
    astc_4x_4_sfloat_block_ext = 1000066000,
    astc_5x_4_sfloat_block_ext = 1000066001,
    astc_5x_5_sfloat_block_ext = 1000066002,
    astc_6x_5_sfloat_block_ext = 1000066003,
    astc_6x_6_sfloat_block_ext = 1000066004,
    astc_8x_5_sfloat_block_ext = 1000066005,
    astc_8x_6_sfloat_block_ext = 1000066006,
    astc_8x_8_sfloat_block_ext = 1000066007,
    astc_1_0x_5_sfloat_block_ext = 1000066008,
    astc_1_0x_6_sfloat_block_ext = 1000066009,
    astc_1_0x_8_sfloat_block_ext = 1000066010,
    astc_1_0x_10_sfloat_block_ext = 1000066011,
    astc_1_2x_10_sfloat_block_ext = 1000066012,
    astc_1_2x_12_sfloat_block_ext = 1000066013,
    g8_b8r8_2plane_444_unorm_ext = 1000330000,
    g10x6_b10x6r10x6_2plane_444_unorm_3pack16_ext = 1000330001,
    g12x4_b12x4r12x4_2plane_444_unorm_3pack16_ext = 1000330002,
    g16_b16r16_2plane_444_unorm_ext = 1000330003,
    a4r4g4b4_unorm_pack16_ext = 1000340000,
    a4b4g4r4_unorm_pack16_ext = 1000340001,
    _,
    pub const g8b8g8r8_422_unorm_khr = Format.g8b8g8r8_422_unorm;
    pub const b8g8r8g8_422_unorm_khr = Format.b8g8r8g8_422_unorm;
    pub const g8_b8_r8_3plane_420_unorm_khr = Format.g8_b8_r8_3plane_420_unorm;
    pub const g8_b8r8_2plane_420_unorm_khr = Format.g8_b8r8_2plane_420_unorm;
    pub const g8_b8_r8_3plane_422_unorm_khr = Format.g8_b8_r8_3plane_422_unorm;
    pub const g8_b8r8_2plane_422_unorm_khr = Format.g8_b8r8_2plane_422_unorm;
    pub const g8_b8_r8_3plane_444_unorm_khr = Format.g8_b8_r8_3plane_444_unorm;
    pub const r10x6_unorm_pack16_khr = Format.r10x6_unorm_pack16;
    pub const r10x6g10x6_unorm_2pack16_khr = Format.r10x6g10x6_unorm_2pack16;
    pub const r10x6g10x6b10x6a10x6_unorm_4pack16_khr = Format.r10x6g10x6b10x6a10x6_unorm_4pack16;
    pub const g10x6b10x6g10x6r10x6_422_unorm_4pack16_khr = Format.g10x6b10x6g10x6r10x6_422_unorm_4pack16;
    pub const b10x6g10x6r10x6g10x6_422_unorm_4pack16_khr = Format.b10x6g10x6r10x6g10x6_422_unorm_4pack16;
    pub const g10x6_b10x6_r10x6_3plane_420_unorm_3pack16_khr = Format.g10x6_b10x6_r10x6_3plane_420_unorm_3pack16;
    pub const g10x6_b10x6r10x6_2plane_420_unorm_3pack16_khr = Format.g10x6_b10x6r10x6_2plane_420_unorm_3pack16;
    pub const g10x6_b10x6_r10x6_3plane_422_unorm_3pack16_khr = Format.g10x6_b10x6_r10x6_3plane_422_unorm_3pack16;
    pub const g10x6_b10x6r10x6_2plane_422_unorm_3pack16_khr = Format.g10x6_b10x6r10x6_2plane_422_unorm_3pack16;
    pub const g10x6_b10x6_r10x6_3plane_444_unorm_3pack16_khr = Format.g10x6_b10x6_r10x6_3plane_444_unorm_3pack16;
    pub const r12x4_unorm_pack16_khr = Format.r12x4_unorm_pack16;
    pub const r12x4g12x4_unorm_2pack16_khr = Format.r12x4g12x4_unorm_2pack16;
    pub const r12x4g12x4b12x4a12x4_unorm_4pack16_khr = Format.r12x4g12x4b12x4a12x4_unorm_4pack16;
    pub const g12x4b12x4g12x4r12x4_422_unorm_4pack16_khr = Format.g12x4b12x4g12x4r12x4_422_unorm_4pack16;
    pub const b12x4g12x4r12x4g12x4_422_unorm_4pack16_khr = Format.b12x4g12x4r12x4g12x4_422_unorm_4pack16;
    pub const g12x4_b12x4_r12x4_3plane_420_unorm_3pack16_khr = Format.g12x4_b12x4_r12x4_3plane_420_unorm_3pack16;
    pub const g12x4_b12x4r12x4_2plane_420_unorm_3pack16_khr = Format.g12x4_b12x4r12x4_2plane_420_unorm_3pack16;
    pub const g12x4_b12x4_r12x4_3plane_422_unorm_3pack16_khr = Format.g12x4_b12x4_r12x4_3plane_422_unorm_3pack16;
    pub const g12x4_b12x4r12x4_2plane_422_unorm_3pack16_khr = Format.g12x4_b12x4r12x4_2plane_422_unorm_3pack16;
    pub const g12x4_b12x4_r12x4_3plane_444_unorm_3pack16_khr = Format.g12x4_b12x4_r12x4_3plane_444_unorm_3pack16;
    pub const g16b16g16r16_422_unorm_khr = Format.g16b16g16r16_422_unorm;
    pub const b16g16r16g16_422_unorm_khr = Format.b16g16r16g16_422_unorm;
    pub const g16_b16_r16_3plane_420_unorm_khr = Format.g16_b16_r16_3plane_420_unorm;
    pub const g16_b16r16_2plane_420_unorm_khr = Format.g16_b16r16_2plane_420_unorm;
    pub const g16_b16_r16_3plane_422_unorm_khr = Format.g16_b16_r16_3plane_422_unorm;
    pub const g16_b16r16_2plane_422_unorm_khr = Format.g16_b16r16_2plane_422_unorm;
    pub const g16_b16_r16_3plane_444_unorm_khr = Format.g16_b16_r16_3plane_444_unorm;
};
pub const StructureType = enum(c_int) {
    application_info = 0,
    instance_create_info = 1,
    device_queue_create_info = 2,
    device_create_info = 3,
    submit_info = 4,
    memory_allocate_info = 5,
    mapped_memory_range = 6,
    bind_sparse_info = 7,
    fence_create_info = 8,
    semaphore_create_info = 9,
    event_create_info = 10,
    query_pool_create_info = 11,
    buffer_create_info = 12,
    buffer_view_create_info = 13,
    image_create_info = 14,
    image_view_create_info = 15,
    shader_module_create_info = 16,
    pipeline_cache_create_info = 17,
    pipeline_shader_stage_create_info = 18,
    pipeline_vertex_input_state_create_info = 19,
    pipeline_input_assembly_state_create_info = 20,
    pipeline_tessellation_state_create_info = 21,
    pipeline_viewport_state_create_info = 22,
    pipeline_rasterization_state_create_info = 23,
    pipeline_multisample_state_create_info = 24,
    pipeline_depth_stencil_state_create_info = 25,
    pipeline_color_blend_state_create_info = 26,
    pipeline_dynamic_state_create_info = 27,
    graphics_pipeline_create_info = 28,
    compute_pipeline_create_info = 29,
    pipeline_layout_create_info = 30,
    sampler_create_info = 31,
    descriptor_set_layout_create_info = 32,
    descriptor_pool_create_info = 33,
    descriptor_set_allocate_info = 34,
    write_descriptor_set = 35,
    copy_descriptor_set = 36,
    framebuffer_create_info = 37,
    render_pass_create_info = 38,
    command_pool_create_info = 39,
    command_buffer_allocate_info = 40,
    command_buffer_inheritance_info = 41,
    command_buffer_begin_info = 42,
    render_pass_begin_info = 43,
    buffer_memory_barrier = 44,
    image_memory_barrier = 45,
    memory_barrier = 46,
    loader_instance_create_info = 47,
    loader_device_create_info = 48,
    physical_device_subgroup_properties = 1000094000,
    bind_buffer_memory_info = 1000157000,
    bind_image_memory_info = 1000157001,
    physical_device_16bit_storage_features = 1000083000,
    memory_dedicated_requirements = 1000127000,
    memory_dedicated_allocate_info = 1000127001,
    memory_allocate_flags_info = 1000060000,
    device_group_render_pass_begin_info = 1000060003,
    device_group_command_buffer_begin_info = 1000060004,
    device_group_submit_info = 1000060005,
    device_group_bind_sparse_info = 1000060006,
    bind_buffer_memory_device_group_info = 1000060013,
    bind_image_memory_device_group_info = 1000060014,
    physical_device_group_properties = 1000070000,
    device_group_device_create_info = 1000070001,
    buffer_memory_requirements_info_2 = 1000146000,
    image_memory_requirements_info_2 = 1000146001,
    image_sparse_memory_requirements_info_2 = 1000146002,
    memory_requirements_2 = 1000146003,
    sparse_image_memory_requirements_2 = 1000146004,
    physical_device_features_2 = 1000059000,
    physical_device_properties_2 = 1000059001,
    format_properties_2 = 1000059002,
    image_format_properties_2 = 1000059003,
    physical_device_image_format_info_2 = 1000059004,
    queue_family_properties_2 = 1000059005,
    physical_device_memory_properties_2 = 1000059006,
    sparse_image_format_properties_2 = 1000059007,
    physical_device_sparse_image_format_info_2 = 1000059008,
    physical_device_point_clipping_properties = 1000117000,
    render_pass_input_attachment_aspect_create_info = 1000117001,
    image_view_usage_create_info = 1000117002,
    pipeline_tessellation_domain_origin_state_create_info = 1000117003,
    render_pass_multiview_create_info = 1000053000,
    physical_device_multiview_features = 1000053001,
    physical_device_multiview_properties = 1000053002,
    physical_device_variable_pointers_features = 1000120000,
    protected_submit_info = 1000145000,
    physical_device_protected_memory_features = 1000145001,
    physical_device_protected_memory_properties = 1000145002,
    device_queue_info_2 = 1000145003,
    sampler_ycbcr_conversion_create_info = 1000156000,
    sampler_ycbcr_conversion_info = 1000156001,
    bind_image_plane_memory_info = 1000156002,
    image_plane_memory_requirements_info = 1000156003,
    physical_device_sampler_ycbcr_conversion_features = 1000156004,
    sampler_ycbcr_conversion_image_format_properties = 1000156005,
    descriptor_update_template_create_info = 1000085000,
    physical_device_external_image_format_info = 1000071000,
    external_image_format_properties = 1000071001,
    physical_device_external_buffer_info = 1000071002,
    external_buffer_properties = 1000071003,
    physical_device_id_properties = 1000071004,
    external_memory_buffer_create_info = 1000072000,
    external_memory_image_create_info = 1000072001,
    export_memory_allocate_info = 1000072002,
    physical_device_external_fence_info = 1000112000,
    external_fence_properties = 1000112001,
    export_fence_create_info = 1000113000,
    export_semaphore_create_info = 1000077000,
    physical_device_external_semaphore_info = 1000076000,
    external_semaphore_properties = 1000076001,
    physical_device_maintenance_3_properties = 1000168000,
    descriptor_set_layout_support = 1000168001,
    physical_device_shader_draw_parameters_features = 1000063000,
    physical_device_vulkan_1_1_features = 49,
    physical_device_vulkan_1_1_properties = 50,
    physical_device_vulkan_1_2_features = 51,
    physical_device_vulkan_1_2_properties = 52,
    image_format_list_create_info = 1000147000,
    attachment_description_2 = 1000109000,
    attachment_reference_2 = 1000109001,
    subpass_description_2 = 1000109002,
    subpass_dependency_2 = 1000109003,
    render_pass_create_info_2 = 1000109004,
    subpass_begin_info = 1000109005,
    subpass_end_info = 1000109006,
    physical_device_8bit_storage_features = 1000177000,
    physical_device_driver_properties = 1000196000,
    physical_device_shader_atomic_int64_features = 1000180000,
    physical_device_shader_float16_int8_features = 1000082000,
    physical_device_float_controls_properties = 1000197000,
    descriptor_set_layout_binding_flags_create_info = 1000161000,
    physical_device_descriptor_indexing_features = 1000161001,
    physical_device_descriptor_indexing_properties = 1000161002,
    descriptor_set_variable_descriptor_count_allocate_info = 1000161003,
    descriptor_set_variable_descriptor_count_layout_support = 1000161004,
    physical_device_depth_stencil_resolve_properties = 1000199000,
    subpass_description_depth_stencil_resolve = 1000199001,
    physical_device_scalar_block_layout_features = 1000221000,
    image_stencil_usage_create_info = 1000246000,
    physical_device_sampler_filter_minmax_properties = 1000130000,
    sampler_reduction_mode_create_info = 1000130001,
    physical_device_vulkan_memory_model_features = 1000211000,
    physical_device_imageless_framebuffer_features = 1000108000,
    framebuffer_attachments_create_info = 1000108001,
    framebuffer_attachment_image_info = 1000108002,
    render_pass_attachment_begin_info = 1000108003,
    physical_device_uniform_buffer_standard_layout_features = 1000253000,
    physical_device_shader_subgroup_extended_types_features = 1000175000,
    physical_device_separate_depth_stencil_layouts_features = 1000241000,
    attachment_reference_stencil_layout = 1000241001,
    attachment_description_stencil_layout = 1000241002,
    physical_device_host_query_reset_features = 1000261000,
    physical_device_timeline_semaphore_features = 1000207000,
    physical_device_timeline_semaphore_properties = 1000207001,
    semaphore_type_create_info = 1000207002,
    timeline_semaphore_submit_info = 1000207003,
    semaphore_wait_info = 1000207004,
    semaphore_signal_info = 1000207005,
    physical_device_buffer_device_address_features = 1000257000,
    buffer_device_address_info = 1000244001,
    buffer_opaque_capture_address_create_info = 1000257002,
    memory_opaque_capture_address_allocate_info = 1000257003,
    device_memory_opaque_capture_address_info = 1000257004,
    swapchain_create_info_khr = 1000001000,
    present_info_khr = 1000001001,
    device_group_present_capabilities_khr = 1000060007,
    image_swapchain_create_info_khr = 1000060008,
    bind_image_memory_swapchain_info_khr = 1000060009,
    acquire_next_image_info_khr = 1000060010,
    device_group_present_info_khr = 1000060011,
    device_group_swapchain_create_info_khr = 1000060012,
    display_mode_create_info_khr = 1000002000,
    display_surface_create_info_khr = 1000002001,
    display_present_info_khr = 1000003000,
    xlib_surface_create_info_khr = 1000004000,
    xcb_surface_create_info_khr = 1000005000,
    wayland_surface_create_info_khr = 1000006000,
    android_surface_create_info_khr = 1000008000,
    win32_surface_create_info_khr = 1000009000,
    debug_report_callback_create_info_ext = 1000011000,
    pipeline_rasterization_state_rasterization_order_amd = 1000018000,
    debug_marker_object_name_info_ext = 1000022000,
    debug_marker_object_tag_info_ext = 1000022001,
    debug_marker_marker_info_ext = 1000022002,
    video_profile_khr = 1000023000,
    video_capabilities_khr = 1000023001,
    video_picture_resource_khr = 1000023002,
    video_get_memory_properties_khr = 1000023003,
    video_bind_memory_khr = 1000023004,
    video_session_create_info_khr = 1000023005,
    video_session_parameters_create_info_khr = 1000023006,
    video_session_parameters_update_info_khr = 1000023007,
    video_begin_coding_info_khr = 1000023008,
    video_end_coding_info_khr = 1000023009,
    video_coding_control_info_khr = 1000023010,
    video_reference_slot_khr = 1000023011,
    video_queue_family_properties_2_khr = 1000023012,
    video_profiles_khr = 1000023013,
    physical_device_video_format_info_khr = 1000023014,
    video_format_properties_khr = 1000023015,
    video_decode_info_khr = 1000024000,
    dedicated_allocation_image_create_info_nv = 1000026000,
    dedicated_allocation_buffer_create_info_nv = 1000026001,
    dedicated_allocation_memory_allocate_info_nv = 1000026002,
    physical_device_transform_feedback_features_ext = 1000028000,
    physical_device_transform_feedback_properties_ext = 1000028001,
    pipeline_rasterization_state_stream_create_info_ext = 1000028002,
    cu_module_create_info_nvx = 1000029000,
    cu_function_create_info_nvx = 1000029001,
    cu_launch_info_nvx = 1000029002,
    image_view_handle_info_nvx = 1000030000,
    image_view_address_properties_nvx = 1000030001,
    video_encode_h264_capabilities_ext = 1000038000,
    video_encode_h264_session_create_info_ext = 1000038001,
    video_encode_h264_session_parameters_create_info_ext = 1000038002,
    video_encode_h264_session_parameters_add_info_ext = 1000038003,
    video_encode_h264_vcl_frame_info_ext = 1000038004,
    video_encode_h264_dpb_slot_info_ext = 1000038005,
    video_encode_h264_nalu_slice_ext = 1000038006,
    video_encode_h264_emit_picture_parameters_ext = 1000038007,
    video_encode_h264_profile_ext = 1000038008,
    video_encode_h265_capabilities_ext = 1000039000,
    video_encode_h265_session_create_info_ext = 1000039001,
    video_encode_h265_session_parameters_create_info_ext = 1000039002,
    video_encode_h265_session_parameters_add_info_ext = 1000039003,
    video_encode_h265_vcl_frame_info_ext = 1000039004,
    video_encode_h265_dpb_slot_info_ext = 1000039005,
    video_encode_h265_nalu_slice_ext = 1000039006,
    video_encode_h265_emit_picture_parameters_ext = 1000039007,
    video_encode_h265_profile_ext = 1000039008,
    video_encode_h265_reference_lists_ext = 1000039009,
    video_decode_h264_capabilities_ext = 1000040000,
    video_decode_h264_session_create_info_ext = 1000040001,
    video_decode_h264_picture_info_ext = 1000040002,
    video_decode_h264_mvc_ext = 1000040003,
    video_decode_h264_profile_ext = 1000040004,
    video_decode_h264_session_parameters_create_info_ext = 1000040005,
    video_decode_h264_session_parameters_add_info_ext = 1000040006,
    video_decode_h264_dpb_slot_info_ext = 1000040007,
    texture_lod_gather_format_properties_amd = 1000041000,
    rendering_info_khr = 1000044000,
    rendering_attachment_info_khr = 1000044001,
    pipeline_rendering_create_info_khr = 1000044002,
    physical_device_dynamic_rendering_features_khr = 1000044003,
    command_buffer_inheritance_rendering_info_khr = 1000044004,
    rendering_fragment_shading_rate_attachment_info_khr = 1000044006,
    rendering_fragment_density_map_attachment_info_ext = 1000044007,
    attachment_sample_count_info_amd = 1000044008,
    multiview_per_view_attributes_info_nvx = 1000044009,
    stream_descriptor_surface_create_info_ggp = 1000049000,
    physical_device_corner_sampled_image_features_nv = 1000050000,
    external_memory_image_create_info_nv = 1000056000,
    export_memory_allocate_info_nv = 1000056001,
    import_memory_win32_handle_info_nv = 1000057000,
    export_memory_win32_handle_info_nv = 1000057001,
    win32_keyed_mutex_acquire_release_info_nv = 1000058000,
    validation_flags_ext = 1000061000,
    vi_surface_create_info_nn = 1000062000,
    physical_device_texture_compression_astc_hdr_features_ext = 1000066000,
    image_view_astc_decode_mode_ext = 1000067000,
    physical_device_astc_decode_features_ext = 1000067001,
    import_memory_win32_handle_info_khr = 1000073000,
    export_memory_win32_handle_info_khr = 1000073001,
    memory_win32_handle_properties_khr = 1000073002,
    memory_get_win32_handle_info_khr = 1000073003,
    import_memory_fd_info_khr = 1000074000,
    memory_fd_properties_khr = 1000074001,
    memory_get_fd_info_khr = 1000074002,
    win32_keyed_mutex_acquire_release_info_khr = 1000075000,
    import_semaphore_win32_handle_info_khr = 1000078000,
    export_semaphore_win32_handle_info_khr = 1000078001,
    d3d12_fence_submit_info_khr = 1000078002,
    semaphore_get_win32_handle_info_khr = 1000078003,
    import_semaphore_fd_info_khr = 1000079000,
    semaphore_get_fd_info_khr = 1000079001,
    physical_device_push_descriptor_properties_khr = 1000080000,
    command_buffer_inheritance_conditional_rendering_info_ext = 1000081000,
    physical_device_conditional_rendering_features_ext = 1000081001,
    conditional_rendering_begin_info_ext = 1000081002,
    present_regions_khr = 1000084000,
    pipeline_viewport_w_scaling_state_create_info_nv = 1000087000,
    surface_capabilities_2_ext = 1000090000,
    display_power_info_ext = 1000091000,
    device_event_info_ext = 1000091001,
    display_event_info_ext = 1000091002,
    swapchain_counter_create_info_ext = 1000091003,
    present_times_info_google = 1000092000,
    physical_device_multiview_per_view_attributes_properties_nvx = 1000097000,
    pipeline_viewport_swizzle_state_create_info_nv = 1000098000,
    physical_device_discard_rectangle_properties_ext = 1000099000,
    pipeline_discard_rectangle_state_create_info_ext = 1000099001,
    physical_device_conservative_rasterization_properties_ext = 1000101000,
    pipeline_rasterization_conservative_state_create_info_ext = 1000101001,
    physical_device_depth_clip_enable_features_ext = 1000102000,
    pipeline_rasterization_depth_clip_state_create_info_ext = 1000102001,
    hdr_metadata_ext = 1000105000,
    shared_present_surface_capabilities_khr = 1000111000,
    import_fence_win32_handle_info_khr = 1000114000,
    export_fence_win32_handle_info_khr = 1000114001,
    fence_get_win32_handle_info_khr = 1000114002,
    import_fence_fd_info_khr = 1000115000,
    fence_get_fd_info_khr = 1000115001,
    physical_device_performance_query_features_khr = 1000116000,
    physical_device_performance_query_properties_khr = 1000116001,
    query_pool_performance_create_info_khr = 1000116002,
    performance_query_submit_info_khr = 1000116003,
    acquire_profiling_lock_info_khr = 1000116004,
    performance_counter_khr = 1000116005,
    performance_counter_description_khr = 1000116006,
    physical_device_surface_info_2_khr = 1000119000,
    surface_capabilities_2_khr = 1000119001,
    surface_format_2_khr = 1000119002,
    display_properties_2_khr = 1000121000,
    display_plane_properties_2_khr = 1000121001,
    display_mode_properties_2_khr = 1000121002,
    display_plane_info_2_khr = 1000121003,
    display_plane_capabilities_2_khr = 1000121004,
    ios_surface_create_info_mvk = 1000122000,
    macos_surface_create_info_mvk = 1000123000,
    debug_utils_object_name_info_ext = 1000128000,
    debug_utils_object_tag_info_ext = 1000128001,
    debug_utils_label_ext = 1000128002,
    debug_utils_messenger_callback_data_ext = 1000128003,
    debug_utils_messenger_create_info_ext = 1000128004,
    android_hardware_buffer_usage_android = 1000129000,
    android_hardware_buffer_properties_android = 1000129001,
    android_hardware_buffer_format_properties_android = 1000129002,
    import_android_hardware_buffer_info_android = 1000129003,
    memory_get_android_hardware_buffer_info_android = 1000129004,
    external_format_android = 1000129005,
    android_hardware_buffer_format_properties_2_android = 1000129006,
    physical_device_inline_uniform_block_features_ext = 1000138000,
    physical_device_inline_uniform_block_properties_ext = 1000138001,
    write_descriptor_set_inline_uniform_block_ext = 1000138002,
    descriptor_pool_inline_uniform_block_create_info_ext = 1000138003,
    sample_locations_info_ext = 1000143000,
    render_pass_sample_locations_begin_info_ext = 1000143001,
    pipeline_sample_locations_state_create_info_ext = 1000143002,
    physical_device_sample_locations_properties_ext = 1000143003,
    multisample_properties_ext = 1000143004,
    physical_device_blend_operation_advanced_features_ext = 1000148000,
    physical_device_blend_operation_advanced_properties_ext = 1000148001,
    pipeline_color_blend_advanced_state_create_info_ext = 1000148002,
    pipeline_coverage_to_color_state_create_info_nv = 1000149000,
    write_descriptor_set_acceleration_structure_khr = 1000150007,
    acceleration_structure_build_geometry_info_khr = 1000150000,
    acceleration_structure_device_address_info_khr = 1000150002,
    acceleration_structure_geometry_aabbs_data_khr = 1000150003,
    acceleration_structure_geometry_instances_data_khr = 1000150004,
    acceleration_structure_geometry_triangles_data_khr = 1000150005,
    acceleration_structure_geometry_khr = 1000150006,
    acceleration_structure_version_info_khr = 1000150009,
    copy_acceleration_structure_info_khr = 1000150010,
    copy_acceleration_structure_to_memory_info_khr = 1000150011,
    copy_memory_to_acceleration_structure_info_khr = 1000150012,
    physical_device_acceleration_structure_features_khr = 1000150013,
    physical_device_acceleration_structure_properties_khr = 1000150014,
    acceleration_structure_create_info_khr = 1000150017,
    acceleration_structure_build_sizes_info_khr = 1000150020,
    physical_device_ray_tracing_pipeline_features_khr = 1000347000,
    physical_device_ray_tracing_pipeline_properties_khr = 1000347001,
    ray_tracing_pipeline_create_info_khr = 1000150015,
    ray_tracing_shader_group_create_info_khr = 1000150016,
    ray_tracing_pipeline_interface_create_info_khr = 1000150018,
    physical_device_ray_query_features_khr = 1000348013,
    pipeline_coverage_modulation_state_create_info_nv = 1000152000,
    physical_device_shader_sm_builtins_features_nv = 1000154000,
    physical_device_shader_sm_builtins_properties_nv = 1000154001,
    drm_format_modifier_properties_list_ext = 1000158000,
    physical_device_image_drm_format_modifier_info_ext = 1000158002,
    image_drm_format_modifier_list_create_info_ext = 1000158003,
    image_drm_format_modifier_explicit_create_info_ext = 1000158004,
    image_drm_format_modifier_properties_ext = 1000158005,
    drm_format_modifier_properties_list_2_ext = 1000158006,
    validation_cache_create_info_ext = 1000160000,
    shader_module_validation_cache_create_info_ext = 1000160001,
    physical_device_portability_subset_features_khr = 1000163000,
    physical_device_portability_subset_properties_khr = 1000163001,
    pipeline_viewport_shading_rate_image_state_create_info_nv = 1000164000,
    physical_device_shading_rate_image_features_nv = 1000164001,
    physical_device_shading_rate_image_properties_nv = 1000164002,
    pipeline_viewport_coarse_sample_order_state_create_info_nv = 1000164005,
    ray_tracing_pipeline_create_info_nv = 1000165000,
    acceleration_structure_create_info_nv = 1000165001,
    geometry_nv = 1000165003,
    geometry_triangles_nv = 1000165004,
    geometry_aabb_nv = 1000165005,
    bind_acceleration_structure_memory_info_nv = 1000165006,
    write_descriptor_set_acceleration_structure_nv = 1000165007,
    acceleration_structure_memory_requirements_info_nv = 1000165008,
    physical_device_ray_tracing_properties_nv = 1000165009,
    ray_tracing_shader_group_create_info_nv = 1000165011,
    acceleration_structure_info_nv = 1000165012,
    physical_device_representative_fragment_test_features_nv = 1000166000,
    pipeline_representative_fragment_test_state_create_info_nv = 1000166001,
    physical_device_image_view_image_format_info_ext = 1000170000,
    filter_cubic_image_view_image_format_properties_ext = 1000170001,
    device_queue_global_priority_create_info_ext = 1000174000,
    import_memory_host_pointer_info_ext = 1000178000,
    memory_host_pointer_properties_ext = 1000178001,
    physical_device_external_memory_host_properties_ext = 1000178002,
    physical_device_shader_clock_features_khr = 1000181000,
    pipeline_compiler_control_create_info_amd = 1000183000,
    calibrated_timestamp_info_ext = 1000184000,
    physical_device_shader_core_properties_amd = 1000185000,
    video_decode_h265_capabilities_ext = 1000187000,
    video_decode_h265_session_create_info_ext = 1000187001,
    video_decode_h265_session_parameters_create_info_ext = 1000187002,
    video_decode_h265_session_parameters_add_info_ext = 1000187003,
    video_decode_h265_profile_ext = 1000187004,
    video_decode_h265_picture_info_ext = 1000187005,
    video_decode_h265_dpb_slot_info_ext = 1000187006,
    device_memory_overallocation_create_info_amd = 1000189000,
    physical_device_vertex_attribute_divisor_properties_ext = 1000190000,
    pipeline_vertex_input_divisor_state_create_info_ext = 1000190001,
    physical_device_vertex_attribute_divisor_features_ext = 1000190002,
    present_frame_token_ggp = 1000191000,
    pipeline_creation_feedback_create_info_ext = 1000192000,
    physical_device_compute_shader_derivatives_features_nv = 1000201000,
    physical_device_mesh_shader_features_nv = 1000202000,
    physical_device_mesh_shader_properties_nv = 1000202001,
    physical_device_fragment_shader_barycentric_features_nv = 1000203000,
    physical_device_shader_image_footprint_features_nv = 1000204000,
    pipeline_viewport_exclusive_scissor_state_create_info_nv = 1000205000,
    physical_device_exclusive_scissor_features_nv = 1000205002,
    checkpoint_data_nv = 1000206000,
    queue_family_checkpoint_properties_nv = 1000206001,
    physical_device_shader_integer_functions_2_features_intel = 1000209000,
    query_pool_performance_query_create_info_intel = 1000210000,
    initialize_performance_api_info_intel = 1000210001,
    performance_marker_info_intel = 1000210002,
    performance_stream_marker_info_intel = 1000210003,
    performance_override_info_intel = 1000210004,
    performance_configuration_acquire_info_intel = 1000210005,
    physical_device_pci_bus_info_properties_ext = 1000212000,
    display_native_hdr_surface_capabilities_amd = 1000213000,
    swapchain_display_native_hdr_create_info_amd = 1000213001,
    imagepipe_surface_create_info_fuchsia = 1000214000,
    physical_device_shader_terminate_invocation_features_khr = 1000215000,
    metal_surface_create_info_ext = 1000217000,
    physical_device_fragment_density_map_features_ext = 1000218000,
    physical_device_fragment_density_map_properties_ext = 1000218001,
    render_pass_fragment_density_map_create_info_ext = 1000218002,
    physical_device_subgroup_size_control_properties_ext = 1000225000,
    pipeline_shader_stage_required_subgroup_size_create_info_ext = 1000225001,
    physical_device_subgroup_size_control_features_ext = 1000225002,
    fragment_shading_rate_attachment_info_khr = 1000226000,
    pipeline_fragment_shading_rate_state_create_info_khr = 1000226001,
    physical_device_fragment_shading_rate_properties_khr = 1000226002,
    physical_device_fragment_shading_rate_features_khr = 1000226003,
    physical_device_fragment_shading_rate_khr = 1000226004,
    physical_device_shader_core_properties_2_amd = 1000227000,
    physical_device_coherent_memory_features_amd = 1000229000,
    physical_device_shader_image_atomic_int64_features_ext = 1000234000,
    physical_device_memory_budget_properties_ext = 1000237000,
    physical_device_memory_priority_features_ext = 1000238000,
    memory_priority_allocate_info_ext = 1000238001,
    surface_protected_capabilities_khr = 1000239000,
    physical_device_dedicated_allocation_image_aliasing_features_nv = 1000240000,
    physical_device_buffer_device_address_features_ext = 1000244000,
    buffer_device_address_create_info_ext = 1000244002,
    physical_device_tool_properties_ext = 1000245000,
    validation_features_ext = 1000247000,
    physical_device_present_wait_features_khr = 1000248000,
    physical_device_cooperative_matrix_features_nv = 1000249000,
    cooperative_matrix_properties_nv = 1000249001,
    physical_device_cooperative_matrix_properties_nv = 1000249002,
    physical_device_coverage_reduction_mode_features_nv = 1000250000,
    pipeline_coverage_reduction_state_create_info_nv = 1000250001,
    framebuffer_mixed_samples_combination_nv = 1000250002,
    physical_device_fragment_shader_interlock_features_ext = 1000251000,
    physical_device_ycbcr_image_arrays_features_ext = 1000252000,
    physical_device_provoking_vertex_features_ext = 1000254000,
    pipeline_rasterization_provoking_vertex_state_create_info_ext = 1000254001,
    physical_device_provoking_vertex_properties_ext = 1000254002,
    surface_full_screen_exclusive_info_ext = 1000255000,
    surface_capabilities_full_screen_exclusive_ext = 1000255002,
    surface_full_screen_exclusive_win32_info_ext = 1000255001,
    headless_surface_create_info_ext = 1000256000,
    physical_device_line_rasterization_features_ext = 1000259000,
    pipeline_rasterization_line_state_create_info_ext = 1000259001,
    physical_device_line_rasterization_properties_ext = 1000259002,
    physical_device_shader_atomic_float_features_ext = 1000260000,
    physical_device_index_type_uint8_features_ext = 1000265000,
    physical_device_extended_dynamic_state_features_ext = 1000267000,
    physical_device_pipeline_executable_properties_features_khr = 1000269000,
    pipeline_info_khr = 1000269001,
    pipeline_executable_properties_khr = 1000269002,
    pipeline_executable_info_khr = 1000269003,
    pipeline_executable_statistic_khr = 1000269004,
    pipeline_executable_internal_representation_khr = 1000269005,
    physical_device_shader_atomic_float_2_features_ext = 1000273000,
    physical_device_shader_demote_to_helper_invocation_features_ext = 1000276000,
    physical_device_device_generated_commands_properties_nv = 1000277000,
    graphics_shader_group_create_info_nv = 1000277001,
    graphics_pipeline_shader_groups_create_info_nv = 1000277002,
    indirect_commands_layout_token_nv = 1000277003,
    indirect_commands_layout_create_info_nv = 1000277004,
    generated_commands_info_nv = 1000277005,
    generated_commands_memory_requirements_info_nv = 1000277006,
    physical_device_device_generated_commands_features_nv = 1000277007,
    physical_device_inherited_viewport_scissor_features_nv = 1000278000,
    command_buffer_inheritance_viewport_scissor_info_nv = 1000278001,
    physical_device_shader_integer_dot_product_features_khr = 1000280000,
    physical_device_shader_integer_dot_product_properties_khr = 1000280001,
    physical_device_texel_buffer_alignment_features_ext = 1000281000,
    physical_device_texel_buffer_alignment_properties_ext = 1000281001,
    command_buffer_inheritance_render_pass_transform_info_qcom = 1000282000,
    render_pass_transform_begin_info_qcom = 1000282001,
    physical_device_device_memory_report_features_ext = 1000284000,
    device_device_memory_report_create_info_ext = 1000284001,
    device_memory_report_callback_data_ext = 1000284002,
    physical_device_robustness_2_features_ext = 1000286000,
    physical_device_robustness_2_properties_ext = 1000286001,
    sampler_custom_border_color_create_info_ext = 1000287000,
    physical_device_custom_border_color_properties_ext = 1000287001,
    physical_device_custom_border_color_features_ext = 1000287002,
    pipeline_library_create_info_khr = 1000290000,
    present_id_khr = 1000294000,
    physical_device_present_id_features_khr = 1000294001,
    physical_device_private_data_features_ext = 1000295000,
    device_private_data_create_info_ext = 1000295001,
    private_data_slot_create_info_ext = 1000295002,
    physical_device_pipeline_creation_cache_control_features_ext = 1000297000,
    video_encode_info_khr = 1000299000,
    video_encode_rate_control_info_khr = 1000299001,
    physical_device_diagnostics_config_features_nv = 1000300000,
    device_diagnostics_config_create_info_nv = 1000300001,
    memory_barrier_2_khr = 1000314000,
    buffer_memory_barrier_2_khr = 1000314001,
    image_memory_barrier_2_khr = 1000314002,
    dependency_info_khr = 1000314003,
    submit_info_2_khr = 1000314004,
    semaphore_submit_info_khr = 1000314005,
    command_buffer_submit_info_khr = 1000314006,
    physical_device_synchronization_2_features_khr = 1000314007,
    queue_family_checkpoint_properties_2_nv = 1000314008,
    checkpoint_data_2_nv = 1000314009,
    physical_device_shader_subgroup_uniform_control_flow_features_khr = 1000323000,
    physical_device_zero_initialize_workgroup_memory_features_khr = 1000325000,
    physical_device_fragment_shading_rate_enums_properties_nv = 1000326000,
    physical_device_fragment_shading_rate_enums_features_nv = 1000326001,
    pipeline_fragment_shading_rate_enum_state_create_info_nv = 1000326002,
    acceleration_structure_geometry_motion_triangles_data_nv = 1000327000,
    physical_device_ray_tracing_motion_blur_features_nv = 1000327001,
    acceleration_structure_motion_info_nv = 1000327002,
    physical_device_ycbcr_2_plane_444_formats_features_ext = 1000330000,
    physical_device_fragment_density_map_2_features_ext = 1000332000,
    physical_device_fragment_density_map_2_properties_ext = 1000332001,
    copy_command_transform_info_qcom = 1000333000,
    physical_device_image_robustness_features_ext = 1000335000,
    physical_device_workgroup_memory_explicit_layout_features_khr = 1000336000,
    copy_buffer_info_2_khr = 1000337000,
    copy_image_info_2_khr = 1000337001,
    copy_buffer_to_image_info_2_khr = 1000337002,
    copy_image_to_buffer_info_2_khr = 1000337003,
    blit_image_info_2_khr = 1000337004,
    resolve_image_info_2_khr = 1000337005,
    buffer_copy_2_khr = 1000337006,
    image_copy_2_khr = 1000337007,
    image_blit_2_khr = 1000337008,
    buffer_image_copy_2_khr = 1000337009,
    image_resolve_2_khr = 1000337010,
    physical_device_4444_formats_features_ext = 1000340000,
    physical_device_rgba10x6_formats_features_ext = 1000344000,
    directfb_surface_create_info_ext = 1000346000,
    physical_device_mutable_descriptor_type_features_valve = 1000351000,
    mutable_descriptor_type_create_info_valve = 1000351002,
    physical_device_vertex_input_dynamic_state_features_ext = 1000352000,
    vertex_input_binding_description_2_ext = 1000352001,
    vertex_input_attribute_description_2_ext = 1000352002,
    physical_device_drm_properties_ext = 1000353000,
    physical_device_primitive_topology_list_restart_features_ext = 1000356000,
    format_properties_3_khr = 1000360000,
    import_memory_zircon_handle_info_fuchsia = 1000364000,
    memory_zircon_handle_properties_fuchsia = 1000364001,
    memory_get_zircon_handle_info_fuchsia = 1000364002,
    import_semaphore_zircon_handle_info_fuchsia = 1000365000,
    semaphore_get_zircon_handle_info_fuchsia = 1000365001,
    buffer_collection_create_info_fuchsia = 1000366000,
    import_memory_buffer_collection_fuchsia = 1000366001,
    buffer_collection_image_create_info_fuchsia = 1000366002,
    buffer_collection_properties_fuchsia = 1000366003,
    buffer_constraints_info_fuchsia = 1000366004,
    buffer_collection_buffer_create_info_fuchsia = 1000366005,
    image_constraints_info_fuchsia = 1000366006,
    image_format_constraints_info_fuchsia = 1000366007,
    sysmem_color_space_fuchsia = 1000366008,
    buffer_collection_constraints_info_fuchsia = 1000366009,
    subpass_shading_pipeline_create_info_huawei = 1000369000,
    physical_device_subpass_shading_features_huawei = 1000369001,
    physical_device_subpass_shading_properties_huawei = 1000369002,
    physical_device_invocation_mask_features_huawei = 1000370000,
    memory_get_remote_address_info_nv = 1000371000,
    physical_device_external_memory_rdma_features_nv = 1000371001,
    physical_device_extended_dynamic_state_2_features_ext = 1000377000,
    screen_surface_create_info_qnx = 1000378000,
    physical_device_color_write_enable_features_ext = 1000381000,
    pipeline_color_write_create_info_ext = 1000381001,
    physical_device_global_priority_query_features_ext = 1000388000,
    queue_family_global_priority_properties_ext = 1000388001,
    physical_device_multi_draw_features_ext = 1000392000,
    physical_device_multi_draw_properties_ext = 1000392001,
    physical_device_border_color_swizzle_features_ext = 1000411000,
    sampler_border_color_component_mapping_create_info_ext = 1000411001,
    physical_device_pageable_device_local_memory_features_ext = 1000412000,
    physical_device_maintenance_4_features_khr = 1000413000,
    physical_device_maintenance_4_properties_khr = 1000413001,
    device_buffer_memory_requirements_khr = 1000413002,
    device_image_memory_requirements_khr = 1000413003,
    _,
    pub const physical_device_variable_pointer_features = StructureType.physical_device_variable_pointers_features;
    pub const physical_device_shader_draw_parameter_features = StructureType.physical_device_shader_draw_parameters_features;
    pub const attachment_sample_count_info_nv = StructureType.attachment_sample_count_info_amd;
    pub const render_pass_multiview_create_info_khr = StructureType.render_pass_multiview_create_info;
    pub const physical_device_multiview_features_khr = StructureType.physical_device_multiview_features;
    pub const physical_device_multiview_properties_khr = StructureType.physical_device_multiview_properties;
    pub const physical_device_features_2_khr = StructureType.physical_device_features_2;
    pub const physical_device_properties_2_khr = StructureType.physical_device_properties_2;
    pub const format_properties_2_khr = StructureType.format_properties_2;
    pub const image_format_properties_2_khr = StructureType.image_format_properties_2;
    pub const physical_device_image_format_info_2_khr = StructureType.physical_device_image_format_info_2;
    pub const queue_family_properties_2_khr = StructureType.queue_family_properties_2;
    pub const physical_device_memory_properties_2_khr = StructureType.physical_device_memory_properties_2;
    pub const sparse_image_format_properties_2_khr = StructureType.sparse_image_format_properties_2;
    pub const physical_device_sparse_image_format_info_2_khr = StructureType.physical_device_sparse_image_format_info_2;
    pub const memory_allocate_flags_info_khr = StructureType.memory_allocate_flags_info;
    pub const device_group_render_pass_begin_info_khr = StructureType.device_group_render_pass_begin_info;
    pub const device_group_command_buffer_begin_info_khr = StructureType.device_group_command_buffer_begin_info;
    pub const device_group_submit_info_khr = StructureType.device_group_submit_info;
    pub const device_group_bind_sparse_info_khr = StructureType.device_group_bind_sparse_info;
    pub const bind_buffer_memory_device_group_info_khr = StructureType.bind_buffer_memory_device_group_info;
    pub const bind_image_memory_device_group_info_khr = StructureType.bind_image_memory_device_group_info;
    pub const physical_device_group_properties_khr = StructureType.physical_device_group_properties;
    pub const device_group_device_create_info_khr = StructureType.device_group_device_create_info;
    pub const physical_device_external_image_format_info_khr = StructureType.physical_device_external_image_format_info;
    pub const external_image_format_properties_khr = StructureType.external_image_format_properties;
    pub const physical_device_external_buffer_info_khr = StructureType.physical_device_external_buffer_info;
    pub const external_buffer_properties_khr = StructureType.external_buffer_properties;
    pub const physical_device_id_properties_khr = StructureType.physical_device_id_properties;
    pub const external_memory_buffer_create_info_khr = StructureType.external_memory_buffer_create_info;
    pub const external_memory_image_create_info_khr = StructureType.external_memory_image_create_info;
    pub const export_memory_allocate_info_khr = StructureType.export_memory_allocate_info;
    pub const physical_device_external_semaphore_info_khr = StructureType.physical_device_external_semaphore_info;
    pub const external_semaphore_properties_khr = StructureType.external_semaphore_properties;
    pub const export_semaphore_create_info_khr = StructureType.export_semaphore_create_info;
    pub const physical_device_shader_float16_int8_features_khr = StructureType.physical_device_shader_float16_int8_features;
    pub const physical_device_float16_int8_features_khr = StructureType.physical_device_shader_float16_int8_features;
    pub const physical_device_16bit_storage_features_khr = StructureType.physical_device_16bit_storage_features;
    pub const descriptor_update_template_create_info_khr = StructureType.descriptor_update_template_create_info;
    pub const physical_device_imageless_framebuffer_features_khr = StructureType.physical_device_imageless_framebuffer_features;
    pub const framebuffer_attachments_create_info_khr = StructureType.framebuffer_attachments_create_info;
    pub const framebuffer_attachment_image_info_khr = StructureType.framebuffer_attachment_image_info;
    pub const render_pass_attachment_begin_info_khr = StructureType.render_pass_attachment_begin_info;
    pub const attachment_description_2_khr = StructureType.attachment_description_2;
    pub const attachment_reference_2_khr = StructureType.attachment_reference_2;
    pub const subpass_description_2_khr = StructureType.subpass_description_2;
    pub const subpass_dependency_2_khr = StructureType.subpass_dependency_2;
    pub const render_pass_create_info_2_khr = StructureType.render_pass_create_info_2;
    pub const subpass_begin_info_khr = StructureType.subpass_begin_info;
    pub const subpass_end_info_khr = StructureType.subpass_end_info;
    pub const physical_device_external_fence_info_khr = StructureType.physical_device_external_fence_info;
    pub const external_fence_properties_khr = StructureType.external_fence_properties;
    pub const export_fence_create_info_khr = StructureType.export_fence_create_info;
    pub const physical_device_point_clipping_properties_khr = StructureType.physical_device_point_clipping_properties;
    pub const render_pass_input_attachment_aspect_create_info_khr = StructureType.render_pass_input_attachment_aspect_create_info;
    pub const image_view_usage_create_info_khr = StructureType.image_view_usage_create_info;
    pub const pipeline_tessellation_domain_origin_state_create_info_khr = StructureType.pipeline_tessellation_domain_origin_state_create_info;
    pub const physical_device_variable_pointers_features_khr = StructureType.physical_device_variable_pointers_features;
    pub const physical_device_variable_pointer_features_khr = StructureType.physical_device_variable_pointers_features_khr;
    pub const memory_dedicated_requirements_khr = StructureType.memory_dedicated_requirements;
    pub const memory_dedicated_allocate_info_khr = StructureType.memory_dedicated_allocate_info;
    pub const physical_device_sampler_filter_minmax_properties_ext = StructureType.physical_device_sampler_filter_minmax_properties;
    pub const sampler_reduction_mode_create_info_ext = StructureType.sampler_reduction_mode_create_info;
    pub const buffer_memory_requirements_info_2_khr = StructureType.buffer_memory_requirements_info_2;
    pub const image_memory_requirements_info_2_khr = StructureType.image_memory_requirements_info_2;
    pub const image_sparse_memory_requirements_info_2_khr = StructureType.image_sparse_memory_requirements_info_2;
    pub const memory_requirements_2_khr = StructureType.memory_requirements_2;
    pub const sparse_image_memory_requirements_2_khr = StructureType.sparse_image_memory_requirements_2;
    pub const image_format_list_create_info_khr = StructureType.image_format_list_create_info;
    pub const sampler_ycbcr_conversion_create_info_khr = StructureType.sampler_ycbcr_conversion_create_info;
    pub const sampler_ycbcr_conversion_info_khr = StructureType.sampler_ycbcr_conversion_info;
    pub const bind_image_plane_memory_info_khr = StructureType.bind_image_plane_memory_info;
    pub const image_plane_memory_requirements_info_khr = StructureType.image_plane_memory_requirements_info;
    pub const physical_device_sampler_ycbcr_conversion_features_khr = StructureType.physical_device_sampler_ycbcr_conversion_features;
    pub const sampler_ycbcr_conversion_image_format_properties_khr = StructureType.sampler_ycbcr_conversion_image_format_properties;
    pub const bind_buffer_memory_info_khr = StructureType.bind_buffer_memory_info;
    pub const bind_image_memory_info_khr = StructureType.bind_image_memory_info;
    pub const descriptor_set_layout_binding_flags_create_info_ext = StructureType.descriptor_set_layout_binding_flags_create_info;
    pub const physical_device_descriptor_indexing_features_ext = StructureType.physical_device_descriptor_indexing_features;
    pub const physical_device_descriptor_indexing_properties_ext = StructureType.physical_device_descriptor_indexing_properties;
    pub const descriptor_set_variable_descriptor_count_allocate_info_ext = StructureType.descriptor_set_variable_descriptor_count_allocate_info;
    pub const descriptor_set_variable_descriptor_count_layout_support_ext = StructureType.descriptor_set_variable_descriptor_count_layout_support;
    pub const physical_device_maintenance_3_properties_khr = StructureType.physical_device_maintenance_3_properties;
    pub const descriptor_set_layout_support_khr = StructureType.descriptor_set_layout_support;
    pub const physical_device_shader_subgroup_extended_types_features_khr = StructureType.physical_device_shader_subgroup_extended_types_features;
    pub const physical_device_8bit_storage_features_khr = StructureType.physical_device_8bit_storage_features;
    pub const physical_device_shader_atomic_int64_features_khr = StructureType.physical_device_shader_atomic_int64_features;
    pub const physical_device_driver_properties_khr = StructureType.physical_device_driver_properties;
    pub const physical_device_float_controls_properties_khr = StructureType.physical_device_float_controls_properties;
    pub const physical_device_depth_stencil_resolve_properties_khr = StructureType.physical_device_depth_stencil_resolve_properties;
    pub const subpass_description_depth_stencil_resolve_khr = StructureType.subpass_description_depth_stencil_resolve;
    pub const physical_device_timeline_semaphore_features_khr = StructureType.physical_device_timeline_semaphore_features;
    pub const physical_device_timeline_semaphore_properties_khr = StructureType.physical_device_timeline_semaphore_properties;
    pub const semaphore_type_create_info_khr = StructureType.semaphore_type_create_info;
    pub const timeline_semaphore_submit_info_khr = StructureType.timeline_semaphore_submit_info;
    pub const semaphore_wait_info_khr = StructureType.semaphore_wait_info;
    pub const semaphore_signal_info_khr = StructureType.semaphore_signal_info;
    pub const query_pool_create_info_intel = StructureType.query_pool_performance_query_create_info_intel;
    pub const physical_device_vulkan_memory_model_features_khr = StructureType.physical_device_vulkan_memory_model_features;
    pub const physical_device_scalar_block_layout_features_ext = StructureType.physical_device_scalar_block_layout_features;
    pub const physical_device_separate_depth_stencil_layouts_features_khr = StructureType.physical_device_separate_depth_stencil_layouts_features;
    pub const attachment_reference_stencil_layout_khr = StructureType.attachment_reference_stencil_layout;
    pub const attachment_description_stencil_layout_khr = StructureType.attachment_description_stencil_layout;
    pub const physical_device_buffer_address_features_ext = StructureType.physical_device_buffer_device_address_features_ext;
    pub const buffer_device_address_info_ext = StructureType.buffer_device_address_info;
    pub const image_stencil_usage_create_info_ext = StructureType.image_stencil_usage_create_info;
    pub const physical_device_uniform_buffer_standard_layout_features_khr = StructureType.physical_device_uniform_buffer_standard_layout_features;
    pub const physical_device_buffer_device_address_features_khr = StructureType.physical_device_buffer_device_address_features;
    pub const buffer_device_address_info_khr = StructureType.buffer_device_address_info;
    pub const buffer_opaque_capture_address_create_info_khr = StructureType.buffer_opaque_capture_address_create_info;
    pub const memory_opaque_capture_address_allocate_info_khr = StructureType.memory_opaque_capture_address_allocate_info;
    pub const device_memory_opaque_capture_address_info_khr = StructureType.device_memory_opaque_capture_address_info;
    pub const physical_device_host_query_reset_features_ext = StructureType.physical_device_host_query_reset_features;
};
pub const SubpassContents = enum(c_int) {
    @"inline" = 0,
    secondary_command_buffers = 1,
    _,
};
pub const Result = enum(c_int) {
    success = 0,
    not_ready = 1,
    timeout = 2,
    event_set = 3,
    event_reset = 4,
    incomplete = 5,
    error_out_of_host_memory = -1,
    error_out_of_device_memory = -2,
    error_initialization_failed = -3,
    error_device_lost = -4,
    error_memory_map_failed = -5,
    error_layer_not_present = -6,
    error_extension_not_present = -7,
    error_feature_not_present = -8,
    error_incompatible_driver = -9,
    error_too_many_objects = -10,
    error_format_not_supported = -11,
    error_fragmented_pool = -12,
    error_unknown = -13,
    error_out_of_pool_memory = -1000069000,
    error_invalid_external_handle = -1000072003,
    error_fragmentation = -1000161000,
    error_invalid_opaque_capture_address = -1000257000,
    error_surface_lost_khr = -1000000000,
    error_native_window_in_use_khr = -1000000001,
    suboptimal_khr = 1000001003,
    error_out_of_date_khr = -1000001004,
    error_incompatible_display_khr = -1000003001,
    error_validation_failed_ext = -1000011001,
    error_invalid_shader_nv = -1000012000,
    error_invalid_drm_format_modifier_plane_layout_ext = -1000158000,
    error_not_permitted_ext = -1000174001,
    error_full_screen_exclusive_mode_lost_ext = -1000255000,
    thread_idle_khr = 1000268000,
    thread_done_khr = 1000268001,
    operation_deferred_khr = 1000268002,
    operation_not_deferred_khr = 1000268003,
    pipeline_compile_required_ext = 1000297000,
    _,
    pub const error_out_of_pool_memory_khr = Result.error_out_of_pool_memory;
    pub const error_invalid_external_handle_khr = Result.error_invalid_external_handle;
    pub const error_fragmentation_ext = Result.error_fragmentation;
    pub const error_invalid_device_address_ext = Result.error_invalid_opaque_capture_address;
    pub const error_invalid_opaque_capture_address_khr = Result.error_invalid_opaque_capture_address;
    pub const error_pipeline_compile_required_ext = Result.pipeline_compile_required_ext;
};
pub const DynamicState = enum(c_int) {
    viewport = 0,
    scissor = 1,
    line_width = 2,
    depth_bias = 3,
    blend_constants = 4,
    depth_bounds = 5,
    stencil_compare_mask = 6,
    stencil_write_mask = 7,
    stencil_reference = 8,
    viewport_w_scaling_nv = 1000087000,
    discard_rectangle_ext = 1000099000,
    sample_locations_ext = 1000143000,
    ray_tracing_pipeline_stack_size_khr = 1000347000,
    viewport_shading_rate_palette_nv = 1000164004,
    viewport_coarse_sample_order_nv = 1000164006,
    exclusive_scissor_nv = 1000205001,
    fragment_shading_rate_khr = 1000226000,
    line_stipple_ext = 1000259000,
    cull_mode_ext = 1000267000,
    front_face_ext = 1000267001,
    primitive_topology_ext = 1000267002,
    viewport_with_count_ext = 1000267003,
    scissor_with_count_ext = 1000267004,
    vertex_input_binding_stride_ext = 1000267005,
    depth_test_enable_ext = 1000267006,
    depth_write_enable_ext = 1000267007,
    depth_compare_op_ext = 1000267008,
    depth_bounds_test_enable_ext = 1000267009,
    stencil_test_enable_ext = 1000267010,
    stencil_op_ext = 1000267011,
    vertex_input_ext = 1000352000,
    patch_control_points_ext = 1000377000,
    rasterizer_discard_enable_ext = 1000377001,
    depth_bias_enable_ext = 1000377002,
    logic_op_ext = 1000377003,
    primitive_restart_enable_ext = 1000377004,
    color_write_enable_ext = 1000381000,
    _,
};
pub const DescriptorUpdateTemplateType = enum(c_int) {
    descriptor_set = 0,
    push_descriptors_khr = 1,
    _,
    pub const descriptor_set_khr = DescriptorUpdateTemplateType.descriptor_set;
};
pub const ObjectType = enum(c_int) {
    unknown = 0,
    instance = 1,
    physical_device = 2,
    device = 3,
    queue = 4,
    semaphore = 5,
    command_buffer = 6,
    fence = 7,
    device_memory = 8,
    buffer = 9,
    image = 10,
    event = 11,
    query_pool = 12,
    buffer_view = 13,
    image_view = 14,
    shader_module = 15,
    pipeline_cache = 16,
    pipeline_layout = 17,
    render_pass = 18,
    pipeline = 19,
    descriptor_set_layout = 20,
    sampler = 21,
    descriptor_pool = 22,
    descriptor_set = 23,
    framebuffer = 24,
    command_pool = 25,
    sampler_ycbcr_conversion = 1000156000,
    descriptor_update_template = 1000085000,
    surface_khr = 1000000000,
    swapchain_khr = 1000001000,
    display_khr = 1000002000,
    display_mode_khr = 1000002001,
    debug_report_callback_ext = 1000011000,
    video_session_khr = 1000023000,
    video_session_parameters_khr = 1000023001,
    cu_module_nvx = 1000029000,
    cu_function_nvx = 1000029001,
    debug_utils_messenger_ext = 1000128000,
    acceleration_structure_khr = 1000150000,
    validation_cache_ext = 1000160000,
    acceleration_structure_nv = 1000165000,
    performance_configuration_intel = 1000210000,
    deferred_operation_khr = 1000268000,
    indirect_commands_layout_nv = 1000277000,
    private_data_slot_ext = 1000295000,
    buffer_collection_fuchsia = 1000366000,
    _,
    pub const descriptor_update_template_khr = ObjectType.descriptor_update_template;
    pub const sampler_ycbcr_conversion_khr = ObjectType.sampler_ycbcr_conversion;
};
pub const QueueFlags = packed struct {
    graphics_bit: bool align(@alignOf(Flags)) = false,
    compute_bit: bool = false,
    transfer_bit: bool = false,
    sparse_binding_bit: bool = false,
    protected_bit: bool = false,
    video_decode_bit_khr: bool = false,
    video_encode_bit_khr: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(QueueFlags, Flags);
};
pub const CullModeFlags = packed struct {
    front_bit: bool align(@alignOf(Flags)) = false,
    back_bit: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(CullModeFlags, Flags);
};
pub const RenderPassCreateFlags = packed struct {
    _reserved_bit_0: bool align(@alignOf(Flags)) = false,
    transform_bit_qcom: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(RenderPassCreateFlags, Flags);
};
pub const DeviceQueueCreateFlags = packed struct {
    protected_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DeviceQueueCreateFlags, Flags);
};
pub const MemoryPropertyFlags = packed struct {
    device_local_bit: bool align(@alignOf(Flags)) = false,
    host_visible_bit: bool = false,
    host_coherent_bit: bool = false,
    host_cached_bit: bool = false,
    lazily_allocated_bit: bool = false,
    protected_bit: bool = false,
    device_coherent_bit_amd: bool = false,
    device_uncached_bit_amd: bool = false,
    rdma_capable_bit_nv: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(MemoryPropertyFlags, Flags);
};
pub const MemoryHeapFlags = packed struct {
    device_local_bit: bool align(@alignOf(Flags)) = false,
    multi_instance_bit: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(MemoryHeapFlags, Flags);
};
pub const AccessFlags = packed struct {
    indirect_command_read_bit: bool align(@alignOf(Flags)) = false,
    index_read_bit: bool = false,
    vertex_attribute_read_bit: bool = false,
    uniform_read_bit: bool = false,
    input_attachment_read_bit: bool = false,
    shader_read_bit: bool = false,
    shader_write_bit: bool = false,
    color_attachment_read_bit: bool = false,
    color_attachment_write_bit: bool = false,
    depth_stencil_attachment_read_bit: bool = false,
    depth_stencil_attachment_write_bit: bool = false,
    transfer_read_bit: bool = false,
    transfer_write_bit: bool = false,
    host_read_bit: bool = false,
    host_write_bit: bool = false,
    memory_read_bit: bool = false,
    memory_write_bit: bool = false,
    command_preprocess_read_bit_nv: bool = false,
    command_preprocess_write_bit_nv: bool = false,
    color_attachment_read_noncoherent_bit_ext: bool = false,
    conditional_rendering_read_bit_ext: bool = false,
    acceleration_structure_read_bit_khr: bool = false,
    acceleration_structure_write_bit_khr: bool = false,
    fragment_shading_rate_attachment_read_bit_khr: bool = false,
    fragment_density_map_read_bit_ext: bool = false,
    transform_feedback_write_bit_ext: bool = false,
    transform_feedback_counter_read_bit_ext: bool = false,
    transform_feedback_counter_write_bit_ext: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(AccessFlags, Flags);
};
pub const BufferUsageFlags = packed struct {
    transfer_src_bit: bool align(@alignOf(Flags)) = false,
    transfer_dst_bit: bool = false,
    uniform_texel_buffer_bit: bool = false,
    storage_texel_buffer_bit: bool = false,
    uniform_buffer_bit: bool = false,
    storage_buffer_bit: bool = false,
    index_buffer_bit: bool = false,
    vertex_buffer_bit: bool = false,
    indirect_buffer_bit: bool = false,
    conditional_rendering_bit_ext: bool = false,
    shader_binding_table_bit_khr: bool = false,
    transform_feedback_buffer_bit_ext: bool = false,
    transform_feedback_counter_buffer_bit_ext: bool = false,
    video_decode_src_bit_khr: bool = false,
    video_decode_dst_bit_khr: bool = false,
    video_encode_dst_bit_khr: bool = false,
    video_encode_src_bit_khr: bool = false,
    shader_device_address_bit: bool = false,
    _reserved_bit_18: bool = false,
    acceleration_structure_build_input_read_only_bit_khr: bool = false,
    acceleration_structure_storage_bit_khr: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(BufferUsageFlags, Flags);
};
pub const BufferCreateFlags = packed struct {
    sparse_binding_bit: bool align(@alignOf(Flags)) = false,
    sparse_residency_bit: bool = false,
    sparse_aliased_bit: bool = false,
    protected_bit: bool = false,
    device_address_capture_replay_bit: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(BufferCreateFlags, Flags);
};
pub const ShaderStageFlags = packed struct {
    vertex_bit: bool align(@alignOf(Flags)) = false,
    tessellation_control_bit: bool = false,
    tessellation_evaluation_bit: bool = false,
    geometry_bit: bool = false,
    fragment_bit: bool = false,
    compute_bit: bool = false,
    task_bit_nv: bool = false,
    mesh_bit_nv: bool = false,
    raygen_bit_khr: bool = false,
    any_hit_bit_khr: bool = false,
    closest_hit_bit_khr: bool = false,
    miss_bit_khr: bool = false,
    intersection_bit_khr: bool = false,
    callable_bit_khr: bool = false,
    subpass_shading_bit_huawei: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ShaderStageFlags, Flags);
};
pub const ImageUsageFlags = packed struct {
    transfer_src_bit: bool align(@alignOf(Flags)) = false,
    transfer_dst_bit: bool = false,
    sampled_bit: bool = false,
    storage_bit: bool = false,
    color_attachment_bit: bool = false,
    depth_stencil_attachment_bit: bool = false,
    transient_attachment_bit: bool = false,
    input_attachment_bit: bool = false,
    fragment_shading_rate_attachment_bit_khr: bool = false,
    fragment_density_map_bit_ext: bool = false,
    video_decode_dst_bit_khr: bool = false,
    video_decode_src_bit_khr: bool = false,
    video_decode_dpb_bit_khr: bool = false,
    video_encode_dst_bit_khr: bool = false,
    video_encode_src_bit_khr: bool = false,
    video_encode_dpb_bit_khr: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    invocation_mask_bit_huawei: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ImageUsageFlags, Flags);
};
pub const ImageCreateFlags = packed struct {
    sparse_binding_bit: bool align(@alignOf(Flags)) = false,
    sparse_residency_bit: bool = false,
    sparse_aliased_bit: bool = false,
    mutable_format_bit: bool = false,
    cube_compatible_bit: bool = false,
    @"2d_array_compatible_bit": bool = false,
    split_instance_bind_regions_bit: bool = false,
    block_texel_view_compatible_bit: bool = false,
    extended_usage_bit: bool = false,
    disjoint_bit: bool = false,
    alias_bit: bool = false,
    protected_bit: bool = false,
    sample_locations_compatible_depth_bit_ext: bool = false,
    corner_sampled_bit_nv: bool = false,
    subsampled_bit_ext: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ImageCreateFlags, Flags);
};
pub const ImageViewCreateFlags = packed struct {
    fragment_density_map_dynamic_bit_ext: bool align(@alignOf(Flags)) = false,
    fragment_density_map_deferred_bit_ext: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ImageViewCreateFlags, Flags);
};
pub const SamplerCreateFlags = packed struct {
    subsampled_bit_ext: bool align(@alignOf(Flags)) = false,
    subsampled_coarse_reconstruction_bit_ext: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SamplerCreateFlags, Flags);
};
pub const PipelineCreateFlags = packed struct {
    disable_optimization_bit: bool align(@alignOf(Flags)) = false,
    allow_derivatives_bit: bool = false,
    derivative_bit: bool = false,
    view_index_from_device_index_bit: bool = false,
    dispatch_base_bit: bool = false,
    defer_compile_bit_nv: bool = false,
    capture_statistics_bit_khr: bool = false,
    capture_internal_representations_bit_khr: bool = false,
    fail_on_pipeline_compile_required_bit_ext: bool = false,
    early_return_on_failure_bit_ext: bool = false,
    _reserved_bit_10: bool = false,
    library_bit_khr: bool = false,
    ray_tracing_skip_triangles_bit_khr: bool = false,
    ray_tracing_skip_aabbs_bit_khr: bool = false,
    ray_tracing_no_null_any_hit_shaders_bit_khr: bool = false,
    ray_tracing_no_null_closest_hit_shaders_bit_khr: bool = false,
    ray_tracing_no_null_miss_shaders_bit_khr: bool = false,
    ray_tracing_no_null_intersection_shaders_bit_khr: bool = false,
    indirect_bindable_bit_nv: bool = false,
    ray_tracing_shader_group_handle_capture_replay_bit_khr: bool = false,
    ray_tracing_allow_motion_bit_nv: bool = false,
    rasterization_state_create_fragment_shading_rate_attachment_bit_khr: bool = false,
    rasterization_state_create_fragment_density_map_attachment_bit_ext: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(PipelineCreateFlags, Flags);
};
pub const PipelineShaderStageCreateFlags = packed struct {
    allow_varying_subgroup_size_bit_ext: bool align(@alignOf(Flags)) = false,
    require_full_subgroups_bit_ext: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(PipelineShaderStageCreateFlags, Flags);
};
pub const ColorComponentFlags = packed struct {
    r_bit: bool align(@alignOf(Flags)) = false,
    g_bit: bool = false,
    b_bit: bool = false,
    a_bit: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ColorComponentFlags, Flags);
};
pub const FenceCreateFlags = packed struct {
    signaled_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(FenceCreateFlags, Flags);
};
pub const FormatFeatureFlags = packed struct {
    sampled_image_bit: bool align(@alignOf(Flags)) = false,
    storage_image_bit: bool = false,
    storage_image_atomic_bit: bool = false,
    uniform_texel_buffer_bit: bool = false,
    storage_texel_buffer_bit: bool = false,
    storage_texel_buffer_atomic_bit: bool = false,
    vertex_buffer_bit: bool = false,
    color_attachment_bit: bool = false,
    color_attachment_blend_bit: bool = false,
    depth_stencil_attachment_bit: bool = false,
    blit_src_bit: bool = false,
    blit_dst_bit: bool = false,
    sampled_image_filter_linear_bit: bool = false,
    sampled_image_filter_cubic_bit_img: bool = false,
    transfer_src_bit: bool = false,
    transfer_dst_bit: bool = false,
    sampled_image_filter_minmax_bit: bool = false,
    midpoint_chroma_samples_bit: bool = false,
    sampled_image_ycbcr_conversion_linear_filter_bit: bool = false,
    sampled_image_ycbcr_conversion_separate_reconstruction_filter_bit: bool = false,
    sampled_image_ycbcr_conversion_chroma_reconstruction_explicit_bit: bool = false,
    sampled_image_ycbcr_conversion_chroma_reconstruction_explicit_forceable_bit: bool = false,
    disjoint_bit: bool = false,
    cosited_chroma_samples_bit: bool = false,
    fragment_density_map_bit_ext: bool = false,
    video_decode_output_bit_khr: bool = false,
    video_decode_dpb_bit_khr: bool = false,
    video_encode_input_bit_khr: bool = false,
    video_encode_dpb_bit_khr: bool = false,
    acceleration_structure_vertex_buffer_bit_khr: bool = false,
    fragment_shading_rate_attachment_bit_khr: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(FormatFeatureFlags, Flags);
};
pub const QueryControlFlags = packed struct {
    precise_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(QueryControlFlags, Flags);
};
pub const QueryResultFlags = packed struct {
    @"64_bit": bool align(@alignOf(Flags)) = false,
    wait_bit: bool = false,
    with_availability_bit: bool = false,
    partial_bit: bool = false,
    with_status_bit_khr: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(QueryResultFlags, Flags);
};
pub const CommandBufferUsageFlags = packed struct {
    one_time_submit_bit: bool align(@alignOf(Flags)) = false,
    render_pass_continue_bit: bool = false,
    simultaneous_use_bit: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(CommandBufferUsageFlags, Flags);
};
pub const QueryPipelineStatisticFlags = packed struct {
    input_assembly_vertices_bit: bool align(@alignOf(Flags)) = false,
    input_assembly_primitives_bit: bool = false,
    vertex_shader_invocations_bit: bool = false,
    geometry_shader_invocations_bit: bool = false,
    geometry_shader_primitives_bit: bool = false,
    clipping_invocations_bit: bool = false,
    clipping_primitives_bit: bool = false,
    fragment_shader_invocations_bit: bool = false,
    tessellation_control_shader_patches_bit: bool = false,
    tessellation_evaluation_shader_invocations_bit: bool = false,
    compute_shader_invocations_bit: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(QueryPipelineStatisticFlags, Flags);
};
pub const ImageAspectFlags = packed struct {
    color_bit: bool align(@alignOf(Flags)) = false,
    depth_bit: bool = false,
    stencil_bit: bool = false,
    metadata_bit: bool = false,
    plane_0_bit: bool = false,
    plane_1_bit: bool = false,
    plane_2_bit: bool = false,
    memory_plane_0_bit_ext: bool = false,
    memory_plane_1_bit_ext: bool = false,
    memory_plane_2_bit_ext: bool = false,
    memory_plane_3_bit_ext: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ImageAspectFlags, Flags);
};
pub const SparseImageFormatFlags = packed struct {
    single_miptail_bit: bool align(@alignOf(Flags)) = false,
    aligned_mip_size_bit: bool = false,
    nonstandard_block_size_bit: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SparseImageFormatFlags, Flags);
};
pub const SparseMemoryBindFlags = packed struct {
    metadata_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SparseMemoryBindFlags, Flags);
};
pub const PipelineStageFlags = packed struct {
    top_of_pipe_bit: bool align(@alignOf(Flags)) = false,
    draw_indirect_bit: bool = false,
    vertex_input_bit: bool = false,
    vertex_shader_bit: bool = false,
    tessellation_control_shader_bit: bool = false,
    tessellation_evaluation_shader_bit: bool = false,
    geometry_shader_bit: bool = false,
    fragment_shader_bit: bool = false,
    early_fragment_tests_bit: bool = false,
    late_fragment_tests_bit: bool = false,
    color_attachment_output_bit: bool = false,
    compute_shader_bit: bool = false,
    transfer_bit: bool = false,
    bottom_of_pipe_bit: bool = false,
    host_bit: bool = false,
    all_graphics_bit: bool = false,
    all_commands_bit: bool = false,
    command_preprocess_bit_nv: bool = false,
    conditional_rendering_bit_ext: bool = false,
    task_shader_bit_nv: bool = false,
    mesh_shader_bit_nv: bool = false,
    ray_tracing_shader_bit_khr: bool = false,
    fragment_shading_rate_attachment_bit_khr: bool = false,
    fragment_density_process_bit_ext: bool = false,
    transform_feedback_bit_ext: bool = false,
    acceleration_structure_build_bit_khr: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(PipelineStageFlags, Flags);
};
pub const CommandPoolCreateFlags = packed struct {
    transient_bit: bool align(@alignOf(Flags)) = false,
    reset_command_buffer_bit: bool = false,
    protected_bit: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(CommandPoolCreateFlags, Flags);
};
pub const CommandPoolResetFlags = packed struct {
    release_resources_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(CommandPoolResetFlags, Flags);
};
pub const CommandBufferResetFlags = packed struct {
    release_resources_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(CommandBufferResetFlags, Flags);
};
pub const SampleCountFlags = packed struct {
    @"1_bit": bool align(@alignOf(Flags)) = false,
    @"2_bit": bool = false,
    @"4_bit": bool = false,
    @"8_bit": bool = false,
    @"16_bit": bool = false,
    @"32_bit": bool = false,
    @"64_bit": bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SampleCountFlags, Flags);
};
pub const AttachmentDescriptionFlags = packed struct {
    may_alias_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(AttachmentDescriptionFlags, Flags);
};
pub const StencilFaceFlags = packed struct {
    front_bit: bool align(@alignOf(Flags)) = false,
    back_bit: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(StencilFaceFlags, Flags);
};
pub const DescriptorPoolCreateFlags = packed struct {
    free_descriptor_set_bit: bool align(@alignOf(Flags)) = false,
    update_after_bind_bit: bool = false,
    host_only_bit_valve: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DescriptorPoolCreateFlags, Flags);
};
pub const DependencyFlags = packed struct {
    by_region_bit: bool align(@alignOf(Flags)) = false,
    view_local_bit: bool = false,
    device_group_bit: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DependencyFlags, Flags);
};
pub const SemaphoreType = enum(c_int) {
    binary = 0,
    timeline = 1,
    _,
    pub const binary_khr = SemaphoreType.binary;
    pub const timeline_khr = SemaphoreType.timeline;
};
pub const SemaphoreWaitFlags = packed struct {
    any_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SemaphoreWaitFlags, Flags);
};
pub const PresentModeKHR = enum(c_int) {
    immediate_khr = 0,
    mailbox_khr = 1,
    fifo_khr = 2,
    fifo_relaxed_khr = 3,
    shared_demand_refresh_khr = 1000111000,
    shared_continuous_refresh_khr = 1000111001,
    _,
};
pub const ColorSpaceKHR = enum(c_int) {
    srgb_nonlinear_khr = 0,
    display_p3_nonlinear_ext = 1000104001,
    extended_srgb_linear_ext = 1000104002,
    display_p3_linear_ext = 1000104003,
    dci_p3_nonlinear_ext = 1000104004,
    bt709_linear_ext = 1000104005,
    bt709_nonlinear_ext = 1000104006,
    bt2020_linear_ext = 1000104007,
    hdr10_st2084_ext = 1000104008,
    dolbyvision_ext = 1000104009,
    hdr10_hlg_ext = 1000104010,
    adobergb_linear_ext = 1000104011,
    adobergb_nonlinear_ext = 1000104012,
    pass_through_ext = 1000104013,
    extended_srgb_nonlinear_ext = 1000104014,
    display_native_amd = 1000213000,
    _,
};
pub const DisplayPlaneAlphaFlagsKHR = packed struct {
    opaque_bit_khr: bool align(@alignOf(Flags)) = false,
    global_bit_khr: bool = false,
    per_pixel_bit_khr: bool = false,
    per_pixel_premultiplied_bit_khr: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DisplayPlaneAlphaFlagsKHR, Flags);
};
pub const CompositeAlphaFlagsKHR = packed struct {
    opaque_bit_khr: bool align(@alignOf(Flags)) = false,
    pre_multiplied_bit_khr: bool = false,
    post_multiplied_bit_khr: bool = false,
    inherit_bit_khr: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(CompositeAlphaFlagsKHR, Flags);
};
pub const SurfaceTransformFlagsKHR = packed struct {
    identity_bit_khr: bool align(@alignOf(Flags)) = false,
    rotate_90_bit_khr: bool = false,
    rotate_180_bit_khr: bool = false,
    rotate_270_bit_khr: bool = false,
    horizontal_mirror_bit_khr: bool = false,
    horizontal_mirror_rotate_90_bit_khr: bool = false,
    horizontal_mirror_rotate_180_bit_khr: bool = false,
    horizontal_mirror_rotate_270_bit_khr: bool = false,
    inherit_bit_khr: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SurfaceTransformFlagsKHR, Flags);
};
pub const SwapchainImageUsageFlagsANDROID = packed struct {
    shared_bit_android: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SwapchainImageUsageFlagsANDROID, Flags);
};
pub const TimeDomainEXT = enum(c_int) {
    device_ext = 0,
    clock_monotonic_ext = 1,
    clock_monotonic_raw_ext = 2,
    query_performance_counter_ext = 3,
    _,
};
pub const DebugReportFlagsEXT = packed struct {
    information_bit_ext: bool align(@alignOf(Flags)) = false,
    warning_bit_ext: bool = false,
    performance_warning_bit_ext: bool = false,
    error_bit_ext: bool = false,
    debug_bit_ext: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DebugReportFlagsEXT, Flags);
};
pub const DebugReportObjectTypeEXT = enum(c_int) {
    unknown_ext = 0,
    instance_ext = 1,
    physical_device_ext = 2,
    device_ext = 3,
    queue_ext = 4,
    semaphore_ext = 5,
    command_buffer_ext = 6,
    fence_ext = 7,
    device_memory_ext = 8,
    buffer_ext = 9,
    image_ext = 10,
    event_ext = 11,
    query_pool_ext = 12,
    buffer_view_ext = 13,
    image_view_ext = 14,
    shader_module_ext = 15,
    pipeline_cache_ext = 16,
    pipeline_layout_ext = 17,
    render_pass_ext = 18,
    pipeline_ext = 19,
    descriptor_set_layout_ext = 20,
    sampler_ext = 21,
    descriptor_pool_ext = 22,
    descriptor_set_ext = 23,
    framebuffer_ext = 24,
    command_pool_ext = 25,
    surface_khr_ext = 26,
    swapchain_khr_ext = 27,
    debug_report_callback_ext_ext = 28,
    display_khr_ext = 29,
    display_mode_khr_ext = 30,
    validation_cache_ext_ext = 33,
    sampler_ycbcr_conversion_ext = 1000156000,
    descriptor_update_template_ext = 1000085000,
    cu_module_nvx_ext = 1000029000,
    cu_function_nvx_ext = 1000029001,
    acceleration_structure_khr_ext = 1000150000,
    acceleration_structure_nv_ext = 1000165000,
    buffer_collection_fuchsia_ext = 1000366000,
    _,
    pub const descriptor_update_template_khr_ext = DebugReportObjectTypeEXT.descriptor_update_template_ext;
    pub const sampler_ycbcr_conversion_khr_ext = DebugReportObjectTypeEXT.sampler_ycbcr_conversion_ext;
};
pub const DeviceMemoryReportEventTypeEXT = enum(c_int) {
    allocate_ext = 0,
    free_ext = 1,
    import_ext = 2,
    unimport_ext = 3,
    allocation_failed_ext = 4,
    _,
};
pub const RasterizationOrderAMD = enum(c_int) {
    strict_amd = 0,
    relaxed_amd = 1,
    _,
};
pub const ExternalMemoryHandleTypeFlagsNV = packed struct {
    opaque_win32_bit_nv: bool align(@alignOf(Flags)) = false,
    opaque_win32_kmt_bit_nv: bool = false,
    d3d11_image_bit_nv: bool = false,
    d3d11_image_kmt_bit_nv: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ExternalMemoryHandleTypeFlagsNV, Flags);
};
pub const ExternalMemoryFeatureFlagsNV = packed struct {
    dedicated_only_bit_nv: bool align(@alignOf(Flags)) = false,
    exportable_bit_nv: bool = false,
    importable_bit_nv: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ExternalMemoryFeatureFlagsNV, Flags);
};
pub const ValidationCheckEXT = enum(c_int) {
    all_ext = 0,
    shaders_ext = 1,
    _,
};
pub const ValidationFeatureEnableEXT = enum(c_int) {
    gpu_assisted_ext = 0,
    gpu_assisted_reserve_binding_slot_ext = 1,
    best_practices_ext = 2,
    debug_printf_ext = 3,
    synchronization_validation_ext = 4,
    _,
};
pub const ValidationFeatureDisableEXT = enum(c_int) {
    all_ext = 0,
    shaders_ext = 1,
    thread_safety_ext = 2,
    api_parameters_ext = 3,
    object_lifetimes_ext = 4,
    core_checks_ext = 5,
    unique_handles_ext = 6,
    shader_validation_cache_ext = 7,
    _,
};
pub const SubgroupFeatureFlags = packed struct {
    basic_bit: bool align(@alignOf(Flags)) = false,
    vote_bit: bool = false,
    arithmetic_bit: bool = false,
    ballot_bit: bool = false,
    shuffle_bit: bool = false,
    shuffle_relative_bit: bool = false,
    clustered_bit: bool = false,
    quad_bit: bool = false,
    partitioned_bit_nv: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SubgroupFeatureFlags, Flags);
};
pub const IndirectCommandsLayoutUsageFlagsNV = packed struct {
    explicit_preprocess_bit_nv: bool align(@alignOf(Flags)) = false,
    indexed_sequences_bit_nv: bool = false,
    unordered_sequences_bit_nv: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(IndirectCommandsLayoutUsageFlagsNV, Flags);
};
pub const IndirectStateFlagsNV = packed struct {
    flag_frontface_bit_nv: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(IndirectStateFlagsNV, Flags);
};
pub const IndirectCommandsTokenTypeNV = enum(c_int) {
    shader_group_nv = 0,
    state_flags_nv = 1,
    index_buffer_nv = 2,
    vertex_buffer_nv = 3,
    push_constant_nv = 4,
    draw_indexed_nv = 5,
    draw_nv = 6,
    draw_tasks_nv = 7,
    _,
};
pub const PrivateDataSlotCreateFlagsEXT = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PrivateDataSlotCreateFlagsEXT, Flags);
};
pub const DescriptorSetLayoutCreateFlags = packed struct {
    push_descriptor_bit_khr: bool align(@alignOf(Flags)) = false,
    update_after_bind_pool_bit: bool = false,
    host_only_pool_bit_valve: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DescriptorSetLayoutCreateFlags, Flags);
};
pub const ExternalMemoryHandleTypeFlags = packed struct {
    opaque_fd_bit: bool align(@alignOf(Flags)) = false,
    opaque_win32_bit: bool = false,
    opaque_win32_kmt_bit: bool = false,
    d3d11_texture_bit: bool = false,
    d3d11_texture_kmt_bit: bool = false,
    d3d12_heap_bit: bool = false,
    d3d12_resource_bit: bool = false,
    host_allocation_bit_ext: bool = false,
    host_mapped_foreign_memory_bit_ext: bool = false,
    dma_buf_bit_ext: bool = false,
    android_hardware_buffer_bit_android: bool = false,
    zircon_vmo_bit_fuchsia: bool = false,
    rdma_address_bit_nv: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ExternalMemoryHandleTypeFlags, Flags);
};
pub const ExternalMemoryFeatureFlags = packed struct {
    dedicated_only_bit: bool align(@alignOf(Flags)) = false,
    exportable_bit: bool = false,
    importable_bit: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ExternalMemoryFeatureFlags, Flags);
};
pub const ExternalSemaphoreHandleTypeFlags = packed struct {
    opaque_fd_bit: bool align(@alignOf(Flags)) = false,
    opaque_win32_bit: bool = false,
    opaque_win32_kmt_bit: bool = false,
    d3d12_fence_bit: bool = false,
    sync_fd_bit: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    zircon_event_bit_fuchsia: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ExternalSemaphoreHandleTypeFlags, Flags);
};
pub const ExternalSemaphoreFeatureFlags = packed struct {
    exportable_bit: bool align(@alignOf(Flags)) = false,
    importable_bit: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ExternalSemaphoreFeatureFlags, Flags);
};
pub const SemaphoreImportFlags = packed struct {
    temporary_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SemaphoreImportFlags, Flags);
};
pub const ExternalFenceHandleTypeFlags = packed struct {
    opaque_fd_bit: bool align(@alignOf(Flags)) = false,
    opaque_win32_bit: bool = false,
    opaque_win32_kmt_bit: bool = false,
    sync_fd_bit: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ExternalFenceHandleTypeFlags, Flags);
};
pub const ExternalFenceFeatureFlags = packed struct {
    exportable_bit: bool align(@alignOf(Flags)) = false,
    importable_bit: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ExternalFenceFeatureFlags, Flags);
};
pub const FenceImportFlags = packed struct {
    temporary_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(FenceImportFlags, Flags);
};
pub const SurfaceCounterFlagsEXT = packed struct {
    vblank_bit_ext: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SurfaceCounterFlagsEXT, Flags);
};
pub const DisplayPowerStateEXT = enum(c_int) {
    off_ext = 0,
    suspend_ext = 1,
    on_ext = 2,
    _,
};
pub const DeviceEventTypeEXT = enum(c_int) {
    display_hotplug_ext = 0,
    _,
};
pub const DisplayEventTypeEXT = enum(c_int) {
    first_pixel_out_ext = 0,
    _,
};
pub const PeerMemoryFeatureFlags = packed struct {
    copy_src_bit: bool align(@alignOf(Flags)) = false,
    copy_dst_bit: bool = false,
    generic_src_bit: bool = false,
    generic_dst_bit: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(PeerMemoryFeatureFlags, Flags);
};
pub const MemoryAllocateFlags = packed struct {
    device_mask_bit: bool align(@alignOf(Flags)) = false,
    device_address_bit: bool = false,
    device_address_capture_replay_bit: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(MemoryAllocateFlags, Flags);
};
pub const DeviceGroupPresentModeFlagsKHR = packed struct {
    local_bit_khr: bool align(@alignOf(Flags)) = false,
    remote_bit_khr: bool = false,
    sum_bit_khr: bool = false,
    local_multi_device_bit_khr: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DeviceGroupPresentModeFlagsKHR, Flags);
};
pub const SwapchainCreateFlagsKHR = packed struct {
    split_instance_bind_regions_bit_khr: bool align(@alignOf(Flags)) = false,
    protected_bit_khr: bool = false,
    mutable_format_bit_khr: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SwapchainCreateFlagsKHR, Flags);
};
pub const ViewportCoordinateSwizzleNV = enum(c_int) {
    positive_x_nv = 0,
    negative_x_nv = 1,
    positive_y_nv = 2,
    negative_y_nv = 3,
    positive_z_nv = 4,
    negative_z_nv = 5,
    positive_w_nv = 6,
    negative_w_nv = 7,
    _,
};
pub const DiscardRectangleModeEXT = enum(c_int) {
    inclusive_ext = 0,
    exclusive_ext = 1,
    _,
};
pub const SubpassDescriptionFlags = packed struct {
    per_view_attributes_bit_nvx: bool align(@alignOf(Flags)) = false,
    per_view_position_x_only_bit_nvx: bool = false,
    fragment_region_bit_qcom: bool = false,
    shader_resolve_bit_qcom: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SubpassDescriptionFlags, Flags);
};
pub const PointClippingBehavior = enum(c_int) {
    all_clip_planes = 0,
    user_clip_planes_only = 1,
    _,
    pub const all_clip_planes_khr = PointClippingBehavior.all_clip_planes;
    pub const user_clip_planes_only_khr = PointClippingBehavior.user_clip_planes_only;
};
pub const SamplerReductionMode = enum(c_int) {
    weighted_average = 0,
    min = 1,
    max = 2,
    _,
    pub const weighted_average_ext = SamplerReductionMode.weighted_average;
    pub const min_ext = SamplerReductionMode.min;
    pub const max_ext = SamplerReductionMode.max;
};
pub const TessellationDomainOrigin = enum(c_int) {
    upper_left = 0,
    lower_left = 1,
    _,
    pub const upper_left_khr = TessellationDomainOrigin.upper_left;
    pub const lower_left_khr = TessellationDomainOrigin.lower_left;
};
pub const SamplerYcbcrModelConversion = enum(c_int) {
    rgb_identity = 0,
    ycbcr_identity = 1,
    ycbcr_709 = 2,
    ycbcr_601 = 3,
    ycbcr_2020 = 4,
    _,
    pub const rgb_identity_khr = SamplerYcbcrModelConversion.rgb_identity;
    pub const ycbcr_identity_khr = SamplerYcbcrModelConversion.ycbcr_identity;
    pub const ycbcr_709_khr = SamplerYcbcrModelConversion.ycbcr_709;
    pub const ycbcr_601_khr = SamplerYcbcrModelConversion.ycbcr_601;
    pub const ycbcr_2020_khr = SamplerYcbcrModelConversion.ycbcr_2020;
};
pub const SamplerYcbcrRange = enum(c_int) {
    itu_full = 0,
    itu_narrow = 1,
    _,
    pub const itu_full_khr = SamplerYcbcrRange.itu_full;
    pub const itu_narrow_khr = SamplerYcbcrRange.itu_narrow;
};
pub const ChromaLocation = enum(c_int) {
    cosited_even = 0,
    midpoint = 1,
    _,
    pub const cosited_even_khr = ChromaLocation.cosited_even;
    pub const midpoint_khr = ChromaLocation.midpoint;
};
pub const BlendOverlapEXT = enum(c_int) {
    uncorrelated_ext = 0,
    disjoint_ext = 1,
    conjoint_ext = 2,
    _,
};
pub const CoverageModulationModeNV = enum(c_int) {
    none_nv = 0,
    rgb_nv = 1,
    alpha_nv = 2,
    rgba_nv = 3,
    _,
};
pub const CoverageReductionModeNV = enum(c_int) {
    merge_nv = 0,
    truncate_nv = 1,
    _,
};
pub const ValidationCacheHeaderVersionEXT = enum(c_int) {
    one_ext = 1,
    _,
};
pub const ShaderInfoTypeAMD = enum(c_int) {
    statistics_amd = 0,
    binary_amd = 1,
    disassembly_amd = 2,
    _,
};
pub const QueueGlobalPriorityEXT = enum(c_int) {
    low_ext = 128,
    medium_ext = 256,
    high_ext = 512,
    realtime_ext = 1024,
    _,
};
pub const DebugUtilsMessageSeverityFlagsEXT = packed struct {
    verbose_bit_ext: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    info_bit_ext: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    warning_bit_ext: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    error_bit_ext: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DebugUtilsMessageSeverityFlagsEXT, Flags);
};
pub const DebugUtilsMessageTypeFlagsEXT = packed struct {
    general_bit_ext: bool align(@alignOf(Flags)) = false,
    validation_bit_ext: bool = false,
    performance_bit_ext: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DebugUtilsMessageTypeFlagsEXT, Flags);
};
pub const ConservativeRasterizationModeEXT = enum(c_int) {
    disabled_ext = 0,
    overestimate_ext = 1,
    underestimate_ext = 2,
    _,
};
pub const DescriptorBindingFlags = packed struct {
    update_after_bind_bit: bool align(@alignOf(Flags)) = false,
    update_unused_while_pending_bit: bool = false,
    partially_bound_bit: bool = false,
    variable_descriptor_count_bit: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DescriptorBindingFlags, Flags);
};
pub const VendorId = enum(c_int) {
    _viv = 0x10001,
    _vsi = 0x10002,
    kazan = 0x10003,
    codeplay = 0x10004,
    _mesa = 0x10005,
    pocl = 0x10006,
    _,
};
pub const DriverId = enum(c_int) {
    amd_proprietary = 1,
    amd_open_source = 2,
    mesa_radv = 3,
    nvidia_proprietary = 4,
    intel_proprietary_windows = 5,
    intel_open_source_mesa = 6,
    imagination_proprietary = 7,
    qualcomm_proprietary = 8,
    arm_proprietary = 9,
    google_swiftshader = 10,
    ggp_proprietary = 11,
    broadcom_proprietary = 12,
    mesa_llvmpipe = 13,
    moltenvk = 14,
    coreavi_proprietary = 15,
    juice_proprietary = 16,
    verisilicon_proprietary = 17,
    mesa_turnip = 18,
    mesa_v3dv = 19,
    mesa_panvk = 20,
    _,
    pub const amd_proprietary_khr = DriverId.amd_proprietary;
    pub const amd_open_source_khr = DriverId.amd_open_source;
    pub const mesa_radv_khr = DriverId.mesa_radv;
    pub const nvidia_proprietary_khr = DriverId.nvidia_proprietary;
    pub const intel_proprietary_windows_khr = DriverId.intel_proprietary_windows;
    pub const intel_open_source_mesa_khr = DriverId.intel_open_source_mesa;
    pub const imagination_proprietary_khr = DriverId.imagination_proprietary;
    pub const qualcomm_proprietary_khr = DriverId.qualcomm_proprietary;
    pub const arm_proprietary_khr = DriverId.arm_proprietary;
    pub const google_swiftshader_khr = DriverId.google_swiftshader;
    pub const ggp_proprietary_khr = DriverId.ggp_proprietary;
    pub const broadcom_proprietary_khr = DriverId.broadcom_proprietary;
};
pub const ConditionalRenderingFlagsEXT = packed struct {
    inverted_bit_ext: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ConditionalRenderingFlagsEXT, Flags);
};
pub const ResolveModeFlags = packed struct {
    sample_zero_bit: bool align(@alignOf(Flags)) = false,
    average_bit: bool = false,
    min_bit: bool = false,
    max_bit: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ResolveModeFlags, Flags);
};
pub const ShadingRatePaletteEntryNV = enum(c_int) {
    no_invocations_nv = 0,
    @"16_invocations_per_pixel_nv" = 1,
    @"8_invocations_per_pixel_nv" = 2,
    @"4_invocations_per_pixel_nv" = 3,
    @"2_invocations_per_pixel_nv" = 4,
    @"1_invocation_per_pixel_nv" = 5,
    @"1_invocation_per_2x1_pixels_nv" = 6,
    @"1_invocation_per_1x2_pixels_nv" = 7,
    @"1_invocation_per_2x2_pixels_nv" = 8,
    @"1_invocation_per_4x2_pixels_nv" = 9,
    @"1_invocation_per_2x4_pixels_nv" = 10,
    @"1_invocation_per_4x4_pixels_nv" = 11,
    _,
};
pub const CoarseSampleOrderTypeNV = enum(c_int) {
    default_nv = 0,
    custom_nv = 1,
    pixel_major_nv = 2,
    sample_major_nv = 3,
    _,
};
pub const GeometryInstanceFlagsKHR = packed struct {
    triangle_facing_cull_disable_bit_khr: bool align(@alignOf(Flags)) = false,
    triangle_flip_facing_bit_khr: bool = false,
    force_opaque_bit_khr: bool = false,
    force_no_opaque_bit_khr: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(GeometryInstanceFlagsKHR, Flags);
};
pub const GeometryFlagsKHR = packed struct {
    opaque_bit_khr: bool align(@alignOf(Flags)) = false,
    no_duplicate_any_hit_invocation_bit_khr: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(GeometryFlagsKHR, Flags);
};
pub const BuildAccelerationStructureFlagsKHR = packed struct {
    allow_update_bit_khr: bool align(@alignOf(Flags)) = false,
    allow_compaction_bit_khr: bool = false,
    prefer_fast_trace_bit_khr: bool = false,
    prefer_fast_build_bit_khr: bool = false,
    low_memory_bit_khr: bool = false,
    motion_bit_nv: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(BuildAccelerationStructureFlagsKHR, Flags);
};
pub const AccelerationStructureCreateFlagsKHR = packed struct {
    device_address_capture_replay_bit_khr: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    motion_bit_nv: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(AccelerationStructureCreateFlagsKHR, Flags);
};
pub const CopyAccelerationStructureModeKHR = enum(c_int) {
    clone_khr = 0,
    compact_khr = 1,
    serialize_khr = 2,
    deserialize_khr = 3,
    _,
    pub const clone_nv = CopyAccelerationStructureModeKHR.clone_khr;
    pub const compact_nv = CopyAccelerationStructureModeKHR.compact_khr;
};
pub const BuildAccelerationStructureModeKHR = enum(c_int) {
    build_khr = 0,
    update_khr = 1,
    _,
};
pub const AccelerationStructureTypeKHR = enum(c_int) {
    top_level_khr = 0,
    bottom_level_khr = 1,
    generic_khr = 2,
    _,
    pub const top_level_nv = AccelerationStructureTypeKHR.top_level_khr;
    pub const bottom_level_nv = AccelerationStructureTypeKHR.bottom_level_khr;
};
pub const GeometryTypeKHR = enum(c_int) {
    triangles_khr = 0,
    aabbs_khr = 1,
    instances_khr = 2,
    _,
    pub const triangles_nv = GeometryTypeKHR.triangles_khr;
    pub const aabbs_nv = GeometryTypeKHR.aabbs_khr;
};
pub const AccelerationStructureMemoryRequirementsTypeNV = enum(c_int) {
    object_nv = 0,
    build_scratch_nv = 1,
    update_scratch_nv = 2,
    _,
};
pub const AccelerationStructureBuildTypeKHR = enum(c_int) {
    host_khr = 0,
    device_khr = 1,
    host_or_device_khr = 2,
    _,
};
pub const RayTracingShaderGroupTypeKHR = enum(c_int) {
    general_khr = 0,
    triangles_hit_group_khr = 1,
    procedural_hit_group_khr = 2,
    _,
    pub const general_nv = RayTracingShaderGroupTypeKHR.general_khr;
    pub const triangles_hit_group_nv = RayTracingShaderGroupTypeKHR.triangles_hit_group_khr;
    pub const procedural_hit_group_nv = RayTracingShaderGroupTypeKHR.procedural_hit_group_khr;
};
pub const AccelerationStructureCompatibilityKHR = enum(c_int) {
    compatible_khr = 0,
    incompatible_khr = 1,
    _,
};
pub const ShaderGroupShaderKHR = enum(c_int) {
    general_khr = 0,
    closest_hit_khr = 1,
    any_hit_khr = 2,
    intersection_khr = 3,
    _,
};
pub const MemoryOverallocationBehaviorAMD = enum(c_int) {
    default_amd = 0,
    allowed_amd = 1,
    disallowed_amd = 2,
    _,
};
pub const FramebufferCreateFlags = packed struct {
    imageless_bit: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(FramebufferCreateFlags, Flags);
};
pub const ScopeNV = enum(c_int) {
    device_nv = 1,
    workgroup_nv = 2,
    subgroup_nv = 3,
    queue_family_nv = 5,
    _,
};
pub const ComponentTypeNV = enum(c_int) {
    float16_nv = 0,
    float32_nv = 1,
    float64_nv = 2,
    sint8_nv = 3,
    sint16_nv = 4,
    sint32_nv = 5,
    sint64_nv = 6,
    uint8_nv = 7,
    uint16_nv = 8,
    uint32_nv = 9,
    uint64_nv = 10,
    _,
};
pub const DeviceDiagnosticsConfigFlagsNV = packed struct {
    enable_shader_debug_info_bit_nv: bool align(@alignOf(Flags)) = false,
    enable_resource_tracking_bit_nv: bool = false,
    enable_automatic_checkpoints_bit_nv: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(DeviceDiagnosticsConfigFlagsNV, Flags);
};
pub const PipelineCreationFeedbackFlagsEXT = packed struct {
    valid_bit_ext: bool align(@alignOf(Flags)) = false,
    application_pipeline_cache_hit_bit_ext: bool = false,
    base_pipeline_acceleration_bit_ext: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(PipelineCreationFeedbackFlagsEXT, Flags);
};
pub const FullScreenExclusiveEXT = enum(c_int) {
    default_ext = 0,
    allowed_ext = 1,
    disallowed_ext = 2,
    application_controlled_ext = 3,
    _,
};
pub const PerformanceCounterScopeKHR = enum(c_int) {
    command_buffer_khr = 0,
    render_pass_khr = 1,
    command_khr = 2,
    _,
    pub const query_scope_command_buffer_khr = PerformanceCounterScopeKHR.command_buffer_khr;
    pub const query_scope_render_pass_khr = PerformanceCounterScopeKHR.render_pass_khr;
    pub const query_scope_command_khr = PerformanceCounterScopeKHR.command_khr;
};
pub const PerformanceCounterUnitKHR = enum(c_int) {
    generic_khr = 0,
    percentage_khr = 1,
    nanoseconds_khr = 2,
    bytes_khr = 3,
    bytes_per_second_khr = 4,
    kelvin_khr = 5,
    watts_khr = 6,
    volts_khr = 7,
    amps_khr = 8,
    hertz_khr = 9,
    cycles_khr = 10,
    _,
};
pub const PerformanceCounterStorageKHR = enum(c_int) {
    int32_khr = 0,
    int64_khr = 1,
    uint32_khr = 2,
    uint64_khr = 3,
    float32_khr = 4,
    float64_khr = 5,
    _,
};
pub const PerformanceCounterDescriptionFlagsKHR = packed struct {
    performance_impacting_bit_khr: bool align(@alignOf(Flags)) = false,
    concurrently_impacted_bit_khr: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(PerformanceCounterDescriptionFlagsKHR, Flags);
};
pub const AcquireProfilingLockFlagsKHR = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(AcquireProfilingLockFlagsKHR, Flags);
};
pub const ShaderCorePropertiesFlagsAMD = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(ShaderCorePropertiesFlagsAMD, Flags);
};
pub const PerformanceConfigurationTypeINTEL = enum(c_int) {
    command_queue_metrics_discovery_activated_intel = 0,
    _,
};
pub const QueryPoolSamplingModeINTEL = enum(c_int) {
    manual_intel = 0,
    _,
};
pub const PerformanceOverrideTypeINTEL = enum(c_int) {
    null_hardware_intel = 0,
    flush_gpu_caches_intel = 1,
    _,
};
pub const PerformanceParameterTypeINTEL = enum(c_int) {
    hw_counters_supported_intel = 0,
    stream_marker_valid_bits_intel = 1,
    _,
};
pub const PerformanceValueTypeINTEL = enum(c_int) {
    uint32_intel = 0,
    uint64_intel = 1,
    float_intel = 2,
    bool_intel = 3,
    string_intel = 4,
    _,
};
pub const ShaderFloatControlsIndependence = enum(c_int) {
    @"32_bit_only" = 0,
    all = 1,
    none = 2,
    _,
    pub const @"32_bit_only_khr" = ShaderFloatControlsIndependence.@"32_bit_only";
    pub const all_khr = ShaderFloatControlsIndependence.all;
    pub const none_khr = ShaderFloatControlsIndependence.none;
};
pub const PipelineExecutableStatisticFormatKHR = enum(c_int) {
    bool32_khr = 0,
    int64_khr = 1,
    uint64_khr = 2,
    float64_khr = 3,
    _,
};
pub const LineRasterizationModeEXT = enum(c_int) {
    default_ext = 0,
    rectangular_ext = 1,
    bresenham_ext = 2,
    rectangular_smooth_ext = 3,
    _,
};
pub const PipelineCompilerControlFlagsAMD = packed struct {
    _reserved_bits: Flags = 0,
    pub usingnamespace FlagsMixin(PipelineCompilerControlFlagsAMD, Flags);
};
pub const ToolPurposeFlagsEXT = packed struct {
    validation_bit_ext: bool align(@alignOf(Flags)) = false,
    profiling_bit_ext: bool = false,
    tracing_bit_ext: bool = false,
    additional_features_bit_ext: bool = false,
    modifying_features_bit_ext: bool = false,
    debug_reporting_bit_ext: bool = false,
    debug_markers_bit_ext: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ToolPurposeFlagsEXT, Flags);
};
pub const FragmentShadingRateCombinerOpKHR = enum(c_int) {
    keep_khr = 0,
    replace_khr = 1,
    min_khr = 2,
    max_khr = 3,
    mul_khr = 4,
    _,
};
pub const FragmentShadingRateNV = enum(c_int) {
    @"1_invocation_per_pixel_nv" = 0,
    @"1_invocation_per_1x2_pixels_nv" = 1,
    @"1_invocation_per_2x1_pixels_nv" = 4,
    @"1_invocation_per_2x2_pixels_nv" = 5,
    @"1_invocation_per_2x4_pixels_nv" = 6,
    @"1_invocation_per_4x2_pixels_nv" = 9,
    @"1_invocation_per_4x4_pixels_nv" = 10,
    @"2_invocations_per_pixel_nv" = 11,
    @"4_invocations_per_pixel_nv" = 12,
    @"8_invocations_per_pixel_nv" = 13,
    @"16_invocations_per_pixel_nv" = 14,
    no_invocations_nv = 15,
    _,
};
pub const FragmentShadingRateTypeNV = enum(c_int) {
    fragment_size_nv = 0,
    enums_nv = 1,
    _,
};
pub const AccessFlags2KHR = packed struct {
    indirect_command_read_bit_khr: bool align(@alignOf(Flags64)) = false,
    index_read_bit_khr: bool = false,
    vertex_attribute_read_bit_khr: bool = false,
    uniform_read_bit_khr: bool = false,
    input_attachment_read_bit_khr: bool = false,
    shader_read_bit_khr: bool = false,
    shader_write_bit_khr: bool = false,
    color_attachment_read_bit_khr: bool = false,
    color_attachment_write_bit_khr: bool = false,
    depth_stencil_attachment_read_bit_khr: bool = false,
    depth_stencil_attachment_write_bit_khr: bool = false,
    transfer_read_bit_khr: bool = false,
    transfer_write_bit_khr: bool = false,
    host_read_bit_khr: bool = false,
    host_write_bit_khr: bool = false,
    memory_read_bit_khr: bool = false,
    memory_write_bit_khr: bool = false,
    command_preprocess_read_bit_nv: bool = false,
    command_preprocess_write_bit_nv: bool = false,
    color_attachment_read_noncoherent_bit_ext: bool = false,
    conditional_rendering_read_bit_ext: bool = false,
    acceleration_structure_read_bit_khr: bool = false,
    acceleration_structure_write_bit_khr: bool = false,
    fragment_shading_rate_attachment_read_bit_khr: bool = false,
    fragment_density_map_read_bit_ext: bool = false,
    transform_feedback_write_bit_ext: bool = false,
    transform_feedback_counter_read_bit_ext: bool = false,
    transform_feedback_counter_write_bit_ext: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    shader_sampled_read_bit_khr: bool = false,
    shader_storage_read_bit_khr: bool = false,
    shader_storage_write_bit_khr: bool = false,
    video_decode_read_bit_khr: bool = false,
    video_decode_write_bit_khr: bool = false,
    video_encode_read_bit_khr: bool = false,
    video_encode_write_bit_khr: bool = false,
    invocation_mask_read_bit_huawei: bool = false,
    _reserved_bit_40: bool = false,
    _reserved_bit_41: bool = false,
    _reserved_bit_42: bool = false,
    _reserved_bit_43: bool = false,
    _reserved_bit_44: bool = false,
    _reserved_bit_45: bool = false,
    _reserved_bit_46: bool = false,
    _reserved_bit_47: bool = false,
    _reserved_bit_48: bool = false,
    _reserved_bit_49: bool = false,
    _reserved_bit_50: bool = false,
    _reserved_bit_51: bool = false,
    _reserved_bit_52: bool = false,
    _reserved_bit_53: bool = false,
    _reserved_bit_54: bool = false,
    _reserved_bit_55: bool = false,
    _reserved_bit_56: bool = false,
    _reserved_bit_57: bool = false,
    _reserved_bit_58: bool = false,
    _reserved_bit_59: bool = false,
    _reserved_bit_60: bool = false,
    _reserved_bit_61: bool = false,
    _reserved_bit_62: bool = false,
    _reserved_bit_63: bool = false,
    pub usingnamespace FlagsMixin(AccessFlags2KHR, Flags64);
};
pub const PipelineStageFlags2KHR = packed struct {
    top_of_pipe_bit_khr: bool align(@alignOf(Flags64)) = false,
    draw_indirect_bit_khr: bool = false,
    vertex_input_bit_khr: bool = false,
    vertex_shader_bit_khr: bool = false,
    tessellation_control_shader_bit_khr: bool = false,
    tessellation_evaluation_shader_bit_khr: bool = false,
    geometry_shader_bit_khr: bool = false,
    fragment_shader_bit_khr: bool = false,
    early_fragment_tests_bit_khr: bool = false,
    late_fragment_tests_bit_khr: bool = false,
    color_attachment_output_bit_khr: bool = false,
    compute_shader_bit_khr: bool = false,
    all_transfer_bit_khr: bool = false,
    bottom_of_pipe_bit_khr: bool = false,
    host_bit_khr: bool = false,
    all_graphics_bit_khr: bool = false,
    all_commands_bit_khr: bool = false,
    command_preprocess_bit_nv: bool = false,
    conditional_rendering_bit_ext: bool = false,
    task_shader_bit_nv: bool = false,
    mesh_shader_bit_nv: bool = false,
    ray_tracing_shader_bit_khr: bool = false,
    fragment_shading_rate_attachment_bit_khr: bool = false,
    fragment_density_process_bit_ext: bool = false,
    transform_feedback_bit_ext: bool = false,
    acceleration_structure_build_bit_khr: bool = false,
    video_decode_bit_khr: bool = false,
    video_encode_bit_khr: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    copy_bit_khr: bool = false,
    resolve_bit_khr: bool = false,
    blit_bit_khr: bool = false,
    clear_bit_khr: bool = false,
    index_input_bit_khr: bool = false,
    vertex_attribute_input_bit_khr: bool = false,
    pre_rasterization_shaders_bit_khr: bool = false,
    subpass_shading_bit_huawei: bool = false,
    invocation_mask_bit_huawei: bool = false,
    _reserved_bit_41: bool = false,
    _reserved_bit_42: bool = false,
    _reserved_bit_43: bool = false,
    _reserved_bit_44: bool = false,
    _reserved_bit_45: bool = false,
    _reserved_bit_46: bool = false,
    _reserved_bit_47: bool = false,
    _reserved_bit_48: bool = false,
    _reserved_bit_49: bool = false,
    _reserved_bit_50: bool = false,
    _reserved_bit_51: bool = false,
    _reserved_bit_52: bool = false,
    _reserved_bit_53: bool = false,
    _reserved_bit_54: bool = false,
    _reserved_bit_55: bool = false,
    _reserved_bit_56: bool = false,
    _reserved_bit_57: bool = false,
    _reserved_bit_58: bool = false,
    _reserved_bit_59: bool = false,
    _reserved_bit_60: bool = false,
    _reserved_bit_61: bool = false,
    _reserved_bit_62: bool = false,
    _reserved_bit_63: bool = false,
    pub usingnamespace FlagsMixin(PipelineStageFlags2KHR, Flags64);
};
pub const SubmitFlagsKHR = packed struct {
    protected_bit_khr: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(SubmitFlagsKHR, Flags);
};
pub const EventCreateFlags = packed struct {
    device_only_bit_khr: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(EventCreateFlags, Flags);
};
pub const ProvokingVertexModeEXT = enum(c_int) {
    first_vertex_ext = 0,
    last_vertex_ext = 1,
    _,
};
pub const AccelerationStructureMotionInstanceTypeNV = enum(c_int) {
    static_nv = 0,
    matrix_motion_nv = 1,
    srt_motion_nv = 2,
    _,
};
pub const VideoCodecOperationFlagsKHR = packed struct {
    decode_h264_bit_ext: bool align(@alignOf(Flags)) = false,
    decode_h265_bit_ext: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    encode_h264_bit_ext: bool = false,
    encode_h265_bit_ext: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoCodecOperationFlagsKHR, Flags);
};
pub const VideoChromaSubsamplingFlagsKHR = packed struct {
    monochrome_bit_khr: bool align(@alignOf(Flags)) = false,
    @"420_bit_khr": bool = false,
    @"422_bit_khr": bool = false,
    @"444_bit_khr": bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoChromaSubsamplingFlagsKHR, Flags);
};
pub const VideoComponentBitDepthFlagsKHR = packed struct {
    @"8_bit_khr": bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    @"10_bit_khr": bool = false,
    _reserved_bit_3: bool = false,
    @"12_bit_khr": bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoComponentBitDepthFlagsKHR, Flags);
};
pub const VideoCapabilityFlagsKHR = packed struct {
    protected_content_bit_khr: bool align(@alignOf(Flags)) = false,
    separate_reference_images_bit_khr: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoCapabilityFlagsKHR, Flags);
};
pub const VideoSessionCreateFlagsKHR = packed struct {
    protected_content_bit_khr: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoSessionCreateFlagsKHR, Flags);
};
pub const VideoCodingQualityPresetFlagsKHR = packed struct {
    normal_bit_khr: bool align(@alignOf(Flags)) = false,
    power_bit_khr: bool = false,
    quality_bit_khr: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoCodingQualityPresetFlagsKHR, Flags);
};
pub const VideoDecodeH264PictureLayoutFlagsEXT = packed struct {
    interlaced_interleaved_lines_bit_ext: bool align(@alignOf(Flags)) = false,
    interlaced_separate_planes_bit_ext: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoDecodeH264PictureLayoutFlagsEXT, Flags);
};
pub const VideoCodingControlFlagsKHR = packed struct {
    reset_bit_khr: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoCodingControlFlagsKHR, Flags);
};
pub const QueryResultStatusKHR = enum(c_int) {
    error_khr = -1,
    not_ready_khr = 0,
    complete_khr = 1,
    _,
};
pub const VideoDecodeFlagsKHR = packed struct {
    reserved_0_bit_khr: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoDecodeFlagsKHR, Flags);
};
pub const VideoEncodeFlagsKHR = packed struct {
    reserved_0_bit_khr: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeFlagsKHR, Flags);
};
pub const VideoEncodeRateControlFlagsKHR = packed struct {
    reset_bit_khr: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeRateControlFlagsKHR, Flags);
};
pub const VideoEncodeRateControlModeFlagsKHR = packed struct {
    _reserved_bit_0: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeRateControlModeFlagsKHR, Flags);
};
pub const VideoEncodeH264CapabilityFlagsEXT = packed struct {
    cabac_bit_ext: bool align(@alignOf(Flags)) = false,
    cavlc_bit_ext: bool = false,
    weighted_bi_pred_implicit_bit_ext: bool = false,
    transform_8x8_bit_ext: bool = false,
    chroma_qp_offset_bit_ext: bool = false,
    second_chroma_qp_offset_bit_ext: bool = false,
    deblocking_filter_disabled_bit_ext: bool = false,
    deblocking_filter_enabled_bit_ext: bool = false,
    deblocking_filter_partial_bit_ext: bool = false,
    multiple_slice_per_frame_bit_ext: bool = false,
    evenly_distributed_slice_size_bit_ext: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeH264CapabilityFlagsEXT, Flags);
};
pub const VideoEncodeH264InputModeFlagsEXT = packed struct {
    frame_bit_ext: bool align(@alignOf(Flags)) = false,
    slice_bit_ext: bool = false,
    non_vcl_bit_ext: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeH264InputModeFlagsEXT, Flags);
};
pub const VideoEncodeH264OutputModeFlagsEXT = packed struct {
    frame_bit_ext: bool align(@alignOf(Flags)) = false,
    slice_bit_ext: bool = false,
    non_vcl_bit_ext: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeH264OutputModeFlagsEXT, Flags);
};
pub const VideoEncodeH264CreateFlagsEXT = packed struct {
    reserved_0_bit_ext: bool align(@alignOf(Flags)) = false,
    _reserved_bit_1: bool = false,
    _reserved_bit_2: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeH264CreateFlagsEXT, Flags);
};
pub const ImageConstraintsInfoFlagsFUCHSIA = packed struct {
    cpu_read_rarely_fuchsia: bool align(@alignOf(Flags)) = false,
    cpu_read_often_fuchsia: bool = false,
    cpu_write_rarely_fuchsia: bool = false,
    cpu_write_often_fuchsia: bool = false,
    protected_optional_fuchsia: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(ImageConstraintsInfoFlagsFUCHSIA, Flags);
};
pub const FormatFeatureFlags2KHR = packed struct {
    sampled_image_bit_khr: bool align(@alignOf(Flags64)) = false,
    storage_image_bit_khr: bool = false,
    storage_image_atomic_bit_khr: bool = false,
    uniform_texel_buffer_bit_khr: bool = false,
    storage_texel_buffer_bit_khr: bool = false,
    storage_texel_buffer_atomic_bit_khr: bool = false,
    vertex_buffer_bit_khr: bool = false,
    color_attachment_bit_khr: bool = false,
    color_attachment_blend_bit_khr: bool = false,
    depth_stencil_attachment_bit_khr: bool = false,
    blit_src_bit_khr: bool = false,
    blit_dst_bit_khr: bool = false,
    sampled_image_filter_linear_bit_khr: bool = false,
    sampled_image_filter_cubic_bit_ext: bool = false,
    transfer_src_bit_khr: bool = false,
    transfer_dst_bit_khr: bool = false,
    sampled_image_filter_minmax_bit_khr: bool = false,
    midpoint_chroma_samples_bit_khr: bool = false,
    sampled_image_ycbcr_conversion_linear_filter_bit_khr: bool = false,
    sampled_image_ycbcr_conversion_separate_reconstruction_filter_bit_khr: bool = false,
    sampled_image_ycbcr_conversion_chroma_reconstruction_explicit_bit_khr: bool = false,
    sampled_image_ycbcr_conversion_chroma_reconstruction_explicit_forceable_bit_khr: bool = false,
    disjoint_bit_khr: bool = false,
    cosited_chroma_samples_bit_khr: bool = false,
    fragment_density_map_bit_ext: bool = false,
    video_decode_output_bit_khr: bool = false,
    video_decode_dpb_bit_khr: bool = false,
    video_encode_input_bit_khr: bool = false,
    video_encode_dpb_bit_khr: bool = false,
    acceleration_structure_vertex_buffer_bit_khr: bool = false,
    fragment_shading_rate_attachment_bit_khr: bool = false,
    storage_read_without_format_bit_khr: bool = false,
    storage_write_without_format_bit_khr: bool = false,
    sampled_image_depth_comparison_bit_khr: bool = false,
    _reserved_bit_34: bool = false,
    _reserved_bit_35: bool = false,
    _reserved_bit_36: bool = false,
    _reserved_bit_37: bool = false,
    _reserved_bit_38: bool = false,
    _reserved_bit_39: bool = false,
    _reserved_bit_40: bool = false,
    _reserved_bit_41: bool = false,
    _reserved_bit_42: bool = false,
    _reserved_bit_43: bool = false,
    _reserved_bit_44: bool = false,
    _reserved_bit_45: bool = false,
    _reserved_bit_46: bool = false,
    _reserved_bit_47: bool = false,
    _reserved_bit_48: bool = false,
    _reserved_bit_49: bool = false,
    _reserved_bit_50: bool = false,
    _reserved_bit_51: bool = false,
    _reserved_bit_52: bool = false,
    _reserved_bit_53: bool = false,
    _reserved_bit_54: bool = false,
    _reserved_bit_55: bool = false,
    _reserved_bit_56: bool = false,
    _reserved_bit_57: bool = false,
    _reserved_bit_58: bool = false,
    _reserved_bit_59: bool = false,
    _reserved_bit_60: bool = false,
    _reserved_bit_61: bool = false,
    _reserved_bit_62: bool = false,
    _reserved_bit_63: bool = false,
    pub usingnamespace FlagsMixin(FormatFeatureFlags2KHR, Flags64);
};
pub const VideoEncodeH265InputModeFlagsEXT = packed struct {
    frame_bit_ext: bool align(@alignOf(Flags)) = false,
    slice_bit_ext: bool = false,
    non_vcl_bit_ext: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeH265InputModeFlagsEXT, Flags);
};
pub const VideoEncodeH265OutputModeFlagsEXT = packed struct {
    frame_bit_ext: bool align(@alignOf(Flags)) = false,
    slice_bit_ext: bool = false,
    non_vcl_bit_ext: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeH265OutputModeFlagsEXT, Flags);
};
pub const VideoEncodeH265CtbSizeFlagsEXT = packed struct {
    @"8_bit_ext": bool align(@alignOf(Flags)) = false,
    @"16_bit_ext": bool = false,
    @"32_bit_ext": bool = false,
    @"64_bit_ext": bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(VideoEncodeH265CtbSizeFlagsEXT, Flags);
};
pub const RenderingFlagsKHR = packed struct {
    contents_secondary_command_buffers_bit_khr: bool align(@alignOf(Flags)) = false,
    suspending_bit_khr: bool = false,
    resuming_bit_khr: bool = false,
    _reserved_bit_3: bool = false,
    _reserved_bit_4: bool = false,
    _reserved_bit_5: bool = false,
    _reserved_bit_6: bool = false,
    _reserved_bit_7: bool = false,
    _reserved_bit_8: bool = false,
    _reserved_bit_9: bool = false,
    _reserved_bit_10: bool = false,
    _reserved_bit_11: bool = false,
    _reserved_bit_12: bool = false,
    _reserved_bit_13: bool = false,
    _reserved_bit_14: bool = false,
    _reserved_bit_15: bool = false,
    _reserved_bit_16: bool = false,
    _reserved_bit_17: bool = false,
    _reserved_bit_18: bool = false,
    _reserved_bit_19: bool = false,
    _reserved_bit_20: bool = false,
    _reserved_bit_21: bool = false,
    _reserved_bit_22: bool = false,
    _reserved_bit_23: bool = false,
    _reserved_bit_24: bool = false,
    _reserved_bit_25: bool = false,
    _reserved_bit_26: bool = false,
    _reserved_bit_27: bool = false,
    _reserved_bit_28: bool = false,
    _reserved_bit_29: bool = false,
    _reserved_bit_30: bool = false,
    _reserved_bit_31: bool = false,
    pub usingnamespace FlagsMixin(RenderingFlagsKHR, Flags);
};
pub const PfnCreateInstance = fn (
    p_create_info: *const InstanceCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_instance: *Instance,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyInstance = fn (
    instance: Instance,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnEnumeratePhysicalDevices = fn (
    instance: Instance,
    p_physical_device_count: *u32,
    p_physical_devices: ?[*]PhysicalDevice,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDeviceProcAddr = fn (
    device: Device,
    p_name: [*:0]const u8,
) callconv(vulkan_call_conv) PfnVoidFunction;
pub const PfnGetInstanceProcAddr = fn (
    instance: Instance,
    p_name: [*:0]const u8,
) callconv(vulkan_call_conv) PfnVoidFunction;
pub const PfnGetPhysicalDeviceProperties = fn (
    physical_device: PhysicalDevice,
    p_properties: *PhysicalDeviceProperties,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceQueueFamilyProperties = fn (
    physical_device: PhysicalDevice,
    p_queue_family_property_count: *u32,
    p_queue_family_properties: ?[*]QueueFamilyProperties,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceMemoryProperties = fn (
    physical_device: PhysicalDevice,
    p_memory_properties: *PhysicalDeviceMemoryProperties,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceFeatures = fn (
    physical_device: PhysicalDevice,
    p_features: *PhysicalDeviceFeatures,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceFormatProperties = fn (
    physical_device: PhysicalDevice,
    format: Format,
    p_format_properties: *FormatProperties,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceImageFormatProperties = fn (
    physical_device: PhysicalDevice,
    format: Format,
    @"type": ImageType,
    tiling: ImageTiling,
    usage: ImageUsageFlags.IntType,
    flags: ImageCreateFlags.IntType,
    p_image_format_properties: *ImageFormatProperties,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateDevice = fn (
    physical_device: PhysicalDevice,
    p_create_info: *const DeviceCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_device: *Device,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyDevice = fn (
    device: Device,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnEnumerateInstanceVersion = fn (
    p_api_version: *u32,
) callconv(vulkan_call_conv) Result;
pub const PfnEnumerateInstanceLayerProperties = fn (
    p_property_count: *u32,
    p_properties: ?[*]LayerProperties,
) callconv(vulkan_call_conv) Result;
pub const PfnEnumerateInstanceExtensionProperties = fn (
    p_layer_name: ?[*:0]const u8,
    p_property_count: *u32,
    p_properties: ?[*]ExtensionProperties,
) callconv(vulkan_call_conv) Result;
pub const PfnEnumerateDeviceLayerProperties = fn (
    physical_device: PhysicalDevice,
    p_property_count: *u32,
    p_properties: ?[*]LayerProperties,
) callconv(vulkan_call_conv) Result;
pub const PfnEnumerateDeviceExtensionProperties = fn (
    physical_device: PhysicalDevice,
    p_layer_name: ?[*:0]const u8,
    p_property_count: *u32,
    p_properties: ?[*]ExtensionProperties,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDeviceQueue = fn (
    device: Device,
    queue_family_index: u32,
    queue_index: u32,
    p_queue: *Queue,
) callconv(vulkan_call_conv) void;
pub const PfnQueueSubmit = fn (
    queue: Queue,
    submit_count: u32,
    p_submits: [*]const SubmitInfo,
    fence: Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnQueueWaitIdle = fn (
    queue: Queue,
) callconv(vulkan_call_conv) Result;
pub const PfnDeviceWaitIdle = fn (
    device: Device,
) callconv(vulkan_call_conv) Result;
pub const PfnAllocateMemory = fn (
    device: Device,
    p_allocate_info: *const MemoryAllocateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_memory: *DeviceMemory,
) callconv(vulkan_call_conv) Result;
pub const PfnFreeMemory = fn (
    device: Device,
    memory: DeviceMemory,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnMapMemory = fn (
    device: Device,
    memory: DeviceMemory,
    offset: DeviceSize,
    size: DeviceSize,
    flags: MemoryMapFlags.IntType,
    pp_data: *?*c_void,
) callconv(vulkan_call_conv) Result;
pub const PfnUnmapMemory = fn (
    device: Device,
    memory: DeviceMemory,
) callconv(vulkan_call_conv) void;
pub const PfnFlushMappedMemoryRanges = fn (
    device: Device,
    memory_range_count: u32,
    p_memory_ranges: [*]const MappedMemoryRange,
) callconv(vulkan_call_conv) Result;
pub const PfnInvalidateMappedMemoryRanges = fn (
    device: Device,
    memory_range_count: u32,
    p_memory_ranges: [*]const MappedMemoryRange,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDeviceMemoryCommitment = fn (
    device: Device,
    memory: DeviceMemory,
    p_committed_memory_in_bytes: *DeviceSize,
) callconv(vulkan_call_conv) void;
pub const PfnGetBufferMemoryRequirements = fn (
    device: Device,
    buffer: Buffer,
    p_memory_requirements: *MemoryRequirements,
) callconv(vulkan_call_conv) void;
pub const PfnBindBufferMemory = fn (
    device: Device,
    buffer: Buffer,
    memory: DeviceMemory,
    memory_offset: DeviceSize,
) callconv(vulkan_call_conv) Result;
pub const PfnGetImageMemoryRequirements = fn (
    device: Device,
    image: Image,
    p_memory_requirements: *MemoryRequirements,
) callconv(vulkan_call_conv) void;
pub const PfnBindImageMemory = fn (
    device: Device,
    image: Image,
    memory: DeviceMemory,
    memory_offset: DeviceSize,
) callconv(vulkan_call_conv) Result;
pub const PfnGetImageSparseMemoryRequirements = fn (
    device: Device,
    image: Image,
    p_sparse_memory_requirement_count: *u32,
    p_sparse_memory_requirements: ?[*]SparseImageMemoryRequirements,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceSparseImageFormatProperties = fn (
    physical_device: PhysicalDevice,
    format: Format,
    @"type": ImageType,
    samples: SampleCountFlags.IntType,
    usage: ImageUsageFlags.IntType,
    tiling: ImageTiling,
    p_property_count: *u32,
    p_properties: ?[*]SparseImageFormatProperties,
) callconv(vulkan_call_conv) void;
pub const PfnQueueBindSparse = fn (
    queue: Queue,
    bind_info_count: u32,
    p_bind_info: [*]const BindSparseInfo,
    fence: Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateFence = fn (
    device: Device,
    p_create_info: *const FenceCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_fence: *Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyFence = fn (
    device: Device,
    fence: Fence,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnResetFences = fn (
    device: Device,
    fence_count: u32,
    p_fences: [*]const Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnGetFenceStatus = fn (
    device: Device,
    fence: Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnWaitForFences = fn (
    device: Device,
    fence_count: u32,
    p_fences: [*]const Fence,
    wait_all: Bool32,
    timeout: u64,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateSemaphore = fn (
    device: Device,
    p_create_info: *const SemaphoreCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_semaphore: *Semaphore,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroySemaphore = fn (
    device: Device,
    semaphore: Semaphore,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateEvent = fn (
    device: Device,
    p_create_info: *const EventCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_event: *Event,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyEvent = fn (
    device: Device,
    event: Event,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetEventStatus = fn (
    device: Device,
    event: Event,
) callconv(vulkan_call_conv) Result;
pub const PfnSetEvent = fn (
    device: Device,
    event: Event,
) callconv(vulkan_call_conv) Result;
pub const PfnResetEvent = fn (
    device: Device,
    event: Event,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateQueryPool = fn (
    device: Device,
    p_create_info: *const QueryPoolCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_query_pool: *QueryPool,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyQueryPool = fn (
    device: Device,
    query_pool: QueryPool,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetQueryPoolResults = fn (
    device: Device,
    query_pool: QueryPool,
    first_query: u32,
    query_count: u32,
    data_size: usize,
    p_data: *c_void,
    stride: DeviceSize,
    flags: QueryResultFlags.IntType,
) callconv(vulkan_call_conv) Result;
pub const PfnResetQueryPool = fn (
    device: Device,
    query_pool: QueryPool,
    first_query: u32,
    query_count: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCreateBuffer = fn (
    device: Device,
    p_create_info: *const BufferCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_buffer: *Buffer,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyBuffer = fn (
    device: Device,
    buffer: Buffer,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateBufferView = fn (
    device: Device,
    p_create_info: *const BufferViewCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_view: *BufferView,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyBufferView = fn (
    device: Device,
    buffer_view: BufferView,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateImage = fn (
    device: Device,
    p_create_info: *const ImageCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_image: *Image,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyImage = fn (
    device: Device,
    image: Image,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetImageSubresourceLayout = fn (
    device: Device,
    image: Image,
    p_subresource: *const ImageSubresource,
    p_layout: *SubresourceLayout,
) callconv(vulkan_call_conv) void;
pub const PfnCreateImageView = fn (
    device: Device,
    p_create_info: *const ImageViewCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_view: *ImageView,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyImageView = fn (
    device: Device,
    image_view: ImageView,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateShaderModule = fn (
    device: Device,
    p_create_info: *const ShaderModuleCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_shader_module: *ShaderModule,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyShaderModule = fn (
    device: Device,
    shader_module: ShaderModule,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreatePipelineCache = fn (
    device: Device,
    p_create_info: *const PipelineCacheCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_pipeline_cache: *PipelineCache,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyPipelineCache = fn (
    device: Device,
    pipeline_cache: PipelineCache,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetPipelineCacheData = fn (
    device: Device,
    pipeline_cache: PipelineCache,
    p_data_size: *usize,
    p_data: ?*c_void,
) callconv(vulkan_call_conv) Result;
pub const PfnMergePipelineCaches = fn (
    device: Device,
    dst_cache: PipelineCache,
    src_cache_count: u32,
    p_src_caches: [*]const PipelineCache,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateGraphicsPipelines = fn (
    device: Device,
    pipeline_cache: PipelineCache,
    create_info_count: u32,
    p_create_infos: [*]const GraphicsPipelineCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_pipelines: [*]Pipeline,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateComputePipelines = fn (
    device: Device,
    pipeline_cache: PipelineCache,
    create_info_count: u32,
    p_create_infos: [*]const ComputePipelineCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_pipelines: [*]Pipeline,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI = fn (
    device: Device,
    renderpass: RenderPass,
    p_max_workgroup_size: *Extent2D,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyPipeline = fn (
    device: Device,
    pipeline: Pipeline,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreatePipelineLayout = fn (
    device: Device,
    p_create_info: *const PipelineLayoutCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_pipeline_layout: *PipelineLayout,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyPipelineLayout = fn (
    device: Device,
    pipeline_layout: PipelineLayout,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateSampler = fn (
    device: Device,
    p_create_info: *const SamplerCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_sampler: *Sampler,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroySampler = fn (
    device: Device,
    sampler: Sampler,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateDescriptorSetLayout = fn (
    device: Device,
    p_create_info: *const DescriptorSetLayoutCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_set_layout: *DescriptorSetLayout,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyDescriptorSetLayout = fn (
    device: Device,
    descriptor_set_layout: DescriptorSetLayout,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateDescriptorPool = fn (
    device: Device,
    p_create_info: *const DescriptorPoolCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_descriptor_pool: *DescriptorPool,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyDescriptorPool = fn (
    device: Device,
    descriptor_pool: DescriptorPool,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnResetDescriptorPool = fn (
    device: Device,
    descriptor_pool: DescriptorPool,
    flags: DescriptorPoolResetFlags.IntType,
) callconv(vulkan_call_conv) Result;
pub const PfnAllocateDescriptorSets = fn (
    device: Device,
    p_allocate_info: *const DescriptorSetAllocateInfo,
    p_descriptor_sets: [*]DescriptorSet,
) callconv(vulkan_call_conv) Result;
pub const PfnFreeDescriptorSets = fn (
    device: Device,
    descriptor_pool: DescriptorPool,
    descriptor_set_count: u32,
    p_descriptor_sets: [*]const DescriptorSet,
) callconv(vulkan_call_conv) Result;
pub const PfnUpdateDescriptorSets = fn (
    device: Device,
    descriptor_write_count: u32,
    p_descriptor_writes: [*]const WriteDescriptorSet,
    descriptor_copy_count: u32,
    p_descriptor_copies: [*]const CopyDescriptorSet,
) callconv(vulkan_call_conv) void;
pub const PfnCreateFramebuffer = fn (
    device: Device,
    p_create_info: *const FramebufferCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_framebuffer: *Framebuffer,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyFramebuffer = fn (
    device: Device,
    framebuffer: Framebuffer,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateRenderPass = fn (
    device: Device,
    p_create_info: *const RenderPassCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_render_pass: *RenderPass,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyRenderPass = fn (
    device: Device,
    render_pass: RenderPass,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetRenderAreaGranularity = fn (
    device: Device,
    render_pass: RenderPass,
    p_granularity: *Extent2D,
) callconv(vulkan_call_conv) void;
pub const PfnCreateCommandPool = fn (
    device: Device,
    p_create_info: *const CommandPoolCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_command_pool: *CommandPool,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyCommandPool = fn (
    device: Device,
    command_pool: CommandPool,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnResetCommandPool = fn (
    device: Device,
    command_pool: CommandPool,
    flags: CommandPoolResetFlags.IntType,
) callconv(vulkan_call_conv) Result;
pub const PfnAllocateCommandBuffers = fn (
    device: Device,
    p_allocate_info: *const CommandBufferAllocateInfo,
    p_command_buffers: [*]CommandBuffer,
) callconv(vulkan_call_conv) Result;
pub const PfnFreeCommandBuffers = fn (
    device: Device,
    command_pool: CommandPool,
    command_buffer_count: u32,
    p_command_buffers: [*]const CommandBuffer,
) callconv(vulkan_call_conv) void;
pub const PfnBeginCommandBuffer = fn (
    command_buffer: CommandBuffer,
    p_begin_info: *const CommandBufferBeginInfo,
) callconv(vulkan_call_conv) Result;
pub const PfnEndCommandBuffer = fn (
    command_buffer: CommandBuffer,
) callconv(vulkan_call_conv) Result;
pub const PfnResetCommandBuffer = fn (
    command_buffer: CommandBuffer,
    flags: CommandBufferResetFlags.IntType,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdBindPipeline = fn (
    command_buffer: CommandBuffer,
    pipeline_bind_point: PipelineBindPoint,
    pipeline: Pipeline,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetViewport = fn (
    command_buffer: CommandBuffer,
    first_viewport: u32,
    viewport_count: u32,
    p_viewports: [*]const Viewport,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetScissor = fn (
    command_buffer: CommandBuffer,
    first_scissor: u32,
    scissor_count: u32,
    p_scissors: [*]const Rect2D,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetLineWidth = fn (
    command_buffer: CommandBuffer,
    line_width: f32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetDepthBias = fn (
    command_buffer: CommandBuffer,
    depth_bias_constant_factor: f32,
    depth_bias_clamp: f32,
    depth_bias_slope_factor: f32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetBlendConstants = fn (
    command_buffer: CommandBuffer,
    blend_constants: [4]f32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetDepthBounds = fn (
    command_buffer: CommandBuffer,
    min_depth_bounds: f32,
    max_depth_bounds: f32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetStencilCompareMask = fn (
    command_buffer: CommandBuffer,
    face_mask: StencilFaceFlags.IntType,
    compare_mask: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetStencilWriteMask = fn (
    command_buffer: CommandBuffer,
    face_mask: StencilFaceFlags.IntType,
    write_mask: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetStencilReference = fn (
    command_buffer: CommandBuffer,
    face_mask: StencilFaceFlags.IntType,
    reference: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBindDescriptorSets = fn (
    command_buffer: CommandBuffer,
    pipeline_bind_point: PipelineBindPoint,
    layout: PipelineLayout,
    first_set: u32,
    descriptor_set_count: u32,
    p_descriptor_sets: [*]const DescriptorSet,
    dynamic_offset_count: u32,
    p_dynamic_offsets: [*]const u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBindIndexBuffer = fn (
    command_buffer: CommandBuffer,
    buffer: Buffer,
    offset: DeviceSize,
    index_type: IndexType,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBindVertexBuffers = fn (
    command_buffer: CommandBuffer,
    first_binding: u32,
    binding_count: u32,
    p_buffers: [*]const Buffer,
    p_offsets: [*]const DeviceSize,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDraw = fn (
    command_buffer: CommandBuffer,
    vertex_count: u32,
    instance_count: u32,
    first_vertex: u32,
    first_instance: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawIndexed = fn (
    command_buffer: CommandBuffer,
    index_count: u32,
    instance_count: u32,
    first_index: u32,
    vertex_offset: i32,
    first_instance: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawMultiEXT = fn (
    command_buffer: CommandBuffer,
    draw_count: u32,
    p_vertex_info: [*]const MultiDrawInfoEXT,
    instance_count: u32,
    first_instance: u32,
    stride: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawMultiIndexedEXT = fn (
    command_buffer: CommandBuffer,
    draw_count: u32,
    p_index_info: [*]const MultiDrawIndexedInfoEXT,
    instance_count: u32,
    first_instance: u32,
    stride: u32,
    p_vertex_offset: ?*const i32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawIndirect = fn (
    command_buffer: CommandBuffer,
    buffer: Buffer,
    offset: DeviceSize,
    draw_count: u32,
    stride: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawIndexedIndirect = fn (
    command_buffer: CommandBuffer,
    buffer: Buffer,
    offset: DeviceSize,
    draw_count: u32,
    stride: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDispatch = fn (
    command_buffer: CommandBuffer,
    group_count_x: u32,
    group_count_y: u32,
    group_count_z: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDispatchIndirect = fn (
    command_buffer: CommandBuffer,
    buffer: Buffer,
    offset: DeviceSize,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSubpassShadingHUAWEI = fn (
    command_buffer: CommandBuffer,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyBuffer = fn (
    command_buffer: CommandBuffer,
    src_buffer: Buffer,
    dst_buffer: Buffer,
    region_count: u32,
    p_regions: [*]const BufferCopy,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyImage = fn (
    command_buffer: CommandBuffer,
    src_image: Image,
    src_image_layout: ImageLayout,
    dst_image: Image,
    dst_image_layout: ImageLayout,
    region_count: u32,
    p_regions: [*]const ImageCopy,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBlitImage = fn (
    command_buffer: CommandBuffer,
    src_image: Image,
    src_image_layout: ImageLayout,
    dst_image: Image,
    dst_image_layout: ImageLayout,
    region_count: u32,
    p_regions: [*]const ImageBlit,
    filter: Filter,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyBufferToImage = fn (
    command_buffer: CommandBuffer,
    src_buffer: Buffer,
    dst_image: Image,
    dst_image_layout: ImageLayout,
    region_count: u32,
    p_regions: [*]const BufferImageCopy,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyImageToBuffer = fn (
    command_buffer: CommandBuffer,
    src_image: Image,
    src_image_layout: ImageLayout,
    dst_buffer: Buffer,
    region_count: u32,
    p_regions: [*]const BufferImageCopy,
) callconv(vulkan_call_conv) void;
pub const PfnCmdUpdateBuffer = fn (
    command_buffer: CommandBuffer,
    dst_buffer: Buffer,
    dst_offset: DeviceSize,
    data_size: DeviceSize,
    p_data: *const c_void,
) callconv(vulkan_call_conv) void;
pub const PfnCmdFillBuffer = fn (
    command_buffer: CommandBuffer,
    dst_buffer: Buffer,
    dst_offset: DeviceSize,
    size: DeviceSize,
    data: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdClearColorImage = fn (
    command_buffer: CommandBuffer,
    image: Image,
    image_layout: ImageLayout,
    p_color: *const ClearColorValue,
    range_count: u32,
    p_ranges: [*]const ImageSubresourceRange,
) callconv(vulkan_call_conv) void;
pub const PfnCmdClearDepthStencilImage = fn (
    command_buffer: CommandBuffer,
    image: Image,
    image_layout: ImageLayout,
    p_depth_stencil: *const ClearDepthStencilValue,
    range_count: u32,
    p_ranges: [*]const ImageSubresourceRange,
) callconv(vulkan_call_conv) void;
pub const PfnCmdClearAttachments = fn (
    command_buffer: CommandBuffer,
    attachment_count: u32,
    p_attachments: [*]const ClearAttachment,
    rect_count: u32,
    p_rects: [*]const ClearRect,
) callconv(vulkan_call_conv) void;
pub const PfnCmdResolveImage = fn (
    command_buffer: CommandBuffer,
    src_image: Image,
    src_image_layout: ImageLayout,
    dst_image: Image,
    dst_image_layout: ImageLayout,
    region_count: u32,
    p_regions: [*]const ImageResolve,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetEvent = fn (
    command_buffer: CommandBuffer,
    event: Event,
    stage_mask: PipelineStageFlags.IntType,
) callconv(vulkan_call_conv) void;
pub const PfnCmdResetEvent = fn (
    command_buffer: CommandBuffer,
    event: Event,
    stage_mask: PipelineStageFlags.IntType,
) callconv(vulkan_call_conv) void;
pub const PfnCmdWaitEvents = fn (
    command_buffer: CommandBuffer,
    event_count: u32,
    p_events: [*]const Event,
    src_stage_mask: PipelineStageFlags.IntType,
    dst_stage_mask: PipelineStageFlags.IntType,
    memory_barrier_count: u32,
    p_memory_barriers: [*]const MemoryBarrier,
    buffer_memory_barrier_count: u32,
    p_buffer_memory_barriers: [*]const BufferMemoryBarrier,
    image_memory_barrier_count: u32,
    p_image_memory_barriers: [*]const ImageMemoryBarrier,
) callconv(vulkan_call_conv) void;
pub const PfnCmdPipelineBarrier = fn (
    command_buffer: CommandBuffer,
    src_stage_mask: PipelineStageFlags.IntType,
    dst_stage_mask: PipelineStageFlags.IntType,
    dependency_flags: DependencyFlags.IntType,
    memory_barrier_count: u32,
    p_memory_barriers: [*]const MemoryBarrier,
    buffer_memory_barrier_count: u32,
    p_buffer_memory_barriers: [*]const BufferMemoryBarrier,
    image_memory_barrier_count: u32,
    p_image_memory_barriers: [*]const ImageMemoryBarrier,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBeginQuery = fn (
    command_buffer: CommandBuffer,
    query_pool: QueryPool,
    query: u32,
    flags: QueryControlFlags.IntType,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndQuery = fn (
    command_buffer: CommandBuffer,
    query_pool: QueryPool,
    query: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBeginConditionalRenderingEXT = fn (
    command_buffer: CommandBuffer,
    p_conditional_rendering_begin: *const ConditionalRenderingBeginInfoEXT,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndConditionalRenderingEXT = fn (
    command_buffer: CommandBuffer,
) callconv(vulkan_call_conv) void;
pub const PfnCmdResetQueryPool = fn (
    command_buffer: CommandBuffer,
    query_pool: QueryPool,
    first_query: u32,
    query_count: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdWriteTimestamp = fn (
    command_buffer: CommandBuffer,
    pipeline_stage: PipelineStageFlags.IntType,
    query_pool: QueryPool,
    query: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyQueryPoolResults = fn (
    command_buffer: CommandBuffer,
    query_pool: QueryPool,
    first_query: u32,
    query_count: u32,
    dst_buffer: Buffer,
    dst_offset: DeviceSize,
    stride: DeviceSize,
    flags: QueryResultFlags.IntType,
) callconv(vulkan_call_conv) void;
pub const PfnCmdPushConstants = fn (
    command_buffer: CommandBuffer,
    layout: PipelineLayout,
    stage_flags: ShaderStageFlags.IntType,
    offset: u32,
    size: u32,
    p_values: *const c_void,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBeginRenderPass = fn (
    command_buffer: CommandBuffer,
    p_render_pass_begin: *const RenderPassBeginInfo,
    contents: SubpassContents,
) callconv(vulkan_call_conv) void;
pub const PfnCmdNextSubpass = fn (
    command_buffer: CommandBuffer,
    contents: SubpassContents,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndRenderPass = fn (
    command_buffer: CommandBuffer,
) callconv(vulkan_call_conv) void;
pub const PfnCmdExecuteCommands = fn (
    command_buffer: CommandBuffer,
    command_buffer_count: u32,
    p_command_buffers: [*]const CommandBuffer,
) callconv(vulkan_call_conv) void;
pub const PfnCreateAndroidSurfaceKHR = fn (
    instance: Instance,
    p_create_info: *const AndroidSurfaceCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceDisplayPropertiesKHR = fn (
    physical_device: PhysicalDevice,
    p_property_count: *u32,
    p_properties: ?[*]DisplayPropertiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceDisplayPlanePropertiesKHR = fn (
    physical_device: PhysicalDevice,
    p_property_count: *u32,
    p_properties: ?[*]DisplayPlanePropertiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDisplayPlaneSupportedDisplaysKHR = fn (
    physical_device: PhysicalDevice,
    plane_index: u32,
    p_display_count: *u32,
    p_displays: ?[*]DisplayKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDisplayModePropertiesKHR = fn (
    physical_device: PhysicalDevice,
    display: DisplayKHR,
    p_property_count: *u32,
    p_properties: ?[*]DisplayModePropertiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateDisplayModeKHR = fn (
    physical_device: PhysicalDevice,
    display: DisplayKHR,
    p_create_info: *const DisplayModeCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_mode: *DisplayModeKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDisplayPlaneCapabilitiesKHR = fn (
    physical_device: PhysicalDevice,
    mode: DisplayModeKHR,
    plane_index: u32,
    p_capabilities: *DisplayPlaneCapabilitiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateDisplayPlaneSurfaceKHR = fn (
    instance: Instance,
    p_create_info: *const DisplaySurfaceCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateSharedSwapchainsKHR = fn (
    device: Device,
    swapchain_count: u32,
    p_create_infos: [*]const SwapchainCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_swapchains: [*]SwapchainKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroySurfaceKHR = fn (
    instance: Instance,
    surface: SurfaceKHR,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceSurfaceSupportKHR = fn (
    physical_device: PhysicalDevice,
    queue_family_index: u32,
    surface: SurfaceKHR,
    p_supported: *Bool32,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceSurfaceCapabilitiesKHR = fn (
    physical_device: PhysicalDevice,
    surface: SurfaceKHR,
    p_surface_capabilities: *SurfaceCapabilitiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceSurfaceFormatsKHR = fn (
    physical_device: PhysicalDevice,
    surface: SurfaceKHR,
    p_surface_format_count: *u32,
    p_surface_formats: ?[*]SurfaceFormatKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceSurfacePresentModesKHR = fn (
    physical_device: PhysicalDevice,
    surface: SurfaceKHR,
    p_present_mode_count: *u32,
    p_present_modes: ?[*]PresentModeKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateSwapchainKHR = fn (
    device: Device,
    p_create_info: *const SwapchainCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_swapchain: *SwapchainKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroySwapchainKHR = fn (
    device: Device,
    swapchain: SwapchainKHR,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetSwapchainImagesKHR = fn (
    device: Device,
    swapchain: SwapchainKHR,
    p_swapchain_image_count: *u32,
    p_swapchain_images: ?[*]Image,
) callconv(vulkan_call_conv) Result;
pub const PfnAcquireNextImageKHR = fn (
    device: Device,
    swapchain: SwapchainKHR,
    timeout: u64,
    semaphore: Semaphore,
    fence: Fence,
    p_image_index: *u32,
) callconv(vulkan_call_conv) Result;
pub const PfnQueuePresentKHR = fn (
    queue: Queue,
    p_present_info: *const PresentInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateViSurfaceNN = fn (
    instance: Instance,
    p_create_info: *const ViSurfaceCreateInfoNN,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateWaylandSurfaceKHR = fn (
    instance: Instance,
    p_create_info: *const WaylandSurfaceCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceWaylandPresentationSupportKHR = fn (
    physical_device: PhysicalDevice,
    queue_family_index: u32,
    display: *wl_display,
) callconv(vulkan_call_conv) Bool32;
pub const PfnCreateWin32SurfaceKHR = fn (
    instance: Instance,
    p_create_info: *const Win32SurfaceCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceWin32PresentationSupportKHR = fn (
    physical_device: PhysicalDevice,
    queue_family_index: u32,
) callconv(vulkan_call_conv) Bool32;
pub const PfnCreateXlibSurfaceKHR = fn (
    instance: Instance,
    p_create_info: *const XlibSurfaceCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceXlibPresentationSupportKHR = fn (
    physical_device: PhysicalDevice,
    queue_family_index: u32,
    dpy: *Display,
    visual_id: VisualID,
) callconv(vulkan_call_conv) Bool32;
pub const PfnCreateXcbSurfaceKHR = fn (
    instance: Instance,
    p_create_info: *const XcbSurfaceCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceXcbPresentationSupportKHR = fn (
    physical_device: PhysicalDevice,
    queue_family_index: u32,
    connection: *xcb_connection_t,
    visual_id: xcb_visualid_t,
) callconv(vulkan_call_conv) Bool32;
pub const PfnCreateDirectFBSurfaceEXT = fn (
    instance: Instance,
    p_create_info: *const DirectFBSurfaceCreateInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceDirectFBPresentationSupportEXT = fn (
    physical_device: PhysicalDevice,
    queue_family_index: u32,
    dfb: *IDirectFB,
) callconv(vulkan_call_conv) Bool32;
pub const PfnCreateImagePipeSurfaceFUCHSIA = fn (
    instance: Instance,
    p_create_info: *const ImagePipeSurfaceCreateInfoFUCHSIA,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateStreamDescriptorSurfaceGGP = fn (
    instance: Instance,
    p_create_info: *const StreamDescriptorSurfaceCreateInfoGGP,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateScreenSurfaceQNX = fn (
    instance: Instance,
    p_create_info: *const ScreenSurfaceCreateInfoQNX,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceScreenPresentationSupportQNX = fn (
    physical_device: PhysicalDevice,
    queue_family_index: u32,
    window: *_screen_window,
) callconv(vulkan_call_conv) Bool32;
pub const PfnCreateDebugReportCallbackEXT = fn (
    instance: Instance,
    p_create_info: *const DebugReportCallbackCreateInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_callback: *DebugReportCallbackEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyDebugReportCallbackEXT = fn (
    instance: Instance,
    callback: DebugReportCallbackEXT,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnDebugReportMessageEXT = fn (
    instance: Instance,
    flags: DebugReportFlagsEXT.IntType,
    object_type: DebugReportObjectTypeEXT,
    object: u64,
    location: usize,
    message_code: i32,
    p_layer_prefix: [*:0]const u8,
    p_message: [*:0]const u8,
) callconv(vulkan_call_conv) void;
pub const PfnDebugMarkerSetObjectNameEXT = fn (
    device: Device,
    p_name_info: *const DebugMarkerObjectNameInfoEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnDebugMarkerSetObjectTagEXT = fn (
    device: Device,
    p_tag_info: *const DebugMarkerObjectTagInfoEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdDebugMarkerBeginEXT = fn (
    command_buffer: CommandBuffer,
    p_marker_info: *const DebugMarkerMarkerInfoEXT,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDebugMarkerEndEXT = fn (
    command_buffer: CommandBuffer,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDebugMarkerInsertEXT = fn (
    command_buffer: CommandBuffer,
    p_marker_info: *const DebugMarkerMarkerInfoEXT,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceExternalImageFormatPropertiesNV = fn (
    physical_device: PhysicalDevice,
    format: Format,
    @"type": ImageType,
    tiling: ImageTiling,
    usage: ImageUsageFlags.IntType,
    flags: ImageCreateFlags.IntType,
    external_handle_type: ExternalMemoryHandleTypeFlagsNV.IntType,
    p_external_image_format_properties: *ExternalImageFormatPropertiesNV,
) callconv(vulkan_call_conv) Result;
pub const PfnGetMemoryWin32HandleNV = fn (
    device: Device,
    memory: DeviceMemory,
    handle_type: ExternalMemoryHandleTypeFlagsNV.IntType,
    p_handle: *HANDLE,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdExecuteGeneratedCommandsNV = fn (
    command_buffer: CommandBuffer,
    is_preprocessed: Bool32,
    p_generated_commands_info: *const GeneratedCommandsInfoNV,
) callconv(vulkan_call_conv) void;
pub const PfnCmdPreprocessGeneratedCommandsNV = fn (
    command_buffer: CommandBuffer,
    p_generated_commands_info: *const GeneratedCommandsInfoNV,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBindPipelineShaderGroupNV = fn (
    command_buffer: CommandBuffer,
    pipeline_bind_point: PipelineBindPoint,
    pipeline: Pipeline,
    group_index: u32,
) callconv(vulkan_call_conv) void;
pub const PfnGetGeneratedCommandsMemoryRequirementsNV = fn (
    device: Device,
    p_info: *const GeneratedCommandsMemoryRequirementsInfoNV,
    p_memory_requirements: *MemoryRequirements2,
) callconv(vulkan_call_conv) void;
pub const PfnCreateIndirectCommandsLayoutNV = fn (
    device: Device,
    p_create_info: *const IndirectCommandsLayoutCreateInfoNV,
    p_allocator: ?*const AllocationCallbacks,
    p_indirect_commands_layout: *IndirectCommandsLayoutNV,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyIndirectCommandsLayoutNV = fn (
    device: Device,
    indirect_commands_layout: IndirectCommandsLayoutNV,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceFeatures2 = fn (
    physical_device: PhysicalDevice,
    p_features: *PhysicalDeviceFeatures2,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceProperties2 = fn (
    physical_device: PhysicalDevice,
    p_properties: *PhysicalDeviceProperties2,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceFormatProperties2 = fn (
    physical_device: PhysicalDevice,
    format: Format,
    p_format_properties: *FormatProperties2,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceImageFormatProperties2 = fn (
    physical_device: PhysicalDevice,
    p_image_format_info: *const PhysicalDeviceImageFormatInfo2,
    p_image_format_properties: *ImageFormatProperties2,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceQueueFamilyProperties2 = fn (
    physical_device: PhysicalDevice,
    p_queue_family_property_count: *u32,
    p_queue_family_properties: ?[*]QueueFamilyProperties2,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceMemoryProperties2 = fn (
    physical_device: PhysicalDevice,
    p_memory_properties: *PhysicalDeviceMemoryProperties2,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceSparseImageFormatProperties2 = fn (
    physical_device: PhysicalDevice,
    p_format_info: *const PhysicalDeviceSparseImageFormatInfo2,
    p_property_count: *u32,
    p_properties: ?[*]SparseImageFormatProperties2,
) callconv(vulkan_call_conv) void;
pub const PfnCmdPushDescriptorSetKHR = fn (
    command_buffer: CommandBuffer,
    pipeline_bind_point: PipelineBindPoint,
    layout: PipelineLayout,
    set: u32,
    descriptor_write_count: u32,
    p_descriptor_writes: [*]const WriteDescriptorSet,
) callconv(vulkan_call_conv) void;
pub const PfnTrimCommandPool = fn (
    device: Device,
    command_pool: CommandPool,
    flags: CommandPoolTrimFlags.IntType,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceExternalBufferProperties = fn (
    physical_device: PhysicalDevice,
    p_external_buffer_info: *const PhysicalDeviceExternalBufferInfo,
    p_external_buffer_properties: *ExternalBufferProperties,
) callconv(vulkan_call_conv) void;
pub const PfnGetMemoryWin32HandleKHR = fn (
    device: Device,
    p_get_win_32_handle_info: *const MemoryGetWin32HandleInfoKHR,
    p_handle: *HANDLE,
) callconv(vulkan_call_conv) Result;
pub const PfnGetMemoryWin32HandlePropertiesKHR = fn (
    device: Device,
    handle_type: ExternalMemoryHandleTypeFlags.IntType,
    handle: HANDLE,
    p_memory_win_32_handle_properties: *MemoryWin32HandlePropertiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetMemoryFdKHR = fn (
    device: Device,
    p_get_fd_info: *const MemoryGetFdInfoKHR,
    p_fd: *c_int,
) callconv(vulkan_call_conv) Result;
pub const PfnGetMemoryFdPropertiesKHR = fn (
    device: Device,
    handle_type: ExternalMemoryHandleTypeFlags.IntType,
    fd: c_int,
    p_memory_fd_properties: *MemoryFdPropertiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetMemoryZirconHandleFUCHSIA = fn (
    device: Device,
    p_get_zircon_handle_info: *const MemoryGetZirconHandleInfoFUCHSIA,
    p_zircon_handle: *zx_handle_t,
) callconv(vulkan_call_conv) Result;
pub const PfnGetMemoryZirconHandlePropertiesFUCHSIA = fn (
    device: Device,
    handle_type: ExternalMemoryHandleTypeFlags.IntType,
    zircon_handle: zx_handle_t,
    p_memory_zircon_handle_properties: *MemoryZirconHandlePropertiesFUCHSIA,
) callconv(vulkan_call_conv) Result;
pub const PfnGetMemoryRemoteAddressNV = fn (
    device: Device,
    p_memory_get_remote_address_info: *const MemoryGetRemoteAddressInfoNV,
    p_address: *RemoteAddressNV,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceExternalSemaphoreProperties = fn (
    physical_device: PhysicalDevice,
    p_external_semaphore_info: *const PhysicalDeviceExternalSemaphoreInfo,
    p_external_semaphore_properties: *ExternalSemaphoreProperties,
) callconv(vulkan_call_conv) void;
pub const PfnGetSemaphoreWin32HandleKHR = fn (
    device: Device,
    p_get_win_32_handle_info: *const SemaphoreGetWin32HandleInfoKHR,
    p_handle: *HANDLE,
) callconv(vulkan_call_conv) Result;
pub const PfnImportSemaphoreWin32HandleKHR = fn (
    device: Device,
    p_import_semaphore_win_32_handle_info: *const ImportSemaphoreWin32HandleInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetSemaphoreFdKHR = fn (
    device: Device,
    p_get_fd_info: *const SemaphoreGetFdInfoKHR,
    p_fd: *c_int,
) callconv(vulkan_call_conv) Result;
pub const PfnImportSemaphoreFdKHR = fn (
    device: Device,
    p_import_semaphore_fd_info: *const ImportSemaphoreFdInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetSemaphoreZirconHandleFUCHSIA = fn (
    device: Device,
    p_get_zircon_handle_info: *const SemaphoreGetZirconHandleInfoFUCHSIA,
    p_zircon_handle: *zx_handle_t,
) callconv(vulkan_call_conv) Result;
pub const PfnImportSemaphoreZirconHandleFUCHSIA = fn (
    device: Device,
    p_import_semaphore_zircon_handle_info: *const ImportSemaphoreZirconHandleInfoFUCHSIA,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceExternalFenceProperties = fn (
    physical_device: PhysicalDevice,
    p_external_fence_info: *const PhysicalDeviceExternalFenceInfo,
    p_external_fence_properties: *ExternalFenceProperties,
) callconv(vulkan_call_conv) void;
pub const PfnGetFenceWin32HandleKHR = fn (
    device: Device,
    p_get_win_32_handle_info: *const FenceGetWin32HandleInfoKHR,
    p_handle: *HANDLE,
) callconv(vulkan_call_conv) Result;
pub const PfnImportFenceWin32HandleKHR = fn (
    device: Device,
    p_import_fence_win_32_handle_info: *const ImportFenceWin32HandleInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetFenceFdKHR = fn (
    device: Device,
    p_get_fd_info: *const FenceGetFdInfoKHR,
    p_fd: *c_int,
) callconv(vulkan_call_conv) Result;
pub const PfnImportFenceFdKHR = fn (
    device: Device,
    p_import_fence_fd_info: *const ImportFenceFdInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnReleaseDisplayEXT = fn (
    physical_device: PhysicalDevice,
    display: DisplayKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnAcquireXlibDisplayEXT = fn (
    physical_device: PhysicalDevice,
    dpy: *Display,
    display: DisplayKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetRandROutputDisplayEXT = fn (
    physical_device: PhysicalDevice,
    dpy: *Display,
    rr_output: RROutput,
    p_display: *DisplayKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnAcquireWinrtDisplayNV = fn (
    physical_device: PhysicalDevice,
    display: DisplayKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetWinrtDisplayNV = fn (
    physical_device: PhysicalDevice,
    device_relative_id: u32,
    p_display: *DisplayKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnDisplayPowerControlEXT = fn (
    device: Device,
    display: DisplayKHR,
    p_display_power_info: *const DisplayPowerInfoEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnRegisterDeviceEventEXT = fn (
    device: Device,
    p_device_event_info: *const DeviceEventInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_fence: *Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnRegisterDisplayEventEXT = fn (
    device: Device,
    display: DisplayKHR,
    p_display_event_info: *const DisplayEventInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_fence: *Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnGetSwapchainCounterEXT = fn (
    device: Device,
    swapchain: SwapchainKHR,
    counter: SurfaceCounterFlagsEXT.IntType,
    p_counter_value: *u64,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceSurfaceCapabilities2EXT = fn (
    physical_device: PhysicalDevice,
    surface: SurfaceKHR,
    p_surface_capabilities: *SurfaceCapabilities2EXT,
) callconv(vulkan_call_conv) Result;
pub const PfnEnumeratePhysicalDeviceGroups = fn (
    instance: Instance,
    p_physical_device_group_count: *u32,
    p_physical_device_group_properties: ?[*]PhysicalDeviceGroupProperties,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDeviceGroupPeerMemoryFeatures = fn (
    device: Device,
    heap_index: u32,
    local_device_index: u32,
    remote_device_index: u32,
    p_peer_memory_features: *PeerMemoryFeatureFlags,
) callconv(vulkan_call_conv) void;
pub const PfnBindBufferMemory2 = fn (
    device: Device,
    bind_info_count: u32,
    p_bind_infos: [*]const BindBufferMemoryInfo,
) callconv(vulkan_call_conv) Result;
pub const PfnBindImageMemory2 = fn (
    device: Device,
    bind_info_count: u32,
    p_bind_infos: [*]const BindImageMemoryInfo,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdSetDeviceMask = fn (
    command_buffer: CommandBuffer,
    device_mask: u32,
) callconv(vulkan_call_conv) void;
pub const PfnGetDeviceGroupPresentCapabilitiesKHR = fn (
    device: Device,
    p_device_group_present_capabilities: *DeviceGroupPresentCapabilitiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDeviceGroupSurfacePresentModesKHR = fn (
    device: Device,
    surface: SurfaceKHR,
    p_modes: *DeviceGroupPresentModeFlagsKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnAcquireNextImage2KHR = fn (
    device: Device,
    p_acquire_info: *const AcquireNextImageInfoKHR,
    p_image_index: *u32,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdDispatchBase = fn (
    command_buffer: CommandBuffer,
    base_group_x: u32,
    base_group_y: u32,
    base_group_z: u32,
    group_count_x: u32,
    group_count_y: u32,
    group_count_z: u32,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDevicePresentRectanglesKHR = fn (
    physical_device: PhysicalDevice,
    surface: SurfaceKHR,
    p_rect_count: *u32,
    p_rects: ?[*]Rect2D,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateDescriptorUpdateTemplate = fn (
    device: Device,
    p_create_info: *const DescriptorUpdateTemplateCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_descriptor_update_template: *DescriptorUpdateTemplate,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyDescriptorUpdateTemplate = fn (
    device: Device,
    descriptor_update_template: DescriptorUpdateTemplate,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnUpdateDescriptorSetWithTemplate = fn (
    device: Device,
    descriptor_set: DescriptorSet,
    descriptor_update_template: DescriptorUpdateTemplate,
    p_data: *const c_void,
) callconv(vulkan_call_conv) void;
pub const PfnCmdPushDescriptorSetWithTemplateKHR = fn (
    command_buffer: CommandBuffer,
    descriptor_update_template: DescriptorUpdateTemplate,
    layout: PipelineLayout,
    set: u32,
    p_data: *const c_void,
) callconv(vulkan_call_conv) void;
pub const PfnSetHdrMetadataEXT = fn (
    device: Device,
    swapchain_count: u32,
    p_swapchains: [*]const SwapchainKHR,
    p_metadata: [*]const HdrMetadataEXT,
) callconv(vulkan_call_conv) void;
pub const PfnGetSwapchainStatusKHR = fn (
    device: Device,
    swapchain: SwapchainKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetRefreshCycleDurationGOOGLE = fn (
    device: Device,
    swapchain: SwapchainKHR,
    p_display_timing_properties: *RefreshCycleDurationGOOGLE,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPastPresentationTimingGOOGLE = fn (
    device: Device,
    swapchain: SwapchainKHR,
    p_presentation_timing_count: *u32,
    p_presentation_timings: ?[*]PastPresentationTimingGOOGLE,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateIOSSurfaceMVK = fn (
    instance: Instance,
    p_create_info: *const IOSSurfaceCreateInfoMVK,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateMacOSSurfaceMVK = fn (
    instance: Instance,
    p_create_info: *const MacOSSurfaceCreateInfoMVK,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateMetalSurfaceEXT = fn (
    instance: Instance,
    p_create_info: *const MetalSurfaceCreateInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdSetViewportWScalingNV = fn (
    command_buffer: CommandBuffer,
    first_viewport: u32,
    viewport_count: u32,
    p_viewport_w_scalings: [*]const ViewportWScalingNV,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetDiscardRectangleEXT = fn (
    command_buffer: CommandBuffer,
    first_discard_rectangle: u32,
    discard_rectangle_count: u32,
    p_discard_rectangles: [*]const Rect2D,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetSampleLocationsEXT = fn (
    command_buffer: CommandBuffer,
    p_sample_locations_info: *const SampleLocationsInfoEXT,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceMultisamplePropertiesEXT = fn (
    physical_device: PhysicalDevice,
    samples: SampleCountFlags.IntType,
    p_multisample_properties: *MultisamplePropertiesEXT,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceSurfaceCapabilities2KHR = fn (
    physical_device: PhysicalDevice,
    p_surface_info: *const PhysicalDeviceSurfaceInfo2KHR,
    p_surface_capabilities: *SurfaceCapabilities2KHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceSurfaceFormats2KHR = fn (
    physical_device: PhysicalDevice,
    p_surface_info: *const PhysicalDeviceSurfaceInfo2KHR,
    p_surface_format_count: *u32,
    p_surface_formats: ?[*]SurfaceFormat2KHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceDisplayProperties2KHR = fn (
    physical_device: PhysicalDevice,
    p_property_count: *u32,
    p_properties: ?[*]DisplayProperties2KHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceDisplayPlaneProperties2KHR = fn (
    physical_device: PhysicalDevice,
    p_property_count: *u32,
    p_properties: ?[*]DisplayPlaneProperties2KHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDisplayModeProperties2KHR = fn (
    physical_device: PhysicalDevice,
    display: DisplayKHR,
    p_property_count: *u32,
    p_properties: ?[*]DisplayModeProperties2KHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDisplayPlaneCapabilities2KHR = fn (
    physical_device: PhysicalDevice,
    p_display_plane_info: *const DisplayPlaneInfo2KHR,
    p_capabilities: *DisplayPlaneCapabilities2KHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetBufferMemoryRequirements2 = fn (
    device: Device,
    p_info: *const BufferMemoryRequirementsInfo2,
    p_memory_requirements: *MemoryRequirements2,
) callconv(vulkan_call_conv) void;
pub const PfnGetImageMemoryRequirements2 = fn (
    device: Device,
    p_info: *const ImageMemoryRequirementsInfo2,
    p_memory_requirements: *MemoryRequirements2,
) callconv(vulkan_call_conv) void;
pub const PfnGetImageSparseMemoryRequirements2 = fn (
    device: Device,
    p_info: *const ImageSparseMemoryRequirementsInfo2,
    p_sparse_memory_requirement_count: *u32,
    p_sparse_memory_requirements: ?[*]SparseImageMemoryRequirements2,
) callconv(vulkan_call_conv) void;
pub const PfnGetDeviceBufferMemoryRequirementsKHR = fn (
    device: Device,
    p_info: *const DeviceBufferMemoryRequirementsKHR,
    p_memory_requirements: *MemoryRequirements2,
) callconv(vulkan_call_conv) void;
pub const PfnGetDeviceImageMemoryRequirementsKHR = fn (
    device: Device,
    p_info: *const DeviceImageMemoryRequirementsKHR,
    p_memory_requirements: *MemoryRequirements2,
) callconv(vulkan_call_conv) void;
pub const PfnGetDeviceImageSparseMemoryRequirementsKHR = fn (
    device: Device,
    p_info: *const DeviceImageMemoryRequirementsKHR,
    p_sparse_memory_requirement_count: *u32,
    p_sparse_memory_requirements: ?[*]SparseImageMemoryRequirements2,
) callconv(vulkan_call_conv) void;
pub const PfnCreateSamplerYcbcrConversion = fn (
    device: Device,
    p_create_info: *const SamplerYcbcrConversionCreateInfo,
    p_allocator: ?*const AllocationCallbacks,
    p_ycbcr_conversion: *SamplerYcbcrConversion,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroySamplerYcbcrConversion = fn (
    device: Device,
    ycbcr_conversion: SamplerYcbcrConversion,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetDeviceQueue2 = fn (
    device: Device,
    p_queue_info: *const DeviceQueueInfo2,
    p_queue: *Queue,
) callconv(vulkan_call_conv) void;
pub const PfnCreateValidationCacheEXT = fn (
    device: Device,
    p_create_info: *const ValidationCacheCreateInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_validation_cache: *ValidationCacheEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyValidationCacheEXT = fn (
    device: Device,
    validation_cache: ValidationCacheEXT,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetValidationCacheDataEXT = fn (
    device: Device,
    validation_cache: ValidationCacheEXT,
    p_data_size: *usize,
    p_data: ?*c_void,
) callconv(vulkan_call_conv) Result;
pub const PfnMergeValidationCachesEXT = fn (
    device: Device,
    dst_cache: ValidationCacheEXT,
    src_cache_count: u32,
    p_src_caches: [*]const ValidationCacheEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDescriptorSetLayoutSupport = fn (
    device: Device,
    p_create_info: *const DescriptorSetLayoutCreateInfo,
    p_support: *DescriptorSetLayoutSupport,
) callconv(vulkan_call_conv) void;
pub const PfnGetSwapchainGrallocUsageANDROID = fn (
    device: Device,
    format: Format,
    image_usage: ImageUsageFlags.IntType,
    gralloc_usage: *c_int,
) callconv(vulkan_call_conv) Result;
pub const PfnGetSwapchainGrallocUsage2ANDROID = fn (
    device: Device,
    format: Format,
    image_usage: ImageUsageFlags.IntType,
    swapchain_image_usage: SwapchainImageUsageFlagsANDROID.IntType,
    gralloc_consumer_usage: *u64,
    gralloc_producer_usage: *u64,
) callconv(vulkan_call_conv) Result;
pub const PfnAcquireImageANDROID = fn (
    device: Device,
    image: Image,
    native_fence_fd: c_int,
    semaphore: Semaphore,
    fence: Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnQueueSignalReleaseImageANDROID = fn (
    queue: Queue,
    wait_semaphore_count: u32,
    p_wait_semaphores: [*]const Semaphore,
    image: Image,
    p_native_fence_fd: *c_int,
) callconv(vulkan_call_conv) Result;
pub const PfnGetShaderInfoAMD = fn (
    device: Device,
    pipeline: Pipeline,
    shader_stage: ShaderStageFlags.IntType,
    info_type: ShaderInfoTypeAMD,
    p_info_size: *usize,
    p_info: ?*c_void,
) callconv(vulkan_call_conv) Result;
pub const PfnSetLocalDimmingAMD = fn (
    device: Device,
    swap_chain: SwapchainKHR,
    local_dimming_enable: Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceCalibrateableTimeDomainsEXT = fn (
    physical_device: PhysicalDevice,
    p_time_domain_count: *u32,
    p_time_domains: ?[*]TimeDomainEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnGetCalibratedTimestampsEXT = fn (
    device: Device,
    timestamp_count: u32,
    p_timestamp_infos: [*]const CalibratedTimestampInfoEXT,
    p_timestamps: [*]u64,
    p_max_deviation: *u64,
) callconv(vulkan_call_conv) Result;
pub const PfnSetDebugUtilsObjectNameEXT = fn (
    device: Device,
    p_name_info: *const DebugUtilsObjectNameInfoEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnSetDebugUtilsObjectTagEXT = fn (
    device: Device,
    p_tag_info: *const DebugUtilsObjectTagInfoEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnQueueBeginDebugUtilsLabelEXT = fn (
    queue: Queue,
    p_label_info: *const DebugUtilsLabelEXT,
) callconv(vulkan_call_conv) void;
pub const PfnQueueEndDebugUtilsLabelEXT = fn (
    queue: Queue,
) callconv(vulkan_call_conv) void;
pub const PfnQueueInsertDebugUtilsLabelEXT = fn (
    queue: Queue,
    p_label_info: *const DebugUtilsLabelEXT,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBeginDebugUtilsLabelEXT = fn (
    command_buffer: CommandBuffer,
    p_label_info: *const DebugUtilsLabelEXT,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndDebugUtilsLabelEXT = fn (
    command_buffer: CommandBuffer,
) callconv(vulkan_call_conv) void;
pub const PfnCmdInsertDebugUtilsLabelEXT = fn (
    command_buffer: CommandBuffer,
    p_label_info: *const DebugUtilsLabelEXT,
) callconv(vulkan_call_conv) void;
pub const PfnCreateDebugUtilsMessengerEXT = fn (
    instance: Instance,
    p_create_info: *const DebugUtilsMessengerCreateInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_messenger: *DebugUtilsMessengerEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyDebugUtilsMessengerEXT = fn (
    instance: Instance,
    messenger: DebugUtilsMessengerEXT,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnSubmitDebugUtilsMessageEXT = fn (
    instance: Instance,
    message_severity: DebugUtilsMessageSeverityFlagsEXT.IntType,
    message_types: DebugUtilsMessageTypeFlagsEXT.IntType,
    p_callback_data: *const DebugUtilsMessengerCallbackDataEXT,
) callconv(vulkan_call_conv) void;
pub const PfnGetMemoryHostPointerPropertiesEXT = fn (
    device: Device,
    handle_type: ExternalMemoryHandleTypeFlags.IntType,
    p_host_pointer: *const c_void,
    p_memory_host_pointer_properties: *MemoryHostPointerPropertiesEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdWriteBufferMarkerAMD = fn (
    command_buffer: CommandBuffer,
    pipeline_stage: PipelineStageFlags.IntType,
    dst_buffer: Buffer,
    dst_offset: DeviceSize,
    marker: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCreateRenderPass2 = fn (
    device: Device,
    p_create_info: *const RenderPassCreateInfo2,
    p_allocator: ?*const AllocationCallbacks,
    p_render_pass: *RenderPass,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdBeginRenderPass2 = fn (
    command_buffer: CommandBuffer,
    p_render_pass_begin: *const RenderPassBeginInfo,
    p_subpass_begin_info: *const SubpassBeginInfo,
) callconv(vulkan_call_conv) void;
pub const PfnCmdNextSubpass2 = fn (
    command_buffer: CommandBuffer,
    p_subpass_begin_info: *const SubpassBeginInfo,
    p_subpass_end_info: *const SubpassEndInfo,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndRenderPass2 = fn (
    command_buffer: CommandBuffer,
    p_subpass_end_info: *const SubpassEndInfo,
) callconv(vulkan_call_conv) void;
pub const PfnGetSemaphoreCounterValue = fn (
    device: Device,
    semaphore: Semaphore,
    p_value: *u64,
) callconv(vulkan_call_conv) Result;
pub const PfnWaitSemaphores = fn (
    device: Device,
    p_wait_info: *const SemaphoreWaitInfo,
    timeout: u64,
) callconv(vulkan_call_conv) Result;
pub const PfnSignalSemaphore = fn (
    device: Device,
    p_signal_info: *const SemaphoreSignalInfo,
) callconv(vulkan_call_conv) Result;
pub const PfnGetAndroidHardwareBufferPropertiesANDROID = fn (
    device: Device,
    buffer: *const AHardwareBuffer,
    p_properties: *AndroidHardwareBufferPropertiesANDROID,
) callconv(vulkan_call_conv) Result;
pub const PfnGetMemoryAndroidHardwareBufferANDROID = fn (
    device: Device,
    p_info: *const MemoryGetAndroidHardwareBufferInfoANDROID,
    p_buffer: **AHardwareBuffer,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdDrawIndirectCount = fn (
    command_buffer: CommandBuffer,
    buffer: Buffer,
    offset: DeviceSize,
    count_buffer: Buffer,
    count_buffer_offset: DeviceSize,
    max_draw_count: u32,
    stride: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawIndexedIndirectCount = fn (
    command_buffer: CommandBuffer,
    buffer: Buffer,
    offset: DeviceSize,
    count_buffer: Buffer,
    count_buffer_offset: DeviceSize,
    max_draw_count: u32,
    stride: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetCheckpointNV = fn (
    command_buffer: CommandBuffer,
    p_checkpoint_marker: *const c_void,
) callconv(vulkan_call_conv) void;
pub const PfnGetQueueCheckpointDataNV = fn (
    queue: Queue,
    p_checkpoint_data_count: *u32,
    p_checkpoint_data: ?[*]CheckpointDataNV,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBindTransformFeedbackBuffersEXT = fn (
    command_buffer: CommandBuffer,
    first_binding: u32,
    binding_count: u32,
    p_buffers: [*]const Buffer,
    p_offsets: [*]const DeviceSize,
    p_sizes: ?[*]const DeviceSize,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBeginTransformFeedbackEXT = fn (
    command_buffer: CommandBuffer,
    first_counter_buffer: u32,
    counter_buffer_count: u32,
    p_counter_buffers: [*]const Buffer,
    p_counter_buffer_offsets: ?[*]const DeviceSize,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndTransformFeedbackEXT = fn (
    command_buffer: CommandBuffer,
    first_counter_buffer: u32,
    counter_buffer_count: u32,
    p_counter_buffers: [*]const Buffer,
    p_counter_buffer_offsets: ?[*]const DeviceSize,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBeginQueryIndexedEXT = fn (
    command_buffer: CommandBuffer,
    query_pool: QueryPool,
    query: u32,
    flags: QueryControlFlags.IntType,
    index: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndQueryIndexedEXT = fn (
    command_buffer: CommandBuffer,
    query_pool: QueryPool,
    query: u32,
    index: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawIndirectByteCountEXT = fn (
    command_buffer: CommandBuffer,
    instance_count: u32,
    first_instance: u32,
    counter_buffer: Buffer,
    counter_buffer_offset: DeviceSize,
    counter_offset: u32,
    vertex_stride: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetExclusiveScissorNV = fn (
    command_buffer: CommandBuffer,
    first_exclusive_scissor: u32,
    exclusive_scissor_count: u32,
    p_exclusive_scissors: [*]const Rect2D,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBindShadingRateImageNV = fn (
    command_buffer: CommandBuffer,
    image_view: ImageView,
    image_layout: ImageLayout,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetViewportShadingRatePaletteNV = fn (
    command_buffer: CommandBuffer,
    first_viewport: u32,
    viewport_count: u32,
    p_shading_rate_palettes: [*]const ShadingRatePaletteNV,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetCoarseSampleOrderNV = fn (
    command_buffer: CommandBuffer,
    sample_order_type: CoarseSampleOrderTypeNV,
    custom_sample_order_count: u32,
    p_custom_sample_orders: [*]const CoarseSampleOrderCustomNV,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawMeshTasksNV = fn (
    command_buffer: CommandBuffer,
    task_count: u32,
    first_task: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawMeshTasksIndirectNV = fn (
    command_buffer: CommandBuffer,
    buffer: Buffer,
    offset: DeviceSize,
    draw_count: u32,
    stride: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdDrawMeshTasksIndirectCountNV = fn (
    command_buffer: CommandBuffer,
    buffer: Buffer,
    offset: DeviceSize,
    count_buffer: Buffer,
    count_buffer_offset: DeviceSize,
    max_draw_count: u32,
    stride: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCompileDeferredNV = fn (
    device: Device,
    pipeline: Pipeline,
    shader: u32,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateAccelerationStructureNV = fn (
    device: Device,
    p_create_info: *const AccelerationStructureCreateInfoNV,
    p_allocator: ?*const AllocationCallbacks,
    p_acceleration_structure: *AccelerationStructureNV,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdBindInvocationMaskHUAWEI = fn (
    command_buffer: CommandBuffer,
    image_view: ImageView,
    image_layout: ImageLayout,
) callconv(vulkan_call_conv) void;
pub const PfnDestroyAccelerationStructureKHR = fn (
    device: Device,
    acceleration_structure: AccelerationStructureKHR,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnDestroyAccelerationStructureNV = fn (
    device: Device,
    acceleration_structure: AccelerationStructureNV,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetAccelerationStructureMemoryRequirementsNV = fn (
    device: Device,
    p_info: *const AccelerationStructureMemoryRequirementsInfoNV,
    p_memory_requirements: *MemoryRequirements2KHR,
) callconv(vulkan_call_conv) void;
pub const PfnBindAccelerationStructureMemoryNV = fn (
    device: Device,
    bind_info_count: u32,
    p_bind_infos: [*]const BindAccelerationStructureMemoryInfoNV,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdCopyAccelerationStructureNV = fn (
    command_buffer: CommandBuffer,
    dst: AccelerationStructureNV,
    src: AccelerationStructureNV,
    mode: CopyAccelerationStructureModeKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyAccelerationStructureKHR = fn (
    command_buffer: CommandBuffer,
    p_info: *const CopyAccelerationStructureInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCopyAccelerationStructureKHR = fn (
    device: Device,
    deferred_operation: DeferredOperationKHR,
    p_info: *const CopyAccelerationStructureInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdCopyAccelerationStructureToMemoryKHR = fn (
    command_buffer: CommandBuffer,
    p_info: *const CopyAccelerationStructureToMemoryInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCopyAccelerationStructureToMemoryKHR = fn (
    device: Device,
    deferred_operation: DeferredOperationKHR,
    p_info: *const CopyAccelerationStructureToMemoryInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdCopyMemoryToAccelerationStructureKHR = fn (
    command_buffer: CommandBuffer,
    p_info: *const CopyMemoryToAccelerationStructureInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCopyMemoryToAccelerationStructureKHR = fn (
    device: Device,
    deferred_operation: DeferredOperationKHR,
    p_info: *const CopyMemoryToAccelerationStructureInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdWriteAccelerationStructuresPropertiesKHR = fn (
    command_buffer: CommandBuffer,
    acceleration_structure_count: u32,
    p_acceleration_structures: [*]const AccelerationStructureKHR,
    query_type: QueryType,
    query_pool: QueryPool,
    first_query: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdWriteAccelerationStructuresPropertiesNV = fn (
    command_buffer: CommandBuffer,
    acceleration_structure_count: u32,
    p_acceleration_structures: [*]const AccelerationStructureNV,
    query_type: QueryType,
    query_pool: QueryPool,
    first_query: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBuildAccelerationStructureNV = fn (
    command_buffer: CommandBuffer,
    p_info: *const AccelerationStructureInfoNV,
    instance_data: Buffer,
    instance_offset: DeviceSize,
    update: Bool32,
    dst: AccelerationStructureNV,
    src: AccelerationStructureNV,
    scratch: Buffer,
    scratch_offset: DeviceSize,
) callconv(vulkan_call_conv) void;
pub const PfnWriteAccelerationStructuresPropertiesKHR = fn (
    device: Device,
    acceleration_structure_count: u32,
    p_acceleration_structures: [*]const AccelerationStructureKHR,
    query_type: QueryType,
    data_size: usize,
    p_data: *c_void,
    stride: usize,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdTraceRaysKHR = fn (
    command_buffer: CommandBuffer,
    p_raygen_shader_binding_table: *const StridedDeviceAddressRegionKHR,
    p_miss_shader_binding_table: *const StridedDeviceAddressRegionKHR,
    p_hit_shader_binding_table: *const StridedDeviceAddressRegionKHR,
    p_callable_shader_binding_table: *const StridedDeviceAddressRegionKHR,
    width: u32,
    height: u32,
    depth: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdTraceRaysNV = fn (
    command_buffer: CommandBuffer,
    raygen_shader_binding_table_buffer: Buffer,
    raygen_shader_binding_offset: DeviceSize,
    miss_shader_binding_table_buffer: Buffer,
    miss_shader_binding_offset: DeviceSize,
    miss_shader_binding_stride: DeviceSize,
    hit_shader_binding_table_buffer: Buffer,
    hit_shader_binding_offset: DeviceSize,
    hit_shader_binding_stride: DeviceSize,
    callable_shader_binding_table_buffer: Buffer,
    callable_shader_binding_offset: DeviceSize,
    callable_shader_binding_stride: DeviceSize,
    width: u32,
    height: u32,
    depth: u32,
) callconv(vulkan_call_conv) void;
pub const PfnGetRayTracingShaderGroupHandlesKHR = fn (
    device: Device,
    pipeline: Pipeline,
    first_group: u32,
    group_count: u32,
    data_size: usize,
    p_data: *c_void,
) callconv(vulkan_call_conv) Result;
pub const PfnGetRayTracingCaptureReplayShaderGroupHandlesKHR = fn (
    device: Device,
    pipeline: Pipeline,
    first_group: u32,
    group_count: u32,
    data_size: usize,
    p_data: *c_void,
) callconv(vulkan_call_conv) Result;
pub const PfnGetAccelerationStructureHandleNV = fn (
    device: Device,
    acceleration_structure: AccelerationStructureNV,
    data_size: usize,
    p_data: *c_void,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateRayTracingPipelinesNV = fn (
    device: Device,
    pipeline_cache: PipelineCache,
    create_info_count: u32,
    p_create_infos: [*]const RayTracingPipelineCreateInfoNV,
    p_allocator: ?*const AllocationCallbacks,
    p_pipelines: [*]Pipeline,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateRayTracingPipelinesKHR = fn (
    device: Device,
    deferred_operation: DeferredOperationKHR,
    pipeline_cache: PipelineCache,
    create_info_count: u32,
    p_create_infos: [*]const RayTracingPipelineCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_pipelines: [*]Pipeline,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceCooperativeMatrixPropertiesNV = fn (
    physical_device: PhysicalDevice,
    p_property_count: *u32,
    p_properties: ?[*]CooperativeMatrixPropertiesNV,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdTraceRaysIndirectKHR = fn (
    command_buffer: CommandBuffer,
    p_raygen_shader_binding_table: *const StridedDeviceAddressRegionKHR,
    p_miss_shader_binding_table: *const StridedDeviceAddressRegionKHR,
    p_hit_shader_binding_table: *const StridedDeviceAddressRegionKHR,
    p_callable_shader_binding_table: *const StridedDeviceAddressRegionKHR,
    indirect_device_address: DeviceAddress,
) callconv(vulkan_call_conv) void;
pub const PfnGetDeviceAccelerationStructureCompatibilityKHR = fn (
    device: Device,
    p_version_info: *const AccelerationStructureVersionInfoKHR,
    p_compatibility: *AccelerationStructureCompatibilityKHR,
) callconv(vulkan_call_conv) void;
pub const PfnGetRayTracingShaderGroupStackSizeKHR = fn (
    device: Device,
    pipeline: Pipeline,
    group: u32,
    group_shader: ShaderGroupShaderKHR,
) callconv(vulkan_call_conv) DeviceSize;
pub const PfnCmdSetRayTracingPipelineStackSizeKHR = fn (
    command_buffer: CommandBuffer,
    pipeline_stack_size: u32,
) callconv(vulkan_call_conv) void;
pub const PfnGetImageViewHandleNVX = fn (
    device: Device,
    p_info: *const ImageViewHandleInfoNVX,
) callconv(vulkan_call_conv) u32;
pub const PfnGetImageViewAddressNVX = fn (
    device: Device,
    image_view: ImageView,
    p_properties: *ImageViewAddressPropertiesNVX,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceSurfacePresentModes2EXT = fn (
    physical_device: PhysicalDevice,
    p_surface_info: *const PhysicalDeviceSurfaceInfo2KHR,
    p_present_mode_count: *u32,
    p_present_modes: ?[*]PresentModeKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDeviceGroupSurfacePresentModes2EXT = fn (
    device: Device,
    p_surface_info: *const PhysicalDeviceSurfaceInfo2KHR,
    p_modes: *DeviceGroupPresentModeFlagsKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnAcquireFullScreenExclusiveModeEXT = fn (
    device: Device,
    swapchain: SwapchainKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnReleaseFullScreenExclusiveModeEXT = fn (
    device: Device,
    swapchain: SwapchainKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR = fn (
    physical_device: PhysicalDevice,
    queue_family_index: u32,
    p_counter_count: *u32,
    p_counters: ?[*]PerformanceCounterKHR,
    p_counter_descriptions: ?[*]PerformanceCounterDescriptionKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR = fn (
    physical_device: PhysicalDevice,
    p_performance_query_create_info: *const QueryPoolPerformanceCreateInfoKHR,
    p_num_passes: *u32,
) callconv(vulkan_call_conv) void;
pub const PfnAcquireProfilingLockKHR = fn (
    device: Device,
    p_info: *const AcquireProfilingLockInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnReleaseProfilingLockKHR = fn (
    device: Device,
) callconv(vulkan_call_conv) void;
pub const PfnGetImageDrmFormatModifierPropertiesEXT = fn (
    device: Device,
    image: Image,
    p_properties: *ImageDrmFormatModifierPropertiesEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnGetBufferOpaqueCaptureAddress = fn (
    device: Device,
    p_info: *const BufferDeviceAddressInfo,
) callconv(vulkan_call_conv) u64;
pub const PfnGetBufferDeviceAddress = fn (
    device: Device,
    p_info: *const BufferDeviceAddressInfo,
) callconv(vulkan_call_conv) DeviceAddress;
pub const PfnCreateHeadlessSurfaceEXT = fn (
    instance: Instance,
    p_create_info: *const HeadlessSurfaceCreateInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_surface: *SurfaceKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV = fn (
    physical_device: PhysicalDevice,
    p_combination_count: *u32,
    p_combinations: ?[*]FramebufferMixedSamplesCombinationNV,
) callconv(vulkan_call_conv) Result;
pub const PfnInitializePerformanceApiINTEL = fn (
    device: Device,
    p_initialize_info: *const InitializePerformanceApiInfoINTEL,
) callconv(vulkan_call_conv) Result;
pub const PfnUninitializePerformanceApiINTEL = fn (
    device: Device,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetPerformanceMarkerINTEL = fn (
    command_buffer: CommandBuffer,
    p_marker_info: *const PerformanceMarkerInfoINTEL,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdSetPerformanceStreamMarkerINTEL = fn (
    command_buffer: CommandBuffer,
    p_marker_info: *const PerformanceStreamMarkerInfoINTEL,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdSetPerformanceOverrideINTEL = fn (
    command_buffer: CommandBuffer,
    p_override_info: *const PerformanceOverrideInfoINTEL,
) callconv(vulkan_call_conv) Result;
pub const PfnAcquirePerformanceConfigurationINTEL = fn (
    device: Device,
    p_acquire_info: *const PerformanceConfigurationAcquireInfoINTEL,
    p_configuration: *PerformanceConfigurationINTEL,
) callconv(vulkan_call_conv) Result;
pub const PfnReleasePerformanceConfigurationINTEL = fn (
    device: Device,
    configuration: PerformanceConfigurationINTEL,
) callconv(vulkan_call_conv) Result;
pub const PfnQueueSetPerformanceConfigurationINTEL = fn (
    queue: Queue,
    configuration: PerformanceConfigurationINTEL,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPerformanceParameterINTEL = fn (
    device: Device,
    parameter: PerformanceParameterTypeINTEL,
    p_value: *PerformanceValueINTEL,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDeviceMemoryOpaqueCaptureAddress = fn (
    device: Device,
    p_info: *const DeviceMemoryOpaqueCaptureAddressInfo,
) callconv(vulkan_call_conv) u64;
pub const PfnGetPipelineExecutablePropertiesKHR = fn (
    device: Device,
    p_pipeline_info: *const PipelineInfoKHR,
    p_executable_count: *u32,
    p_properties: ?[*]PipelineExecutablePropertiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPipelineExecutableStatisticsKHR = fn (
    device: Device,
    p_executable_info: *const PipelineExecutableInfoKHR,
    p_statistic_count: *u32,
    p_statistics: ?[*]PipelineExecutableStatisticKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPipelineExecutableInternalRepresentationsKHR = fn (
    device: Device,
    p_executable_info: *const PipelineExecutableInfoKHR,
    p_internal_representation_count: *u32,
    p_internal_representations: ?[*]PipelineExecutableInternalRepresentationKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdSetLineStippleEXT = fn (
    command_buffer: CommandBuffer,
    line_stipple_factor: u32,
    line_stipple_pattern: u16,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceToolPropertiesEXT = fn (
    physical_device: PhysicalDevice,
    p_tool_count: *u32,
    p_tool_properties: ?[*]PhysicalDeviceToolPropertiesEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateAccelerationStructureKHR = fn (
    device: Device,
    p_create_info: *const AccelerationStructureCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_acceleration_structure: *AccelerationStructureKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdBuildAccelerationStructuresKHR = fn (
    command_buffer: CommandBuffer,
    info_count: u32,
    p_infos: [*]const AccelerationStructureBuildGeometryInfoKHR,
    pp_build_range_infos: [*]const *const AccelerationStructureBuildRangeInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBuildAccelerationStructuresIndirectKHR = fn (
    command_buffer: CommandBuffer,
    info_count: u32,
    p_infos: [*]const AccelerationStructureBuildGeometryInfoKHR,
    p_indirect_device_addresses: [*]const DeviceAddress,
    p_indirect_strides: [*]const u32,
    pp_max_primitive_counts: [*]const *const u32,
) callconv(vulkan_call_conv) void;
pub const PfnBuildAccelerationStructuresKHR = fn (
    device: Device,
    deferred_operation: DeferredOperationKHR,
    info_count: u32,
    p_infos: [*]const AccelerationStructureBuildGeometryInfoKHR,
    pp_build_range_infos: [*]const *const AccelerationStructureBuildRangeInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetAccelerationStructureDeviceAddressKHR = fn (
    device: Device,
    p_info: *const AccelerationStructureDeviceAddressInfoKHR,
) callconv(vulkan_call_conv) DeviceAddress;
pub const PfnCreateDeferredOperationKHR = fn (
    device: Device,
    p_allocator: ?*const AllocationCallbacks,
    p_deferred_operation: *DeferredOperationKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyDeferredOperationKHR = fn (
    device: Device,
    operation: DeferredOperationKHR,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetDeferredOperationMaxConcurrencyKHR = fn (
    device: Device,
    operation: DeferredOperationKHR,
) callconv(vulkan_call_conv) u32;
pub const PfnGetDeferredOperationResultKHR = fn (
    device: Device,
    operation: DeferredOperationKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnDeferredOperationJoinKHR = fn (
    device: Device,
    operation: DeferredOperationKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdSetCullModeEXT = fn (
    command_buffer: CommandBuffer,
    cull_mode: CullModeFlags.IntType,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetFrontFaceEXT = fn (
    command_buffer: CommandBuffer,
    front_face: FrontFace,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetPrimitiveTopologyEXT = fn (
    command_buffer: CommandBuffer,
    primitive_topology: PrimitiveTopology,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetViewportWithCountEXT = fn (
    command_buffer: CommandBuffer,
    viewport_count: u32,
    p_viewports: [*]const Viewport,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetScissorWithCountEXT = fn (
    command_buffer: CommandBuffer,
    scissor_count: u32,
    p_scissors: [*]const Rect2D,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBindVertexBuffers2EXT = fn (
    command_buffer: CommandBuffer,
    first_binding: u32,
    binding_count: u32,
    p_buffers: [*]const Buffer,
    p_offsets: [*]const DeviceSize,
    p_sizes: ?[*]const DeviceSize,
    p_strides: ?[*]const DeviceSize,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetDepthTestEnableEXT = fn (
    command_buffer: CommandBuffer,
    depth_test_enable: Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetDepthWriteEnableEXT = fn (
    command_buffer: CommandBuffer,
    depth_write_enable: Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetDepthCompareOpEXT = fn (
    command_buffer: CommandBuffer,
    depth_compare_op: CompareOp,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetDepthBoundsTestEnableEXT = fn (
    command_buffer: CommandBuffer,
    depth_bounds_test_enable: Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetStencilTestEnableEXT = fn (
    command_buffer: CommandBuffer,
    stencil_test_enable: Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetStencilOpEXT = fn (
    command_buffer: CommandBuffer,
    face_mask: StencilFaceFlags.IntType,
    fail_op: StencilOp,
    pass_op: StencilOp,
    depth_fail_op: StencilOp,
    compare_op: CompareOp,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetPatchControlPointsEXT = fn (
    command_buffer: CommandBuffer,
    patch_control_points: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetRasterizerDiscardEnableEXT = fn (
    command_buffer: CommandBuffer,
    rasterizer_discard_enable: Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetDepthBiasEnableEXT = fn (
    command_buffer: CommandBuffer,
    depth_bias_enable: Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetLogicOpEXT = fn (
    command_buffer: CommandBuffer,
    logic_op: LogicOp,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetPrimitiveRestartEnableEXT = fn (
    command_buffer: CommandBuffer,
    primitive_restart_enable: Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnCreatePrivateDataSlotEXT = fn (
    device: Device,
    p_create_info: *const PrivateDataSlotCreateInfoEXT,
    p_allocator: ?*const AllocationCallbacks,
    p_private_data_slot: *PrivateDataSlotEXT,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyPrivateDataSlotEXT = fn (
    device: Device,
    private_data_slot: PrivateDataSlotEXT,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnSetPrivateDataEXT = fn (
    device: Device,
    object_type: ObjectType,
    object_handle: u64,
    private_data_slot: PrivateDataSlotEXT,
    data: u64,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPrivateDataEXT = fn (
    device: Device,
    object_type: ObjectType,
    object_handle: u64,
    private_data_slot: PrivateDataSlotEXT,
    p_data: *u64,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyBuffer2KHR = fn (
    command_buffer: CommandBuffer,
    p_copy_buffer_info: *const CopyBufferInfo2KHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyImage2KHR = fn (
    command_buffer: CommandBuffer,
    p_copy_image_info: *const CopyImageInfo2KHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBlitImage2KHR = fn (
    command_buffer: CommandBuffer,
    p_blit_image_info: *const BlitImageInfo2KHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyBufferToImage2KHR = fn (
    command_buffer: CommandBuffer,
    p_copy_buffer_to_image_info: *const CopyBufferToImageInfo2KHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCopyImageToBuffer2KHR = fn (
    command_buffer: CommandBuffer,
    p_copy_image_to_buffer_info: *const CopyImageToBufferInfo2KHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdResolveImage2KHR = fn (
    command_buffer: CommandBuffer,
    p_resolve_image_info: *const ResolveImageInfo2KHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetFragmentShadingRateKHR = fn (
    command_buffer: CommandBuffer,
    p_fragment_size: *const Extent2D,
    combiner_ops: [2]FragmentShadingRateCombinerOpKHR,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceFragmentShadingRatesKHR = fn (
    physical_device: PhysicalDevice,
    p_fragment_shading_rate_count: *u32,
    p_fragment_shading_rates: ?[*]PhysicalDeviceFragmentShadingRateKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdSetFragmentShadingRateEnumNV = fn (
    command_buffer: CommandBuffer,
    shading_rate: FragmentShadingRateNV,
    combiner_ops: [2]FragmentShadingRateCombinerOpKHR,
) callconv(vulkan_call_conv) void;
pub const PfnGetAccelerationStructureBuildSizesKHR = fn (
    device: Device,
    build_type: AccelerationStructureBuildTypeKHR,
    p_build_info: *const AccelerationStructureBuildGeometryInfoKHR,
    p_max_primitive_counts: ?[*]const u32,
    p_size_info: *AccelerationStructureBuildSizesInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetVertexInputEXT = fn (
    command_buffer: CommandBuffer,
    vertex_binding_description_count: u32,
    p_vertex_binding_descriptions: [*]const VertexInputBindingDescription2EXT,
    vertex_attribute_description_count: u32,
    p_vertex_attribute_descriptions: [*]const VertexInputAttributeDescription2EXT,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetColorWriteEnableEXT = fn (
    command_buffer: CommandBuffer,
    attachment_count: u32,
    p_color_write_enables: [*]const Bool32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdSetEvent2KHR = fn (
    command_buffer: CommandBuffer,
    event: Event,
    p_dependency_info: *const DependencyInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdResetEvent2KHR = fn (
    command_buffer: CommandBuffer,
    event: Event,
    stage_mask: PipelineStageFlags2KHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdWaitEvents2KHR = fn (
    command_buffer: CommandBuffer,
    event_count: u32,
    p_events: [*]const Event,
    p_dependency_infos: [*]const DependencyInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdPipelineBarrier2KHR = fn (
    command_buffer: CommandBuffer,
    p_dependency_info: *const DependencyInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnQueueSubmit2KHR = fn (
    queue: Queue,
    submit_count: u32,
    p_submits: [*]const SubmitInfo2KHR,
    fence: Fence,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdWriteTimestamp2KHR = fn (
    command_buffer: CommandBuffer,
    stage: PipelineStageFlags2KHR,
    query_pool: QueryPool,
    query: u32,
) callconv(vulkan_call_conv) void;
pub const PfnCmdWriteBufferMarker2AMD = fn (
    command_buffer: CommandBuffer,
    stage: PipelineStageFlags2KHR,
    dst_buffer: Buffer,
    dst_offset: DeviceSize,
    marker: u32,
) callconv(vulkan_call_conv) void;
pub const PfnGetQueueCheckpointData2NV = fn (
    queue: Queue,
    p_checkpoint_data_count: *u32,
    p_checkpoint_data: ?[*]CheckpointData2NV,
) callconv(vulkan_call_conv) void;
pub const PfnGetPhysicalDeviceVideoCapabilitiesKHR = fn (
    physical_device: PhysicalDevice,
    p_video_profile: *const VideoProfileKHR,
    p_capabilities: *VideoCapabilitiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetPhysicalDeviceVideoFormatPropertiesKHR = fn (
    physical_device: PhysicalDevice,
    p_video_format_info: *const PhysicalDeviceVideoFormatInfoKHR,
    p_video_format_property_count: *u32,
    p_video_format_properties: ?[*]VideoFormatPropertiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateVideoSessionKHR = fn (
    device: Device,
    p_create_info: *const VideoSessionCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_video_session: *VideoSessionKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyVideoSessionKHR = fn (
    device: Device,
    video_session: VideoSessionKHR,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCreateVideoSessionParametersKHR = fn (
    device: Device,
    p_create_info: *const VideoSessionParametersCreateInfoKHR,
    p_allocator: ?*const AllocationCallbacks,
    p_video_session_parameters: *VideoSessionParametersKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnUpdateVideoSessionParametersKHR = fn (
    device: Device,
    video_session_parameters: VideoSessionParametersKHR,
    p_update_info: *const VideoSessionParametersUpdateInfoKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyVideoSessionParametersKHR = fn (
    device: Device,
    video_session_parameters: VideoSessionParametersKHR,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetVideoSessionMemoryRequirementsKHR = fn (
    device: Device,
    video_session: VideoSessionKHR,
    p_video_session_memory_requirements_count: *u32,
    p_video_session_memory_requirements: ?[*]VideoGetMemoryPropertiesKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnBindVideoSessionMemoryKHR = fn (
    device: Device,
    video_session: VideoSessionKHR,
    video_session_bind_memory_count: u32,
    p_video_session_bind_memories: [*]const VideoBindMemoryKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdDecodeVideoKHR = fn (
    command_buffer: CommandBuffer,
    p_frame_info: *const VideoDecodeInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdBeginVideoCodingKHR = fn (
    command_buffer: CommandBuffer,
    p_begin_info: *const VideoBeginCodingInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdControlVideoCodingKHR = fn (
    command_buffer: CommandBuffer,
    p_coding_control_info: *const VideoCodingControlInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndVideoCodingKHR = fn (
    command_buffer: CommandBuffer,
    p_end_coding_info: *const VideoEndCodingInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEncodeVideoKHR = fn (
    command_buffer: CommandBuffer,
    p_encode_info: *const VideoEncodeInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCreateCuModuleNVX = fn (
    device: Device,
    p_create_info: *const CuModuleCreateInfoNVX,
    p_allocator: ?*const AllocationCallbacks,
    p_module: *CuModuleNVX,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateCuFunctionNVX = fn (
    device: Device,
    p_create_info: *const CuFunctionCreateInfoNVX,
    p_allocator: ?*const AllocationCallbacks,
    p_function: *CuFunctionNVX,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyCuModuleNVX = fn (
    device: Device,
    module: CuModuleNVX,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnDestroyCuFunctionNVX = fn (
    device: Device,
    function: CuFunctionNVX,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnCmdCuLaunchKernelNVX = fn (
    command_buffer: CommandBuffer,
    p_launch_info: *const CuLaunchInfoNVX,
) callconv(vulkan_call_conv) void;
pub const PfnSetDeviceMemoryPriorityEXT = fn (
    device: Device,
    memory: DeviceMemory,
    priority: f32,
) callconv(vulkan_call_conv) void;
pub const PfnAcquireDrmDisplayEXT = fn (
    physical_device: PhysicalDevice,
    drm_fd: i32,
    display: DisplayKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnGetDrmDisplayEXT = fn (
    physical_device: PhysicalDevice,
    drm_fd: i32,
    connector_id: u32,
    display: *DisplayKHR,
) callconv(vulkan_call_conv) Result;
pub const PfnWaitForPresentKHR = fn (
    device: Device,
    swapchain: SwapchainKHR,
    present_id: u64,
    timeout: u64,
) callconv(vulkan_call_conv) Result;
pub const PfnCreateBufferCollectionFUCHSIA = fn (
    device: Device,
    p_create_info: *const BufferCollectionCreateInfoFUCHSIA,
    p_allocator: ?*const AllocationCallbacks,
    p_collection: *BufferCollectionFUCHSIA,
) callconv(vulkan_call_conv) Result;
pub const PfnSetBufferCollectionBufferConstraintsFUCHSIA = fn (
    device: Device,
    collection: BufferCollectionFUCHSIA,
    p_buffer_constraints_info: *const BufferConstraintsInfoFUCHSIA,
) callconv(vulkan_call_conv) Result;
pub const PfnSetBufferCollectionImageConstraintsFUCHSIA = fn (
    device: Device,
    collection: BufferCollectionFUCHSIA,
    p_image_constraints_info: *const ImageConstraintsInfoFUCHSIA,
) callconv(vulkan_call_conv) Result;
pub const PfnDestroyBufferCollectionFUCHSIA = fn (
    device: Device,
    collection: BufferCollectionFUCHSIA,
    p_allocator: ?*const AllocationCallbacks,
) callconv(vulkan_call_conv) void;
pub const PfnGetBufferCollectionPropertiesFUCHSIA = fn (
    device: Device,
    collection: BufferCollectionFUCHSIA,
    p_properties: *BufferCollectionPropertiesFUCHSIA,
) callconv(vulkan_call_conv) Result;
pub const PfnCmdBeginRenderingKHR = fn (
    command_buffer: CommandBuffer,
    p_rendering_info: *const RenderingInfoKHR,
) callconv(vulkan_call_conv) void;
pub const PfnCmdEndRenderingKHR = fn (
    command_buffer: CommandBuffer,
) callconv(vulkan_call_conv) void;
pub const extension_info = struct {
    const Info = struct {
        name: [:0]const u8,
        version: u32,
    };
    pub const khr_surface = Info{
        .name = "VK_KHR_surface",
        .version = 25,
    };
    pub const khr_swapchain = Info{
        .name = "VK_KHR_swapchain",
        .version = 70,
    };
    pub const khr_display = Info{
        .name = "VK_KHR_display",
        .version = 23,
    };
    pub const khr_display_swapchain = Info{
        .name = "VK_KHR_display_swapchain",
        .version = 10,
    };
    pub const khr_xlib_surface = Info{
        .name = "VK_KHR_xlib_surface",
        .version = 6,
    };
    pub const khr_xcb_surface = Info{
        .name = "VK_KHR_xcb_surface",
        .version = 6,
    };
    pub const khr_wayland_surface = Info{
        .name = "VK_KHR_wayland_surface",
        .version = 6,
    };
    pub const khr_android_surface = Info{
        .name = "VK_KHR_android_surface",
        .version = 6,
    };
    pub const khr_win_32_surface = Info{
        .name = "VK_KHR_win32_surface",
        .version = 6,
    };
    pub const ext_debug_report = Info{
        .name = "VK_EXT_debug_report",
        .version = 10,
    };
    pub const nv_glsl_shader = Info{
        .name = "VK_NV_glsl_shader",
        .version = 1,
    };
    pub const ext_depth_range_unrestricted = Info{
        .name = "VK_EXT_depth_range_unrestricted",
        .version = 1,
    };
    pub const khr_sampler_mirror_clamp_to_edge = Info{
        .name = "VK_KHR_sampler_mirror_clamp_to_edge",
        .version = 3,
    };
    pub const img_filter_cubic = Info{
        .name = "VK_IMG_filter_cubic",
        .version = 1,
    };
    pub const amd_rasterization_order = Info{
        .name = "VK_AMD_rasterization_order",
        .version = 1,
    };
    pub const amd_shader_trinary_minmax = Info{
        .name = "VK_AMD_shader_trinary_minmax",
        .version = 1,
    };
    pub const amd_shader_explicit_vertex_parameter = Info{
        .name = "VK_AMD_shader_explicit_vertex_parameter",
        .version = 1,
    };
    pub const ext_debug_marker = Info{
        .name = "VK_EXT_debug_marker",
        .version = 4,
    };
    pub const khr_video_queue = Info{
        .name = "VK_KHR_video_queue",
        .version = 2,
    };
    pub const khr_video_decode_queue = Info{
        .name = "VK_KHR_video_decode_queue",
        .version = 2,
    };
    pub const amd_gcn_shader = Info{
        .name = "VK_AMD_gcn_shader",
        .version = 1,
    };
    pub const nv_dedicated_allocation = Info{
        .name = "VK_NV_dedicated_allocation",
        .version = 1,
    };
    pub const ext_transform_feedback = Info{
        .name = "VK_EXT_transform_feedback",
        .version = 1,
    };
    pub const nvx_binary_import = Info{
        .name = "VK_NVX_binary_import",
        .version = 1,
    };
    pub const nvx_image_view_handle = Info{
        .name = "VK_NVX_image_view_handle",
        .version = 2,
    };
    pub const amd_draw_indirect_count = Info{
        .name = "VK_AMD_draw_indirect_count",
        .version = 2,
    };
    pub const amd_negative_viewport_height = Info{
        .name = "VK_AMD_negative_viewport_height",
        .version = 1,
    };
    pub const amd_gpu_shader_half_float = Info{
        .name = "VK_AMD_gpu_shader_half_float",
        .version = 2,
    };
    pub const amd_shader_ballot = Info{
        .name = "VK_AMD_shader_ballot",
        .version = 1,
    };
    pub const ext_video_encode_h_264 = Info{
        .name = "VK_EXT_video_encode_h264",
        .version = 2,
    };
    pub const ext_video_encode_h_265 = Info{
        .name = "VK_EXT_video_encode_h265",
        .version = 2,
    };
    pub const ext_video_decode_h_264 = Info{
        .name = "VK_EXT_video_decode_h264",
        .version = 3,
    };
    pub const amd_texture_gather_bias_lod = Info{
        .name = "VK_AMD_texture_gather_bias_lod",
        .version = 1,
    };
    pub const amd_shader_info = Info{
        .name = "VK_AMD_shader_info",
        .version = 1,
    };
    pub const khr_dynamic_rendering = Info{
        .name = "VK_KHR_dynamic_rendering",
        .version = 1,
    };
    pub const amd_shader_image_load_store_lod = Info{
        .name = "VK_AMD_shader_image_load_store_lod",
        .version = 1,
    };
    pub const ggp_stream_descriptor_surface = Info{
        .name = "VK_GGP_stream_descriptor_surface",
        .version = 1,
    };
    pub const nv_corner_sampled_image = Info{
        .name = "VK_NV_corner_sampled_image",
        .version = 2,
    };
    pub const khr_multiview = Info{
        .name = "VK_KHR_multiview",
        .version = 1,
    };
    pub const img_format_pvrtc = Info{
        .name = "VK_IMG_format_pvrtc",
        .version = 1,
    };
    pub const nv_external_memory_capabilities = Info{
        .name = "VK_NV_external_memory_capabilities",
        .version = 1,
    };
    pub const nv_external_memory = Info{
        .name = "VK_NV_external_memory",
        .version = 1,
    };
    pub const nv_external_memory_win_32 = Info{
        .name = "VK_NV_external_memory_win32",
        .version = 1,
    };
    pub const nv_win_32_keyed_mutex = Info{
        .name = "VK_NV_win32_keyed_mutex",
        .version = 2,
    };
    pub const khr_get_physical_device_properties_2 = Info{
        .name = "VK_KHR_get_physical_device_properties2",
        .version = 2,
    };
    pub const khr_device_group = Info{
        .name = "VK_KHR_device_group",
        .version = 4,
    };
    pub const ext_validation_flags = Info{
        .name = "VK_EXT_validation_flags",
        .version = 2,
    };
    pub const nn_vi_surface = Info{
        .name = "VK_NN_vi_surface",
        .version = 1,
    };
    pub const khr_shader_draw_parameters = Info{
        .name = "VK_KHR_shader_draw_parameters",
        .version = 1,
    };
    pub const ext_shader_subgroup_ballot = Info{
        .name = "VK_EXT_shader_subgroup_ballot",
        .version = 1,
    };
    pub const ext_shader_subgroup_vote = Info{
        .name = "VK_EXT_shader_subgroup_vote",
        .version = 1,
    };
    pub const ext_texture_compression_astc_hdr = Info{
        .name = "VK_EXT_texture_compression_astc_hdr",
        .version = 1,
    };
    pub const ext_astc_decode_mode = Info{
        .name = "VK_EXT_astc_decode_mode",
        .version = 1,
    };
    pub const khr_maintenance_1 = Info{
        .name = "VK_KHR_maintenance1",
        .version = 2,
    };
    pub const khr_device_group_creation = Info{
        .name = "VK_KHR_device_group_creation",
        .version = 1,
    };
    pub const khr_external_memory_capabilities = Info{
        .name = "VK_KHR_external_memory_capabilities",
        .version = 1,
    };
    pub const khr_external_memory = Info{
        .name = "VK_KHR_external_memory",
        .version = 1,
    };
    pub const khr_external_memory_win_32 = Info{
        .name = "VK_KHR_external_memory_win32",
        .version = 1,
    };
    pub const khr_external_memory_fd = Info{
        .name = "VK_KHR_external_memory_fd",
        .version = 1,
    };
    pub const khr_win_32_keyed_mutex = Info{
        .name = "VK_KHR_win32_keyed_mutex",
        .version = 1,
    };
    pub const khr_external_semaphore_capabilities = Info{
        .name = "VK_KHR_external_semaphore_capabilities",
        .version = 1,
    };
    pub const khr_external_semaphore = Info{
        .name = "VK_KHR_external_semaphore",
        .version = 1,
    };
    pub const khr_external_semaphore_win_32 = Info{
        .name = "VK_KHR_external_semaphore_win32",
        .version = 1,
    };
    pub const khr_external_semaphore_fd = Info{
        .name = "VK_KHR_external_semaphore_fd",
        .version = 1,
    };
    pub const khr_push_descriptor = Info{
        .name = "VK_KHR_push_descriptor",
        .version = 2,
    };
    pub const ext_conditional_rendering = Info{
        .name = "VK_EXT_conditional_rendering",
        .version = 2,
    };
    pub const khr_shader_float_16_int_8 = Info{
        .name = "VK_KHR_shader_float16_int8",
        .version = 1,
    };
    pub const khr_1_6bit_storage = Info{
        .name = "VK_KHR_16bit_storage",
        .version = 1,
    };
    pub const khr_incremental_present = Info{
        .name = "VK_KHR_incremental_present",
        .version = 2,
    };
    pub const khr_descriptor_update_template = Info{
        .name = "VK_KHR_descriptor_update_template",
        .version = 1,
    };
    pub const nv_clip_space_w_scaling = Info{
        .name = "VK_NV_clip_space_w_scaling",
        .version = 1,
    };
    pub const ext_direct_mode_display = Info{
        .name = "VK_EXT_direct_mode_display",
        .version = 1,
    };
    pub const ext_acquire_xlib_display = Info{
        .name = "VK_EXT_acquire_xlib_display",
        .version = 1,
    };
    pub const ext_display_surface_counter = Info{
        .name = "VK_EXT_display_surface_counter",
        .version = 1,
    };
    pub const ext_display_control = Info{
        .name = "VK_EXT_display_control",
        .version = 1,
    };
    pub const google_display_timing = Info{
        .name = "VK_GOOGLE_display_timing",
        .version = 1,
    };
    pub const nv_sample_mask_override_coverage = Info{
        .name = "VK_NV_sample_mask_override_coverage",
        .version = 1,
    };
    pub const nv_geometry_shader_passthrough = Info{
        .name = "VK_NV_geometry_shader_passthrough",
        .version = 1,
    };
    pub const nv_viewport_array_2 = Info{
        .name = "VK_NV_viewport_array2",
        .version = 1,
    };
    pub const nvx_multiview_per_view_attributes = Info{
        .name = "VK_NVX_multiview_per_view_attributes",
        .version = 1,
    };
    pub const nv_viewport_swizzle = Info{
        .name = "VK_NV_viewport_swizzle",
        .version = 1,
    };
    pub const ext_discard_rectangles = Info{
        .name = "VK_EXT_discard_rectangles",
        .version = 1,
    };
    pub const ext_conservative_rasterization = Info{
        .name = "VK_EXT_conservative_rasterization",
        .version = 1,
    };
    pub const ext_depth_clip_enable = Info{
        .name = "VK_EXT_depth_clip_enable",
        .version = 1,
    };
    pub const ext_swapchain_colorspace = Info{
        .name = "VK_EXT_swapchain_colorspace",
        .version = 4,
    };
    pub const ext_hdr_metadata = Info{
        .name = "VK_EXT_hdr_metadata",
        .version = 2,
    };
    pub const khr_imageless_framebuffer = Info{
        .name = "VK_KHR_imageless_framebuffer",
        .version = 1,
    };
    pub const khr_create_renderpass_2 = Info{
        .name = "VK_KHR_create_renderpass2",
        .version = 1,
    };
    pub const khr_shared_presentable_image = Info{
        .name = "VK_KHR_shared_presentable_image",
        .version = 1,
    };
    pub const khr_external_fence_capabilities = Info{
        .name = "VK_KHR_external_fence_capabilities",
        .version = 1,
    };
    pub const khr_external_fence = Info{
        .name = "VK_KHR_external_fence",
        .version = 1,
    };
    pub const khr_external_fence_win_32 = Info{
        .name = "VK_KHR_external_fence_win32",
        .version = 1,
    };
    pub const khr_external_fence_fd = Info{
        .name = "VK_KHR_external_fence_fd",
        .version = 1,
    };
    pub const khr_performance_query = Info{
        .name = "VK_KHR_performance_query",
        .version = 1,
    };
    pub const khr_maintenance_2 = Info{
        .name = "VK_KHR_maintenance2",
        .version = 1,
    };
    pub const khr_get_surface_capabilities_2 = Info{
        .name = "VK_KHR_get_surface_capabilities2",
        .version = 1,
    };
    pub const khr_variable_pointers = Info{
        .name = "VK_KHR_variable_pointers",
        .version = 1,
    };
    pub const khr_get_display_properties_2 = Info{
        .name = "VK_KHR_get_display_properties2",
        .version = 1,
    };
    pub const mvk_ios_surface = Info{
        .name = "VK_MVK_ios_surface",
        .version = 3,
    };
    pub const mvk_macos_surface = Info{
        .name = "VK_MVK_macos_surface",
        .version = 3,
    };
    pub const ext_external_memory_dma_buf = Info{
        .name = "VK_EXT_external_memory_dma_buf",
        .version = 1,
    };
    pub const ext_queue_family_foreign = Info{
        .name = "VK_EXT_queue_family_foreign",
        .version = 1,
    };
    pub const khr_dedicated_allocation = Info{
        .name = "VK_KHR_dedicated_allocation",
        .version = 3,
    };
    pub const ext_debug_utils = Info{
        .name = "VK_EXT_debug_utils",
        .version = 2,
    };
    pub const android_external_memory_android_hardware_buffer = Info{
        .name = "VK_ANDROID_external_memory_android_hardware_buffer",
        .version = 4,
    };
    pub const ext_sampler_filter_minmax = Info{
        .name = "VK_EXT_sampler_filter_minmax",
        .version = 2,
    };
    pub const khr_storage_buffer_storage_class = Info{
        .name = "VK_KHR_storage_buffer_storage_class",
        .version = 1,
    };
    pub const amd_gpu_shader_int_16 = Info{
        .name = "VK_AMD_gpu_shader_int16",
        .version = 2,
    };
    pub const amd_mixed_attachment_samples = Info{
        .name = "VK_AMD_mixed_attachment_samples",
        .version = 1,
    };
    pub const amd_shader_fragment_mask = Info{
        .name = "VK_AMD_shader_fragment_mask",
        .version = 1,
    };
    pub const ext_inline_uniform_block = Info{
        .name = "VK_EXT_inline_uniform_block",
        .version = 1,
    };
    pub const ext_shader_stencil_export = Info{
        .name = "VK_EXT_shader_stencil_export",
        .version = 1,
    };
    pub const ext_sample_locations = Info{
        .name = "VK_EXT_sample_locations",
        .version = 1,
    };
    pub const khr_relaxed_block_layout = Info{
        .name = "VK_KHR_relaxed_block_layout",
        .version = 1,
    };
    pub const khr_get_memory_requirements_2 = Info{
        .name = "VK_KHR_get_memory_requirements2",
        .version = 1,
    };
    pub const khr_image_format_list = Info{
        .name = "VK_KHR_image_format_list",
        .version = 1,
    };
    pub const ext_blend_operation_advanced = Info{
        .name = "VK_EXT_blend_operation_advanced",
        .version = 2,
    };
    pub const nv_fragment_coverage_to_color = Info{
        .name = "VK_NV_fragment_coverage_to_color",
        .version = 1,
    };
    pub const khr_acceleration_structure = Info{
        .name = "VK_KHR_acceleration_structure",
        .version = 13,
    };
    pub const khr_ray_tracing_pipeline = Info{
        .name = "VK_KHR_ray_tracing_pipeline",
        .version = 1,
    };
    pub const khr_ray_query = Info{
        .name = "VK_KHR_ray_query",
        .version = 1,
    };
    pub const nv_framebuffer_mixed_samples = Info{
        .name = "VK_NV_framebuffer_mixed_samples",
        .version = 1,
    };
    pub const nv_fill_rectangle = Info{
        .name = "VK_NV_fill_rectangle",
        .version = 1,
    };
    pub const nv_shader_sm_builtins = Info{
        .name = "VK_NV_shader_sm_builtins",
        .version = 1,
    };
    pub const ext_post_depth_coverage = Info{
        .name = "VK_EXT_post_depth_coverage",
        .version = 1,
    };
    pub const khr_sampler_ycbcr_conversion = Info{
        .name = "VK_KHR_sampler_ycbcr_conversion",
        .version = 14,
    };
    pub const khr_bind_memory_2 = Info{
        .name = "VK_KHR_bind_memory2",
        .version = 1,
    };
    pub const ext_image_drm_format_modifier = Info{
        .name = "VK_EXT_image_drm_format_modifier",
        .version = 2,
    };
    pub const ext_validation_cache = Info{
        .name = "VK_EXT_validation_cache",
        .version = 1,
    };
    pub const ext_descriptor_indexing = Info{
        .name = "VK_EXT_descriptor_indexing",
        .version = 2,
    };
    pub const ext_shader_viewport_index_layer = Info{
        .name = "VK_EXT_shader_viewport_index_layer",
        .version = 1,
    };
    pub const khr_portability_subset = Info{
        .name = "VK_KHR_portability_subset",
        .version = 1,
    };
    pub const nv_shading_rate_image = Info{
        .name = "VK_NV_shading_rate_image",
        .version = 3,
    };
    pub const nv_ray_tracing = Info{
        .name = "VK_NV_ray_tracing",
        .version = 3,
    };
    pub const nv_representative_fragment_test = Info{
        .name = "VK_NV_representative_fragment_test",
        .version = 2,
    };
    pub const khr_maintenance_3 = Info{
        .name = "VK_KHR_maintenance3",
        .version = 1,
    };
    pub const khr_draw_indirect_count = Info{
        .name = "VK_KHR_draw_indirect_count",
        .version = 1,
    };
    pub const ext_filter_cubic = Info{
        .name = "VK_EXT_filter_cubic",
        .version = 3,
    };
    pub const qcom_render_pass_shader_resolve = Info{
        .name = "VK_QCOM_render_pass_shader_resolve",
        .version = 4,
    };
    pub const ext_global_priority = Info{
        .name = "VK_EXT_global_priority",
        .version = 2,
    };
    pub const khr_shader_subgroup_extended_types = Info{
        .name = "VK_KHR_shader_subgroup_extended_types",
        .version = 1,
    };
    pub const khr_8bit_storage = Info{
        .name = "VK_KHR_8bit_storage",
        .version = 1,
    };
    pub const ext_external_memory_host = Info{
        .name = "VK_EXT_external_memory_host",
        .version = 1,
    };
    pub const amd_buffer_marker = Info{
        .name = "VK_AMD_buffer_marker",
        .version = 1,
    };
    pub const khr_shader_atomic_int_64 = Info{
        .name = "VK_KHR_shader_atomic_int64",
        .version = 1,
    };
    pub const khr_shader_clock = Info{
        .name = "VK_KHR_shader_clock",
        .version = 1,
    };
    pub const amd_pipeline_compiler_control = Info{
        .name = "VK_AMD_pipeline_compiler_control",
        .version = 1,
    };
    pub const ext_calibrated_timestamps = Info{
        .name = "VK_EXT_calibrated_timestamps",
        .version = 2,
    };
    pub const amd_shader_core_properties = Info{
        .name = "VK_AMD_shader_core_properties",
        .version = 2,
    };
    pub const ext_video_decode_h_265 = Info{
        .name = "VK_EXT_video_decode_h265",
        .version = 1,
    };
    pub const amd_memory_overallocation_behavior = Info{
        .name = "VK_AMD_memory_overallocation_behavior",
        .version = 1,
    };
    pub const ext_vertex_attribute_divisor = Info{
        .name = "VK_EXT_vertex_attribute_divisor",
        .version = 3,
    };
    pub const ggp_frame_token = Info{
        .name = "VK_GGP_frame_token",
        .version = 1,
    };
    pub const ext_pipeline_creation_feedback = Info{
        .name = "VK_EXT_pipeline_creation_feedback",
        .version = 1,
    };
    pub const khr_driver_properties = Info{
        .name = "VK_KHR_driver_properties",
        .version = 1,
    };
    pub const khr_shader_float_controls = Info{
        .name = "VK_KHR_shader_float_controls",
        .version = 4,
    };
    pub const nv_shader_subgroup_partitioned = Info{
        .name = "VK_NV_shader_subgroup_partitioned",
        .version = 1,
    };
    pub const khr_depth_stencil_resolve = Info{
        .name = "VK_KHR_depth_stencil_resolve",
        .version = 1,
    };
    pub const khr_swapchain_mutable_format = Info{
        .name = "VK_KHR_swapchain_mutable_format",
        .version = 1,
    };
    pub const nv_compute_shader_derivatives = Info{
        .name = "VK_NV_compute_shader_derivatives",
        .version = 1,
    };
    pub const nv_mesh_shader = Info{
        .name = "VK_NV_mesh_shader",
        .version = 1,
    };
    pub const nv_fragment_shader_barycentric = Info{
        .name = "VK_NV_fragment_shader_barycentric",
        .version = 1,
    };
    pub const nv_shader_image_footprint = Info{
        .name = "VK_NV_shader_image_footprint",
        .version = 2,
    };
    pub const nv_scissor_exclusive = Info{
        .name = "VK_NV_scissor_exclusive",
        .version = 1,
    };
    pub const nv_device_diagnostic_checkpoints = Info{
        .name = "VK_NV_device_diagnostic_checkpoints",
        .version = 2,
    };
    pub const khr_timeline_semaphore = Info{
        .name = "VK_KHR_timeline_semaphore",
        .version = 2,
    };
    pub const intel_shader_integer_functions_2 = Info{
        .name = "VK_INTEL_shader_integer_functions2",
        .version = 1,
    };
    pub const intel_performance_query = Info{
        .name = "VK_INTEL_performance_query",
        .version = 2,
    };
    pub const khr_vulkan_memory_model = Info{
        .name = "VK_KHR_vulkan_memory_model",
        .version = 3,
    };
    pub const ext_pci_bus_info = Info{
        .name = "VK_EXT_pci_bus_info",
        .version = 2,
    };
    pub const amd_display_native_hdr = Info{
        .name = "VK_AMD_display_native_hdr",
        .version = 1,
    };
    pub const fuchsia_imagepipe_surface = Info{
        .name = "VK_FUCHSIA_imagepipe_surface",
        .version = 1,
    };
    pub const khr_shader_terminate_invocation = Info{
        .name = "VK_KHR_shader_terminate_invocation",
        .version = 1,
    };
    pub const ext_metal_surface = Info{
        .name = "VK_EXT_metal_surface",
        .version = 1,
    };
    pub const ext_fragment_density_map = Info{
        .name = "VK_EXT_fragment_density_map",
        .version = 2,
    };
    pub const ext_scalar_block_layout = Info{
        .name = "VK_EXT_scalar_block_layout",
        .version = 1,
    };
    pub const google_hlsl_functionality_1 = Info{
        .name = "VK_GOOGLE_hlsl_functionality1",
        .version = 1,
    };
    pub const google_decorate_string = Info{
        .name = "VK_GOOGLE_decorate_string",
        .version = 1,
    };
    pub const ext_subgroup_size_control = Info{
        .name = "VK_EXT_subgroup_size_control",
        .version = 2,
    };
    pub const khr_fragment_shading_rate = Info{
        .name = "VK_KHR_fragment_shading_rate",
        .version = 2,
    };
    pub const amd_shader_core_properties_2 = Info{
        .name = "VK_AMD_shader_core_properties2",
        .version = 1,
    };
    pub const amd_device_coherent_memory = Info{
        .name = "VK_AMD_device_coherent_memory",
        .version = 1,
    };
    pub const ext_shader_image_atomic_int_64 = Info{
        .name = "VK_EXT_shader_image_atomic_int64",
        .version = 1,
    };
    pub const khr_spirv_1_4 = Info{
        .name = "VK_KHR_spirv_1_4",
        .version = 1,
    };
    pub const ext_memory_budget = Info{
        .name = "VK_EXT_memory_budget",
        .version = 1,
    };
    pub const ext_memory_priority = Info{
        .name = "VK_EXT_memory_priority",
        .version = 1,
    };
    pub const khr_surface_protected_capabilities = Info{
        .name = "VK_KHR_surface_protected_capabilities",
        .version = 1,
    };
    pub const nv_dedicated_allocation_image_aliasing = Info{
        .name = "VK_NV_dedicated_allocation_image_aliasing",
        .version = 1,
    };
    pub const khr_separate_depth_stencil_layouts = Info{
        .name = "VK_KHR_separate_depth_stencil_layouts",
        .version = 1,
    };
    pub const ext_buffer_device_address = Info{
        .name = "VK_EXT_buffer_device_address",
        .version = 2,
    };
    pub const ext_tooling_info = Info{
        .name = "VK_EXT_tooling_info",
        .version = 1,
    };
    pub const ext_separate_stencil_usage = Info{
        .name = "VK_EXT_separate_stencil_usage",
        .version = 1,
    };
    pub const ext_validation_features = Info{
        .name = "VK_EXT_validation_features",
        .version = 5,
    };
    pub const khr_present_wait = Info{
        .name = "VK_KHR_present_wait",
        .version = 1,
    };
    pub const nv_cooperative_matrix = Info{
        .name = "VK_NV_cooperative_matrix",
        .version = 1,
    };
    pub const nv_coverage_reduction_mode = Info{
        .name = "VK_NV_coverage_reduction_mode",
        .version = 1,
    };
    pub const ext_fragment_shader_interlock = Info{
        .name = "VK_EXT_fragment_shader_interlock",
        .version = 1,
    };
    pub const ext_ycbcr_image_arrays = Info{
        .name = "VK_EXT_ycbcr_image_arrays",
        .version = 1,
    };
    pub const khr_uniform_buffer_standard_layout = Info{
        .name = "VK_KHR_uniform_buffer_standard_layout",
        .version = 1,
    };
    pub const ext_provoking_vertex = Info{
        .name = "VK_EXT_provoking_vertex",
        .version = 1,
    };
    pub const ext_full_screen_exclusive = Info{
        .name = "VK_EXT_full_screen_exclusive",
        .version = 4,
    };
    pub const ext_headless_surface = Info{
        .name = "VK_EXT_headless_surface",
        .version = 1,
    };
    pub const khr_buffer_device_address = Info{
        .name = "VK_KHR_buffer_device_address",
        .version = 1,
    };
    pub const ext_line_rasterization = Info{
        .name = "VK_EXT_line_rasterization",
        .version = 1,
    };
    pub const ext_shader_atomic_float = Info{
        .name = "VK_EXT_shader_atomic_float",
        .version = 1,
    };
    pub const ext_host_query_reset = Info{
        .name = "VK_EXT_host_query_reset",
        .version = 1,
    };
    pub const ext_index_type_uint_8 = Info{
        .name = "VK_EXT_index_type_uint8",
        .version = 1,
    };
    pub const ext_extended_dynamic_state = Info{
        .name = "VK_EXT_extended_dynamic_state",
        .version = 1,
    };
    pub const khr_deferred_host_operations = Info{
        .name = "VK_KHR_deferred_host_operations",
        .version = 4,
    };
    pub const khr_pipeline_executable_properties = Info{
        .name = "VK_KHR_pipeline_executable_properties",
        .version = 1,
    };
    pub const ext_shader_atomic_float_2 = Info{
        .name = "VK_EXT_shader_atomic_float2",
        .version = 1,
    };
    pub const ext_shader_demote_to_helper_invocation = Info{
        .name = "VK_EXT_shader_demote_to_helper_invocation",
        .version = 1,
    };
    pub const nv_device_generated_commands = Info{
        .name = "VK_NV_device_generated_commands",
        .version = 3,
    };
    pub const nv_inherited_viewport_scissor = Info{
        .name = "VK_NV_inherited_viewport_scissor",
        .version = 1,
    };
    pub const khr_shader_integer_dot_product = Info{
        .name = "VK_KHR_shader_integer_dot_product",
        .version = 1,
    };
    pub const ext_texel_buffer_alignment = Info{
        .name = "VK_EXT_texel_buffer_alignment",
        .version = 1,
    };
    pub const qcom_render_pass_transform = Info{
        .name = "VK_QCOM_render_pass_transform",
        .version = 2,
    };
    pub const ext_device_memory_report = Info{
        .name = "VK_EXT_device_memory_report",
        .version = 2,
    };
    pub const ext_acquire_drm_display = Info{
        .name = "VK_EXT_acquire_drm_display",
        .version = 1,
    };
    pub const ext_robustness_2 = Info{
        .name = "VK_EXT_robustness2",
        .version = 1,
    };
    pub const ext_custom_border_color = Info{
        .name = "VK_EXT_custom_border_color",
        .version = 12,
    };
    pub const google_user_type = Info{
        .name = "VK_GOOGLE_user_type",
        .version = 1,
    };
    pub const khr_pipeline_library = Info{
        .name = "VK_KHR_pipeline_library",
        .version = 1,
    };
    pub const khr_shader_non_semantic_info = Info{
        .name = "VK_KHR_shader_non_semantic_info",
        .version = 1,
    };
    pub const khr_present_id = Info{
        .name = "VK_KHR_present_id",
        .version = 1,
    };
    pub const ext_private_data = Info{
        .name = "VK_EXT_private_data",
        .version = 1,
    };
    pub const ext_pipeline_creation_cache_control = Info{
        .name = "VK_EXT_pipeline_creation_cache_control",
        .version = 3,
    };
    pub const khr_video_encode_queue = Info{
        .name = "VK_KHR_video_encode_queue",
        .version = 3,
    };
    pub const nv_device_diagnostics_config = Info{
        .name = "VK_NV_device_diagnostics_config",
        .version = 1,
    };
    pub const qcom_render_pass_store_ops = Info{
        .name = "VK_QCOM_render_pass_store_ops",
        .version = 2,
    };
    pub const khr_synchronization_2 = Info{
        .name = "VK_KHR_synchronization2",
        .version = 1,
    };
    pub const khr_shader_subgroup_uniform_control_flow = Info{
        .name = "VK_KHR_shader_subgroup_uniform_control_flow",
        .version = 1,
    };
    pub const khr_zero_initialize_workgroup_memory = Info{
        .name = "VK_KHR_zero_initialize_workgroup_memory",
        .version = 1,
    };
    pub const nv_fragment_shading_rate_enums = Info{
        .name = "VK_NV_fragment_shading_rate_enums",
        .version = 1,
    };
    pub const nv_ray_tracing_motion_blur = Info{
        .name = "VK_NV_ray_tracing_motion_blur",
        .version = 1,
    };
    pub const ext_ycbcr_2plane_444_formats = Info{
        .name = "VK_EXT_ycbcr_2plane_444_formats",
        .version = 1,
    };
    pub const ext_fragment_density_map_2 = Info{
        .name = "VK_EXT_fragment_density_map2",
        .version = 1,
    };
    pub const qcom_rotated_copy_commands = Info{
        .name = "VK_QCOM_rotated_copy_commands",
        .version = 1,
    };
    pub const ext_image_robustness = Info{
        .name = "VK_EXT_image_robustness",
        .version = 1,
    };
    pub const khr_workgroup_memory_explicit_layout = Info{
        .name = "VK_KHR_workgroup_memory_explicit_layout",
        .version = 1,
    };
    pub const khr_copy_commands_2 = Info{
        .name = "VK_KHR_copy_commands2",
        .version = 1,
    };
    pub const ext_4444_formats = Info{
        .name = "VK_EXT_4444_formats",
        .version = 1,
    };
    pub const ext_rgba_1_0x_6_formats = Info{
        .name = "VK_EXT_rgba10x6_formats",
        .version = 1,
    };
    pub const nv_acquire_winrt_display = Info{
        .name = "VK_NV_acquire_winrt_display",
        .version = 1,
    };
    pub const ext_directfb_surface = Info{
        .name = "VK_EXT_directfb_surface",
        .version = 1,
    };
    pub const valve_mutable_descriptor_type = Info{
        .name = "VK_VALVE_mutable_descriptor_type",
        .version = 1,
    };
    pub const ext_vertex_input_dynamic_state = Info{
        .name = "VK_EXT_vertex_input_dynamic_state",
        .version = 2,
    };
    pub const ext_physical_device_drm = Info{
        .name = "VK_EXT_physical_device_drm",
        .version = 1,
    };
    pub const ext_primitive_topology_list_restart = Info{
        .name = "VK_EXT_primitive_topology_list_restart",
        .version = 1,
    };
    pub const khr_format_feature_flags_2 = Info{
        .name = "VK_KHR_format_feature_flags2",
        .version = 1,
    };
    pub const fuchsia_external_memory = Info{
        .name = "VK_FUCHSIA_external_memory",
        .version = 1,
    };
    pub const fuchsia_external_semaphore = Info{
        .name = "VK_FUCHSIA_external_semaphore",
        .version = 1,
    };
    pub const fuchsia_buffer_collection = Info{
        .name = "VK_FUCHSIA_buffer_collection",
        .version = 2,
    };
    pub const huawei_subpass_shading = Info{
        .name = "VK_HUAWEI_subpass_shading",
        .version = 2,
    };
    pub const huawei_invocation_mask = Info{
        .name = "VK_HUAWEI_invocation_mask",
        .version = 1,
    };
    pub const nv_external_memory_rdma = Info{
        .name = "VK_NV_external_memory_rdma",
        .version = 1,
    };
    pub const ext_extended_dynamic_state_2 = Info{
        .name = "VK_EXT_extended_dynamic_state2",
        .version = 1,
    };
    pub const qnx_screen_surface = Info{
        .name = "VK_QNX_screen_surface",
        .version = 1,
    };
    pub const ext_color_write_enable = Info{
        .name = "VK_EXT_color_write_enable",
        .version = 1,
    };
    pub const ext_global_priority_query = Info{
        .name = "VK_EXT_global_priority_query",
        .version = 1,
    };
    pub const ext_multi_draw = Info{
        .name = "VK_EXT_multi_draw",
        .version = 1,
    };
    pub const ext_load_store_op_none = Info{
        .name = "VK_EXT_load_store_op_none",
        .version = 1,
    };
    pub const ext_border_color_swizzle = Info{
        .name = "VK_EXT_border_color_swizzle",
        .version = 1,
    };
    pub const ext_pageable_device_local_memory = Info{
        .name = "VK_EXT_pageable_device_local_memory",
        .version = 1,
    };
    pub const khr_maintenance_4 = Info{
        .name = "VK_KHR_maintenance4",
        .version = 1,
    };
};
pub fn BaseWrapper(comptime cmds: anytype) type {
    comptime var fields: [cmds.len]std.builtin.TypeInfo.StructField = undefined;
    inline for (cmds) |cmd, i| {
        const cmd_name = BaseCommandToString(cmd);
        const cmd_type_name = "Pfn" ++ cmd_name;
        const cmd_type = @field(GlobalScope, cmd_type_name);
        fields[i] = .{
            .name = "vk" ++ cmd_name,
            .field_type = cmd_type,
            .default_value = null,
            .is_comptime = false,
            .alignment = @alignOf(*cmd_type),
        };
    }
    const Dispatch = @Type(.{
        .Struct = .{
            .layout = .Auto,
            .fields = &fields,
            .decls = &[_]std.builtin.TypeInfo.Declaration{},
            .is_tuple = false,
        },
    });
    return struct {
        dispatch: Dispatch,

        const Self = @This();
        pub fn load(loader: anytype) !Self {
            var self: Self = undefined;
            inline for (std.meta.fields(Dispatch)) |field| {
                const name = @ptrCast([*:0]const u8, field.name ++ "\x00");
                const cmd_ptr = loader(.null_handle, name) orelse return error.CommandLoadFailure;
                @field(self.dispatch, field.name) = @ptrCast(field.field_type, cmd_ptr);
            }
            return self;
        }
        pub const CreateInstanceError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            LayerNotPresent,
            ExtensionNotPresent,
            IncompatibleDriver,
            Unknown,
        };
        pub fn createInstance(
            self: Self,
            create_info: InstanceCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateInstanceError!Instance {
            var instance: Instance = undefined;
            const result = self.dispatch.vkCreateInstance(
                &create_info,
                p_allocator,
                &instance,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_layer_not_present => return error.LayerNotPresent,
                Result.error_extension_not_present => return error.ExtensionNotPresent,
                Result.error_incompatible_driver => return error.IncompatibleDriver,
                else => return error.Unknown,
            }
            return instance;
        }
        pub fn getInstanceProcAddr(
            self: Self,
            instance: Instance,
            p_name: [*:0]const u8,
        ) PfnVoidFunction {
            return self.dispatch.vkGetInstanceProcAddr(
                instance,
                p_name,
            );
        }
        pub const EnumerateInstanceVersionError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn enumerateInstanceVersion(
            self: Self,
        ) EnumerateInstanceVersionError!u32 {
            var api_version: u32 = undefined;
            const result = self.dispatch.vkEnumerateInstanceVersion(
                &api_version,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return api_version;
        }
        pub const EnumerateInstanceLayerPropertiesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn enumerateInstanceLayerProperties(
            self: Self,
            p_property_count: *u32,
            p_properties: ?[*]LayerProperties,
        ) EnumerateInstanceLayerPropertiesError!Result {
            const result = self.dispatch.vkEnumerateInstanceLayerProperties(
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const EnumerateInstanceExtensionPropertiesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            LayerNotPresent,
            Unknown,
        };
        pub fn enumerateInstanceExtensionProperties(
            self: Self,
            p_layer_name: ?[*:0]const u8,
            p_property_count: *u32,
            p_properties: ?[*]ExtensionProperties,
        ) EnumerateInstanceExtensionPropertiesError!Result {
            const result = self.dispatch.vkEnumerateInstanceExtensionProperties(
                p_layer_name,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_layer_not_present => return error.LayerNotPresent,
                else => return error.Unknown,
            }
            return result;
        }
    };
}
pub fn InstanceWrapper(comptime cmds: anytype) type {
    comptime var fields: [cmds.len]std.builtin.TypeInfo.StructField = undefined;
    inline for (cmds) |cmd, i| {
        const cmd_name = InstanceCommandToString(cmd);
        const cmd_type_name = "Pfn" ++ cmd_name;
        const cmd_type = @field(GlobalScope, cmd_type_name);
        fields[i] = .{
            .name = "vk" ++ cmd_name,
            .field_type = cmd_type,
            .default_value = null,
            .is_comptime = false,
            .alignment = @alignOf(*cmd_type),
        };
    }
    const Dispatch = @Type(.{
        .Struct = .{
            .layout = .Auto,
            .fields = &fields,
            .decls = &[_]std.builtin.TypeInfo.Declaration{},
            .is_tuple = false,
        },
    });
    return struct {
        dispatch: Dispatch,

        const Self = @This();
        pub fn load(instance: Instance, loader: anytype) !Self {
            var self: Self = undefined;
            inline for (std.meta.fields(Dispatch)) |field| {
                const name = @ptrCast([*:0]const u8, field.name ++ "\x00");
                const cmd_ptr = loader(instance, name) orelse return error.CommandLoadFailure;
                @field(self.dispatch, field.name) = @ptrCast(field.field_type, cmd_ptr);
            }
            return self;
        }
        pub fn destroyInstance(
            self: Self,
            instance: Instance,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyInstance(
                instance,
                p_allocator,
            );
        }
        pub const EnumeratePhysicalDevicesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn enumeratePhysicalDevices(
            self: Self,
            instance: Instance,
            p_physical_device_count: *u32,
            p_physical_devices: ?[*]PhysicalDevice,
        ) EnumeratePhysicalDevicesError!Result {
            const result = self.dispatch.vkEnumeratePhysicalDevices(
                instance,
                p_physical_device_count,
                p_physical_devices,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn getDeviceProcAddr(
            self: Self,
            device: Device,
            p_name: [*:0]const u8,
        ) PfnVoidFunction {
            return self.dispatch.vkGetDeviceProcAddr(
                device,
                p_name,
            );
        }
        pub fn getPhysicalDeviceProperties(
            self: Self,
            physical_device: PhysicalDevice,
        ) PhysicalDeviceProperties {
            var properties: PhysicalDeviceProperties = undefined;
            self.dispatch.vkGetPhysicalDeviceProperties(
                physical_device,
                &properties,
            );
            return properties;
        }
        pub fn getPhysicalDeviceQueueFamilyProperties(
            self: Self,
            physical_device: PhysicalDevice,
            p_queue_family_property_count: *u32,
            p_queue_family_properties: ?[*]QueueFamilyProperties,
        ) void {
            self.dispatch.vkGetPhysicalDeviceQueueFamilyProperties(
                physical_device,
                p_queue_family_property_count,
                p_queue_family_properties,
            );
        }
        pub fn getPhysicalDeviceMemoryProperties(
            self: Self,
            physical_device: PhysicalDevice,
        ) PhysicalDeviceMemoryProperties {
            var memory_properties: PhysicalDeviceMemoryProperties = undefined;
            self.dispatch.vkGetPhysicalDeviceMemoryProperties(
                physical_device,
                &memory_properties,
            );
            return memory_properties;
        }
        pub fn getPhysicalDeviceFeatures(
            self: Self,
            physical_device: PhysicalDevice,
        ) PhysicalDeviceFeatures {
            var features: PhysicalDeviceFeatures = undefined;
            self.dispatch.vkGetPhysicalDeviceFeatures(
                physical_device,
                &features,
            );
            return features;
        }
        pub fn getPhysicalDeviceFormatProperties(
            self: Self,
            physical_device: PhysicalDevice,
            format: Format,
        ) FormatProperties {
            var format_properties: FormatProperties = undefined;
            self.dispatch.vkGetPhysicalDeviceFormatProperties(
                physical_device,
                format,
                &format_properties,
            );
            return format_properties;
        }
        pub const GetPhysicalDeviceImageFormatPropertiesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            FormatNotSupported,
            Unknown,
        };
        pub fn getPhysicalDeviceImageFormatProperties(
            self: Self,
            physical_device: PhysicalDevice,
            format: Format,
            @"type": ImageType,
            tiling: ImageTiling,
            usage: ImageUsageFlags,
            flags: ImageCreateFlags,
        ) GetPhysicalDeviceImageFormatPropertiesError!ImageFormatProperties {
            var image_format_properties: ImageFormatProperties = undefined;
            const result = self.dispatch.vkGetPhysicalDeviceImageFormatProperties(
                physical_device,
                format,
                @"type",
                tiling,
                usage.toInt(),
                flags.toInt(),
                &image_format_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_format_not_supported => return error.FormatNotSupported,
                else => return error.Unknown,
            }
            return image_format_properties;
        }
        pub const CreateDeviceError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            ExtensionNotPresent,
            FeatureNotPresent,
            TooManyObjects,
            DeviceLost,
            Unknown,
        };
        pub fn createDevice(
            self: Self,
            physical_device: PhysicalDevice,
            create_info: DeviceCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDeviceError!Device {
            var device: Device = undefined;
            const result = self.dispatch.vkCreateDevice(
                physical_device,
                &create_info,
                p_allocator,
                &device,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_extension_not_present => return error.ExtensionNotPresent,
                Result.error_feature_not_present => return error.FeatureNotPresent,
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
            return device;
        }
        pub const EnumerateDeviceLayerPropertiesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn enumerateDeviceLayerProperties(
            self: Self,
            physical_device: PhysicalDevice,
            p_property_count: *u32,
            p_properties: ?[*]LayerProperties,
        ) EnumerateDeviceLayerPropertiesError!Result {
            const result = self.dispatch.vkEnumerateDeviceLayerProperties(
                physical_device,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const EnumerateDeviceExtensionPropertiesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            LayerNotPresent,
            Unknown,
        };
        pub fn enumerateDeviceExtensionProperties(
            self: Self,
            physical_device: PhysicalDevice,
            p_layer_name: ?[*:0]const u8,
            p_property_count: *u32,
            p_properties: ?[*]ExtensionProperties,
        ) EnumerateDeviceExtensionPropertiesError!Result {
            const result = self.dispatch.vkEnumerateDeviceExtensionProperties(
                physical_device,
                p_layer_name,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_layer_not_present => return error.LayerNotPresent,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn getPhysicalDeviceSparseImageFormatProperties(
            self: Self,
            physical_device: PhysicalDevice,
            format: Format,
            @"type": ImageType,
            samples: SampleCountFlags,
            usage: ImageUsageFlags,
            tiling: ImageTiling,
            p_property_count: *u32,
            p_properties: ?[*]SparseImageFormatProperties,
        ) void {
            self.dispatch.vkGetPhysicalDeviceSparseImageFormatProperties(
                physical_device,
                format,
                @"type",
                samples.toInt(),
                usage.toInt(),
                tiling,
                p_property_count,
                p_properties,
            );
        }
        pub const CreateAndroidSurfaceKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            NativeWindowInUseKHR,
            Unknown,
        };
        pub fn createAndroidSurfaceKHR(
            self: Self,
            instance: Instance,
            create_info: AndroidSurfaceCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateAndroidSurfaceKHRError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateAndroidSurfaceKHR(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_native_window_in_use_khr => return error.NativeWindowInUseKHR,
                else => return error.Unknown,
            }
            return surface;
        }
        pub const GetPhysicalDeviceDisplayPropertiesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceDisplayPropertiesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            p_property_count: *u32,
            p_properties: ?[*]DisplayPropertiesKHR,
        ) GetPhysicalDeviceDisplayPropertiesKHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceDisplayPropertiesKHR(
                physical_device,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDeviceDisplayPlanePropertiesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceDisplayPlanePropertiesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            p_property_count: *u32,
            p_properties: ?[*]DisplayPlanePropertiesKHR,
        ) GetPhysicalDeviceDisplayPlanePropertiesKHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceDisplayPlanePropertiesKHR(
                physical_device,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetDisplayPlaneSupportedDisplaysKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getDisplayPlaneSupportedDisplaysKHR(
            self: Self,
            physical_device: PhysicalDevice,
            plane_index: u32,
            p_display_count: *u32,
            p_displays: ?[*]DisplayKHR,
        ) GetDisplayPlaneSupportedDisplaysKHRError!Result {
            const result = self.dispatch.vkGetDisplayPlaneSupportedDisplaysKHR(
                physical_device,
                plane_index,
                p_display_count,
                p_displays,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetDisplayModePropertiesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getDisplayModePropertiesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            display: DisplayKHR,
            p_property_count: *u32,
            p_properties: ?[*]DisplayModePropertiesKHR,
        ) GetDisplayModePropertiesKHRError!Result {
            const result = self.dispatch.vkGetDisplayModePropertiesKHR(
                physical_device,
                display,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const CreateDisplayModeKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn createDisplayModeKHR(
            self: Self,
            physical_device: PhysicalDevice,
            display: DisplayKHR,
            create_info: DisplayModeCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDisplayModeKHRError!DisplayModeKHR {
            var mode: DisplayModeKHR = undefined;
            const result = self.dispatch.vkCreateDisplayModeKHR(
                physical_device,
                display,
                &create_info,
                p_allocator,
                &mode,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return mode;
        }
        pub const GetDisplayPlaneCapabilitiesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getDisplayPlaneCapabilitiesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            mode: DisplayModeKHR,
            plane_index: u32,
        ) GetDisplayPlaneCapabilitiesKHRError!DisplayPlaneCapabilitiesKHR {
            var capabilities: DisplayPlaneCapabilitiesKHR = undefined;
            const result = self.dispatch.vkGetDisplayPlaneCapabilitiesKHR(
                physical_device,
                mode,
                plane_index,
                &capabilities,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return capabilities;
        }
        pub const CreateDisplayPlaneSurfaceKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createDisplayPlaneSurfaceKHR(
            self: Self,
            instance: Instance,
            create_info: DisplaySurfaceCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDisplayPlaneSurfaceKHRError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateDisplayPlaneSurfaceKHR(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub fn destroySurfaceKHR(
            self: Self,
            instance: Instance,
            surface: SurfaceKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroySurfaceKHR(
                instance,
                surface,
                p_allocator,
            );
        }
        pub const GetPhysicalDeviceSurfaceSupportKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPhysicalDeviceSurfaceSupportKHR(
            self: Self,
            physical_device: PhysicalDevice,
            queue_family_index: u32,
            surface: SurfaceKHR,
        ) GetPhysicalDeviceSurfaceSupportKHRError!Bool32 {
            var supported: Bool32 = undefined;
            const result = self.dispatch.vkGetPhysicalDeviceSurfaceSupportKHR(
                physical_device,
                queue_family_index,
                surface,
                &supported,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return supported;
        }
        pub const GetPhysicalDeviceSurfaceCapabilitiesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPhysicalDeviceSurfaceCapabilitiesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            surface: SurfaceKHR,
        ) GetPhysicalDeviceSurfaceCapabilitiesKHRError!SurfaceCapabilitiesKHR {
            var surface_capabilities: SurfaceCapabilitiesKHR = undefined;
            const result = self.dispatch.vkGetPhysicalDeviceSurfaceCapabilitiesKHR(
                physical_device,
                surface,
                &surface_capabilities,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return surface_capabilities;
        }
        pub const GetPhysicalDeviceSurfaceFormatsKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPhysicalDeviceSurfaceFormatsKHR(
            self: Self,
            physical_device: PhysicalDevice,
            surface: SurfaceKHR,
            p_surface_format_count: *u32,
            p_surface_formats: ?[*]SurfaceFormatKHR,
        ) GetPhysicalDeviceSurfaceFormatsKHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceSurfaceFormatsKHR(
                physical_device,
                surface,
                p_surface_format_count,
                p_surface_formats,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDeviceSurfacePresentModesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPhysicalDeviceSurfacePresentModesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            surface: SurfaceKHR,
            p_present_mode_count: *u32,
            p_present_modes: ?[*]PresentModeKHR,
        ) GetPhysicalDeviceSurfacePresentModesKHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceSurfacePresentModesKHR(
                physical_device,
                surface,
                p_present_mode_count,
                p_present_modes,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return result;
        }
        pub const CreateViSurfaceNNError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            NativeWindowInUseKHR,
            Unknown,
        };
        pub fn createViSurfaceNN(
            self: Self,
            instance: Instance,
            create_info: ViSurfaceCreateInfoNN,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateViSurfaceNNError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateViSurfaceNN(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_native_window_in_use_khr => return error.NativeWindowInUseKHR,
                else => return error.Unknown,
            }
            return surface;
        }
        pub const CreateWaylandSurfaceKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createWaylandSurfaceKHR(
            self: Self,
            instance: Instance,
            create_info: WaylandSurfaceCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateWaylandSurfaceKHRError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateWaylandSurfaceKHR(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub fn getPhysicalDeviceWaylandPresentationSupportKHR(
            self: Self,
            physical_device: PhysicalDevice,
            queue_family_index: u32,
            display: *wl_display,
        ) Bool32 {
            return self.dispatch.vkGetPhysicalDeviceWaylandPresentationSupportKHR(
                physical_device,
                queue_family_index,
                display,
            );
        }
        pub const CreateWin32SurfaceKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createWin32SurfaceKHR(
            self: Self,
            instance: Instance,
            create_info: Win32SurfaceCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateWin32SurfaceKHRError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateWin32SurfaceKHR(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub fn getPhysicalDeviceWin32PresentationSupportKHR(
            self: Self,
            physical_device: PhysicalDevice,
            queue_family_index: u32,
        ) Bool32 {
            return self.dispatch.vkGetPhysicalDeviceWin32PresentationSupportKHR(
                physical_device,
                queue_family_index,
            );
        }
        pub const CreateXlibSurfaceKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createXlibSurfaceKHR(
            self: Self,
            instance: Instance,
            create_info: XlibSurfaceCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateXlibSurfaceKHRError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateXlibSurfaceKHR(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub fn getPhysicalDeviceXlibPresentationSupportKHR(
            self: Self,
            physical_device: PhysicalDevice,
            queue_family_index: u32,
            dpy: *Display,
            visual_id: VisualID,
        ) Bool32 {
            return self.dispatch.vkGetPhysicalDeviceXlibPresentationSupportKHR(
                physical_device,
                queue_family_index,
                dpy,
                visual_id,
            );
        }
        pub const CreateXcbSurfaceKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createXcbSurfaceKHR(
            self: Self,
            instance: Instance,
            create_info: XcbSurfaceCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateXcbSurfaceKHRError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateXcbSurfaceKHR(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub fn getPhysicalDeviceXcbPresentationSupportKHR(
            self: Self,
            physical_device: PhysicalDevice,
            queue_family_index: u32,
            connection: *xcb_connection_t,
            visual_id: xcb_visualid_t,
        ) Bool32 {
            return self.dispatch.vkGetPhysicalDeviceXcbPresentationSupportKHR(
                physical_device,
                queue_family_index,
                connection,
                visual_id,
            );
        }
        pub const CreateDirectFbSurfaceEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createDirectFbSurfaceEXT(
            self: Self,
            instance: Instance,
            create_info: DirectFBSurfaceCreateInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDirectFbSurfaceEXTError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateDirectFBSurfaceEXT(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub fn getPhysicalDeviceDirectFbPresentationSupportEXT(
            self: Self,
            physical_device: PhysicalDevice,
            queue_family_index: u32,
            dfb: *IDirectFB,
        ) Bool32 {
            return self.dispatch.vkGetPhysicalDeviceDirectFBPresentationSupportEXT(
                physical_device,
                queue_family_index,
                dfb,
            );
        }
        pub const CreateImagePipeSurfaceFUCHSIAError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createImagePipeSurfaceFUCHSIA(
            self: Self,
            instance: Instance,
            create_info: ImagePipeSurfaceCreateInfoFUCHSIA,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateImagePipeSurfaceFUCHSIAError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateImagePipeSurfaceFUCHSIA(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub const CreateStreamDescriptorSurfaceGGPError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            NativeWindowInUseKHR,
            Unknown,
        };
        pub fn createStreamDescriptorSurfaceGGP(
            self: Self,
            instance: Instance,
            create_info: StreamDescriptorSurfaceCreateInfoGGP,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateStreamDescriptorSurfaceGGPError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateStreamDescriptorSurfaceGGP(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_native_window_in_use_khr => return error.NativeWindowInUseKHR,
                else => return error.Unknown,
            }
            return surface;
        }
        pub const CreateScreenSurfaceQNXError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createScreenSurfaceQNX(
            self: Self,
            instance: Instance,
            create_info: ScreenSurfaceCreateInfoQNX,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateScreenSurfaceQNXError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateScreenSurfaceQNX(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub fn getPhysicalDeviceScreenPresentationSupportQNX(
            self: Self,
            physical_device: PhysicalDevice,
            queue_family_index: u32,
            window: *_screen_window,
        ) Bool32 {
            return self.dispatch.vkGetPhysicalDeviceScreenPresentationSupportQNX(
                physical_device,
                queue_family_index,
                window,
            );
        }
        pub const CreateDebugReportCallbackEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn createDebugReportCallbackEXT(
            self: Self,
            instance: Instance,
            create_info: DebugReportCallbackCreateInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDebugReportCallbackEXTError!DebugReportCallbackEXT {
            var callback: DebugReportCallbackEXT = undefined;
            const result = self.dispatch.vkCreateDebugReportCallbackEXT(
                instance,
                &create_info,
                p_allocator,
                &callback,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return callback;
        }
        pub fn destroyDebugReportCallbackEXT(
            self: Self,
            instance: Instance,
            callback: DebugReportCallbackEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyDebugReportCallbackEXT(
                instance,
                callback,
                p_allocator,
            );
        }
        pub fn debugReportMessageEXT(
            self: Self,
            instance: Instance,
            flags: DebugReportFlagsEXT,
            object_type: DebugReportObjectTypeEXT,
            object: u64,
            location: usize,
            message_code: i32,
            p_layer_prefix: [*:0]const u8,
            p_message: [*:0]const u8,
        ) void {
            self.dispatch.vkDebugReportMessageEXT(
                instance,
                flags.toInt(),
                object_type,
                object,
                location,
                message_code,
                p_layer_prefix,
                p_message,
            );
        }
        pub const GetPhysicalDeviceExternalImageFormatPropertiesNVError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            FormatNotSupported,
            Unknown,
        };
        pub fn getPhysicalDeviceExternalImageFormatPropertiesNV(
            self: Self,
            physical_device: PhysicalDevice,
            format: Format,
            @"type": ImageType,
            tiling: ImageTiling,
            usage: ImageUsageFlags,
            flags: ImageCreateFlags,
            external_handle_type: ExternalMemoryHandleTypeFlagsNV,
        ) GetPhysicalDeviceExternalImageFormatPropertiesNVError!ExternalImageFormatPropertiesNV {
            var external_image_format_properties: ExternalImageFormatPropertiesNV = undefined;
            const result = self.dispatch.vkGetPhysicalDeviceExternalImageFormatPropertiesNV(
                physical_device,
                format,
                @"type",
                tiling,
                usage.toInt(),
                flags.toInt(),
                external_handle_type.toInt(),
                &external_image_format_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_format_not_supported => return error.FormatNotSupported,
                else => return error.Unknown,
            }
            return external_image_format_properties;
        }
        pub fn getPhysicalDeviceFeatures2(
            self: Self,
            physical_device: PhysicalDevice,
            p_features: *PhysicalDeviceFeatures2,
        ) void {
            self.dispatch.vkGetPhysicalDeviceFeatures2(
                physical_device,
                p_features,
            );
        }
        pub fn getPhysicalDeviceProperties2(
            self: Self,
            physical_device: PhysicalDevice,
            p_properties: *PhysicalDeviceProperties2,
        ) void {
            self.dispatch.vkGetPhysicalDeviceProperties2(
                physical_device,
                p_properties,
            );
        }
        pub fn getPhysicalDeviceFormatProperties2(
            self: Self,
            physical_device: PhysicalDevice,
            format: Format,
            p_format_properties: *FormatProperties2,
        ) void {
            self.dispatch.vkGetPhysicalDeviceFormatProperties2(
                physical_device,
                format,
                p_format_properties,
            );
        }
        pub const GetPhysicalDeviceImageFormatProperties2Error = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            FormatNotSupported,
            Unknown,
        };
        pub fn getPhysicalDeviceImageFormatProperties2(
            self: Self,
            physical_device: PhysicalDevice,
            image_format_info: PhysicalDeviceImageFormatInfo2,
            p_image_format_properties: *ImageFormatProperties2,
        ) GetPhysicalDeviceImageFormatProperties2Error!void {
            const result = self.dispatch.vkGetPhysicalDeviceImageFormatProperties2(
                physical_device,
                &image_format_info,
                p_image_format_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_format_not_supported => return error.FormatNotSupported,
                else => return error.Unknown,
            }
        }
        pub fn getPhysicalDeviceQueueFamilyProperties2(
            self: Self,
            physical_device: PhysicalDevice,
            p_queue_family_property_count: *u32,
            p_queue_family_properties: ?[*]QueueFamilyProperties2,
        ) void {
            self.dispatch.vkGetPhysicalDeviceQueueFamilyProperties2(
                physical_device,
                p_queue_family_property_count,
                p_queue_family_properties,
            );
        }
        pub fn getPhysicalDeviceMemoryProperties2(
            self: Self,
            physical_device: PhysicalDevice,
            p_memory_properties: *PhysicalDeviceMemoryProperties2,
        ) void {
            self.dispatch.vkGetPhysicalDeviceMemoryProperties2(
                physical_device,
                p_memory_properties,
            );
        }
        pub fn getPhysicalDeviceSparseImageFormatProperties2(
            self: Self,
            physical_device: PhysicalDevice,
            format_info: PhysicalDeviceSparseImageFormatInfo2,
            p_property_count: *u32,
            p_properties: ?[*]SparseImageFormatProperties2,
        ) void {
            self.dispatch.vkGetPhysicalDeviceSparseImageFormatProperties2(
                physical_device,
                &format_info,
                p_property_count,
                p_properties,
            );
        }
        pub fn getPhysicalDeviceExternalBufferProperties(
            self: Self,
            physical_device: PhysicalDevice,
            external_buffer_info: PhysicalDeviceExternalBufferInfo,
            p_external_buffer_properties: *ExternalBufferProperties,
        ) void {
            self.dispatch.vkGetPhysicalDeviceExternalBufferProperties(
                physical_device,
                &external_buffer_info,
                p_external_buffer_properties,
            );
        }
        pub fn getPhysicalDeviceExternalSemaphoreProperties(
            self: Self,
            physical_device: PhysicalDevice,
            external_semaphore_info: PhysicalDeviceExternalSemaphoreInfo,
            p_external_semaphore_properties: *ExternalSemaphoreProperties,
        ) void {
            self.dispatch.vkGetPhysicalDeviceExternalSemaphoreProperties(
                physical_device,
                &external_semaphore_info,
                p_external_semaphore_properties,
            );
        }
        pub fn getPhysicalDeviceExternalFenceProperties(
            self: Self,
            physical_device: PhysicalDevice,
            external_fence_info: PhysicalDeviceExternalFenceInfo,
            p_external_fence_properties: *ExternalFenceProperties,
        ) void {
            self.dispatch.vkGetPhysicalDeviceExternalFenceProperties(
                physical_device,
                &external_fence_info,
                p_external_fence_properties,
            );
        }
        pub fn releaseDisplayEXT(
            self: Self,
            physical_device: PhysicalDevice,
            display: DisplayKHR,
        ) void {
            const result = self.dispatch.vkReleaseDisplayEXT(
                physical_device,
                display,
            );
            switch (result) {
                Result.success => {},
                else => return error.Unknown,
            }
        }
        pub const AcquireXlibDisplayEXTError = error{
            OutOfHostMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn acquireXlibDisplayEXT(
            self: Self,
            physical_device: PhysicalDevice,
            dpy: *Display,
            display: DisplayKHR,
        ) AcquireXlibDisplayEXTError!void {
            const result = self.dispatch.vkAcquireXlibDisplayEXT(
                physical_device,
                dpy,
                display,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
        }
        pub const GetRandROutputDisplayEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn getRandROutputDisplayEXT(
            self: Self,
            physical_device: PhysicalDevice,
            dpy: *Display,
            rr_output: RROutput,
        ) GetRandROutputDisplayEXTError!DisplayKHR {
            var display: DisplayKHR = undefined;
            const result = self.dispatch.vkGetRandROutputDisplayEXT(
                physical_device,
                dpy,
                rr_output,
                &display,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return display;
        }
        pub const AcquireWinrtDisplayNVError = error{
            OutOfHostMemory,
            DeviceLost,
            InitializationFailed,
            Unknown,
        };
        pub fn acquireWinrtDisplayNV(
            self: Self,
            physical_device: PhysicalDevice,
            display: DisplayKHR,
        ) AcquireWinrtDisplayNVError!void {
            const result = self.dispatch.vkAcquireWinrtDisplayNV(
                physical_device,
                display,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
        }
        pub const GetWinrtDisplayNVError = error{
            OutOfHostMemory,
            DeviceLost,
            InitializationFailed,
            Unknown,
        };
        pub fn getWinrtDisplayNV(
            self: Self,
            physical_device: PhysicalDevice,
            device_relative_id: u32,
        ) GetWinrtDisplayNVError!DisplayKHR {
            var display: DisplayKHR = undefined;
            const result = self.dispatch.vkGetWinrtDisplayNV(
                physical_device,
                device_relative_id,
                &display,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return display;
        }
        pub const GetPhysicalDeviceSurfaceCapabilities2EXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPhysicalDeviceSurfaceCapabilities2EXT(
            self: Self,
            physical_device: PhysicalDevice,
            surface: SurfaceKHR,
            p_surface_capabilities: *SurfaceCapabilities2EXT,
        ) GetPhysicalDeviceSurfaceCapabilities2EXTError!void {
            const result = self.dispatch.vkGetPhysicalDeviceSurfaceCapabilities2EXT(
                physical_device,
                surface,
                p_surface_capabilities,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
        }
        pub const EnumeratePhysicalDeviceGroupsError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn enumeratePhysicalDeviceGroups(
            self: Self,
            instance: Instance,
            p_physical_device_group_count: *u32,
            p_physical_device_group_properties: ?[*]PhysicalDeviceGroupProperties,
        ) EnumeratePhysicalDeviceGroupsError!Result {
            const result = self.dispatch.vkEnumeratePhysicalDeviceGroups(
                instance,
                p_physical_device_group_count,
                p_physical_device_group_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDevicePresentRectanglesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPhysicalDevicePresentRectanglesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            surface: SurfaceKHR,
            p_rect_count: *u32,
            p_rects: ?[*]Rect2D,
        ) GetPhysicalDevicePresentRectanglesKHRError!Result {
            const result = self.dispatch.vkGetPhysicalDevicePresentRectanglesKHR(
                physical_device,
                surface,
                p_rect_count,
                p_rects,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const CreateIosSurfaceMVKError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            NativeWindowInUseKHR,
            Unknown,
        };
        pub fn createIosSurfaceMVK(
            self: Self,
            instance: Instance,
            create_info: IOSSurfaceCreateInfoMVK,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateIosSurfaceMVKError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateIOSSurfaceMVK(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_native_window_in_use_khr => return error.NativeWindowInUseKHR,
                else => return error.Unknown,
            }
            return surface;
        }
        pub const CreateMacOsSurfaceMVKError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            NativeWindowInUseKHR,
            Unknown,
        };
        pub fn createMacOsSurfaceMVK(
            self: Self,
            instance: Instance,
            create_info: MacOSSurfaceCreateInfoMVK,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateMacOsSurfaceMVKError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateMacOSSurfaceMVK(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_native_window_in_use_khr => return error.NativeWindowInUseKHR,
                else => return error.Unknown,
            }
            return surface;
        }
        pub const CreateMetalSurfaceEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            NativeWindowInUseKHR,
            Unknown,
        };
        pub fn createMetalSurfaceEXT(
            self: Self,
            instance: Instance,
            create_info: MetalSurfaceCreateInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateMetalSurfaceEXTError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateMetalSurfaceEXT(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_native_window_in_use_khr => return error.NativeWindowInUseKHR,
                else => return error.Unknown,
            }
            return surface;
        }
        pub fn getPhysicalDeviceMultisamplePropertiesEXT(
            self: Self,
            physical_device: PhysicalDevice,
            samples: SampleCountFlags,
            p_multisample_properties: *MultisamplePropertiesEXT,
        ) void {
            self.dispatch.vkGetPhysicalDeviceMultisamplePropertiesEXT(
                physical_device,
                samples.toInt(),
                p_multisample_properties,
            );
        }
        pub const GetPhysicalDeviceSurfaceCapabilities2KHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPhysicalDeviceSurfaceCapabilities2KHR(
            self: Self,
            physical_device: PhysicalDevice,
            surface_info: PhysicalDeviceSurfaceInfo2KHR,
            p_surface_capabilities: *SurfaceCapabilities2KHR,
        ) GetPhysicalDeviceSurfaceCapabilities2KHRError!void {
            const result = self.dispatch.vkGetPhysicalDeviceSurfaceCapabilities2KHR(
                physical_device,
                &surface_info,
                p_surface_capabilities,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
        }
        pub const GetPhysicalDeviceSurfaceFormats2KHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPhysicalDeviceSurfaceFormats2KHR(
            self: Self,
            physical_device: PhysicalDevice,
            surface_info: PhysicalDeviceSurfaceInfo2KHR,
            p_surface_format_count: *u32,
            p_surface_formats: ?[*]SurfaceFormat2KHR,
        ) GetPhysicalDeviceSurfaceFormats2KHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceSurfaceFormats2KHR(
                physical_device,
                &surface_info,
                p_surface_format_count,
                p_surface_formats,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDeviceDisplayProperties2KHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceDisplayProperties2KHR(
            self: Self,
            physical_device: PhysicalDevice,
            p_property_count: *u32,
            p_properties: ?[*]DisplayProperties2KHR,
        ) GetPhysicalDeviceDisplayProperties2KHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceDisplayProperties2KHR(
                physical_device,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDeviceDisplayPlaneProperties2KHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceDisplayPlaneProperties2KHR(
            self: Self,
            physical_device: PhysicalDevice,
            p_property_count: *u32,
            p_properties: ?[*]DisplayPlaneProperties2KHR,
        ) GetPhysicalDeviceDisplayPlaneProperties2KHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceDisplayPlaneProperties2KHR(
                physical_device,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetDisplayModeProperties2KHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getDisplayModeProperties2KHR(
            self: Self,
            physical_device: PhysicalDevice,
            display: DisplayKHR,
            p_property_count: *u32,
            p_properties: ?[*]DisplayModeProperties2KHR,
        ) GetDisplayModeProperties2KHRError!Result {
            const result = self.dispatch.vkGetDisplayModeProperties2KHR(
                physical_device,
                display,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetDisplayPlaneCapabilities2KHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getDisplayPlaneCapabilities2KHR(
            self: Self,
            physical_device: PhysicalDevice,
            display_plane_info: DisplayPlaneInfo2KHR,
            p_capabilities: *DisplayPlaneCapabilities2KHR,
        ) GetDisplayPlaneCapabilities2KHRError!void {
            const result = self.dispatch.vkGetDisplayPlaneCapabilities2KHR(
                physical_device,
                &display_plane_info,
                p_capabilities,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const GetPhysicalDeviceCalibrateableTimeDomainsEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceCalibrateableTimeDomainsEXT(
            self: Self,
            physical_device: PhysicalDevice,
            p_time_domain_count: *u32,
            p_time_domains: ?[*]TimeDomainEXT,
        ) GetPhysicalDeviceCalibrateableTimeDomainsEXTError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceCalibrateableTimeDomainsEXT(
                physical_device,
                p_time_domain_count,
                p_time_domains,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const CreateDebugUtilsMessengerEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn createDebugUtilsMessengerEXT(
            self: Self,
            instance: Instance,
            create_info: DebugUtilsMessengerCreateInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDebugUtilsMessengerEXTError!DebugUtilsMessengerEXT {
            var messenger: DebugUtilsMessengerEXT = undefined;
            const result = self.dispatch.vkCreateDebugUtilsMessengerEXT(
                instance,
                &create_info,
                p_allocator,
                &messenger,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return messenger;
        }
        pub fn destroyDebugUtilsMessengerEXT(
            self: Self,
            instance: Instance,
            messenger: DebugUtilsMessengerEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyDebugUtilsMessengerEXT(
                instance,
                messenger,
                p_allocator,
            );
        }
        pub fn submitDebugUtilsMessageEXT(
            self: Self,
            instance: Instance,
            message_severity: DebugUtilsMessageSeverityFlagsEXT,
            message_types: DebugUtilsMessageTypeFlagsEXT,
            callback_data: DebugUtilsMessengerCallbackDataEXT,
        ) void {
            self.dispatch.vkSubmitDebugUtilsMessageEXT(
                instance,
                message_severity.toInt(),
                message_types.toInt(),
                &callback_data,
            );
        }
        pub const GetPhysicalDeviceCooperativeMatrixPropertiesNVError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceCooperativeMatrixPropertiesNV(
            self: Self,
            physical_device: PhysicalDevice,
            p_property_count: *u32,
            p_properties: ?[*]CooperativeMatrixPropertiesNV,
        ) GetPhysicalDeviceCooperativeMatrixPropertiesNVError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceCooperativeMatrixPropertiesNV(
                physical_device,
                p_property_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDeviceSurfacePresentModes2EXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPhysicalDeviceSurfacePresentModes2EXT(
            self: Self,
            physical_device: PhysicalDevice,
            surface_info: PhysicalDeviceSurfaceInfo2KHR,
            p_present_mode_count: *u32,
            p_present_modes: ?[*]PresentModeKHR,
        ) GetPhysicalDeviceSurfacePresentModes2EXTError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceSurfacePresentModes2EXT(
                physical_device,
                &surface_info,
                p_present_mode_count,
                p_present_modes,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return result;
        }
        pub const EnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn enumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR(
            self: Self,
            physical_device: PhysicalDevice,
            queue_family_index: u32,
            p_counter_count: *u32,
            p_counters: ?[*]PerformanceCounterKHR,
            p_counter_descriptions: ?[*]PerformanceCounterDescriptionKHR,
        ) EnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHRError!Result {
            const result = self.dispatch.vkEnumeratePhysicalDeviceQueueFamilyPerformanceQueryCountersKHR(
                physical_device,
                queue_family_index,
                p_counter_count,
                p_counters,
                p_counter_descriptions,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn getPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            performance_query_create_info: QueryPoolPerformanceCreateInfoKHR,
        ) u32 {
            var num_passes: u32 = undefined;
            self.dispatch.vkGetPhysicalDeviceQueueFamilyPerformanceQueryPassesKHR(
                physical_device,
                &performance_query_create_info,
                &num_passes,
            );
            return num_passes;
        }
        pub const CreateHeadlessSurfaceEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createHeadlessSurfaceEXT(
            self: Self,
            instance: Instance,
            create_info: HeadlessSurfaceCreateInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateHeadlessSurfaceEXTError!SurfaceKHR {
            var surface: SurfaceKHR = undefined;
            const result = self.dispatch.vkCreateHeadlessSurfaceEXT(
                instance,
                &create_info,
                p_allocator,
                &surface,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return surface;
        }
        pub const GetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNVError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV(
            self: Self,
            physical_device: PhysicalDevice,
            p_combination_count: *u32,
            p_combinations: ?[*]FramebufferMixedSamplesCombinationNV,
        ) GetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNVError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceSupportedFramebufferMixedSamplesCombinationsNV(
                physical_device,
                p_combination_count,
                p_combinations,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDeviceToolPropertiesEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceToolPropertiesEXT(
            self: Self,
            physical_device: PhysicalDevice,
            p_tool_count: *u32,
            p_tool_properties: ?[*]PhysicalDeviceToolPropertiesEXT,
        ) GetPhysicalDeviceToolPropertiesEXTError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceToolPropertiesEXT(
                physical_device,
                p_tool_count,
                p_tool_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDeviceFragmentShadingRatesKHRError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn getPhysicalDeviceFragmentShadingRatesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            p_fragment_shading_rate_count: *u32,
            p_fragment_shading_rates: ?[*]PhysicalDeviceFragmentShadingRateKHR,
        ) GetPhysicalDeviceFragmentShadingRatesKHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceFragmentShadingRatesKHR(
                physical_device,
                p_fragment_shading_rate_count,
                p_fragment_shading_rates,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPhysicalDeviceVideoCapabilitiesKHRError = error{
            ExtensionNotPresent,
            InitializationFailed,
            FeatureNotPresent,
            FormatNotSupported,
            Unknown,
        };
        pub fn getPhysicalDeviceVideoCapabilitiesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            video_profile: VideoProfileKHR,
            p_capabilities: *VideoCapabilitiesKHR,
        ) GetPhysicalDeviceVideoCapabilitiesKHRError!void {
            const result = self.dispatch.vkGetPhysicalDeviceVideoCapabilitiesKHR(
                physical_device,
                &video_profile,
                p_capabilities,
            );
            switch (result) {
                Result.success => {},
                Result.error_extension_not_present => return error.ExtensionNotPresent,
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_feature_not_present => return error.FeatureNotPresent,
                Result.error_format_not_supported => return error.FormatNotSupported,
                else => return error.Unknown,
            }
        }
        pub const GetPhysicalDeviceVideoFormatPropertiesKHRError = error{
            ExtensionNotPresent,
            InitializationFailed,
            FormatNotSupported,
            Unknown,
        };
        pub fn getPhysicalDeviceVideoFormatPropertiesKHR(
            self: Self,
            physical_device: PhysicalDevice,
            video_format_info: PhysicalDeviceVideoFormatInfoKHR,
            p_video_format_property_count: *u32,
            p_video_format_properties: ?[*]VideoFormatPropertiesKHR,
        ) GetPhysicalDeviceVideoFormatPropertiesKHRError!Result {
            const result = self.dispatch.vkGetPhysicalDeviceVideoFormatPropertiesKHR(
                physical_device,
                &video_format_info,
                p_video_format_property_count,
                p_video_format_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_extension_not_present => return error.ExtensionNotPresent,
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_format_not_supported => return error.FormatNotSupported,
                else => return error.Unknown,
            }
            return result;
        }
        pub const AcquireDrmDisplayEXTError = error{
            InitializationFailed,
            Unknown,
        };
        pub fn acquireDrmDisplayEXT(
            self: Self,
            physical_device: PhysicalDevice,
            drm_fd: i32,
            display: DisplayKHR,
        ) AcquireDrmDisplayEXTError!void {
            const result = self.dispatch.vkAcquireDrmDisplayEXT(
                physical_device,
                drm_fd,
                display,
            );
            switch (result) {
                Result.success => {},
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
        }
        pub const GetDrmDisplayEXTError = error{
            InitializationFailed,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getDrmDisplayEXT(
            self: Self,
            physical_device: PhysicalDevice,
            drm_fd: i32,
            connector_id: u32,
        ) GetDrmDisplayEXTError!DisplayKHR {
            var display: DisplayKHR = undefined;
            const result = self.dispatch.vkGetDrmDisplayEXT(
                physical_device,
                drm_fd,
                connector_id,
                &display,
            );
            switch (result) {
                Result.success => {},
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return display;
        }
    };
}
pub fn DeviceWrapper(comptime cmds: anytype) type {
    comptime var fields: [cmds.len]std.builtin.TypeInfo.StructField = undefined;
    inline for (cmds) |cmd, i| {
        const cmd_name = DeviceCommandToString(cmd);
        const cmd_type_name = "Pfn" ++ cmd_name;
        const cmd_type = @field(GlobalScope, cmd_type_name);
        fields[i] = .{
            .name = "vk" ++ cmd_name,
            .field_type = cmd_type,
            .default_value = null,
            .is_comptime = false,
            .alignment = @alignOf(*cmd_type),
        };
    }
    const Dispatch = @Type(.{
        .Struct = .{
            .layout = .Auto,
            .fields = &fields,
            .decls = &[_]std.builtin.TypeInfo.Declaration{},
            .is_tuple = false,
        },
    });
    return struct {
        dispatch: Dispatch,

        const Self = @This();
        pub fn load(device: Device, loader: anytype) !Self {
            var self: Self = undefined;
            inline for (std.meta.fields(Dispatch)) |field| {
                const name = @ptrCast([*:0]const u8, field.name ++ "\x00");
                const cmd_ptr = loader(device, name) orelse return error.CommandLoadFailure;
                @field(self.dispatch, field.name) = @ptrCast(field.field_type, cmd_ptr);
            }
            return self;
        }
        pub fn destroyDevice(
            self: Self,
            device: Device,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyDevice(
                device,
                p_allocator,
            );
        }
        pub fn getDeviceQueue(
            self: Self,
            device: Device,
            queue_family_index: u32,
            queue_index: u32,
        ) Queue {
            var queue: Queue = undefined;
            self.dispatch.vkGetDeviceQueue(
                device,
                queue_family_index,
                queue_index,
                &queue,
            );
            return queue;
        }
        pub const QueueSubmitError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn queueSubmit(
            self: Self,
            queue: Queue,
            submit_count: u32,
            p_submits: [*]const SubmitInfo,
            fence: Fence,
        ) QueueSubmitError!void {
            const result = self.dispatch.vkQueueSubmit(
                queue,
                submit_count,
                p_submits,
                fence,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
        }
        pub const QueueWaitIdleError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn queueWaitIdle(
            self: Self,
            queue: Queue,
        ) QueueWaitIdleError!void {
            const result = self.dispatch.vkQueueWaitIdle(
                queue,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
        }
        pub const DeviceWaitIdleError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn deviceWaitIdle(
            self: Self,
            device: Device,
        ) DeviceWaitIdleError!void {
            const result = self.dispatch.vkDeviceWaitIdle(
                device,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
        }
        pub const AllocateMemoryError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidExternalHandle,
            InvalidOpaqueCaptureAddressKHR,
            Unknown,
        };
        pub fn allocateMemory(
            self: Self,
            device: Device,
            allocate_info: MemoryAllocateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) AllocateMemoryError!DeviceMemory {
            var memory: DeviceMemory = undefined;
            const result = self.dispatch.vkAllocateMemory(
                device,
                &allocate_info,
                p_allocator,
                &memory,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                Result.error_invalid_opaque_capture_address_khr => return error.InvalidOpaqueCaptureAddressKHR,
                else => return error.Unknown,
            }
            return memory;
        }
        pub fn freeMemory(
            self: Self,
            device: Device,
            memory: DeviceMemory,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkFreeMemory(
                device,
                memory,
                p_allocator,
            );
        }
        pub const MapMemoryError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            MemoryMapFailed,
            Unknown,
        };
        pub fn mapMemory(
            self: Self,
            device: Device,
            memory: DeviceMemory,
            offset: DeviceSize,
            size: DeviceSize,
            flags: MemoryMapFlags,
        ) MapMemoryError!?*c_void {
            var pp_data: ?*c_void = undefined;
            const result = self.dispatch.vkMapMemory(
                device,
                memory,
                offset,
                size,
                flags.toInt(),
                &pp_data,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_memory_map_failed => return error.MemoryMapFailed,
                else => return error.Unknown,
            }
            return pp_data;
        }
        pub fn unmapMemory(
            self: Self,
            device: Device,
            memory: DeviceMemory,
        ) void {
            self.dispatch.vkUnmapMemory(
                device,
                memory,
            );
        }
        pub const FlushMappedMemoryRangesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn flushMappedMemoryRanges(
            self: Self,
            device: Device,
            memory_range_count: u32,
            p_memory_ranges: [*]const MappedMemoryRange,
        ) FlushMappedMemoryRangesError!void {
            const result = self.dispatch.vkFlushMappedMemoryRanges(
                device,
                memory_range_count,
                p_memory_ranges,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const InvalidateMappedMemoryRangesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn invalidateMappedMemoryRanges(
            self: Self,
            device: Device,
            memory_range_count: u32,
            p_memory_ranges: [*]const MappedMemoryRange,
        ) InvalidateMappedMemoryRangesError!void {
            const result = self.dispatch.vkInvalidateMappedMemoryRanges(
                device,
                memory_range_count,
                p_memory_ranges,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn getDeviceMemoryCommitment(
            self: Self,
            device: Device,
            memory: DeviceMemory,
        ) DeviceSize {
            var committed_memory_in_bytes: DeviceSize = undefined;
            self.dispatch.vkGetDeviceMemoryCommitment(
                device,
                memory,
                &committed_memory_in_bytes,
            );
            return committed_memory_in_bytes;
        }
        pub fn getBufferMemoryRequirements(
            self: Self,
            device: Device,
            buffer: Buffer,
        ) MemoryRequirements {
            var memory_requirements: MemoryRequirements = undefined;
            self.dispatch.vkGetBufferMemoryRequirements(
                device,
                buffer,
                &memory_requirements,
            );
            return memory_requirements;
        }
        pub const BindBufferMemoryError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidOpaqueCaptureAddressKHR,
            Unknown,
        };
        pub fn bindBufferMemory(
            self: Self,
            device: Device,
            buffer: Buffer,
            memory: DeviceMemory,
            memory_offset: DeviceSize,
        ) BindBufferMemoryError!void {
            const result = self.dispatch.vkBindBufferMemory(
                device,
                buffer,
                memory,
                memory_offset,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_opaque_capture_address_khr => return error.InvalidOpaqueCaptureAddressKHR,
                else => return error.Unknown,
            }
        }
        pub fn getImageMemoryRequirements(
            self: Self,
            device: Device,
            image: Image,
        ) MemoryRequirements {
            var memory_requirements: MemoryRequirements = undefined;
            self.dispatch.vkGetImageMemoryRequirements(
                device,
                image,
                &memory_requirements,
            );
            return memory_requirements;
        }
        pub const BindImageMemoryError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn bindImageMemory(
            self: Self,
            device: Device,
            image: Image,
            memory: DeviceMemory,
            memory_offset: DeviceSize,
        ) BindImageMemoryError!void {
            const result = self.dispatch.vkBindImageMemory(
                device,
                image,
                memory,
                memory_offset,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn getImageSparseMemoryRequirements(
            self: Self,
            device: Device,
            image: Image,
            p_sparse_memory_requirement_count: *u32,
            p_sparse_memory_requirements: ?[*]SparseImageMemoryRequirements,
        ) void {
            self.dispatch.vkGetImageSparseMemoryRequirements(
                device,
                image,
                p_sparse_memory_requirement_count,
                p_sparse_memory_requirements,
            );
        }
        pub const QueueBindSparseError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn queueBindSparse(
            self: Self,
            queue: Queue,
            bind_info_count: u32,
            p_bind_info: [*]const BindSparseInfo,
            fence: Fence,
        ) QueueBindSparseError!void {
            const result = self.dispatch.vkQueueBindSparse(
                queue,
                bind_info_count,
                p_bind_info,
                fence,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
        }
        pub const CreateFenceError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createFence(
            self: Self,
            device: Device,
            create_info: FenceCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateFenceError!Fence {
            var fence: Fence = undefined;
            const result = self.dispatch.vkCreateFence(
                device,
                &create_info,
                p_allocator,
                &fence,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return fence;
        }
        pub fn destroyFence(
            self: Self,
            device: Device,
            fence: Fence,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyFence(
                device,
                fence,
                p_allocator,
            );
        }
        pub const ResetFencesError = error{
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn resetFences(
            self: Self,
            device: Device,
            fence_count: u32,
            p_fences: [*]const Fence,
        ) ResetFencesError!void {
            const result = self.dispatch.vkResetFences(
                device,
                fence_count,
                p_fences,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const GetFenceStatusError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn getFenceStatus(
            self: Self,
            device: Device,
            fence: Fence,
        ) GetFenceStatusError!Result {
            const result = self.dispatch.vkGetFenceStatus(
                device,
                fence,
            );
            switch (result) {
                Result.success => {},
                Result.not_ready => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
            return result;
        }
        pub const WaitForFencesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn waitForFences(
            self: Self,
            device: Device,
            fence_count: u32,
            p_fences: [*]const Fence,
            wait_all: Bool32,
            timeout: u64,
        ) WaitForFencesError!Result {
            const result = self.dispatch.vkWaitForFences(
                device,
                fence_count,
                p_fences,
                wait_all,
                timeout,
            );
            switch (result) {
                Result.success => {},
                Result.timeout => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
            return result;
        }
        pub const CreateSemaphoreError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createSemaphore(
            self: Self,
            device: Device,
            create_info: SemaphoreCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateSemaphoreError!Semaphore {
            var semaphore: Semaphore = undefined;
            const result = self.dispatch.vkCreateSemaphore(
                device,
                &create_info,
                p_allocator,
                &semaphore,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return semaphore;
        }
        pub fn destroySemaphore(
            self: Self,
            device: Device,
            semaphore: Semaphore,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroySemaphore(
                device,
                semaphore,
                p_allocator,
            );
        }
        pub const CreateEventError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createEvent(
            self: Self,
            device: Device,
            create_info: EventCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateEventError!Event {
            var event: Event = undefined;
            const result = self.dispatch.vkCreateEvent(
                device,
                &create_info,
                p_allocator,
                &event,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return event;
        }
        pub fn destroyEvent(
            self: Self,
            device: Device,
            event: Event,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyEvent(
                device,
                event,
                p_allocator,
            );
        }
        pub const GetEventStatusError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn getEventStatus(
            self: Self,
            device: Device,
            event: Event,
        ) GetEventStatusError!Result {
            const result = self.dispatch.vkGetEventStatus(
                device,
                event,
            );
            switch (result) {
                Result.event_set => {},
                Result.event_reset => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
            return result;
        }
        pub const SetEventError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn setEvent(
            self: Self,
            device: Device,
            event: Event,
        ) SetEventError!void {
            const result = self.dispatch.vkSetEvent(
                device,
                event,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const ResetEventError = error{
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn resetEvent(
            self: Self,
            device: Device,
            event: Event,
        ) ResetEventError!void {
            const result = self.dispatch.vkResetEvent(
                device,
                event,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const CreateQueryPoolError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createQueryPool(
            self: Self,
            device: Device,
            create_info: QueryPoolCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateQueryPoolError!QueryPool {
            var query_pool: QueryPool = undefined;
            const result = self.dispatch.vkCreateQueryPool(
                device,
                &create_info,
                p_allocator,
                &query_pool,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return query_pool;
        }
        pub fn destroyQueryPool(
            self: Self,
            device: Device,
            query_pool: QueryPool,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyQueryPool(
                device,
                query_pool,
                p_allocator,
            );
        }
        pub const GetQueryPoolResultsError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn getQueryPoolResults(
            self: Self,
            device: Device,
            query_pool: QueryPool,
            first_query: u32,
            query_count: u32,
            data_size: usize,
            p_data: *c_void,
            stride: DeviceSize,
            flags: QueryResultFlags,
        ) GetQueryPoolResultsError!Result {
            const result = self.dispatch.vkGetQueryPoolResults(
                device,
                query_pool,
                first_query,
                query_count,
                data_size,
                p_data,
                stride,
                flags.toInt(),
            );
            switch (result) {
                Result.success => {},
                Result.not_ready => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn resetQueryPool(
            self: Self,
            device: Device,
            query_pool: QueryPool,
            first_query: u32,
            query_count: u32,
        ) void {
            self.dispatch.vkResetQueryPool(
                device,
                query_pool,
                first_query,
                query_count,
            );
        }
        pub const CreateBufferError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidOpaqueCaptureAddressKHR,
            Unknown,
        };
        pub fn createBuffer(
            self: Self,
            device: Device,
            create_info: BufferCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateBufferError!Buffer {
            var buffer: Buffer = undefined;
            const result = self.dispatch.vkCreateBuffer(
                device,
                &create_info,
                p_allocator,
                &buffer,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_opaque_capture_address_khr => return error.InvalidOpaqueCaptureAddressKHR,
                else => return error.Unknown,
            }
            return buffer;
        }
        pub fn destroyBuffer(
            self: Self,
            device: Device,
            buffer: Buffer,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyBuffer(
                device,
                buffer,
                p_allocator,
            );
        }
        pub const CreateBufferViewError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createBufferView(
            self: Self,
            device: Device,
            create_info: BufferViewCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateBufferViewError!BufferView {
            var view: BufferView = undefined;
            const result = self.dispatch.vkCreateBufferView(
                device,
                &create_info,
                p_allocator,
                &view,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return view;
        }
        pub fn destroyBufferView(
            self: Self,
            device: Device,
            buffer_view: BufferView,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyBufferView(
                device,
                buffer_view,
                p_allocator,
            );
        }
        pub const CreateImageError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createImage(
            self: Self,
            device: Device,
            create_info: ImageCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateImageError!Image {
            var image: Image = undefined;
            const result = self.dispatch.vkCreateImage(
                device,
                &create_info,
                p_allocator,
                &image,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return image;
        }
        pub fn destroyImage(
            self: Self,
            device: Device,
            image: Image,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyImage(
                device,
                image,
                p_allocator,
            );
        }
        pub fn getImageSubresourceLayout(
            self: Self,
            device: Device,
            image: Image,
            subresource: ImageSubresource,
        ) SubresourceLayout {
            var layout: SubresourceLayout = undefined;
            self.dispatch.vkGetImageSubresourceLayout(
                device,
                image,
                &subresource,
                &layout,
            );
            return layout;
        }
        pub const CreateImageViewError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createImageView(
            self: Self,
            device: Device,
            create_info: ImageViewCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateImageViewError!ImageView {
            var view: ImageView = undefined;
            const result = self.dispatch.vkCreateImageView(
                device,
                &create_info,
                p_allocator,
                &view,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return view;
        }
        pub fn destroyImageView(
            self: Self,
            device: Device,
            image_view: ImageView,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyImageView(
                device,
                image_view,
                p_allocator,
            );
        }
        pub const CreateShaderModuleError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidShaderNV,
            Unknown,
        };
        pub fn createShaderModule(
            self: Self,
            device: Device,
            create_info: ShaderModuleCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateShaderModuleError!ShaderModule {
            var shader_module: ShaderModule = undefined;
            const result = self.dispatch.vkCreateShaderModule(
                device,
                &create_info,
                p_allocator,
                &shader_module,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_shader_nv => return error.InvalidShaderNV,
                else => return error.Unknown,
            }
            return shader_module;
        }
        pub fn destroyShaderModule(
            self: Self,
            device: Device,
            shader_module: ShaderModule,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyShaderModule(
                device,
                shader_module,
                p_allocator,
            );
        }
        pub const CreatePipelineCacheError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createPipelineCache(
            self: Self,
            device: Device,
            create_info: PipelineCacheCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreatePipelineCacheError!PipelineCache {
            var pipeline_cache: PipelineCache = undefined;
            const result = self.dispatch.vkCreatePipelineCache(
                device,
                &create_info,
                p_allocator,
                &pipeline_cache,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return pipeline_cache;
        }
        pub fn destroyPipelineCache(
            self: Self,
            device: Device,
            pipeline_cache: PipelineCache,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyPipelineCache(
                device,
                pipeline_cache,
                p_allocator,
            );
        }
        pub const GetPipelineCacheDataError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPipelineCacheData(
            self: Self,
            device: Device,
            pipeline_cache: PipelineCache,
            p_data_size: *usize,
            p_data: ?*c_void,
        ) GetPipelineCacheDataError!Result {
            const result = self.dispatch.vkGetPipelineCacheData(
                device,
                pipeline_cache,
                p_data_size,
                p_data,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const MergePipelineCachesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn mergePipelineCaches(
            self: Self,
            device: Device,
            dst_cache: PipelineCache,
            src_cache_count: u32,
            p_src_caches: [*]const PipelineCache,
        ) MergePipelineCachesError!void {
            const result = self.dispatch.vkMergePipelineCaches(
                device,
                dst_cache,
                src_cache_count,
                p_src_caches,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const CreateGraphicsPipelinesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidShaderNV,
            Unknown,
        };
        pub fn createGraphicsPipelines(
            self: Self,
            device: Device,
            pipeline_cache: PipelineCache,
            create_info_count: u32,
            p_create_infos: [*]const GraphicsPipelineCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
            p_pipelines: [*]Pipeline,
        ) CreateGraphicsPipelinesError!Result {
            const result = self.dispatch.vkCreateGraphicsPipelines(
                device,
                pipeline_cache,
                create_info_count,
                p_create_infos,
                p_allocator,
                p_pipelines,
            );
            switch (result) {
                Result.success => {},
                Result.pipeline_compile_required_ext => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_shader_nv => return error.InvalidShaderNV,
                else => return error.Unknown,
            }
            return result;
        }
        pub const CreateComputePipelinesError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidShaderNV,
            Unknown,
        };
        pub fn createComputePipelines(
            self: Self,
            device: Device,
            pipeline_cache: PipelineCache,
            create_info_count: u32,
            p_create_infos: [*]const ComputePipelineCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
            p_pipelines: [*]Pipeline,
        ) CreateComputePipelinesError!Result {
            const result = self.dispatch.vkCreateComputePipelines(
                device,
                pipeline_cache,
                create_info_count,
                p_create_infos,
                p_allocator,
                p_pipelines,
            );
            switch (result) {
                Result.success => {},
                Result.pipeline_compile_required_ext => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_shader_nv => return error.InvalidShaderNV,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetDeviceSubpassShadingMaxWorkgroupSizeHUAWEIResult = struct {
            result: Result,
            max_workgroup_size: Extent2D,
        };
        pub const GetDeviceSubpassShadingMaxWorkgroupSizeHUAWEIError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getDeviceSubpassShadingMaxWorkgroupSizeHUAWEI(
            self: Self,
            device: Device,
            renderpass: RenderPass,
        ) GetDeviceSubpassShadingMaxWorkgroupSizeHUAWEIError!GetDeviceSubpassShadingMaxWorkgroupSizeHUAWEIResult {
            var return_values: GetDeviceSubpassShadingMaxWorkgroupSizeHUAWEIResult = undefined;
            const result = self.dispatch.vkGetDeviceSubpassShadingMaxWorkgroupSizeHUAWEI(
                device,
                renderpass,
                &return_values.max_workgroup_size,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return_values.result = result;
            return return_values;
        }
        pub fn destroyPipeline(
            self: Self,
            device: Device,
            pipeline: Pipeline,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyPipeline(
                device,
                pipeline,
                p_allocator,
            );
        }
        pub const CreatePipelineLayoutError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createPipelineLayout(
            self: Self,
            device: Device,
            create_info: PipelineLayoutCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreatePipelineLayoutError!PipelineLayout {
            var pipeline_layout: PipelineLayout = undefined;
            const result = self.dispatch.vkCreatePipelineLayout(
                device,
                &create_info,
                p_allocator,
                &pipeline_layout,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return pipeline_layout;
        }
        pub fn destroyPipelineLayout(
            self: Self,
            device: Device,
            pipeline_layout: PipelineLayout,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyPipelineLayout(
                device,
                pipeline_layout,
                p_allocator,
            );
        }
        pub const CreateSamplerError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createSampler(
            self: Self,
            device: Device,
            create_info: SamplerCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateSamplerError!Sampler {
            var sampler: Sampler = undefined;
            const result = self.dispatch.vkCreateSampler(
                device,
                &create_info,
                p_allocator,
                &sampler,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return sampler;
        }
        pub fn destroySampler(
            self: Self,
            device: Device,
            sampler: Sampler,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroySampler(
                device,
                sampler,
                p_allocator,
            );
        }
        pub const CreateDescriptorSetLayoutError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createDescriptorSetLayout(
            self: Self,
            device: Device,
            create_info: DescriptorSetLayoutCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDescriptorSetLayoutError!DescriptorSetLayout {
            var set_layout: DescriptorSetLayout = undefined;
            const result = self.dispatch.vkCreateDescriptorSetLayout(
                device,
                &create_info,
                p_allocator,
                &set_layout,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return set_layout;
        }
        pub fn destroyDescriptorSetLayout(
            self: Self,
            device: Device,
            descriptor_set_layout: DescriptorSetLayout,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyDescriptorSetLayout(
                device,
                descriptor_set_layout,
                p_allocator,
            );
        }
        pub const CreateDescriptorPoolError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            FragmentationEXT,
            Unknown,
        };
        pub fn createDescriptorPool(
            self: Self,
            device: Device,
            create_info: DescriptorPoolCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDescriptorPoolError!DescriptorPool {
            var descriptor_pool: DescriptorPool = undefined;
            const result = self.dispatch.vkCreateDescriptorPool(
                device,
                &create_info,
                p_allocator,
                &descriptor_pool,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_fragmentation_ext => return error.FragmentationEXT,
                else => return error.Unknown,
            }
            return descriptor_pool;
        }
        pub fn destroyDescriptorPool(
            self: Self,
            device: Device,
            descriptor_pool: DescriptorPool,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyDescriptorPool(
                device,
                descriptor_pool,
                p_allocator,
            );
        }
        pub fn resetDescriptorPool(
            self: Self,
            device: Device,
            descriptor_pool: DescriptorPool,
            flags: DescriptorPoolResetFlags,
        ) void {
            const result = self.dispatch.vkResetDescriptorPool(
                device,
                descriptor_pool,
                flags.toInt(),
            );
            switch (result) {
                Result.success => {},
                else => return error.Unknown,
            }
        }
        pub const AllocateDescriptorSetsError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            FragmentedPool,
            OutOfPoolMemory,
            Unknown,
        };
        pub fn allocateDescriptorSets(
            self: Self,
            device: Device,
            allocate_info: DescriptorSetAllocateInfo,
            p_descriptor_sets: [*]DescriptorSet,
        ) AllocateDescriptorSetsError!void {
            const result = self.dispatch.vkAllocateDescriptorSets(
                device,
                &allocate_info,
                p_descriptor_sets,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_fragmented_pool => return error.FragmentedPool,
                Result.error_out_of_pool_memory => return error.OutOfPoolMemory,
                else => return error.Unknown,
            }
        }
        pub fn freeDescriptorSets(
            self: Self,
            device: Device,
            descriptor_pool: DescriptorPool,
            descriptor_set_count: u32,
            p_descriptor_sets: [*]const DescriptorSet,
        ) void {
            const result = self.dispatch.vkFreeDescriptorSets(
                device,
                descriptor_pool,
                descriptor_set_count,
                p_descriptor_sets,
            );
            switch (result) {
                Result.success => {},
                else => return error.Unknown,
            }
        }
        pub fn updateDescriptorSets(
            self: Self,
            device: Device,
            descriptor_write_count: u32,
            p_descriptor_writes: [*]const WriteDescriptorSet,
            descriptor_copy_count: u32,
            p_descriptor_copies: [*]const CopyDescriptorSet,
        ) void {
            self.dispatch.vkUpdateDescriptorSets(
                device,
                descriptor_write_count,
                p_descriptor_writes,
                descriptor_copy_count,
                p_descriptor_copies,
            );
        }
        pub const CreateFramebufferError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createFramebuffer(
            self: Self,
            device: Device,
            create_info: FramebufferCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateFramebufferError!Framebuffer {
            var framebuffer: Framebuffer = undefined;
            const result = self.dispatch.vkCreateFramebuffer(
                device,
                &create_info,
                p_allocator,
                &framebuffer,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return framebuffer;
        }
        pub fn destroyFramebuffer(
            self: Self,
            device: Device,
            framebuffer: Framebuffer,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyFramebuffer(
                device,
                framebuffer,
                p_allocator,
            );
        }
        pub const CreateRenderPassError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createRenderPass(
            self: Self,
            device: Device,
            create_info: RenderPassCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateRenderPassError!RenderPass {
            var render_pass: RenderPass = undefined;
            const result = self.dispatch.vkCreateRenderPass(
                device,
                &create_info,
                p_allocator,
                &render_pass,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return render_pass;
        }
        pub fn destroyRenderPass(
            self: Self,
            device: Device,
            render_pass: RenderPass,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyRenderPass(
                device,
                render_pass,
                p_allocator,
            );
        }
        pub fn getRenderAreaGranularity(
            self: Self,
            device: Device,
            render_pass: RenderPass,
        ) Extent2D {
            var granularity: Extent2D = undefined;
            self.dispatch.vkGetRenderAreaGranularity(
                device,
                render_pass,
                &granularity,
            );
            return granularity;
        }
        pub const CreateCommandPoolError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createCommandPool(
            self: Self,
            device: Device,
            create_info: CommandPoolCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateCommandPoolError!CommandPool {
            var command_pool: CommandPool = undefined;
            const result = self.dispatch.vkCreateCommandPool(
                device,
                &create_info,
                p_allocator,
                &command_pool,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return command_pool;
        }
        pub fn destroyCommandPool(
            self: Self,
            device: Device,
            command_pool: CommandPool,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyCommandPool(
                device,
                command_pool,
                p_allocator,
            );
        }
        pub const ResetCommandPoolError = error{
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn resetCommandPool(
            self: Self,
            device: Device,
            command_pool: CommandPool,
            flags: CommandPoolResetFlags,
        ) ResetCommandPoolError!void {
            const result = self.dispatch.vkResetCommandPool(
                device,
                command_pool,
                flags.toInt(),
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const AllocateCommandBuffersError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn allocateCommandBuffers(
            self: Self,
            device: Device,
            allocate_info: CommandBufferAllocateInfo,
            p_command_buffers: [*]CommandBuffer,
        ) AllocateCommandBuffersError!void {
            const result = self.dispatch.vkAllocateCommandBuffers(
                device,
                &allocate_info,
                p_command_buffers,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn freeCommandBuffers(
            self: Self,
            device: Device,
            command_pool: CommandPool,
            command_buffer_count: u32,
            p_command_buffers: [*]const CommandBuffer,
        ) void {
            self.dispatch.vkFreeCommandBuffers(
                device,
                command_pool,
                command_buffer_count,
                p_command_buffers,
            );
        }
        pub const BeginCommandBufferError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn beginCommandBuffer(
            self: Self,
            command_buffer: CommandBuffer,
            begin_info: CommandBufferBeginInfo,
        ) BeginCommandBufferError!void {
            const result = self.dispatch.vkBeginCommandBuffer(
                command_buffer,
                &begin_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const EndCommandBufferError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn endCommandBuffer(
            self: Self,
            command_buffer: CommandBuffer,
        ) EndCommandBufferError!void {
            const result = self.dispatch.vkEndCommandBuffer(
                command_buffer,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const ResetCommandBufferError = error{
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn resetCommandBuffer(
            self: Self,
            command_buffer: CommandBuffer,
            flags: CommandBufferResetFlags,
        ) ResetCommandBufferError!void {
            const result = self.dispatch.vkResetCommandBuffer(
                command_buffer,
                flags.toInt(),
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn cmdBindPipeline(
            self: Self,
            command_buffer: CommandBuffer,
            pipeline_bind_point: PipelineBindPoint,
            pipeline: Pipeline,
        ) void {
            self.dispatch.vkCmdBindPipeline(
                command_buffer,
                pipeline_bind_point,
                pipeline,
            );
        }
        pub fn cmdSetViewport(
            self: Self,
            command_buffer: CommandBuffer,
            first_viewport: u32,
            viewport_count: u32,
            p_viewports: [*]const Viewport,
        ) void {
            self.dispatch.vkCmdSetViewport(
                command_buffer,
                first_viewport,
                viewport_count,
                p_viewports,
            );
        }
        pub fn cmdSetScissor(
            self: Self,
            command_buffer: CommandBuffer,
            first_scissor: u32,
            scissor_count: u32,
            p_scissors: [*]const Rect2D,
        ) void {
            self.dispatch.vkCmdSetScissor(
                command_buffer,
                first_scissor,
                scissor_count,
                p_scissors,
            );
        }
        pub fn cmdSetLineWidth(
            self: Self,
            command_buffer: CommandBuffer,
            line_width: f32,
        ) void {
            self.dispatch.vkCmdSetLineWidth(
                command_buffer,
                line_width,
            );
        }
        pub fn cmdSetDepthBias(
            self: Self,
            command_buffer: CommandBuffer,
            depth_bias_constant_factor: f32,
            depth_bias_clamp: f32,
            depth_bias_slope_factor: f32,
        ) void {
            self.dispatch.vkCmdSetDepthBias(
                command_buffer,
                depth_bias_constant_factor,
                depth_bias_clamp,
                depth_bias_slope_factor,
            );
        }
        pub fn cmdSetBlendConstants(
            self: Self,
            command_buffer: CommandBuffer,
            blend_constants: [4]f32,
        ) void {
            self.dispatch.vkCmdSetBlendConstants(
                command_buffer,
                blend_constants,
            );
        }
        pub fn cmdSetDepthBounds(
            self: Self,
            command_buffer: CommandBuffer,
            min_depth_bounds: f32,
            max_depth_bounds: f32,
        ) void {
            self.dispatch.vkCmdSetDepthBounds(
                command_buffer,
                min_depth_bounds,
                max_depth_bounds,
            );
        }
        pub fn cmdSetStencilCompareMask(
            self: Self,
            command_buffer: CommandBuffer,
            face_mask: StencilFaceFlags,
            compare_mask: u32,
        ) void {
            self.dispatch.vkCmdSetStencilCompareMask(
                command_buffer,
                face_mask.toInt(),
                compare_mask,
            );
        }
        pub fn cmdSetStencilWriteMask(
            self: Self,
            command_buffer: CommandBuffer,
            face_mask: StencilFaceFlags,
            write_mask: u32,
        ) void {
            self.dispatch.vkCmdSetStencilWriteMask(
                command_buffer,
                face_mask.toInt(),
                write_mask,
            );
        }
        pub fn cmdSetStencilReference(
            self: Self,
            command_buffer: CommandBuffer,
            face_mask: StencilFaceFlags,
            reference: u32,
        ) void {
            self.dispatch.vkCmdSetStencilReference(
                command_buffer,
                face_mask.toInt(),
                reference,
            );
        }
        pub fn cmdBindDescriptorSets(
            self: Self,
            command_buffer: CommandBuffer,
            pipeline_bind_point: PipelineBindPoint,
            layout: PipelineLayout,
            first_set: u32,
            descriptor_set_count: u32,
            p_descriptor_sets: [*]const DescriptorSet,
            dynamic_offset_count: u32,
            p_dynamic_offsets: [*]const u32,
        ) void {
            self.dispatch.vkCmdBindDescriptorSets(
                command_buffer,
                pipeline_bind_point,
                layout,
                first_set,
                descriptor_set_count,
                p_descriptor_sets,
                dynamic_offset_count,
                p_dynamic_offsets,
            );
        }
        pub fn cmdBindIndexBuffer(
            self: Self,
            command_buffer: CommandBuffer,
            buffer: Buffer,
            offset: DeviceSize,
            index_type: IndexType,
        ) void {
            self.dispatch.vkCmdBindIndexBuffer(
                command_buffer,
                buffer,
                offset,
                index_type,
            );
        }
        pub fn cmdBindVertexBuffers(
            self: Self,
            command_buffer: CommandBuffer,
            first_binding: u32,
            binding_count: u32,
            p_buffers: [*]const Buffer,
            p_offsets: [*]const DeviceSize,
        ) void {
            self.dispatch.vkCmdBindVertexBuffers(
                command_buffer,
                first_binding,
                binding_count,
                p_buffers,
                p_offsets,
            );
        }
        pub fn cmdDraw(
            self: Self,
            command_buffer: CommandBuffer,
            vertex_count: u32,
            instance_count: u32,
            first_vertex: u32,
            first_instance: u32,
        ) void {
            self.dispatch.vkCmdDraw(
                command_buffer,
                vertex_count,
                instance_count,
                first_vertex,
                first_instance,
            );
        }
        pub fn cmdDrawIndexed(
            self: Self,
            command_buffer: CommandBuffer,
            index_count: u32,
            instance_count: u32,
            first_index: u32,
            vertex_offset: i32,
            first_instance: u32,
        ) void {
            self.dispatch.vkCmdDrawIndexed(
                command_buffer,
                index_count,
                instance_count,
                first_index,
                vertex_offset,
                first_instance,
            );
        }
        pub fn cmdDrawMultiEXT(
            self: Self,
            command_buffer: CommandBuffer,
            draw_count: u32,
            p_vertex_info: [*]const MultiDrawInfoEXT,
            instance_count: u32,
            first_instance: u32,
            stride: u32,
        ) void {
            self.dispatch.vkCmdDrawMultiEXT(
                command_buffer,
                draw_count,
                p_vertex_info,
                instance_count,
                first_instance,
                stride,
            );
        }
        pub fn cmdDrawMultiIndexedEXT(
            self: Self,
            command_buffer: CommandBuffer,
            draw_count: u32,
            p_index_info: [*]const MultiDrawIndexedInfoEXT,
            instance_count: u32,
            first_instance: u32,
            stride: u32,
            p_vertex_offset: ?*const i32,
        ) void {
            self.dispatch.vkCmdDrawMultiIndexedEXT(
                command_buffer,
                draw_count,
                p_index_info,
                instance_count,
                first_instance,
                stride,
                p_vertex_offset,
            );
        }
        pub fn cmdDrawIndirect(
            self: Self,
            command_buffer: CommandBuffer,
            buffer: Buffer,
            offset: DeviceSize,
            draw_count: u32,
            stride: u32,
        ) void {
            self.dispatch.vkCmdDrawIndirect(
                command_buffer,
                buffer,
                offset,
                draw_count,
                stride,
            );
        }
        pub fn cmdDrawIndexedIndirect(
            self: Self,
            command_buffer: CommandBuffer,
            buffer: Buffer,
            offset: DeviceSize,
            draw_count: u32,
            stride: u32,
        ) void {
            self.dispatch.vkCmdDrawIndexedIndirect(
                command_buffer,
                buffer,
                offset,
                draw_count,
                stride,
            );
        }
        pub fn cmdDispatch(
            self: Self,
            command_buffer: CommandBuffer,
            group_count_x: u32,
            group_count_y: u32,
            group_count_z: u32,
        ) void {
            self.dispatch.vkCmdDispatch(
                command_buffer,
                group_count_x,
                group_count_y,
                group_count_z,
            );
        }
        pub fn cmdDispatchIndirect(
            self: Self,
            command_buffer: CommandBuffer,
            buffer: Buffer,
            offset: DeviceSize,
        ) void {
            self.dispatch.vkCmdDispatchIndirect(
                command_buffer,
                buffer,
                offset,
            );
        }
        pub fn cmdSubpassShadingHUAWEI(
            self: Self,
            command_buffer: CommandBuffer,
        ) void {
            self.dispatch.vkCmdSubpassShadingHUAWEI(
                command_buffer,
            );
        }
        pub fn cmdCopyBuffer(
            self: Self,
            command_buffer: CommandBuffer,
            src_buffer: Buffer,
            dst_buffer: Buffer,
            region_count: u32,
            p_regions: [*]const BufferCopy,
        ) void {
            self.dispatch.vkCmdCopyBuffer(
                command_buffer,
                src_buffer,
                dst_buffer,
                region_count,
                p_regions,
            );
        }
        pub fn cmdCopyImage(
            self: Self,
            command_buffer: CommandBuffer,
            src_image: Image,
            src_image_layout: ImageLayout,
            dst_image: Image,
            dst_image_layout: ImageLayout,
            region_count: u32,
            p_regions: [*]const ImageCopy,
        ) void {
            self.dispatch.vkCmdCopyImage(
                command_buffer,
                src_image,
                src_image_layout,
                dst_image,
                dst_image_layout,
                region_count,
                p_regions,
            );
        }
        pub fn cmdBlitImage(
            self: Self,
            command_buffer: CommandBuffer,
            src_image: Image,
            src_image_layout: ImageLayout,
            dst_image: Image,
            dst_image_layout: ImageLayout,
            region_count: u32,
            p_regions: [*]const ImageBlit,
            filter: Filter,
        ) void {
            self.dispatch.vkCmdBlitImage(
                command_buffer,
                src_image,
                src_image_layout,
                dst_image,
                dst_image_layout,
                region_count,
                p_regions,
                filter,
            );
        }
        pub fn cmdCopyBufferToImage(
            self: Self,
            command_buffer: CommandBuffer,
            src_buffer: Buffer,
            dst_image: Image,
            dst_image_layout: ImageLayout,
            region_count: u32,
            p_regions: [*]const BufferImageCopy,
        ) void {
            self.dispatch.vkCmdCopyBufferToImage(
                command_buffer,
                src_buffer,
                dst_image,
                dst_image_layout,
                region_count,
                p_regions,
            );
        }
        pub fn cmdCopyImageToBuffer(
            self: Self,
            command_buffer: CommandBuffer,
            src_image: Image,
            src_image_layout: ImageLayout,
            dst_buffer: Buffer,
            region_count: u32,
            p_regions: [*]const BufferImageCopy,
        ) void {
            self.dispatch.vkCmdCopyImageToBuffer(
                command_buffer,
                src_image,
                src_image_layout,
                dst_buffer,
                region_count,
                p_regions,
            );
        }
        pub fn cmdUpdateBuffer(
            self: Self,
            command_buffer: CommandBuffer,
            dst_buffer: Buffer,
            dst_offset: DeviceSize,
            data_size: DeviceSize,
            p_data: *const c_void,
        ) void {
            self.dispatch.vkCmdUpdateBuffer(
                command_buffer,
                dst_buffer,
                dst_offset,
                data_size,
                p_data,
            );
        }
        pub fn cmdFillBuffer(
            self: Self,
            command_buffer: CommandBuffer,
            dst_buffer: Buffer,
            dst_offset: DeviceSize,
            size: DeviceSize,
            data: u32,
        ) void {
            self.dispatch.vkCmdFillBuffer(
                command_buffer,
                dst_buffer,
                dst_offset,
                size,
                data,
            );
        }
        pub fn cmdClearColorImage(
            self: Self,
            command_buffer: CommandBuffer,
            image: Image,
            image_layout: ImageLayout,
            color: ClearColorValue,
            range_count: u32,
            p_ranges: [*]const ImageSubresourceRange,
        ) void {
            self.dispatch.vkCmdClearColorImage(
                command_buffer,
                image,
                image_layout,
                &color,
                range_count,
                p_ranges,
            );
        }
        pub fn cmdClearDepthStencilImage(
            self: Self,
            command_buffer: CommandBuffer,
            image: Image,
            image_layout: ImageLayout,
            depth_stencil: ClearDepthStencilValue,
            range_count: u32,
            p_ranges: [*]const ImageSubresourceRange,
        ) void {
            self.dispatch.vkCmdClearDepthStencilImage(
                command_buffer,
                image,
                image_layout,
                &depth_stencil,
                range_count,
                p_ranges,
            );
        }
        pub fn cmdClearAttachments(
            self: Self,
            command_buffer: CommandBuffer,
            attachment_count: u32,
            p_attachments: [*]const ClearAttachment,
            rect_count: u32,
            p_rects: [*]const ClearRect,
        ) void {
            self.dispatch.vkCmdClearAttachments(
                command_buffer,
                attachment_count,
                p_attachments,
                rect_count,
                p_rects,
            );
        }
        pub fn cmdResolveImage(
            self: Self,
            command_buffer: CommandBuffer,
            src_image: Image,
            src_image_layout: ImageLayout,
            dst_image: Image,
            dst_image_layout: ImageLayout,
            region_count: u32,
            p_regions: [*]const ImageResolve,
        ) void {
            self.dispatch.vkCmdResolveImage(
                command_buffer,
                src_image,
                src_image_layout,
                dst_image,
                dst_image_layout,
                region_count,
                p_regions,
            );
        }
        pub fn cmdSetEvent(
            self: Self,
            command_buffer: CommandBuffer,
            event: Event,
            stage_mask: PipelineStageFlags,
        ) void {
            self.dispatch.vkCmdSetEvent(
                command_buffer,
                event,
                stage_mask.toInt(),
            );
        }
        pub fn cmdResetEvent(
            self: Self,
            command_buffer: CommandBuffer,
            event: Event,
            stage_mask: PipelineStageFlags,
        ) void {
            self.dispatch.vkCmdResetEvent(
                command_buffer,
                event,
                stage_mask.toInt(),
            );
        }
        pub fn cmdWaitEvents(
            self: Self,
            command_buffer: CommandBuffer,
            event_count: u32,
            p_events: [*]const Event,
            src_stage_mask: PipelineStageFlags,
            dst_stage_mask: PipelineStageFlags,
            memory_barrier_count: u32,
            p_memory_barriers: [*]const MemoryBarrier,
            buffer_memory_barrier_count: u32,
            p_buffer_memory_barriers: [*]const BufferMemoryBarrier,
            image_memory_barrier_count: u32,
            p_image_memory_barriers: [*]const ImageMemoryBarrier,
        ) void {
            self.dispatch.vkCmdWaitEvents(
                command_buffer,
                event_count,
                p_events,
                src_stage_mask.toInt(),
                dst_stage_mask.toInt(),
                memory_barrier_count,
                p_memory_barriers,
                buffer_memory_barrier_count,
                p_buffer_memory_barriers,
                image_memory_barrier_count,
                p_image_memory_barriers,
            );
        }
        pub fn cmdPipelineBarrier(
            self: Self,
            command_buffer: CommandBuffer,
            src_stage_mask: PipelineStageFlags,
            dst_stage_mask: PipelineStageFlags,
            dependency_flags: DependencyFlags,
            memory_barrier_count: u32,
            p_memory_barriers: [*]const MemoryBarrier,
            buffer_memory_barrier_count: u32,
            p_buffer_memory_barriers: [*]const BufferMemoryBarrier,
            image_memory_barrier_count: u32,
            p_image_memory_barriers: [*]const ImageMemoryBarrier,
        ) void {
            self.dispatch.vkCmdPipelineBarrier(
                command_buffer,
                src_stage_mask.toInt(),
                dst_stage_mask.toInt(),
                dependency_flags.toInt(),
                memory_barrier_count,
                p_memory_barriers,
                buffer_memory_barrier_count,
                p_buffer_memory_barriers,
                image_memory_barrier_count,
                p_image_memory_barriers,
            );
        }
        pub fn cmdBeginQuery(
            self: Self,
            command_buffer: CommandBuffer,
            query_pool: QueryPool,
            query: u32,
            flags: QueryControlFlags,
        ) void {
            self.dispatch.vkCmdBeginQuery(
                command_buffer,
                query_pool,
                query,
                flags.toInt(),
            );
        }
        pub fn cmdEndQuery(
            self: Self,
            command_buffer: CommandBuffer,
            query_pool: QueryPool,
            query: u32,
        ) void {
            self.dispatch.vkCmdEndQuery(
                command_buffer,
                query_pool,
                query,
            );
        }
        pub fn cmdBeginConditionalRenderingEXT(
            self: Self,
            command_buffer: CommandBuffer,
            conditional_rendering_begin: ConditionalRenderingBeginInfoEXT,
        ) void {
            self.dispatch.vkCmdBeginConditionalRenderingEXT(
                command_buffer,
                &conditional_rendering_begin,
            );
        }
        pub fn cmdEndConditionalRenderingEXT(
            self: Self,
            command_buffer: CommandBuffer,
        ) void {
            self.dispatch.vkCmdEndConditionalRenderingEXT(
                command_buffer,
            );
        }
        pub fn cmdResetQueryPool(
            self: Self,
            command_buffer: CommandBuffer,
            query_pool: QueryPool,
            first_query: u32,
            query_count: u32,
        ) void {
            self.dispatch.vkCmdResetQueryPool(
                command_buffer,
                query_pool,
                first_query,
                query_count,
            );
        }
        pub fn cmdWriteTimestamp(
            self: Self,
            command_buffer: CommandBuffer,
            pipeline_stage: PipelineStageFlags,
            query_pool: QueryPool,
            query: u32,
        ) void {
            self.dispatch.vkCmdWriteTimestamp(
                command_buffer,
                pipeline_stage.toInt(),
                query_pool,
                query,
            );
        }
        pub fn cmdCopyQueryPoolResults(
            self: Self,
            command_buffer: CommandBuffer,
            query_pool: QueryPool,
            first_query: u32,
            query_count: u32,
            dst_buffer: Buffer,
            dst_offset: DeviceSize,
            stride: DeviceSize,
            flags: QueryResultFlags,
        ) void {
            self.dispatch.vkCmdCopyQueryPoolResults(
                command_buffer,
                query_pool,
                first_query,
                query_count,
                dst_buffer,
                dst_offset,
                stride,
                flags.toInt(),
            );
        }
        pub fn cmdPushConstants(
            self: Self,
            command_buffer: CommandBuffer,
            layout: PipelineLayout,
            stage_flags: ShaderStageFlags,
            offset: u32,
            size: u32,
            p_values: *const c_void,
        ) void {
            self.dispatch.vkCmdPushConstants(
                command_buffer,
                layout,
                stage_flags.toInt(),
                offset,
                size,
                p_values,
            );
        }
        pub fn cmdBeginRenderPass(
            self: Self,
            command_buffer: CommandBuffer,
            render_pass_begin: RenderPassBeginInfo,
            contents: SubpassContents,
        ) void {
            self.dispatch.vkCmdBeginRenderPass(
                command_buffer,
                &render_pass_begin,
                contents,
            );
        }
        pub fn cmdNextSubpass(
            self: Self,
            command_buffer: CommandBuffer,
            contents: SubpassContents,
        ) void {
            self.dispatch.vkCmdNextSubpass(
                command_buffer,
                contents,
            );
        }
        pub fn cmdEndRenderPass(
            self: Self,
            command_buffer: CommandBuffer,
        ) void {
            self.dispatch.vkCmdEndRenderPass(
                command_buffer,
            );
        }
        pub fn cmdExecuteCommands(
            self: Self,
            command_buffer: CommandBuffer,
            command_buffer_count: u32,
            p_command_buffers: [*]const CommandBuffer,
        ) void {
            self.dispatch.vkCmdExecuteCommands(
                command_buffer,
                command_buffer_count,
                p_command_buffers,
            );
        }
        pub const CreateSharedSwapchainsKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            IncompatibleDisplayKHR,
            DeviceLost,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn createSharedSwapchainsKHR(
            self: Self,
            device: Device,
            swapchain_count: u32,
            p_create_infos: [*]const SwapchainCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
            p_swapchains: [*]SwapchainKHR,
        ) CreateSharedSwapchainsKHRError!void {
            const result = self.dispatch.vkCreateSharedSwapchainsKHR(
                device,
                swapchain_count,
                p_create_infos,
                p_allocator,
                p_swapchains,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_incompatible_display_khr => return error.IncompatibleDisplayKHR,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
        }
        pub const CreateSwapchainKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            SurfaceLostKHR,
            NativeWindowInUseKHR,
            InitializationFailed,
            Unknown,
        };
        pub fn createSwapchainKHR(
            self: Self,
            device: Device,
            create_info: SwapchainCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateSwapchainKHRError!SwapchainKHR {
            var swapchain: SwapchainKHR = undefined;
            const result = self.dispatch.vkCreateSwapchainKHR(
                device,
                &create_info,
                p_allocator,
                &swapchain,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                Result.error_native_window_in_use_khr => return error.NativeWindowInUseKHR,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return swapchain;
        }
        pub fn destroySwapchainKHR(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroySwapchainKHR(
                device,
                swapchain,
                p_allocator,
            );
        }
        pub const GetSwapchainImagesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getSwapchainImagesKHR(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
            p_swapchain_image_count: *u32,
            p_swapchain_images: ?[*]Image,
        ) GetSwapchainImagesKHRError!Result {
            const result = self.dispatch.vkGetSwapchainImagesKHR(
                device,
                swapchain,
                p_swapchain_image_count,
                p_swapchain_images,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const AcquireNextImageKHRResult = struct {
            result: Result,
            image_index: u32,
        };
        pub const AcquireNextImageKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            OutOfDateKHR,
            SurfaceLostKHR,
            FullScreenExclusiveModeLostEXT,
            Unknown,
        };
        pub fn acquireNextImageKHR(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
            timeout: u64,
            semaphore: Semaphore,
            fence: Fence,
        ) AcquireNextImageKHRError!AcquireNextImageKHRResult {
            var return_values: AcquireNextImageKHRResult = undefined;
            const result = self.dispatch.vkAcquireNextImageKHR(
                device,
                swapchain,
                timeout,
                semaphore,
                fence,
                &return_values.image_index,
            );
            switch (result) {
                Result.success => {},
                Result.timeout => {},
                Result.not_ready => {},
                Result.suboptimal_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_out_of_date_khr => return error.OutOfDateKHR,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                Result.error_full_screen_exclusive_mode_lost_ext => return error.FullScreenExclusiveModeLostEXT,
                else => return error.Unknown,
            }
            return_values.result = result;
            return return_values;
        }
        pub const QueuePresentKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            OutOfDateKHR,
            SurfaceLostKHR,
            FullScreenExclusiveModeLostEXT,
            Unknown,
        };
        pub fn queuePresentKHR(
            self: Self,
            queue: Queue,
            present_info: PresentInfoKHR,
        ) QueuePresentKHRError!Result {
            const result = self.dispatch.vkQueuePresentKHR(
                queue,
                &present_info,
            );
            switch (result) {
                Result.success => {},
                Result.suboptimal_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_out_of_date_khr => return error.OutOfDateKHR,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                Result.error_full_screen_exclusive_mode_lost_ext => return error.FullScreenExclusiveModeLostEXT,
                else => return error.Unknown,
            }
            return result;
        }
        pub const DebugMarkerSetObjectNameEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn debugMarkerSetObjectNameEXT(
            self: Self,
            device: Device,
            name_info: DebugMarkerObjectNameInfoEXT,
        ) DebugMarkerSetObjectNameEXTError!void {
            const result = self.dispatch.vkDebugMarkerSetObjectNameEXT(
                device,
                &name_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const DebugMarkerSetObjectTagEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn debugMarkerSetObjectTagEXT(
            self: Self,
            device: Device,
            tag_info: DebugMarkerObjectTagInfoEXT,
        ) DebugMarkerSetObjectTagEXTError!void {
            const result = self.dispatch.vkDebugMarkerSetObjectTagEXT(
                device,
                &tag_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn cmdDebugMarkerBeginEXT(
            self: Self,
            command_buffer: CommandBuffer,
            marker_info: DebugMarkerMarkerInfoEXT,
        ) void {
            self.dispatch.vkCmdDebugMarkerBeginEXT(
                command_buffer,
                &marker_info,
            );
        }
        pub fn cmdDebugMarkerEndEXT(
            self: Self,
            command_buffer: CommandBuffer,
        ) void {
            self.dispatch.vkCmdDebugMarkerEndEXT(
                command_buffer,
            );
        }
        pub fn cmdDebugMarkerInsertEXT(
            self: Self,
            command_buffer: CommandBuffer,
            marker_info: DebugMarkerMarkerInfoEXT,
        ) void {
            self.dispatch.vkCmdDebugMarkerInsertEXT(
                command_buffer,
                &marker_info,
            );
        }
        pub const GetMemoryWin32HandleNVError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getMemoryWin32HandleNV(
            self: Self,
            device: Device,
            memory: DeviceMemory,
            handle_type: ExternalMemoryHandleTypeFlagsNV,
            p_handle: *HANDLE,
        ) GetMemoryWin32HandleNVError!void {
            const result = self.dispatch.vkGetMemoryWin32HandleNV(
                device,
                memory,
                handle_type.toInt(),
                p_handle,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub fn cmdExecuteGeneratedCommandsNV(
            self: Self,
            command_buffer: CommandBuffer,
            is_preprocessed: Bool32,
            generated_commands_info: GeneratedCommandsInfoNV,
        ) void {
            self.dispatch.vkCmdExecuteGeneratedCommandsNV(
                command_buffer,
                is_preprocessed,
                &generated_commands_info,
            );
        }
        pub fn cmdPreprocessGeneratedCommandsNV(
            self: Self,
            command_buffer: CommandBuffer,
            generated_commands_info: GeneratedCommandsInfoNV,
        ) void {
            self.dispatch.vkCmdPreprocessGeneratedCommandsNV(
                command_buffer,
                &generated_commands_info,
            );
        }
        pub fn cmdBindPipelineShaderGroupNV(
            self: Self,
            command_buffer: CommandBuffer,
            pipeline_bind_point: PipelineBindPoint,
            pipeline: Pipeline,
            group_index: u32,
        ) void {
            self.dispatch.vkCmdBindPipelineShaderGroupNV(
                command_buffer,
                pipeline_bind_point,
                pipeline,
                group_index,
            );
        }
        pub fn getGeneratedCommandsMemoryRequirementsNV(
            self: Self,
            device: Device,
            info: GeneratedCommandsMemoryRequirementsInfoNV,
            p_memory_requirements: *MemoryRequirements2,
        ) void {
            self.dispatch.vkGetGeneratedCommandsMemoryRequirementsNV(
                device,
                &info,
                p_memory_requirements,
            );
        }
        pub const CreateIndirectCommandsLayoutNVError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createIndirectCommandsLayoutNV(
            self: Self,
            device: Device,
            create_info: IndirectCommandsLayoutCreateInfoNV,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateIndirectCommandsLayoutNVError!IndirectCommandsLayoutNV {
            var indirect_commands_layout: IndirectCommandsLayoutNV = undefined;
            const result = self.dispatch.vkCreateIndirectCommandsLayoutNV(
                device,
                &create_info,
                p_allocator,
                &indirect_commands_layout,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return indirect_commands_layout;
        }
        pub fn destroyIndirectCommandsLayoutNV(
            self: Self,
            device: Device,
            indirect_commands_layout: IndirectCommandsLayoutNV,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyIndirectCommandsLayoutNV(
                device,
                indirect_commands_layout,
                p_allocator,
            );
        }
        pub fn cmdPushDescriptorSetKHR(
            self: Self,
            command_buffer: CommandBuffer,
            pipeline_bind_point: PipelineBindPoint,
            layout: PipelineLayout,
            set: u32,
            descriptor_write_count: u32,
            p_descriptor_writes: [*]const WriteDescriptorSet,
        ) void {
            self.dispatch.vkCmdPushDescriptorSetKHR(
                command_buffer,
                pipeline_bind_point,
                layout,
                set,
                descriptor_write_count,
                p_descriptor_writes,
            );
        }
        pub fn trimCommandPool(
            self: Self,
            device: Device,
            command_pool: CommandPool,
            flags: CommandPoolTrimFlags,
        ) void {
            self.dispatch.vkTrimCommandPool(
                device,
                command_pool,
                flags.toInt(),
            );
        }
        pub const GetMemoryWin32HandleKHRError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getMemoryWin32HandleKHR(
            self: Self,
            device: Device,
            get_win_32_handle_info: MemoryGetWin32HandleInfoKHR,
            p_handle: *HANDLE,
        ) GetMemoryWin32HandleKHRError!void {
            const result = self.dispatch.vkGetMemoryWin32HandleKHR(
                device,
                &get_win_32_handle_info,
                p_handle,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const GetMemoryWin32HandlePropertiesKHRError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            Unknown,
        };
        pub fn getMemoryWin32HandlePropertiesKHR(
            self: Self,
            device: Device,
            handle_type: ExternalMemoryHandleTypeFlags,
            handle: HANDLE,
            p_memory_win_32_handle_properties: *MemoryWin32HandlePropertiesKHR,
        ) GetMemoryWin32HandlePropertiesKHRError!void {
            const result = self.dispatch.vkGetMemoryWin32HandlePropertiesKHR(
                device,
                handle_type.toInt(),
                handle,
                p_memory_win_32_handle_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub const GetMemoryFdKHRError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getMemoryFdKHR(
            self: Self,
            device: Device,
            get_fd_info: MemoryGetFdInfoKHR,
        ) GetMemoryFdKHRError!c_int {
            var fd: c_int = undefined;
            const result = self.dispatch.vkGetMemoryFdKHR(
                device,
                &get_fd_info,
                &fd,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return fd;
        }
        pub const GetMemoryFdPropertiesKHRError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            Unknown,
        };
        pub fn getMemoryFdPropertiesKHR(
            self: Self,
            device: Device,
            handle_type: ExternalMemoryHandleTypeFlags,
            fd: c_int,
            p_memory_fd_properties: *MemoryFdPropertiesKHR,
        ) GetMemoryFdPropertiesKHRError!void {
            const result = self.dispatch.vkGetMemoryFdPropertiesKHR(
                device,
                handle_type.toInt(),
                fd,
                p_memory_fd_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub const GetMemoryZirconHandleFUCHSIAError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getMemoryZirconHandleFUCHSIA(
            self: Self,
            device: Device,
            get_zircon_handle_info: MemoryGetZirconHandleInfoFUCHSIA,
            p_zircon_handle: *zx_handle_t,
        ) GetMemoryZirconHandleFUCHSIAError!void {
            const result = self.dispatch.vkGetMemoryZirconHandleFUCHSIA(
                device,
                &get_zircon_handle_info,
                p_zircon_handle,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const GetMemoryZirconHandlePropertiesFUCHSIAError = error{
            InvalidExternalHandle,
            Unknown,
        };
        pub fn getMemoryZirconHandlePropertiesFUCHSIA(
            self: Self,
            device: Device,
            handle_type: ExternalMemoryHandleTypeFlags,
            zircon_handle: zx_handle_t,
            p_memory_zircon_handle_properties: *MemoryZirconHandlePropertiesFUCHSIA,
        ) GetMemoryZirconHandlePropertiesFUCHSIAError!void {
            const result = self.dispatch.vkGetMemoryZirconHandlePropertiesFUCHSIA(
                device,
                handle_type.toInt(),
                zircon_handle,
                p_memory_zircon_handle_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub const GetMemoryRemoteAddressNVError = error{
            InvalidExternalHandle,
            Unknown,
        };
        pub fn getMemoryRemoteAddressNV(
            self: Self,
            device: Device,
            memory_get_remote_address_info: MemoryGetRemoteAddressInfoNV,
        ) GetMemoryRemoteAddressNVError!RemoteAddressNV {
            var address: RemoteAddressNV = undefined;
            const result = self.dispatch.vkGetMemoryRemoteAddressNV(
                device,
                &memory_get_remote_address_info,
                &address,
            );
            switch (result) {
                Result.success => {},
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
            return address;
        }
        pub const GetSemaphoreWin32HandleKHRError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getSemaphoreWin32HandleKHR(
            self: Self,
            device: Device,
            get_win_32_handle_info: SemaphoreGetWin32HandleInfoKHR,
            p_handle: *HANDLE,
        ) GetSemaphoreWin32HandleKHRError!void {
            const result = self.dispatch.vkGetSemaphoreWin32HandleKHR(
                device,
                &get_win_32_handle_info,
                p_handle,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const ImportSemaphoreWin32HandleKHRError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            Unknown,
        };
        pub fn importSemaphoreWin32HandleKHR(
            self: Self,
            device: Device,
            import_semaphore_win_32_handle_info: ImportSemaphoreWin32HandleInfoKHR,
        ) ImportSemaphoreWin32HandleKHRError!void {
            const result = self.dispatch.vkImportSemaphoreWin32HandleKHR(
                device,
                &import_semaphore_win_32_handle_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub const GetSemaphoreFdKHRError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getSemaphoreFdKHR(
            self: Self,
            device: Device,
            get_fd_info: SemaphoreGetFdInfoKHR,
        ) GetSemaphoreFdKHRError!c_int {
            var fd: c_int = undefined;
            const result = self.dispatch.vkGetSemaphoreFdKHR(
                device,
                &get_fd_info,
                &fd,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return fd;
        }
        pub const ImportSemaphoreFdKHRError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            Unknown,
        };
        pub fn importSemaphoreFdKHR(
            self: Self,
            device: Device,
            import_semaphore_fd_info: ImportSemaphoreFdInfoKHR,
        ) ImportSemaphoreFdKHRError!void {
            const result = self.dispatch.vkImportSemaphoreFdKHR(
                device,
                &import_semaphore_fd_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub const GetSemaphoreZirconHandleFUCHSIAError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getSemaphoreZirconHandleFUCHSIA(
            self: Self,
            device: Device,
            get_zircon_handle_info: SemaphoreGetZirconHandleInfoFUCHSIA,
            p_zircon_handle: *zx_handle_t,
        ) GetSemaphoreZirconHandleFUCHSIAError!void {
            const result = self.dispatch.vkGetSemaphoreZirconHandleFUCHSIA(
                device,
                &get_zircon_handle_info,
                p_zircon_handle,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const ImportSemaphoreZirconHandleFUCHSIAError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            Unknown,
        };
        pub fn importSemaphoreZirconHandleFUCHSIA(
            self: Self,
            device: Device,
            import_semaphore_zircon_handle_info: ImportSemaphoreZirconHandleInfoFUCHSIA,
        ) ImportSemaphoreZirconHandleFUCHSIAError!void {
            const result = self.dispatch.vkImportSemaphoreZirconHandleFUCHSIA(
                device,
                &import_semaphore_zircon_handle_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub const GetFenceWin32HandleKHRError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getFenceWin32HandleKHR(
            self: Self,
            device: Device,
            get_win_32_handle_info: FenceGetWin32HandleInfoKHR,
            p_handle: *HANDLE,
        ) GetFenceWin32HandleKHRError!void {
            const result = self.dispatch.vkGetFenceWin32HandleKHR(
                device,
                &get_win_32_handle_info,
                p_handle,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const ImportFenceWin32HandleKHRError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            Unknown,
        };
        pub fn importFenceWin32HandleKHR(
            self: Self,
            device: Device,
            import_fence_win_32_handle_info: ImportFenceWin32HandleInfoKHR,
        ) ImportFenceWin32HandleKHRError!void {
            const result = self.dispatch.vkImportFenceWin32HandleKHR(
                device,
                &import_fence_win_32_handle_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub const GetFenceFdKHRError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getFenceFdKHR(
            self: Self,
            device: Device,
            get_fd_info: FenceGetFdInfoKHR,
        ) GetFenceFdKHRError!c_int {
            var fd: c_int = undefined;
            const result = self.dispatch.vkGetFenceFdKHR(
                device,
                &get_fd_info,
                &fd,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return fd;
        }
        pub const ImportFenceFdKHRError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            Unknown,
        };
        pub fn importFenceFdKHR(
            self: Self,
            device: Device,
            import_fence_fd_info: ImportFenceFdInfoKHR,
        ) ImportFenceFdKHRError!void {
            const result = self.dispatch.vkImportFenceFdKHR(
                device,
                &import_fence_fd_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub const DisplayPowerControlEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn displayPowerControlEXT(
            self: Self,
            device: Device,
            display: DisplayKHR,
            display_power_info: DisplayPowerInfoEXT,
        ) DisplayPowerControlEXTError!void {
            const result = self.dispatch.vkDisplayPowerControlEXT(
                device,
                display,
                &display_power_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const RegisterDeviceEventEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn registerDeviceEventEXT(
            self: Self,
            device: Device,
            device_event_info: DeviceEventInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) RegisterDeviceEventEXTError!Fence {
            var fence: Fence = undefined;
            const result = self.dispatch.vkRegisterDeviceEventEXT(
                device,
                &device_event_info,
                p_allocator,
                &fence,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return fence;
        }
        pub const RegisterDisplayEventEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn registerDisplayEventEXT(
            self: Self,
            device: Device,
            display: DisplayKHR,
            display_event_info: DisplayEventInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) RegisterDisplayEventEXTError!Fence {
            var fence: Fence = undefined;
            const result = self.dispatch.vkRegisterDisplayEventEXT(
                device,
                display,
                &display_event_info,
                p_allocator,
                &fence,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return fence;
        }
        pub const GetSwapchainCounterEXTError = error{
            OutOfHostMemory,
            DeviceLost,
            OutOfDateKHR,
            Unknown,
        };
        pub fn getSwapchainCounterEXT(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
            counter: SurfaceCounterFlagsEXT,
        ) GetSwapchainCounterEXTError!u64 {
            var counter_value: u64 = undefined;
            const result = self.dispatch.vkGetSwapchainCounterEXT(
                device,
                swapchain,
                counter.toInt(),
                &counter_value,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_out_of_date_khr => return error.OutOfDateKHR,
                else => return error.Unknown,
            }
            return counter_value;
        }
        pub fn getDeviceGroupPeerMemoryFeatures(
            self: Self,
            device: Device,
            heap_index: u32,
            local_device_index: u32,
            remote_device_index: u32,
        ) PeerMemoryFeatureFlags {
            var peer_memory_features: PeerMemoryFeatureFlags = undefined;
            self.dispatch.vkGetDeviceGroupPeerMemoryFeatures(
                device,
                heap_index,
                local_device_index,
                remote_device_index,
                &peer_memory_features,
            );
            return peer_memory_features;
        }
        pub const BindBufferMemory2Error = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidOpaqueCaptureAddressKHR,
            Unknown,
        };
        pub fn bindBufferMemory2(
            self: Self,
            device: Device,
            bind_info_count: u32,
            p_bind_infos: [*]const BindBufferMemoryInfo,
        ) BindBufferMemory2Error!void {
            const result = self.dispatch.vkBindBufferMemory2(
                device,
                bind_info_count,
                p_bind_infos,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_opaque_capture_address_khr => return error.InvalidOpaqueCaptureAddressKHR,
                else => return error.Unknown,
            }
        }
        pub const BindImageMemory2Error = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn bindImageMemory2(
            self: Self,
            device: Device,
            bind_info_count: u32,
            p_bind_infos: [*]const BindImageMemoryInfo,
        ) BindImageMemory2Error!void {
            const result = self.dispatch.vkBindImageMemory2(
                device,
                bind_info_count,
                p_bind_infos,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn cmdSetDeviceMask(
            self: Self,
            command_buffer: CommandBuffer,
            device_mask: u32,
        ) void {
            self.dispatch.vkCmdSetDeviceMask(
                command_buffer,
                device_mask,
            );
        }
        pub const GetDeviceGroupPresentCapabilitiesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getDeviceGroupPresentCapabilitiesKHR(
            self: Self,
            device: Device,
            p_device_group_present_capabilities: *DeviceGroupPresentCapabilitiesKHR,
        ) GetDeviceGroupPresentCapabilitiesKHRError!void {
            const result = self.dispatch.vkGetDeviceGroupPresentCapabilitiesKHR(
                device,
                p_device_group_present_capabilities,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const GetDeviceGroupSurfacePresentModesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getDeviceGroupSurfacePresentModesKHR(
            self: Self,
            device: Device,
            surface: SurfaceKHR,
        ) GetDeviceGroupSurfacePresentModesKHRError!DeviceGroupPresentModeFlagsKHR {
            var modes: DeviceGroupPresentModeFlagsKHR = undefined;
            const result = self.dispatch.vkGetDeviceGroupSurfacePresentModesKHR(
                device,
                surface,
                &modes,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return modes;
        }
        pub const AcquireNextImage2KHRResult = struct {
            result: Result,
            image_index: u32,
        };
        pub const AcquireNextImage2KHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            OutOfDateKHR,
            SurfaceLostKHR,
            FullScreenExclusiveModeLostEXT,
            Unknown,
        };
        pub fn acquireNextImage2KHR(
            self: Self,
            device: Device,
            acquire_info: AcquireNextImageInfoKHR,
        ) AcquireNextImage2KHRError!AcquireNextImage2KHRResult {
            var return_values: AcquireNextImage2KHRResult = undefined;
            const result = self.dispatch.vkAcquireNextImage2KHR(
                device,
                &acquire_info,
                &return_values.image_index,
            );
            switch (result) {
                Result.success => {},
                Result.timeout => {},
                Result.not_ready => {},
                Result.suboptimal_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_out_of_date_khr => return error.OutOfDateKHR,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                Result.error_full_screen_exclusive_mode_lost_ext => return error.FullScreenExclusiveModeLostEXT,
                else => return error.Unknown,
            }
            return_values.result = result;
            return return_values;
        }
        pub fn cmdDispatchBase(
            self: Self,
            command_buffer: CommandBuffer,
            base_group_x: u32,
            base_group_y: u32,
            base_group_z: u32,
            group_count_x: u32,
            group_count_y: u32,
            group_count_z: u32,
        ) void {
            self.dispatch.vkCmdDispatchBase(
                command_buffer,
                base_group_x,
                base_group_y,
                base_group_z,
                group_count_x,
                group_count_y,
                group_count_z,
            );
        }
        pub const CreateDescriptorUpdateTemplateError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createDescriptorUpdateTemplate(
            self: Self,
            device: Device,
            create_info: DescriptorUpdateTemplateCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDescriptorUpdateTemplateError!DescriptorUpdateTemplate {
            var descriptor_update_template: DescriptorUpdateTemplate = undefined;
            const result = self.dispatch.vkCreateDescriptorUpdateTemplate(
                device,
                &create_info,
                p_allocator,
                &descriptor_update_template,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return descriptor_update_template;
        }
        pub fn destroyDescriptorUpdateTemplate(
            self: Self,
            device: Device,
            descriptor_update_template: DescriptorUpdateTemplate,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyDescriptorUpdateTemplate(
                device,
                descriptor_update_template,
                p_allocator,
            );
        }
        pub fn updateDescriptorSetWithTemplate(
            self: Self,
            device: Device,
            descriptor_set: DescriptorSet,
            descriptor_update_template: DescriptorUpdateTemplate,
            p_data: *const c_void,
        ) void {
            self.dispatch.vkUpdateDescriptorSetWithTemplate(
                device,
                descriptor_set,
                descriptor_update_template,
                p_data,
            );
        }
        pub fn cmdPushDescriptorSetWithTemplateKHR(
            self: Self,
            command_buffer: CommandBuffer,
            descriptor_update_template: DescriptorUpdateTemplate,
            layout: PipelineLayout,
            set: u32,
            p_data: *const c_void,
        ) void {
            self.dispatch.vkCmdPushDescriptorSetWithTemplateKHR(
                command_buffer,
                descriptor_update_template,
                layout,
                set,
                p_data,
            );
        }
        pub fn setHdrMetadataEXT(
            self: Self,
            device: Device,
            swapchain_count: u32,
            p_swapchains: [*]const SwapchainKHR,
            p_metadata: [*]const HdrMetadataEXT,
        ) void {
            self.dispatch.vkSetHdrMetadataEXT(
                device,
                swapchain_count,
                p_swapchains,
                p_metadata,
            );
        }
        pub const GetSwapchainStatusKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            OutOfDateKHR,
            SurfaceLostKHR,
            FullScreenExclusiveModeLostEXT,
            Unknown,
        };
        pub fn getSwapchainStatusKHR(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
        ) GetSwapchainStatusKHRError!Result {
            const result = self.dispatch.vkGetSwapchainStatusKHR(
                device,
                swapchain,
            );
            switch (result) {
                Result.success => {},
                Result.suboptimal_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_out_of_date_khr => return error.OutOfDateKHR,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                Result.error_full_screen_exclusive_mode_lost_ext => return error.FullScreenExclusiveModeLostEXT,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetRefreshCycleDurationGOOGLEError = error{
            OutOfHostMemory,
            DeviceLost,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getRefreshCycleDurationGOOGLE(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
        ) GetRefreshCycleDurationGOOGLEError!RefreshCycleDurationGOOGLE {
            var display_timing_properties: RefreshCycleDurationGOOGLE = undefined;
            const result = self.dispatch.vkGetRefreshCycleDurationGOOGLE(
                device,
                swapchain,
                &display_timing_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return display_timing_properties;
        }
        pub const GetPastPresentationTimingGOOGLEError = error{
            OutOfHostMemory,
            DeviceLost,
            OutOfDateKHR,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getPastPresentationTimingGOOGLE(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
            p_presentation_timing_count: *u32,
            p_presentation_timings: ?[*]PastPresentationTimingGOOGLE,
        ) GetPastPresentationTimingGOOGLEError!Result {
            const result = self.dispatch.vkGetPastPresentationTimingGOOGLE(
                device,
                swapchain,
                p_presentation_timing_count,
                p_presentation_timings,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_device_lost => return error.DeviceLost,
                Result.error_out_of_date_khr => return error.OutOfDateKHR,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn cmdSetViewportWScalingNV(
            self: Self,
            command_buffer: CommandBuffer,
            first_viewport: u32,
            viewport_count: u32,
            p_viewport_w_scalings: [*]const ViewportWScalingNV,
        ) void {
            self.dispatch.vkCmdSetViewportWScalingNV(
                command_buffer,
                first_viewport,
                viewport_count,
                p_viewport_w_scalings,
            );
        }
        pub fn cmdSetDiscardRectangleEXT(
            self: Self,
            command_buffer: CommandBuffer,
            first_discard_rectangle: u32,
            discard_rectangle_count: u32,
            p_discard_rectangles: [*]const Rect2D,
        ) void {
            self.dispatch.vkCmdSetDiscardRectangleEXT(
                command_buffer,
                first_discard_rectangle,
                discard_rectangle_count,
                p_discard_rectangles,
            );
        }
        pub fn cmdSetSampleLocationsEXT(
            self: Self,
            command_buffer: CommandBuffer,
            sample_locations_info: SampleLocationsInfoEXT,
        ) void {
            self.dispatch.vkCmdSetSampleLocationsEXT(
                command_buffer,
                &sample_locations_info,
            );
        }
        pub fn getBufferMemoryRequirements2(
            self: Self,
            device: Device,
            info: BufferMemoryRequirementsInfo2,
            p_memory_requirements: *MemoryRequirements2,
        ) void {
            self.dispatch.vkGetBufferMemoryRequirements2(
                device,
                &info,
                p_memory_requirements,
            );
        }
        pub fn getImageMemoryRequirements2(
            self: Self,
            device: Device,
            info: ImageMemoryRequirementsInfo2,
            p_memory_requirements: *MemoryRequirements2,
        ) void {
            self.dispatch.vkGetImageMemoryRequirements2(
                device,
                &info,
                p_memory_requirements,
            );
        }
        pub fn getImageSparseMemoryRequirements2(
            self: Self,
            device: Device,
            info: ImageSparseMemoryRequirementsInfo2,
            p_sparse_memory_requirement_count: *u32,
            p_sparse_memory_requirements: ?[*]SparseImageMemoryRequirements2,
        ) void {
            self.dispatch.vkGetImageSparseMemoryRequirements2(
                device,
                &info,
                p_sparse_memory_requirement_count,
                p_sparse_memory_requirements,
            );
        }
        pub fn getDeviceBufferMemoryRequirementsKHR(
            self: Self,
            device: Device,
            info: DeviceBufferMemoryRequirementsKHR,
            p_memory_requirements: *MemoryRequirements2,
        ) void {
            self.dispatch.vkGetDeviceBufferMemoryRequirementsKHR(
                device,
                &info,
                p_memory_requirements,
            );
        }
        pub fn getDeviceImageMemoryRequirementsKHR(
            self: Self,
            device: Device,
            info: DeviceImageMemoryRequirementsKHR,
            p_memory_requirements: *MemoryRequirements2,
        ) void {
            self.dispatch.vkGetDeviceImageMemoryRequirementsKHR(
                device,
                &info,
                p_memory_requirements,
            );
        }
        pub fn getDeviceImageSparseMemoryRequirementsKHR(
            self: Self,
            device: Device,
            info: DeviceImageMemoryRequirementsKHR,
            p_sparse_memory_requirement_count: *u32,
            p_sparse_memory_requirements: ?[*]SparseImageMemoryRequirements2,
        ) void {
            self.dispatch.vkGetDeviceImageSparseMemoryRequirementsKHR(
                device,
                &info,
                p_sparse_memory_requirement_count,
                p_sparse_memory_requirements,
            );
        }
        pub const CreateSamplerYcbcrConversionError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createSamplerYcbcrConversion(
            self: Self,
            device: Device,
            create_info: SamplerYcbcrConversionCreateInfo,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateSamplerYcbcrConversionError!SamplerYcbcrConversion {
            var ycbcr_conversion: SamplerYcbcrConversion = undefined;
            const result = self.dispatch.vkCreateSamplerYcbcrConversion(
                device,
                &create_info,
                p_allocator,
                &ycbcr_conversion,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return ycbcr_conversion;
        }
        pub fn destroySamplerYcbcrConversion(
            self: Self,
            device: Device,
            ycbcr_conversion: SamplerYcbcrConversion,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroySamplerYcbcrConversion(
                device,
                ycbcr_conversion,
                p_allocator,
            );
        }
        pub fn getDeviceQueue2(
            self: Self,
            device: Device,
            queue_info: DeviceQueueInfo2,
        ) Queue {
            var queue: Queue = undefined;
            self.dispatch.vkGetDeviceQueue2(
                device,
                &queue_info,
                &queue,
            );
            return queue;
        }
        pub const CreateValidationCacheEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn createValidationCacheEXT(
            self: Self,
            device: Device,
            create_info: ValidationCacheCreateInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateValidationCacheEXTError!ValidationCacheEXT {
            var validation_cache: ValidationCacheEXT = undefined;
            const result = self.dispatch.vkCreateValidationCacheEXT(
                device,
                &create_info,
                p_allocator,
                &validation_cache,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return validation_cache;
        }
        pub fn destroyValidationCacheEXT(
            self: Self,
            device: Device,
            validation_cache: ValidationCacheEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyValidationCacheEXT(
                device,
                validation_cache,
                p_allocator,
            );
        }
        pub const GetValidationCacheDataEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getValidationCacheDataEXT(
            self: Self,
            device: Device,
            validation_cache: ValidationCacheEXT,
            p_data_size: *usize,
            p_data: ?*c_void,
        ) GetValidationCacheDataEXTError!Result {
            const result = self.dispatch.vkGetValidationCacheDataEXT(
                device,
                validation_cache,
                p_data_size,
                p_data,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const MergeValidationCachesEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn mergeValidationCachesEXT(
            self: Self,
            device: Device,
            dst_cache: ValidationCacheEXT,
            src_cache_count: u32,
            p_src_caches: [*]const ValidationCacheEXT,
        ) MergeValidationCachesEXTError!void {
            const result = self.dispatch.vkMergeValidationCachesEXT(
                device,
                dst_cache,
                src_cache_count,
                p_src_caches,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn getDescriptorSetLayoutSupport(
            self: Self,
            device: Device,
            create_info: DescriptorSetLayoutCreateInfo,
            p_support: *DescriptorSetLayoutSupport,
        ) void {
            self.dispatch.vkGetDescriptorSetLayoutSupport(
                device,
                &create_info,
                p_support,
            );
        }
        pub fn getSwapchainGrallocUsageANDROID(
            self: Self,
            device: Device,
            format: Format,
            image_usage: ImageUsageFlags,
        ) c_int {
            var gralloc_usage: c_int = undefined;
            const result = self.dispatch.vkGetSwapchainGrallocUsageANDROID(
                device,
                format,
                image_usage.toInt(),
                &gralloc_usage,
            );
            switch (result) {
                else => return error.Unknown,
            }
            return gralloc_usage;
        }
        pub const GetSwapchainGrallocUsage2ANDROIDResult = struct {
            gralloc_consumer_usage: u64,
            gralloc_producer_usage: u64,
        };
        pub fn getSwapchainGrallocUsage2ANDROID(
            self: Self,
            device: Device,
            format: Format,
            image_usage: ImageUsageFlags,
            swapchain_image_usage: SwapchainImageUsageFlagsANDROID,
        ) GetSwapchainGrallocUsage2ANDROIDResult {
            var return_values: GetSwapchainGrallocUsage2ANDROIDResult = undefined;
            const result = self.dispatch.vkGetSwapchainGrallocUsage2ANDROID(
                device,
                format,
                image_usage.toInt(),
                swapchain_image_usage.toInt(),
                &return_values.gralloc_consumer_usage,
                &return_values.gralloc_producer_usage,
            );
            switch (result) {
                else => return error.Unknown,
            }
            return return_values;
        }
        pub fn acquireImageANDROID(
            self: Self,
            device: Device,
            image: Image,
            native_fence_fd: c_int,
            semaphore: Semaphore,
            fence: Fence,
        ) void {
            const result = self.dispatch.vkAcquireImageANDROID(
                device,
                image,
                native_fence_fd,
                semaphore,
                fence,
            );
            switch (result) {
                else => return error.Unknown,
            }
        }
        pub fn queueSignalReleaseImageANDROID(
            self: Self,
            queue: Queue,
            wait_semaphore_count: u32,
            p_wait_semaphores: [*]const Semaphore,
            image: Image,
        ) c_int {
            var native_fence_fd: c_int = undefined;
            const result = self.dispatch.vkQueueSignalReleaseImageANDROID(
                queue,
                wait_semaphore_count,
                p_wait_semaphores,
                image,
                &native_fence_fd,
            );
            switch (result) {
                else => return error.Unknown,
            }
            return native_fence_fd;
        }
        pub const GetShaderInfoAMDError = error{
            FeatureNotPresent,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getShaderInfoAMD(
            self: Self,
            device: Device,
            pipeline: Pipeline,
            shader_stage: ShaderStageFlags,
            info_type: ShaderInfoTypeAMD,
            p_info_size: *usize,
            p_info: ?*c_void,
        ) GetShaderInfoAMDError!Result {
            const result = self.dispatch.vkGetShaderInfoAMD(
                device,
                pipeline,
                shader_stage.toInt(),
                info_type,
                p_info_size,
                p_info,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_feature_not_present => return error.FeatureNotPresent,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn setLocalDimmingAMD(
            self: Self,
            device: Device,
            swap_chain: SwapchainKHR,
            local_dimming_enable: Bool32,
        ) void {
            self.dispatch.vkSetLocalDimmingAMD(
                device,
                swap_chain,
                local_dimming_enable,
            );
        }
        pub const GetCalibratedTimestampsEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getCalibratedTimestampsEXT(
            self: Self,
            device: Device,
            timestamp_count: u32,
            p_timestamp_infos: [*]const CalibratedTimestampInfoEXT,
            p_timestamps: [*]u64,
        ) GetCalibratedTimestampsEXTError!u64 {
            var max_deviation: u64 = undefined;
            const result = self.dispatch.vkGetCalibratedTimestampsEXT(
                device,
                timestamp_count,
                p_timestamp_infos,
                p_timestamps,
                &max_deviation,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return max_deviation;
        }
        pub const SetDebugUtilsObjectNameEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn setDebugUtilsObjectNameEXT(
            self: Self,
            device: Device,
            name_info: DebugUtilsObjectNameInfoEXT,
        ) SetDebugUtilsObjectNameEXTError!void {
            const result = self.dispatch.vkSetDebugUtilsObjectNameEXT(
                device,
                &name_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const SetDebugUtilsObjectTagEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn setDebugUtilsObjectTagEXT(
            self: Self,
            device: Device,
            tag_info: DebugUtilsObjectTagInfoEXT,
        ) SetDebugUtilsObjectTagEXTError!void {
            const result = self.dispatch.vkSetDebugUtilsObjectTagEXT(
                device,
                &tag_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn queueBeginDebugUtilsLabelEXT(
            self: Self,
            queue: Queue,
            label_info: DebugUtilsLabelEXT,
        ) void {
            self.dispatch.vkQueueBeginDebugUtilsLabelEXT(
                queue,
                &label_info,
            );
        }
        pub fn queueEndDebugUtilsLabelEXT(
            self: Self,
            queue: Queue,
        ) void {
            self.dispatch.vkQueueEndDebugUtilsLabelEXT(
                queue,
            );
        }
        pub fn queueInsertDebugUtilsLabelEXT(
            self: Self,
            queue: Queue,
            label_info: DebugUtilsLabelEXT,
        ) void {
            self.dispatch.vkQueueInsertDebugUtilsLabelEXT(
                queue,
                &label_info,
            );
        }
        pub fn cmdBeginDebugUtilsLabelEXT(
            self: Self,
            command_buffer: CommandBuffer,
            label_info: DebugUtilsLabelEXT,
        ) void {
            self.dispatch.vkCmdBeginDebugUtilsLabelEXT(
                command_buffer,
                &label_info,
            );
        }
        pub fn cmdEndDebugUtilsLabelEXT(
            self: Self,
            command_buffer: CommandBuffer,
        ) void {
            self.dispatch.vkCmdEndDebugUtilsLabelEXT(
                command_buffer,
            );
        }
        pub fn cmdInsertDebugUtilsLabelEXT(
            self: Self,
            command_buffer: CommandBuffer,
            label_info: DebugUtilsLabelEXT,
        ) void {
            self.dispatch.vkCmdInsertDebugUtilsLabelEXT(
                command_buffer,
                &label_info,
            );
        }
        pub const GetMemoryHostPointerPropertiesEXTError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            Unknown,
        };
        pub fn getMemoryHostPointerPropertiesEXT(
            self: Self,
            device: Device,
            handle_type: ExternalMemoryHandleTypeFlags,
            p_host_pointer: *const c_void,
            p_memory_host_pointer_properties: *MemoryHostPointerPropertiesEXT,
        ) GetMemoryHostPointerPropertiesEXTError!void {
            const result = self.dispatch.vkGetMemoryHostPointerPropertiesEXT(
                device,
                handle_type.toInt(),
                p_host_pointer,
                p_memory_host_pointer_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                else => return error.Unknown,
            }
        }
        pub fn cmdWriteBufferMarkerAMD(
            self: Self,
            command_buffer: CommandBuffer,
            pipeline_stage: PipelineStageFlags,
            dst_buffer: Buffer,
            dst_offset: DeviceSize,
            marker: u32,
        ) void {
            self.dispatch.vkCmdWriteBufferMarkerAMD(
                command_buffer,
                pipeline_stage.toInt(),
                dst_buffer,
                dst_offset,
                marker,
            );
        }
        pub const CreateRenderPass2Error = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn createRenderPass2(
            self: Self,
            device: Device,
            create_info: RenderPassCreateInfo2,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateRenderPass2Error!RenderPass {
            var render_pass: RenderPass = undefined;
            const result = self.dispatch.vkCreateRenderPass2(
                device,
                &create_info,
                p_allocator,
                &render_pass,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return render_pass;
        }
        pub fn cmdBeginRenderPass2(
            self: Self,
            command_buffer: CommandBuffer,
            render_pass_begin: RenderPassBeginInfo,
            subpass_begin_info: SubpassBeginInfo,
        ) void {
            self.dispatch.vkCmdBeginRenderPass2(
                command_buffer,
                &render_pass_begin,
                &subpass_begin_info,
            );
        }
        pub fn cmdNextSubpass2(
            self: Self,
            command_buffer: CommandBuffer,
            subpass_begin_info: SubpassBeginInfo,
            subpass_end_info: SubpassEndInfo,
        ) void {
            self.dispatch.vkCmdNextSubpass2(
                command_buffer,
                &subpass_begin_info,
                &subpass_end_info,
            );
        }
        pub fn cmdEndRenderPass2(
            self: Self,
            command_buffer: CommandBuffer,
            subpass_end_info: SubpassEndInfo,
        ) void {
            self.dispatch.vkCmdEndRenderPass2(
                command_buffer,
                &subpass_end_info,
            );
        }
        pub const GetSemaphoreCounterValueError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn getSemaphoreCounterValue(
            self: Self,
            device: Device,
            semaphore: Semaphore,
        ) GetSemaphoreCounterValueError!u64 {
            var value: u64 = undefined;
            const result = self.dispatch.vkGetSemaphoreCounterValue(
                device,
                semaphore,
                &value,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
            return value;
        }
        pub const WaitSemaphoresError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn waitSemaphores(
            self: Self,
            device: Device,
            wait_info: SemaphoreWaitInfo,
            timeout: u64,
        ) WaitSemaphoresError!Result {
            const result = self.dispatch.vkWaitSemaphores(
                device,
                &wait_info,
                timeout,
            );
            switch (result) {
                Result.success => {},
                Result.timeout => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
            return result;
        }
        pub const SignalSemaphoreError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn signalSemaphore(
            self: Self,
            device: Device,
            signal_info: SemaphoreSignalInfo,
        ) SignalSemaphoreError!void {
            const result = self.dispatch.vkSignalSemaphore(
                device,
                &signal_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const GetAndroidHardwareBufferPropertiesANDROIDError = error{
            OutOfHostMemory,
            InvalidExternalHandleKHR,
            Unknown,
        };
        pub fn getAndroidHardwareBufferPropertiesANDROID(
            self: Self,
            device: Device,
            buffer: *const AHardwareBuffer,
            p_properties: *AndroidHardwareBufferPropertiesANDROID,
        ) GetAndroidHardwareBufferPropertiesANDROIDError!void {
            const result = self.dispatch.vkGetAndroidHardwareBufferPropertiesANDROID(
                device,
                buffer,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle_khr => return error.InvalidExternalHandleKHR,
                else => return error.Unknown,
            }
        }
        pub const GetMemoryAndroidHardwareBufferANDROIDError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getMemoryAndroidHardwareBufferANDROID(
            self: Self,
            device: Device,
            info: MemoryGetAndroidHardwareBufferInfoANDROID,
        ) GetMemoryAndroidHardwareBufferANDROIDError!*AHardwareBuffer {
            var buffer: *AHardwareBuffer = undefined;
            const result = self.dispatch.vkGetMemoryAndroidHardwareBufferANDROID(
                device,
                &info,
                &buffer,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return buffer;
        }
        pub fn cmdDrawIndirectCount(
            self: Self,
            command_buffer: CommandBuffer,
            buffer: Buffer,
            offset: DeviceSize,
            count_buffer: Buffer,
            count_buffer_offset: DeviceSize,
            max_draw_count: u32,
            stride: u32,
        ) void {
            self.dispatch.vkCmdDrawIndirectCount(
                command_buffer,
                buffer,
                offset,
                count_buffer,
                count_buffer_offset,
                max_draw_count,
                stride,
            );
        }
        pub fn cmdDrawIndexedIndirectCount(
            self: Self,
            command_buffer: CommandBuffer,
            buffer: Buffer,
            offset: DeviceSize,
            count_buffer: Buffer,
            count_buffer_offset: DeviceSize,
            max_draw_count: u32,
            stride: u32,
        ) void {
            self.dispatch.vkCmdDrawIndexedIndirectCount(
                command_buffer,
                buffer,
                offset,
                count_buffer,
                count_buffer_offset,
                max_draw_count,
                stride,
            );
        }
        pub fn cmdSetCheckpointNV(
            self: Self,
            command_buffer: CommandBuffer,
            p_checkpoint_marker: *const c_void,
        ) void {
            self.dispatch.vkCmdSetCheckpointNV(
                command_buffer,
                p_checkpoint_marker,
            );
        }
        pub fn getQueueCheckpointDataNV(
            self: Self,
            queue: Queue,
            p_checkpoint_data_count: *u32,
            p_checkpoint_data: ?[*]CheckpointDataNV,
        ) void {
            self.dispatch.vkGetQueueCheckpointDataNV(
                queue,
                p_checkpoint_data_count,
                p_checkpoint_data,
            );
        }
        pub fn cmdBindTransformFeedbackBuffersEXT(
            self: Self,
            command_buffer: CommandBuffer,
            first_binding: u32,
            binding_count: u32,
            p_buffers: [*]const Buffer,
            p_offsets: [*]const DeviceSize,
            p_sizes: ?[*]const DeviceSize,
        ) void {
            self.dispatch.vkCmdBindTransformFeedbackBuffersEXT(
                command_buffer,
                first_binding,
                binding_count,
                p_buffers,
                p_offsets,
                p_sizes,
            );
        }
        pub fn cmdBeginTransformFeedbackEXT(
            self: Self,
            command_buffer: CommandBuffer,
            first_counter_buffer: u32,
            counter_buffer_count: u32,
            p_counter_buffers: [*]const Buffer,
            p_counter_buffer_offsets: ?[*]const DeviceSize,
        ) void {
            self.dispatch.vkCmdBeginTransformFeedbackEXT(
                command_buffer,
                first_counter_buffer,
                counter_buffer_count,
                p_counter_buffers,
                p_counter_buffer_offsets,
            );
        }
        pub fn cmdEndTransformFeedbackEXT(
            self: Self,
            command_buffer: CommandBuffer,
            first_counter_buffer: u32,
            counter_buffer_count: u32,
            p_counter_buffers: [*]const Buffer,
            p_counter_buffer_offsets: ?[*]const DeviceSize,
        ) void {
            self.dispatch.vkCmdEndTransformFeedbackEXT(
                command_buffer,
                first_counter_buffer,
                counter_buffer_count,
                p_counter_buffers,
                p_counter_buffer_offsets,
            );
        }
        pub fn cmdBeginQueryIndexedEXT(
            self: Self,
            command_buffer: CommandBuffer,
            query_pool: QueryPool,
            query: u32,
            flags: QueryControlFlags,
            index: u32,
        ) void {
            self.dispatch.vkCmdBeginQueryIndexedEXT(
                command_buffer,
                query_pool,
                query,
                flags.toInt(),
                index,
            );
        }
        pub fn cmdEndQueryIndexedEXT(
            self: Self,
            command_buffer: CommandBuffer,
            query_pool: QueryPool,
            query: u32,
            index: u32,
        ) void {
            self.dispatch.vkCmdEndQueryIndexedEXT(
                command_buffer,
                query_pool,
                query,
                index,
            );
        }
        pub fn cmdDrawIndirectByteCountEXT(
            self: Self,
            command_buffer: CommandBuffer,
            instance_count: u32,
            first_instance: u32,
            counter_buffer: Buffer,
            counter_buffer_offset: DeviceSize,
            counter_offset: u32,
            vertex_stride: u32,
        ) void {
            self.dispatch.vkCmdDrawIndirectByteCountEXT(
                command_buffer,
                instance_count,
                first_instance,
                counter_buffer,
                counter_buffer_offset,
                counter_offset,
                vertex_stride,
            );
        }
        pub fn cmdSetExclusiveScissorNV(
            self: Self,
            command_buffer: CommandBuffer,
            first_exclusive_scissor: u32,
            exclusive_scissor_count: u32,
            p_exclusive_scissors: [*]const Rect2D,
        ) void {
            self.dispatch.vkCmdSetExclusiveScissorNV(
                command_buffer,
                first_exclusive_scissor,
                exclusive_scissor_count,
                p_exclusive_scissors,
            );
        }
        pub fn cmdBindShadingRateImageNV(
            self: Self,
            command_buffer: CommandBuffer,
            image_view: ImageView,
            image_layout: ImageLayout,
        ) void {
            self.dispatch.vkCmdBindShadingRateImageNV(
                command_buffer,
                image_view,
                image_layout,
            );
        }
        pub fn cmdSetViewportShadingRatePaletteNV(
            self: Self,
            command_buffer: CommandBuffer,
            first_viewport: u32,
            viewport_count: u32,
            p_shading_rate_palettes: [*]const ShadingRatePaletteNV,
        ) void {
            self.dispatch.vkCmdSetViewportShadingRatePaletteNV(
                command_buffer,
                first_viewport,
                viewport_count,
                p_shading_rate_palettes,
            );
        }
        pub fn cmdSetCoarseSampleOrderNV(
            self: Self,
            command_buffer: CommandBuffer,
            sample_order_type: CoarseSampleOrderTypeNV,
            custom_sample_order_count: u32,
            p_custom_sample_orders: [*]const CoarseSampleOrderCustomNV,
        ) void {
            self.dispatch.vkCmdSetCoarseSampleOrderNV(
                command_buffer,
                sample_order_type,
                custom_sample_order_count,
                p_custom_sample_orders,
            );
        }
        pub fn cmdDrawMeshTasksNV(
            self: Self,
            command_buffer: CommandBuffer,
            task_count: u32,
            first_task: u32,
        ) void {
            self.dispatch.vkCmdDrawMeshTasksNV(
                command_buffer,
                task_count,
                first_task,
            );
        }
        pub fn cmdDrawMeshTasksIndirectNV(
            self: Self,
            command_buffer: CommandBuffer,
            buffer: Buffer,
            offset: DeviceSize,
            draw_count: u32,
            stride: u32,
        ) void {
            self.dispatch.vkCmdDrawMeshTasksIndirectNV(
                command_buffer,
                buffer,
                offset,
                draw_count,
                stride,
            );
        }
        pub fn cmdDrawMeshTasksIndirectCountNV(
            self: Self,
            command_buffer: CommandBuffer,
            buffer: Buffer,
            offset: DeviceSize,
            count_buffer: Buffer,
            count_buffer_offset: DeviceSize,
            max_draw_count: u32,
            stride: u32,
        ) void {
            self.dispatch.vkCmdDrawMeshTasksIndirectCountNV(
                command_buffer,
                buffer,
                offset,
                count_buffer,
                count_buffer_offset,
                max_draw_count,
                stride,
            );
        }
        pub const CompileDeferredNVError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn compileDeferredNV(
            self: Self,
            device: Device,
            pipeline: Pipeline,
            shader: u32,
        ) CompileDeferredNVError!void {
            const result = self.dispatch.vkCompileDeferredNV(
                device,
                pipeline,
                shader,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const CreateAccelerationStructureNVError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn createAccelerationStructureNV(
            self: Self,
            device: Device,
            create_info: AccelerationStructureCreateInfoNV,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateAccelerationStructureNVError!AccelerationStructureNV {
            var acceleration_structure: AccelerationStructureNV = undefined;
            const result = self.dispatch.vkCreateAccelerationStructureNV(
                device,
                &create_info,
                p_allocator,
                &acceleration_structure,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return acceleration_structure;
        }
        pub fn cmdBindInvocationMaskHUAWEI(
            self: Self,
            command_buffer: CommandBuffer,
            image_view: ImageView,
            image_layout: ImageLayout,
        ) void {
            self.dispatch.vkCmdBindInvocationMaskHUAWEI(
                command_buffer,
                image_view,
                image_layout,
            );
        }
        pub fn destroyAccelerationStructureKHR(
            self: Self,
            device: Device,
            acceleration_structure: AccelerationStructureKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyAccelerationStructureKHR(
                device,
                acceleration_structure,
                p_allocator,
            );
        }
        pub fn destroyAccelerationStructureNV(
            self: Self,
            device: Device,
            acceleration_structure: AccelerationStructureNV,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyAccelerationStructureNV(
                device,
                acceleration_structure,
                p_allocator,
            );
        }
        pub fn getAccelerationStructureMemoryRequirementsNV(
            self: Self,
            device: Device,
            info: AccelerationStructureMemoryRequirementsInfoNV,
            p_memory_requirements: *MemoryRequirements2KHR,
        ) void {
            self.dispatch.vkGetAccelerationStructureMemoryRequirementsNV(
                device,
                &info,
                p_memory_requirements,
            );
        }
        pub const BindAccelerationStructureMemoryNVError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn bindAccelerationStructureMemoryNV(
            self: Self,
            device: Device,
            bind_info_count: u32,
            p_bind_infos: [*]const BindAccelerationStructureMemoryInfoNV,
        ) BindAccelerationStructureMemoryNVError!void {
            const result = self.dispatch.vkBindAccelerationStructureMemoryNV(
                device,
                bind_info_count,
                p_bind_infos,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn cmdCopyAccelerationStructureNV(
            self: Self,
            command_buffer: CommandBuffer,
            dst: AccelerationStructureNV,
            src: AccelerationStructureNV,
            mode: CopyAccelerationStructureModeKHR,
        ) void {
            self.dispatch.vkCmdCopyAccelerationStructureNV(
                command_buffer,
                dst,
                src,
                mode,
            );
        }
        pub fn cmdCopyAccelerationStructureKHR(
            self: Self,
            command_buffer: CommandBuffer,
            info: CopyAccelerationStructureInfoKHR,
        ) void {
            self.dispatch.vkCmdCopyAccelerationStructureKHR(
                command_buffer,
                &info,
            );
        }
        pub const CopyAccelerationStructureKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn copyAccelerationStructureKHR(
            self: Self,
            device: Device,
            deferred_operation: DeferredOperationKHR,
            info: CopyAccelerationStructureInfoKHR,
        ) CopyAccelerationStructureKHRError!Result {
            const result = self.dispatch.vkCopyAccelerationStructureKHR(
                device,
                deferred_operation,
                &info,
            );
            switch (result) {
                Result.success => {},
                Result.operation_deferred_khr => {},
                Result.operation_not_deferred_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn cmdCopyAccelerationStructureToMemoryKHR(
            self: Self,
            command_buffer: CommandBuffer,
            info: CopyAccelerationStructureToMemoryInfoKHR,
        ) void {
            self.dispatch.vkCmdCopyAccelerationStructureToMemoryKHR(
                command_buffer,
                &info,
            );
        }
        pub const CopyAccelerationStructureToMemoryKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn copyAccelerationStructureToMemoryKHR(
            self: Self,
            device: Device,
            deferred_operation: DeferredOperationKHR,
            info: CopyAccelerationStructureToMemoryInfoKHR,
        ) CopyAccelerationStructureToMemoryKHRError!Result {
            const result = self.dispatch.vkCopyAccelerationStructureToMemoryKHR(
                device,
                deferred_operation,
                &info,
            );
            switch (result) {
                Result.success => {},
                Result.operation_deferred_khr => {},
                Result.operation_not_deferred_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn cmdCopyMemoryToAccelerationStructureKHR(
            self: Self,
            command_buffer: CommandBuffer,
            info: CopyMemoryToAccelerationStructureInfoKHR,
        ) void {
            self.dispatch.vkCmdCopyMemoryToAccelerationStructureKHR(
                command_buffer,
                &info,
            );
        }
        pub const CopyMemoryToAccelerationStructureKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn copyMemoryToAccelerationStructureKHR(
            self: Self,
            device: Device,
            deferred_operation: DeferredOperationKHR,
            info: CopyMemoryToAccelerationStructureInfoKHR,
        ) CopyMemoryToAccelerationStructureKHRError!Result {
            const result = self.dispatch.vkCopyMemoryToAccelerationStructureKHR(
                device,
                deferred_operation,
                &info,
            );
            switch (result) {
                Result.success => {},
                Result.operation_deferred_khr => {},
                Result.operation_not_deferred_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn cmdWriteAccelerationStructuresPropertiesKHR(
            self: Self,
            command_buffer: CommandBuffer,
            acceleration_structure_count: u32,
            p_acceleration_structures: [*]const AccelerationStructureKHR,
            query_type: QueryType,
            query_pool: QueryPool,
            first_query: u32,
        ) void {
            self.dispatch.vkCmdWriteAccelerationStructuresPropertiesKHR(
                command_buffer,
                acceleration_structure_count,
                p_acceleration_structures,
                query_type,
                query_pool,
                first_query,
            );
        }
        pub fn cmdWriteAccelerationStructuresPropertiesNV(
            self: Self,
            command_buffer: CommandBuffer,
            acceleration_structure_count: u32,
            p_acceleration_structures: [*]const AccelerationStructureNV,
            query_type: QueryType,
            query_pool: QueryPool,
            first_query: u32,
        ) void {
            self.dispatch.vkCmdWriteAccelerationStructuresPropertiesNV(
                command_buffer,
                acceleration_structure_count,
                p_acceleration_structures,
                query_type,
                query_pool,
                first_query,
            );
        }
        pub fn cmdBuildAccelerationStructureNV(
            self: Self,
            command_buffer: CommandBuffer,
            info: AccelerationStructureInfoNV,
            instance_data: Buffer,
            instance_offset: DeviceSize,
            update: Bool32,
            dst: AccelerationStructureNV,
            src: AccelerationStructureNV,
            scratch: Buffer,
            scratch_offset: DeviceSize,
        ) void {
            self.dispatch.vkCmdBuildAccelerationStructureNV(
                command_buffer,
                &info,
                instance_data,
                instance_offset,
                update,
                dst,
                src,
                scratch,
                scratch_offset,
            );
        }
        pub const WriteAccelerationStructuresPropertiesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn writeAccelerationStructuresPropertiesKHR(
            self: Self,
            device: Device,
            acceleration_structure_count: u32,
            p_acceleration_structures: [*]const AccelerationStructureKHR,
            query_type: QueryType,
            data_size: usize,
            p_data: *c_void,
            stride: usize,
        ) WriteAccelerationStructuresPropertiesKHRError!void {
            const result = self.dispatch.vkWriteAccelerationStructuresPropertiesKHR(
                device,
                acceleration_structure_count,
                p_acceleration_structures,
                query_type,
                data_size,
                p_data,
                stride,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub fn cmdTraceRaysKHR(
            self: Self,
            command_buffer: CommandBuffer,
            raygen_shader_binding_table: StridedDeviceAddressRegionKHR,
            miss_shader_binding_table: StridedDeviceAddressRegionKHR,
            hit_shader_binding_table: StridedDeviceAddressRegionKHR,
            callable_shader_binding_table: StridedDeviceAddressRegionKHR,
            width: u32,
            height: u32,
            depth: u32,
        ) void {
            self.dispatch.vkCmdTraceRaysKHR(
                command_buffer,
                &raygen_shader_binding_table,
                &miss_shader_binding_table,
                &hit_shader_binding_table,
                &callable_shader_binding_table,
                width,
                height,
                depth,
            );
        }
        pub fn cmdTraceRaysNV(
            self: Self,
            command_buffer: CommandBuffer,
            raygen_shader_binding_table_buffer: Buffer,
            raygen_shader_binding_offset: DeviceSize,
            miss_shader_binding_table_buffer: Buffer,
            miss_shader_binding_offset: DeviceSize,
            miss_shader_binding_stride: DeviceSize,
            hit_shader_binding_table_buffer: Buffer,
            hit_shader_binding_offset: DeviceSize,
            hit_shader_binding_stride: DeviceSize,
            callable_shader_binding_table_buffer: Buffer,
            callable_shader_binding_offset: DeviceSize,
            callable_shader_binding_stride: DeviceSize,
            width: u32,
            height: u32,
            depth: u32,
        ) void {
            self.dispatch.vkCmdTraceRaysNV(
                command_buffer,
                raygen_shader_binding_table_buffer,
                raygen_shader_binding_offset,
                miss_shader_binding_table_buffer,
                miss_shader_binding_offset,
                miss_shader_binding_stride,
                hit_shader_binding_table_buffer,
                hit_shader_binding_offset,
                hit_shader_binding_stride,
                callable_shader_binding_table_buffer,
                callable_shader_binding_offset,
                callable_shader_binding_stride,
                width,
                height,
                depth,
            );
        }
        pub const GetRayTracingShaderGroupHandlesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getRayTracingShaderGroupHandlesKHR(
            self: Self,
            device: Device,
            pipeline: Pipeline,
            first_group: u32,
            group_count: u32,
            data_size: usize,
            p_data: *c_void,
        ) GetRayTracingShaderGroupHandlesKHRError!void {
            const result = self.dispatch.vkGetRayTracingShaderGroupHandlesKHR(
                device,
                pipeline,
                first_group,
                group_count,
                data_size,
                p_data,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const GetRayTracingCaptureReplayShaderGroupHandlesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getRayTracingCaptureReplayShaderGroupHandlesKHR(
            self: Self,
            device: Device,
            pipeline: Pipeline,
            first_group: u32,
            group_count: u32,
            data_size: usize,
            p_data: *c_void,
        ) GetRayTracingCaptureReplayShaderGroupHandlesKHRError!void {
            const result = self.dispatch.vkGetRayTracingCaptureReplayShaderGroupHandlesKHR(
                device,
                pipeline,
                first_group,
                group_count,
                data_size,
                p_data,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const GetAccelerationStructureHandleNVError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getAccelerationStructureHandleNV(
            self: Self,
            device: Device,
            acceleration_structure: AccelerationStructureNV,
            data_size: usize,
            p_data: *c_void,
        ) GetAccelerationStructureHandleNVError!void {
            const result = self.dispatch.vkGetAccelerationStructureHandleNV(
                device,
                acceleration_structure,
                data_size,
                p_data,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
        }
        pub const CreateRayTracingPipelinesNVError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidShaderNV,
            Unknown,
        };
        pub fn createRayTracingPipelinesNV(
            self: Self,
            device: Device,
            pipeline_cache: PipelineCache,
            create_info_count: u32,
            p_create_infos: [*]const RayTracingPipelineCreateInfoNV,
            p_allocator: ?*const AllocationCallbacks,
            p_pipelines: [*]Pipeline,
        ) CreateRayTracingPipelinesNVError!Result {
            const result = self.dispatch.vkCreateRayTracingPipelinesNV(
                device,
                pipeline_cache,
                create_info_count,
                p_create_infos,
                p_allocator,
                p_pipelines,
            );
            switch (result) {
                Result.success => {},
                Result.pipeline_compile_required_ext => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_shader_nv => return error.InvalidShaderNV,
                else => return error.Unknown,
            }
            return result;
        }
        pub const CreateRayTracingPipelinesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InvalidOpaqueCaptureAddress,
            Unknown,
        };
        pub fn createRayTracingPipelinesKHR(
            self: Self,
            device: Device,
            deferred_operation: DeferredOperationKHR,
            pipeline_cache: PipelineCache,
            create_info_count: u32,
            p_create_infos: [*]const RayTracingPipelineCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
            p_pipelines: [*]Pipeline,
        ) CreateRayTracingPipelinesKHRError!Result {
            const result = self.dispatch.vkCreateRayTracingPipelinesKHR(
                device,
                deferred_operation,
                pipeline_cache,
                create_info_count,
                p_create_infos,
                p_allocator,
                p_pipelines,
            );
            switch (result) {
                Result.success => {},
                Result.operation_deferred_khr => {},
                Result.operation_not_deferred_khr => {},
                Result.pipeline_compile_required_ext => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_invalid_opaque_capture_address => return error.InvalidOpaqueCaptureAddress,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn cmdTraceRaysIndirectKHR(
            self: Self,
            command_buffer: CommandBuffer,
            raygen_shader_binding_table: StridedDeviceAddressRegionKHR,
            miss_shader_binding_table: StridedDeviceAddressRegionKHR,
            hit_shader_binding_table: StridedDeviceAddressRegionKHR,
            callable_shader_binding_table: StridedDeviceAddressRegionKHR,
            indirect_device_address: DeviceAddress,
        ) void {
            self.dispatch.vkCmdTraceRaysIndirectKHR(
                command_buffer,
                &raygen_shader_binding_table,
                &miss_shader_binding_table,
                &hit_shader_binding_table,
                &callable_shader_binding_table,
                indirect_device_address,
            );
        }
        pub fn getDeviceAccelerationStructureCompatibilityKHR(
            self: Self,
            device: Device,
            version_info: AccelerationStructureVersionInfoKHR,
        ) AccelerationStructureCompatibilityKHR {
            var compatibility: AccelerationStructureCompatibilityKHR = undefined;
            self.dispatch.vkGetDeviceAccelerationStructureCompatibilityKHR(
                device,
                &version_info,
                &compatibility,
            );
            return compatibility;
        }
        pub fn getRayTracingShaderGroupStackSizeKHR(
            self: Self,
            device: Device,
            pipeline: Pipeline,
            group: u32,
            group_shader: ShaderGroupShaderKHR,
        ) DeviceSize {
            return self.dispatch.vkGetRayTracingShaderGroupStackSizeKHR(
                device,
                pipeline,
                group,
                group_shader,
            );
        }
        pub fn cmdSetRayTracingPipelineStackSizeKHR(
            self: Self,
            command_buffer: CommandBuffer,
            pipeline_stack_size: u32,
        ) void {
            self.dispatch.vkCmdSetRayTracingPipelineStackSizeKHR(
                command_buffer,
                pipeline_stack_size,
            );
        }
        pub fn getImageViewHandleNVX(
            self: Self,
            device: Device,
            info: ImageViewHandleInfoNVX,
        ) u32 {
            return self.dispatch.vkGetImageViewHandleNVX(
                device,
                &info,
            );
        }
        pub const GetImageViewAddressNVXError = error{
            OutOfHostMemory,
            Unknown,
            Unknown,
        };
        pub fn getImageViewAddressNVX(
            self: Self,
            device: Device,
            image_view: ImageView,
            p_properties: *ImageViewAddressPropertiesNVX,
        ) GetImageViewAddressNVXError!void {
            const result = self.dispatch.vkGetImageViewAddressNVX(
                device,
                image_view,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_unknown => return error.Unknown,
                else => return error.Unknown,
            }
        }
        pub const GetDeviceGroupSurfacePresentModes2EXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn getDeviceGroupSurfacePresentModes2EXT(
            self: Self,
            device: Device,
            surface_info: PhysicalDeviceSurfaceInfo2KHR,
        ) GetDeviceGroupSurfacePresentModes2EXTError!DeviceGroupPresentModeFlagsKHR {
            var modes: DeviceGroupPresentModeFlagsKHR = undefined;
            const result = self.dispatch.vkGetDeviceGroupSurfacePresentModes2EXT(
                device,
                &surface_info,
                &modes,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
            return modes;
        }
        pub const AcquireFullScreenExclusiveModeEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn acquireFullScreenExclusiveModeEXT(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
        ) AcquireFullScreenExclusiveModeEXTError!void {
            const result = self.dispatch.vkAcquireFullScreenExclusiveModeEXT(
                device,
                swapchain,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
        }
        pub const ReleaseFullScreenExclusiveModeEXTError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            SurfaceLostKHR,
            Unknown,
        };
        pub fn releaseFullScreenExclusiveModeEXT(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
        ) ReleaseFullScreenExclusiveModeEXTError!void {
            const result = self.dispatch.vkReleaseFullScreenExclusiveModeEXT(
                device,
                swapchain,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_surface_lost_khr => return error.SurfaceLostKHR,
                else => return error.Unknown,
            }
        }
        pub const AcquireProfilingLockKHRError = error{
            OutOfHostMemory,
            Timeout,
            Unknown,
        };
        pub fn acquireProfilingLockKHR(
            self: Self,
            device: Device,
            info: AcquireProfilingLockInfoKHR,
        ) AcquireProfilingLockKHRError!void {
            const result = self.dispatch.vkAcquireProfilingLockKHR(
                device,
                &info,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.timeout => return error.Timeout,
                else => return error.Unknown,
            }
        }
        pub fn releaseProfilingLockKHR(
            self: Self,
            device: Device,
        ) void {
            self.dispatch.vkReleaseProfilingLockKHR(
                device,
            );
        }
        pub const GetImageDrmFormatModifierPropertiesEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn getImageDrmFormatModifierPropertiesEXT(
            self: Self,
            device: Device,
            image: Image,
            p_properties: *ImageDrmFormatModifierPropertiesEXT,
        ) GetImageDrmFormatModifierPropertiesEXTError!void {
            const result = self.dispatch.vkGetImageDrmFormatModifierPropertiesEXT(
                device,
                image,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub fn getBufferOpaqueCaptureAddress(
            self: Self,
            device: Device,
            info: BufferDeviceAddressInfo,
        ) u64 {
            return self.dispatch.vkGetBufferOpaqueCaptureAddress(
                device,
                &info,
            );
        }
        pub fn getBufferDeviceAddress(
            self: Self,
            device: Device,
            info: BufferDeviceAddressInfo,
        ) DeviceAddress {
            return self.dispatch.vkGetBufferDeviceAddress(
                device,
                &info,
            );
        }
        pub const InitializePerformanceApiINTELError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn initializePerformanceApiINTEL(
            self: Self,
            device: Device,
            initialize_info: InitializePerformanceApiInfoINTEL,
        ) InitializePerformanceApiINTELError!void {
            const result = self.dispatch.vkInitializePerformanceApiINTEL(
                device,
                &initialize_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub fn uninitializePerformanceApiINTEL(
            self: Self,
            device: Device,
        ) void {
            self.dispatch.vkUninitializePerformanceApiINTEL(
                device,
            );
        }
        pub const CmdSetPerformanceMarkerINTELError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn cmdSetPerformanceMarkerINTEL(
            self: Self,
            command_buffer: CommandBuffer,
            marker_info: PerformanceMarkerInfoINTEL,
        ) CmdSetPerformanceMarkerINTELError!void {
            const result = self.dispatch.vkCmdSetPerformanceMarkerINTEL(
                command_buffer,
                &marker_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const CmdSetPerformanceStreamMarkerINTELError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn cmdSetPerformanceStreamMarkerINTEL(
            self: Self,
            command_buffer: CommandBuffer,
            marker_info: PerformanceStreamMarkerInfoINTEL,
        ) CmdSetPerformanceStreamMarkerINTELError!void {
            const result = self.dispatch.vkCmdSetPerformanceStreamMarkerINTEL(
                command_buffer,
                &marker_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const CmdSetPerformanceOverrideINTELError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn cmdSetPerformanceOverrideINTEL(
            self: Self,
            command_buffer: CommandBuffer,
            override_info: PerformanceOverrideInfoINTEL,
        ) CmdSetPerformanceOverrideINTELError!void {
            const result = self.dispatch.vkCmdSetPerformanceOverrideINTEL(
                command_buffer,
                &override_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const AcquirePerformanceConfigurationINTELError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn acquirePerformanceConfigurationINTEL(
            self: Self,
            device: Device,
            acquire_info: PerformanceConfigurationAcquireInfoINTEL,
        ) AcquirePerformanceConfigurationINTELError!PerformanceConfigurationINTEL {
            var configuration: PerformanceConfigurationINTEL = undefined;
            const result = self.dispatch.vkAcquirePerformanceConfigurationINTEL(
                device,
                &acquire_info,
                &configuration,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return configuration;
        }
        pub const ReleasePerformanceConfigurationINTELError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn releasePerformanceConfigurationINTEL(
            self: Self,
            device: Device,
            configuration: PerformanceConfigurationINTEL,
        ) ReleasePerformanceConfigurationINTELError!void {
            const result = self.dispatch.vkReleasePerformanceConfigurationINTEL(
                device,
                configuration,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const QueueSetPerformanceConfigurationINTELError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn queueSetPerformanceConfigurationINTEL(
            self: Self,
            queue: Queue,
            configuration: PerformanceConfigurationINTEL,
        ) QueueSetPerformanceConfigurationINTELError!void {
            const result = self.dispatch.vkQueueSetPerformanceConfigurationINTEL(
                queue,
                configuration,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub const GetPerformanceParameterINTELError = error{
            TooManyObjects,
            OutOfHostMemory,
            Unknown,
        };
        pub fn getPerformanceParameterINTEL(
            self: Self,
            device: Device,
            parameter: PerformanceParameterTypeINTEL,
        ) GetPerformanceParameterINTELError!PerformanceValueINTEL {
            var value: PerformanceValueINTEL = undefined;
            const result = self.dispatch.vkGetPerformanceParameterINTEL(
                device,
                parameter,
                &value,
            );
            switch (result) {
                Result.success => {},
                Result.error_too_many_objects => return error.TooManyObjects,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return value;
        }
        pub fn getDeviceMemoryOpaqueCaptureAddress(
            self: Self,
            device: Device,
            info: DeviceMemoryOpaqueCaptureAddressInfo,
        ) u64 {
            return self.dispatch.vkGetDeviceMemoryOpaqueCaptureAddress(
                device,
                &info,
            );
        }
        pub const GetPipelineExecutablePropertiesKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPipelineExecutablePropertiesKHR(
            self: Self,
            device: Device,
            pipeline_info: PipelineInfoKHR,
            p_executable_count: *u32,
            p_properties: ?[*]PipelineExecutablePropertiesKHR,
        ) GetPipelineExecutablePropertiesKHRError!Result {
            const result = self.dispatch.vkGetPipelineExecutablePropertiesKHR(
                device,
                &pipeline_info,
                p_executable_count,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPipelineExecutableStatisticsKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPipelineExecutableStatisticsKHR(
            self: Self,
            device: Device,
            executable_info: PipelineExecutableInfoKHR,
            p_statistic_count: *u32,
            p_statistics: ?[*]PipelineExecutableStatisticKHR,
        ) GetPipelineExecutableStatisticsKHRError!Result {
            const result = self.dispatch.vkGetPipelineExecutableStatisticsKHR(
                device,
                &executable_info,
                p_statistic_count,
                p_statistics,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub const GetPipelineExecutableInternalRepresentationsKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn getPipelineExecutableInternalRepresentationsKHR(
            self: Self,
            device: Device,
            executable_info: PipelineExecutableInfoKHR,
            p_internal_representation_count: *u32,
            p_internal_representations: ?[*]PipelineExecutableInternalRepresentationKHR,
        ) GetPipelineExecutableInternalRepresentationsKHRError!Result {
            const result = self.dispatch.vkGetPipelineExecutableInternalRepresentationsKHR(
                device,
                &executable_info,
                p_internal_representation_count,
                p_internal_representations,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn cmdSetLineStippleEXT(
            self: Self,
            command_buffer: CommandBuffer,
            line_stipple_factor: u32,
            line_stipple_pattern: u16,
        ) void {
            self.dispatch.vkCmdSetLineStippleEXT(
                command_buffer,
                line_stipple_factor,
                line_stipple_pattern,
            );
        }
        pub const CreateAccelerationStructureKHRError = error{
            OutOfHostMemory,
            InvalidOpaqueCaptureAddressKHR,
            Unknown,
        };
        pub fn createAccelerationStructureKHR(
            self: Self,
            device: Device,
            create_info: AccelerationStructureCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateAccelerationStructureKHRError!AccelerationStructureKHR {
            var acceleration_structure: AccelerationStructureKHR = undefined;
            const result = self.dispatch.vkCreateAccelerationStructureKHR(
                device,
                &create_info,
                p_allocator,
                &acceleration_structure,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_opaque_capture_address_khr => return error.InvalidOpaqueCaptureAddressKHR,
                else => return error.Unknown,
            }
            return acceleration_structure;
        }
        pub fn cmdBuildAccelerationStructuresKHR(
            self: Self,
            command_buffer: CommandBuffer,
            info_count: u32,
            p_infos: [*]const AccelerationStructureBuildGeometryInfoKHR,
            pp_build_range_infos: [*]const *const AccelerationStructureBuildRangeInfoKHR,
        ) void {
            self.dispatch.vkCmdBuildAccelerationStructuresKHR(
                command_buffer,
                info_count,
                p_infos,
                pp_build_range_infos,
            );
        }
        pub fn cmdBuildAccelerationStructuresIndirectKHR(
            self: Self,
            command_buffer: CommandBuffer,
            info_count: u32,
            p_infos: [*]const AccelerationStructureBuildGeometryInfoKHR,
            p_indirect_device_addresses: [*]const DeviceAddress,
            p_indirect_strides: [*]const u32,
            pp_max_primitive_counts: [*]const *const u32,
        ) void {
            self.dispatch.vkCmdBuildAccelerationStructuresIndirectKHR(
                command_buffer,
                info_count,
                p_infos,
                p_indirect_device_addresses,
                p_indirect_strides,
                pp_max_primitive_counts,
            );
        }
        pub const BuildAccelerationStructuresKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn buildAccelerationStructuresKHR(
            self: Self,
            device: Device,
            deferred_operation: DeferredOperationKHR,
            info_count: u32,
            p_infos: [*]const AccelerationStructureBuildGeometryInfoKHR,
            pp_build_range_infos: [*]const *const AccelerationStructureBuildRangeInfoKHR,
        ) BuildAccelerationStructuresKHRError!Result {
            const result = self.dispatch.vkBuildAccelerationStructuresKHR(
                device,
                deferred_operation,
                info_count,
                p_infos,
                pp_build_range_infos,
            );
            switch (result) {
                Result.success => {},
                Result.operation_deferred_khr => {},
                Result.operation_not_deferred_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn getAccelerationStructureDeviceAddressKHR(
            self: Self,
            device: Device,
            info: AccelerationStructureDeviceAddressInfoKHR,
        ) DeviceAddress {
            return self.dispatch.vkGetAccelerationStructureDeviceAddressKHR(
                device,
                &info,
            );
        }
        pub const CreateDeferredOperationKHRError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn createDeferredOperationKHR(
            self: Self,
            device: Device,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateDeferredOperationKHRError!DeferredOperationKHR {
            var deferred_operation: DeferredOperationKHR = undefined;
            const result = self.dispatch.vkCreateDeferredOperationKHR(
                device,
                p_allocator,
                &deferred_operation,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return deferred_operation;
        }
        pub fn destroyDeferredOperationKHR(
            self: Self,
            device: Device,
            operation: DeferredOperationKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyDeferredOperationKHR(
                device,
                operation,
                p_allocator,
            );
        }
        pub fn getDeferredOperationMaxConcurrencyKHR(
            self: Self,
            device: Device,
            operation: DeferredOperationKHR,
        ) u32 {
            return self.dispatch.vkGetDeferredOperationMaxConcurrencyKHR(
                device,
                operation,
            );
        }
        pub fn getDeferredOperationResultKHR(
            self: Self,
            device: Device,
            operation: DeferredOperationKHR,
        ) Result {
            const result = self.dispatch.vkGetDeferredOperationResultKHR(
                device,
                operation,
            );
            switch (result) {
                Result.success => {},
                Result.not_ready => {},
                else => return error.Unknown,
            }
            return result;
        }
        pub const DeferredOperationJoinKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            Unknown,
        };
        pub fn deferredOperationJoinKHR(
            self: Self,
            device: Device,
            operation: DeferredOperationKHR,
        ) DeferredOperationJoinKHRError!Result {
            const result = self.dispatch.vkDeferredOperationJoinKHR(
                device,
                operation,
            );
            switch (result) {
                Result.success => {},
                Result.thread_done_khr => {},
                Result.thread_idle_khr => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                else => return error.Unknown,
            }
            return result;
        }
        pub fn cmdSetCullModeEXT(
            self: Self,
            command_buffer: CommandBuffer,
            cull_mode: CullModeFlags,
        ) void {
            self.dispatch.vkCmdSetCullModeEXT(
                command_buffer,
                cull_mode.toInt(),
            );
        }
        pub fn cmdSetFrontFaceEXT(
            self: Self,
            command_buffer: CommandBuffer,
            front_face: FrontFace,
        ) void {
            self.dispatch.vkCmdSetFrontFaceEXT(
                command_buffer,
                front_face,
            );
        }
        pub fn cmdSetPrimitiveTopologyEXT(
            self: Self,
            command_buffer: CommandBuffer,
            primitive_topology: PrimitiveTopology,
        ) void {
            self.dispatch.vkCmdSetPrimitiveTopologyEXT(
                command_buffer,
                primitive_topology,
            );
        }
        pub fn cmdSetViewportWithCountEXT(
            self: Self,
            command_buffer: CommandBuffer,
            viewport_count: u32,
            p_viewports: [*]const Viewport,
        ) void {
            self.dispatch.vkCmdSetViewportWithCountEXT(
                command_buffer,
                viewport_count,
                p_viewports,
            );
        }
        pub fn cmdSetScissorWithCountEXT(
            self: Self,
            command_buffer: CommandBuffer,
            scissor_count: u32,
            p_scissors: [*]const Rect2D,
        ) void {
            self.dispatch.vkCmdSetScissorWithCountEXT(
                command_buffer,
                scissor_count,
                p_scissors,
            );
        }
        pub fn cmdBindVertexBuffers2EXT(
            self: Self,
            command_buffer: CommandBuffer,
            first_binding: u32,
            binding_count: u32,
            p_buffers: [*]const Buffer,
            p_offsets: [*]const DeviceSize,
            p_sizes: ?[*]const DeviceSize,
            p_strides: ?[*]const DeviceSize,
        ) void {
            self.dispatch.vkCmdBindVertexBuffers2EXT(
                command_buffer,
                first_binding,
                binding_count,
                p_buffers,
                p_offsets,
                p_sizes,
                p_strides,
            );
        }
        pub fn cmdSetDepthTestEnableEXT(
            self: Self,
            command_buffer: CommandBuffer,
            depth_test_enable: Bool32,
        ) void {
            self.dispatch.vkCmdSetDepthTestEnableEXT(
                command_buffer,
                depth_test_enable,
            );
        }
        pub fn cmdSetDepthWriteEnableEXT(
            self: Self,
            command_buffer: CommandBuffer,
            depth_write_enable: Bool32,
        ) void {
            self.dispatch.vkCmdSetDepthWriteEnableEXT(
                command_buffer,
                depth_write_enable,
            );
        }
        pub fn cmdSetDepthCompareOpEXT(
            self: Self,
            command_buffer: CommandBuffer,
            depth_compare_op: CompareOp,
        ) void {
            self.dispatch.vkCmdSetDepthCompareOpEXT(
                command_buffer,
                depth_compare_op,
            );
        }
        pub fn cmdSetDepthBoundsTestEnableEXT(
            self: Self,
            command_buffer: CommandBuffer,
            depth_bounds_test_enable: Bool32,
        ) void {
            self.dispatch.vkCmdSetDepthBoundsTestEnableEXT(
                command_buffer,
                depth_bounds_test_enable,
            );
        }
        pub fn cmdSetStencilTestEnableEXT(
            self: Self,
            command_buffer: CommandBuffer,
            stencil_test_enable: Bool32,
        ) void {
            self.dispatch.vkCmdSetStencilTestEnableEXT(
                command_buffer,
                stencil_test_enable,
            );
        }
        pub fn cmdSetStencilOpEXT(
            self: Self,
            command_buffer: CommandBuffer,
            face_mask: StencilFaceFlags,
            fail_op: StencilOp,
            pass_op: StencilOp,
            depth_fail_op: StencilOp,
            compare_op: CompareOp,
        ) void {
            self.dispatch.vkCmdSetStencilOpEXT(
                command_buffer,
                face_mask.toInt(),
                fail_op,
                pass_op,
                depth_fail_op,
                compare_op,
            );
        }
        pub fn cmdSetPatchControlPointsEXT(
            self: Self,
            command_buffer: CommandBuffer,
            patch_control_points: u32,
        ) void {
            self.dispatch.vkCmdSetPatchControlPointsEXT(
                command_buffer,
                patch_control_points,
            );
        }
        pub fn cmdSetRasterizerDiscardEnableEXT(
            self: Self,
            command_buffer: CommandBuffer,
            rasterizer_discard_enable: Bool32,
        ) void {
            self.dispatch.vkCmdSetRasterizerDiscardEnableEXT(
                command_buffer,
                rasterizer_discard_enable,
            );
        }
        pub fn cmdSetDepthBiasEnableEXT(
            self: Self,
            command_buffer: CommandBuffer,
            depth_bias_enable: Bool32,
        ) void {
            self.dispatch.vkCmdSetDepthBiasEnableEXT(
                command_buffer,
                depth_bias_enable,
            );
        }
        pub fn cmdSetLogicOpEXT(
            self: Self,
            command_buffer: CommandBuffer,
            logic_op: LogicOp,
        ) void {
            self.dispatch.vkCmdSetLogicOpEXT(
                command_buffer,
                logic_op,
            );
        }
        pub fn cmdSetPrimitiveRestartEnableEXT(
            self: Self,
            command_buffer: CommandBuffer,
            primitive_restart_enable: Bool32,
        ) void {
            self.dispatch.vkCmdSetPrimitiveRestartEnableEXT(
                command_buffer,
                primitive_restart_enable,
            );
        }
        pub const CreatePrivateDataSlotEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn createPrivateDataSlotEXT(
            self: Self,
            device: Device,
            create_info: PrivateDataSlotCreateInfoEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) CreatePrivateDataSlotEXTError!PrivateDataSlotEXT {
            var private_data_slot: PrivateDataSlotEXT = undefined;
            const result = self.dispatch.vkCreatePrivateDataSlotEXT(
                device,
                &create_info,
                p_allocator,
                &private_data_slot,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
            return private_data_slot;
        }
        pub fn destroyPrivateDataSlotEXT(
            self: Self,
            device: Device,
            private_data_slot: PrivateDataSlotEXT,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyPrivateDataSlotEXT(
                device,
                private_data_slot,
                p_allocator,
            );
        }
        pub const SetPrivateDataEXTError = error{
            OutOfHostMemory,
            Unknown,
        };
        pub fn setPrivateDataEXT(
            self: Self,
            device: Device,
            object_type: ObjectType,
            object_handle: u64,
            private_data_slot: PrivateDataSlotEXT,
            data: u64,
        ) SetPrivateDataEXTError!void {
            const result = self.dispatch.vkSetPrivateDataEXT(
                device,
                object_type,
                object_handle,
                private_data_slot,
                data,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                else => return error.Unknown,
            }
        }
        pub fn getPrivateDataEXT(
            self: Self,
            device: Device,
            object_type: ObjectType,
            object_handle: u64,
            private_data_slot: PrivateDataSlotEXT,
        ) u64 {
            var data: u64 = undefined;
            self.dispatch.vkGetPrivateDataEXT(
                device,
                object_type,
                object_handle,
                private_data_slot,
                &data,
            );
            return data;
        }
        pub fn cmdCopyBuffer2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            copy_buffer_info: CopyBufferInfo2KHR,
        ) void {
            self.dispatch.vkCmdCopyBuffer2KHR(
                command_buffer,
                &copy_buffer_info,
            );
        }
        pub fn cmdCopyImage2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            copy_image_info: CopyImageInfo2KHR,
        ) void {
            self.dispatch.vkCmdCopyImage2KHR(
                command_buffer,
                &copy_image_info,
            );
        }
        pub fn cmdBlitImage2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            blit_image_info: BlitImageInfo2KHR,
        ) void {
            self.dispatch.vkCmdBlitImage2KHR(
                command_buffer,
                &blit_image_info,
            );
        }
        pub fn cmdCopyBufferToImage2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            copy_buffer_to_image_info: CopyBufferToImageInfo2KHR,
        ) void {
            self.dispatch.vkCmdCopyBufferToImage2KHR(
                command_buffer,
                &copy_buffer_to_image_info,
            );
        }
        pub fn cmdCopyImageToBuffer2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            copy_image_to_buffer_info: CopyImageToBufferInfo2KHR,
        ) void {
            self.dispatch.vkCmdCopyImageToBuffer2KHR(
                command_buffer,
                &copy_image_to_buffer_info,
            );
        }
        pub fn cmdResolveImage2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            resolve_image_info: ResolveImageInfo2KHR,
        ) void {
            self.dispatch.vkCmdResolveImage2KHR(
                command_buffer,
                &resolve_image_info,
            );
        }
        pub fn cmdSetFragmentShadingRateKHR(
            self: Self,
            command_buffer: CommandBuffer,
            fragment_size: Extent2D,
            combiner_ops: [2]FragmentShadingRateCombinerOpKHR,
        ) void {
            self.dispatch.vkCmdSetFragmentShadingRateKHR(
                command_buffer,
                &fragment_size,
                combiner_ops,
            );
        }
        pub fn cmdSetFragmentShadingRateEnumNV(
            self: Self,
            command_buffer: CommandBuffer,
            shading_rate: FragmentShadingRateNV,
            combiner_ops: [2]FragmentShadingRateCombinerOpKHR,
        ) void {
            self.dispatch.vkCmdSetFragmentShadingRateEnumNV(
                command_buffer,
                shading_rate,
                combiner_ops,
            );
        }
        pub fn getAccelerationStructureBuildSizesKHR(
            self: Self,
            device: Device,
            build_type: AccelerationStructureBuildTypeKHR,
            build_info: AccelerationStructureBuildGeometryInfoKHR,
            p_max_primitive_counts: ?[*]const u32,
            p_size_info: *AccelerationStructureBuildSizesInfoKHR,
        ) void {
            self.dispatch.vkGetAccelerationStructureBuildSizesKHR(
                device,
                build_type,
                &build_info,
                p_max_primitive_counts,
                p_size_info,
            );
        }
        pub fn cmdSetVertexInputEXT(
            self: Self,
            command_buffer: CommandBuffer,
            vertex_binding_description_count: u32,
            p_vertex_binding_descriptions: [*]const VertexInputBindingDescription2EXT,
            vertex_attribute_description_count: u32,
            p_vertex_attribute_descriptions: [*]const VertexInputAttributeDescription2EXT,
        ) void {
            self.dispatch.vkCmdSetVertexInputEXT(
                command_buffer,
                vertex_binding_description_count,
                p_vertex_binding_descriptions,
                vertex_attribute_description_count,
                p_vertex_attribute_descriptions,
            );
        }
        pub fn cmdSetColorWriteEnableEXT(
            self: Self,
            command_buffer: CommandBuffer,
            attachment_count: u32,
            p_color_write_enables: [*]const Bool32,
        ) void {
            self.dispatch.vkCmdSetColorWriteEnableEXT(
                command_buffer,
                attachment_count,
                p_color_write_enables,
            );
        }
        pub fn cmdSetEvent2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            event: Event,
            dependency_info: DependencyInfoKHR,
        ) void {
            self.dispatch.vkCmdSetEvent2KHR(
                command_buffer,
                event,
                &dependency_info,
            );
        }
        pub fn cmdResetEvent2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            event: Event,
            stage_mask: PipelineStageFlags2KHR,
        ) void {
            self.dispatch.vkCmdResetEvent2KHR(
                command_buffer,
                event,
                stage_mask,
            );
        }
        pub fn cmdWaitEvents2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            event_count: u32,
            p_events: [*]const Event,
            p_dependency_infos: [*]const DependencyInfoKHR,
        ) void {
            self.dispatch.vkCmdWaitEvents2KHR(
                command_buffer,
                event_count,
                p_events,
                p_dependency_infos,
            );
        }
        pub fn cmdPipelineBarrier2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            dependency_info: DependencyInfoKHR,
        ) void {
            self.dispatch.vkCmdPipelineBarrier2KHR(
                command_buffer,
                &dependency_info,
            );
        }
        pub const QueueSubmit2KHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn queueSubmit2KHR(
            self: Self,
            queue: Queue,
            submit_count: u32,
            p_submits: [*]const SubmitInfo2KHR,
            fence: Fence,
        ) QueueSubmit2KHRError!void {
            const result = self.dispatch.vkQueueSubmit2KHR(
                queue,
                submit_count,
                p_submits,
                fence,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
        }
        pub fn cmdWriteTimestamp2KHR(
            self: Self,
            command_buffer: CommandBuffer,
            stage: PipelineStageFlags2KHR,
            query_pool: QueryPool,
            query: u32,
        ) void {
            self.dispatch.vkCmdWriteTimestamp2KHR(
                command_buffer,
                stage,
                query_pool,
                query,
            );
        }
        pub fn cmdWriteBufferMarker2AMD(
            self: Self,
            command_buffer: CommandBuffer,
            stage: PipelineStageFlags2KHR,
            dst_buffer: Buffer,
            dst_offset: DeviceSize,
            marker: u32,
        ) void {
            self.dispatch.vkCmdWriteBufferMarker2AMD(
                command_buffer,
                stage,
                dst_buffer,
                dst_offset,
                marker,
            );
        }
        pub fn getQueueCheckpointData2NV(
            self: Self,
            queue: Queue,
            p_checkpoint_data_count: *u32,
            p_checkpoint_data: ?[*]CheckpointData2NV,
        ) void {
            self.dispatch.vkGetQueueCheckpointData2NV(
                queue,
                p_checkpoint_data_count,
                p_checkpoint_data,
            );
        }
        pub const CreateVideoSessionKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            IncompatibleDriver,
            FeatureNotPresent,
            Unknown,
        };
        pub fn createVideoSessionKHR(
            self: Self,
            device: Device,
            create_info: VideoSessionCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateVideoSessionKHRError!VideoSessionKHR {
            var video_session: VideoSessionKHR = undefined;
            const result = self.dispatch.vkCreateVideoSessionKHR(
                device,
                &create_info,
                p_allocator,
                &video_session,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_incompatible_driver => return error.IncompatibleDriver,
                Result.error_feature_not_present => return error.FeatureNotPresent,
                else => return error.Unknown,
            }
            return video_session;
        }
        pub fn destroyVideoSessionKHR(
            self: Self,
            device: Device,
            video_session: VideoSessionKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyVideoSessionKHR(
                device,
                video_session,
                p_allocator,
            );
        }
        pub const CreateVideoSessionParametersKHRError = error{
            InitializationFailed,
            OutOfHostMemory,
            OutOfDeviceMemory,
            TooManyObjects,
            Unknown,
        };
        pub fn createVideoSessionParametersKHR(
            self: Self,
            device: Device,
            create_info: VideoSessionParametersCreateInfoKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateVideoSessionParametersKHRError!VideoSessionParametersKHR {
            var video_session_parameters: VideoSessionParametersKHR = undefined;
            const result = self.dispatch.vkCreateVideoSessionParametersKHR(
                device,
                &create_info,
                p_allocator,
                &video_session_parameters,
            );
            switch (result) {
                Result.success => {},
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_too_many_objects => return error.TooManyObjects,
                else => return error.Unknown,
            }
            return video_session_parameters;
        }
        pub const UpdateVideoSessionParametersKHRError = error{
            InitializationFailed,
            TooManyObjects,
            Unknown,
        };
        pub fn updateVideoSessionParametersKHR(
            self: Self,
            device: Device,
            video_session_parameters: VideoSessionParametersKHR,
            update_info: VideoSessionParametersUpdateInfoKHR,
        ) UpdateVideoSessionParametersKHRError!void {
            const result = self.dispatch.vkUpdateVideoSessionParametersKHR(
                device,
                video_session_parameters,
                &update_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_too_many_objects => return error.TooManyObjects,
                else => return error.Unknown,
            }
        }
        pub fn destroyVideoSessionParametersKHR(
            self: Self,
            device: Device,
            video_session_parameters: VideoSessionParametersKHR,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyVideoSessionParametersKHR(
                device,
                video_session_parameters,
                p_allocator,
            );
        }
        pub const GetVideoSessionMemoryRequirementsKHRError = error{
            InitializationFailed,
            Unknown,
        };
        pub fn getVideoSessionMemoryRequirementsKHR(
            self: Self,
            device: Device,
            video_session: VideoSessionKHR,
            p_video_session_memory_requirements_count: *u32,
            p_video_session_memory_requirements: ?[*]VideoGetMemoryPropertiesKHR,
        ) GetVideoSessionMemoryRequirementsKHRError!Result {
            const result = self.dispatch.vkGetVideoSessionMemoryRequirementsKHR(
                device,
                video_session,
                p_video_session_memory_requirements_count,
                p_video_session_memory_requirements,
            );
            switch (result) {
                Result.success => {},
                Result.incomplete => {},
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return result;
        }
        pub const BindVideoSessionMemoryKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn bindVideoSessionMemoryKHR(
            self: Self,
            device: Device,
            video_session: VideoSessionKHR,
            video_session_bind_memory_count: u32,
            p_video_session_bind_memories: [*]const VideoBindMemoryKHR,
        ) BindVideoSessionMemoryKHRError!void {
            const result = self.dispatch.vkBindVideoSessionMemoryKHR(
                device,
                video_session,
                video_session_bind_memory_count,
                p_video_session_bind_memories,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
        }
        pub fn cmdDecodeVideoKHR(
            self: Self,
            command_buffer: CommandBuffer,
            frame_info: VideoDecodeInfoKHR,
        ) void {
            self.dispatch.vkCmdDecodeVideoKHR(
                command_buffer,
                &frame_info,
            );
        }
        pub fn cmdBeginVideoCodingKHR(
            self: Self,
            command_buffer: CommandBuffer,
            begin_info: VideoBeginCodingInfoKHR,
        ) void {
            self.dispatch.vkCmdBeginVideoCodingKHR(
                command_buffer,
                &begin_info,
            );
        }
        pub fn cmdControlVideoCodingKHR(
            self: Self,
            command_buffer: CommandBuffer,
            coding_control_info: VideoCodingControlInfoKHR,
        ) void {
            self.dispatch.vkCmdControlVideoCodingKHR(
                command_buffer,
                &coding_control_info,
            );
        }
        pub fn cmdEndVideoCodingKHR(
            self: Self,
            command_buffer: CommandBuffer,
            end_coding_info: VideoEndCodingInfoKHR,
        ) void {
            self.dispatch.vkCmdEndVideoCodingKHR(
                command_buffer,
                &end_coding_info,
            );
        }
        pub fn cmdEncodeVideoKHR(
            self: Self,
            command_buffer: CommandBuffer,
            encode_info: VideoEncodeInfoKHR,
        ) void {
            self.dispatch.vkCmdEncodeVideoKHR(
                command_buffer,
                &encode_info,
            );
        }
        pub const CreateCuModuleNVXError = error{
            OutOfHostMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn createCuModuleNVX(
            self: Self,
            device: Device,
            create_info: CuModuleCreateInfoNVX,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateCuModuleNVXError!CuModuleNVX {
            var module: CuModuleNVX = undefined;
            const result = self.dispatch.vkCreateCuModuleNVX(
                device,
                &create_info,
                p_allocator,
                &module,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return module;
        }
        pub const CreateCuFunctionNVXError = error{
            OutOfHostMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn createCuFunctionNVX(
            self: Self,
            device: Device,
            create_info: CuFunctionCreateInfoNVX,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateCuFunctionNVXError!CuFunctionNVX {
            var function: CuFunctionNVX = undefined;
            const result = self.dispatch.vkCreateCuFunctionNVX(
                device,
                &create_info,
                p_allocator,
                &function,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return function;
        }
        pub fn destroyCuModuleNVX(
            self: Self,
            device: Device,
            module: CuModuleNVX,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyCuModuleNVX(
                device,
                module,
                p_allocator,
            );
        }
        pub fn destroyCuFunctionNVX(
            self: Self,
            device: Device,
            function: CuFunctionNVX,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyCuFunctionNVX(
                device,
                function,
                p_allocator,
            );
        }
        pub fn cmdCuLaunchKernelNVX(
            self: Self,
            command_buffer: CommandBuffer,
            launch_info: CuLaunchInfoNVX,
        ) void {
            self.dispatch.vkCmdCuLaunchKernelNVX(
                command_buffer,
                &launch_info,
            );
        }
        pub fn setDeviceMemoryPriorityEXT(
            self: Self,
            device: Device,
            memory: DeviceMemory,
            priority: f32,
        ) void {
            self.dispatch.vkSetDeviceMemoryPriorityEXT(
                device,
                memory,
                priority,
            );
        }
        pub const WaitForPresentKHRError = error{
            OutOfHostMemory,
            OutOfDeviceMemory,
            DeviceLost,
            Unknown,
        };
        pub fn waitForPresentKHR(
            self: Self,
            device: Device,
            swapchain: SwapchainKHR,
            present_id: u64,
            timeout: u64,
        ) WaitForPresentKHRError!Result {
            const result = self.dispatch.vkWaitForPresentKHR(
                device,
                swapchain,
                present_id,
                timeout,
            );
            switch (result) {
                Result.success => {},
                Result.timeout => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_out_of_device_memory => return error.OutOfDeviceMemory,
                Result.error_device_lost => return error.DeviceLost,
                else => return error.Unknown,
            }
            return result;
        }
        pub const CreateBufferCollectionFUCHSIAError = error{
            OutOfHostMemory,
            InvalidExternalHandle,
            InitializationFailed,
            Unknown,
        };
        pub fn createBufferCollectionFUCHSIA(
            self: Self,
            device: Device,
            create_info: BufferCollectionCreateInfoFUCHSIA,
            p_allocator: ?*const AllocationCallbacks,
        ) CreateBufferCollectionFUCHSIAError!BufferCollectionFUCHSIA {
            var collection: BufferCollectionFUCHSIA = undefined;
            const result = self.dispatch.vkCreateBufferCollectionFUCHSIA(
                device,
                &create_info,
                p_allocator,
                &collection,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_invalid_external_handle => return error.InvalidExternalHandle,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
            return collection;
        }
        pub const SetBufferCollectionBufferConstraintsFUCHSIAError = error{
            InitializationFailed,
            OutOfHostMemory,
            FormatNotSupported,
            Unknown,
        };
        pub fn setBufferCollectionBufferConstraintsFUCHSIA(
            self: Self,
            device: Device,
            collection: BufferCollectionFUCHSIA,
            buffer_constraints_info: BufferConstraintsInfoFUCHSIA,
        ) SetBufferCollectionBufferConstraintsFUCHSIAError!void {
            const result = self.dispatch.vkSetBufferCollectionBufferConstraintsFUCHSIA(
                device,
                collection,
                &buffer_constraints_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_format_not_supported => return error.FormatNotSupported,
                else => return error.Unknown,
            }
        }
        pub const SetBufferCollectionImageConstraintsFUCHSIAError = error{
            InitializationFailed,
            OutOfHostMemory,
            FormatNotSupported,
            Unknown,
        };
        pub fn setBufferCollectionImageConstraintsFUCHSIA(
            self: Self,
            device: Device,
            collection: BufferCollectionFUCHSIA,
            image_constraints_info: ImageConstraintsInfoFUCHSIA,
        ) SetBufferCollectionImageConstraintsFUCHSIAError!void {
            const result = self.dispatch.vkSetBufferCollectionImageConstraintsFUCHSIA(
                device,
                collection,
                &image_constraints_info,
            );
            switch (result) {
                Result.success => {},
                Result.error_initialization_failed => return error.InitializationFailed,
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_format_not_supported => return error.FormatNotSupported,
                else => return error.Unknown,
            }
        }
        pub fn destroyBufferCollectionFUCHSIA(
            self: Self,
            device: Device,
            collection: BufferCollectionFUCHSIA,
            p_allocator: ?*const AllocationCallbacks,
        ) void {
            self.dispatch.vkDestroyBufferCollectionFUCHSIA(
                device,
                collection,
                p_allocator,
            );
        }
        pub const GetBufferCollectionPropertiesFUCHSIAError = error{
            OutOfHostMemory,
            InitializationFailed,
            Unknown,
        };
        pub fn getBufferCollectionPropertiesFUCHSIA(
            self: Self,
            device: Device,
            collection: BufferCollectionFUCHSIA,
            p_properties: *BufferCollectionPropertiesFUCHSIA,
        ) GetBufferCollectionPropertiesFUCHSIAError!void {
            const result = self.dispatch.vkGetBufferCollectionPropertiesFUCHSIA(
                device,
                collection,
                p_properties,
            );
            switch (result) {
                Result.success => {},
                Result.error_out_of_host_memory => return error.OutOfHostMemory,
                Result.error_initialization_failed => return error.InitializationFailed,
                else => return error.Unknown,
            }
        }
        pub fn cmdBeginRenderingKHR(
            self: Self,
            command_buffer: CommandBuffer,
            rendering_info: RenderingInfoKHR,
        ) void {
            self.dispatch.vkCmdBeginRenderingKHR(
                command_buffer,
                &rendering_info,
            );
        }
        pub fn cmdEndRenderingKHR(
            self: Self,
            command_buffer: CommandBuffer,
        ) void {
            self.dispatch.vkCmdEndRenderingKHR(
                command_buffer,
            );
        }
    };
}
