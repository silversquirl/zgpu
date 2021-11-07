// This file contains zgpu extensions to the webgpu-native API

#ifndef ZGPU_H_
#define ZGPU_H_

#include "webgpu-headers/webgpu.h"

enum ZGPUExtraSType {
	WGPUSType_SurfaceDescriptorFromGlfwWindow = 0x07000000,
};

typedef struct WGPUSurfaceDescriptorFromGlfwWindow {
	WGPUChainedStruct chain;
	void *glfwWindow;
} WGPUSurfaceDescriptorFromGlfwWindow;

WGPU_EXPORT void wgpuAdapterDestroy(WGPUAdapter adapter);
WGPU_EXPORT void wgpuInstanceDestroy(WGPUInstance instance);

#endif // ZGPU_H_
