//! zgpu build plugin
const std = @import("std");

/// Returns a FileSource for wgpu-native built with the specified linkage.
/// Pass this to step.addObjectFileSource.
pub fn lib(
    b: *std.build.Builder,
    root: []const u8, // Path to root of zgpu repo
    linkage: std.build.LibExeObjStep.Linkage,
) std.build.FileSource {
    // TODO: not-linux support
    // TODO: cross-compilation support
    const wgpu_native_path = if (std.fs.path.isAbsolute(root))
        b.fmt("{s}/wgpu-native", .{root})
    else
        b.fmt("{s}/{s}/wgpu-native", .{ b.build_root, root });
    const step = RustLibStep.init(b, wgpu_native_path, switch (linkage) {
        .static => "libwgpu_native.a",
        .dynamic => "libwgpu_native.so",
    });
    return .{ .generated = &step.file };
}

const RustLibStep = struct {
    step: std.build.Step,
    cmd: *std.build.RunStep,
    lib_name: []const u8,
    file: std.build.GeneratedFile,

    pub fn init(b: *std.build.Builder, path: []const u8, lib_name: []const u8) *RustLibStep {
        const target_dir = b.fmt("{s}/rust", .{b.cache_root});
        const lib_path = b.fmt("{s}/release/{s}", .{ target_dir, lib_name });

        const self = b.allocator.create(RustLibStep) catch unreachable;
        self.* = .{
            .step = std.build.Step.init(
                .custom,
                b.fmt("build rust lib '{s}'", .{lib_name}),
                b.allocator,
                make,
            ),
            .cmd = b.addSystemCommand(&.{
                "cargo",
                "build",
                "--quiet",
                "--lib",
                "--release",
                "--target-dir",
                b.pathFromRoot(target_dir),
            }),
            .lib_name = b.pathFromRoot(lib_path),
            .file = .{ .step = &self.step },
        };

        self.step.dependOn(&self.cmd.step);
        self.cmd.cwd = path;

        return self;
    }

    fn make(step: *std.build.Step) !void {
        const self = @fieldParentPtr(RustLibStep, "step", step);
        self.file.path = self.lib_name;
    }
};
