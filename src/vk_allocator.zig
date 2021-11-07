const std = @import("std");
const vk = @import("vk.zig");

/// Wraps a *std.mem.Allocator into a vk.AllocationCallbacks so Zig allocators can easily be used for allocating Vulkan objects.
pub fn wrap(allocator: *std.mem.Allocator) vk.AllocationCallbacks {
    return .{
        .p_user_data = allocator,
        .pfn_allocation = @ptrCast(fn (*c_void, usize, usize, vk.SystemAllocationScope) callconv(vk.vulkan_call_conv) *c_void, alloc),
        .pfn_reallocation = @ptrCast(fn (*c_void, *c_void, usize, usize, vk.SystemAllocationScope) callconv(vk.vulkan_call_conv) *c_void, realloc),
        .pfn_free = @ptrCast(fn (*c_void, *c_void) callconv(vk.vulkan_call_conv) void, free),
        .pfn_internal_allocation = null,
        .pfn_internal_free = null,
    };
}

pub inline fn unwrap(vk_alloc: vk.AllocationCallbacks) *std.mem.Allocator {
    return @ptrCast(
        *std.mem.Allocator,
        @alignCast(
            @alignOf(std.mem.Allocator),
            vk_alloc.p_user_data,
        ),
    );
}

const Header = struct {
    size: usize,
    alignment: u29,
};

fn realloc(user_data: *c_void, original: ?*c_void, new_size: usize, calign: usize, _: vk.SystemAllocationScope) callconv(vk.vulkan_call_conv) ?*c_void {
    var old_align: u29 = 0;
    var old_mem: []u8 = &.{};

    if (original) |orig| {
        const old_hdr = @intToPtr(*align(1) Header, @ptrToInt(orig) - @sizeOf(Header));
        old_align = old_hdr.alignment;
        const old_hdr_size = ceilToMultiple(@sizeOf(Header), old_align);
        const old_ptr = @intToPtr([*]u8, @ptrToInt(orig) - old_hdr_size);
        old_mem = old_ptr[0 .. old_hdr.size + old_hdr_size];
    } else if (new_size == 0) {
        return null;
    }

    const new_align = std.math.cast(u29, calign) catch return null;
    const new_hdr_size = ceilToMultiple(@sizeOf(Header), new_align);

    const allocator = @ptrCast(*std.mem.Allocator, @alignCast(@alignOf(std.mem.Allocator), user_data));

    var mem = reallocBytes(allocator, old_mem, old_align, if (new_size > 0) new_size + new_hdr_size else 0, new_align, 0, @returnAddress()) catch return null;

    if (new_size > 0) {
        const new_hdr = @ptrCast(*align(1) Header, mem.ptr + new_hdr_size - @sizeOf(Header));
        new_hdr.size = new_size;
        new_hdr.alignment = new_align;
        return mem.ptr + new_hdr_size;
    }

    return null;
}

fn alloc(user_data: *c_void, size: usize, calign: usize, allocation_scope: vk.SystemAllocationScope) callconv(vk.vulkan_call_conv) ?*c_void {
    return realloc(user_data, null, size, calign, allocation_scope);
}

fn free(user_data: *c_void, memory: ?*c_void) callconv(vk.vulkan_call_conv) void {
    _ = realloc(user_data, memory, 0, 1, undefined);
}

// FIXME: stolen from stdlib, since it's not exposed, but we need non-comptime alignment params.
fn reallocBytes(
    self: *std.mem.Allocator,
    old_mem: []u8,
    old_alignment: u29,
    new_byte_count: usize,
    new_alignment: u29,
    len_align: u29,
    return_address: usize,
) ![]u8 {
    if (old_mem.len == 0) {
        const new_mem = try self.allocFn(self, new_byte_count, new_alignment, len_align, return_address);
        @memset(new_mem.ptr, undefined, new_byte_count);
        return new_mem;
    }

    if (std.mem.isAligned(@ptrToInt(old_mem.ptr), new_alignment)) {
        if (new_byte_count <= old_mem.len) {
            const shrunk_len = self.shrinkBytes(old_mem, old_alignment, new_byte_count, len_align, return_address);
            return old_mem.ptr[0..shrunk_len];
        }
        if (self.resizeFn(self, old_mem, old_alignment, new_byte_count, len_align, return_address)) |resized_len| {
            std.debug.assert(resized_len >= new_byte_count);
            @memset(old_mem.ptr + new_byte_count, undefined, resized_len - new_byte_count);
            return old_mem.ptr[0..resized_len];
        } else |_| {}
    }
    if (new_byte_count <= old_mem.len and new_alignment <= old_alignment) {
        return error.OutOfMemory;
    }

    std.debug.assert(new_byte_count > 0);
    const new_mem = try self.allocFn(self, new_byte_count, new_alignment, len_align, return_address);
    @memcpy(new_mem.ptr, old_mem.ptr, std.math.min(new_byte_count, old_mem.len));
    @memset(old_mem.ptr, undefined, old_mem.len);
    _ = self.shrinkBytes(old_mem, old_alignment, 0, 0, return_address);
    return new_mem;
}

/// Returns the lowest multiple of `a` which is >= `x`. `a` must be a power of 2.
fn ceilToMultiple(x: usize, a: u29) usize {
    std.debug.assert(std.math.isPowerOfTwo(a));
    return ~((~x + 1) & (~@as(usize, a) + 1)) + 1;
}
