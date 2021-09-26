const std = @import("std");
const Deps = @import("Deps.zig");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const deps = Deps.init(b);
    deps.add("https://github.com/silversquirl/glfz", "main");

    const exe = b.addExecutable("wgpu", "main.zig");

    deps.addTo(exe);
    exe.linkLibC();
    exe.linkSystemLibrary("glfw3");

    exe.addLibPath("../../wgpu-native/target/release");
    exe.linkSystemLibrary("wgpu_native");

    exe.setTarget(target);
    exe.setBuildMode(mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
