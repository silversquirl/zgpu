// This file contains zgpu extensions to the webgpu-native API

#ifndef ZGPU_H_
#define ZGPU_H_

#include "webgpu-headers/webgpu.h"

WGPU_EXPORT void wgpuAdapterDestroy(WGPUAdapter *adapter);
WGPU_EXPORT void wgpuDeviceDestroy(WGPUDevice *device);
WGPU_EXPORT void wgpuInstanceDestroy(WGPUInstance *instance);

#endif // ZGPU_H_
