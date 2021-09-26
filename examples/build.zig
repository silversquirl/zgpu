const std = @import("std");
const Deps = @import("Deps.zig");

pub fn build(b: *std.build.Builder) void {
    const target = b.standardTargetOptions(.{});
    const mode = b.standardReleaseOptions();

    const deps = Deps.init(b);
    deps.add("https://github.com/silversquirl/glfz", "main");
    deps.addPackagePath("zgpu", "../zgpu.zig");

    const opts = ExampleOpts{
        .target = target,
        .mode = mode,
        .b = b,
        .deps = deps,
    };

    example("triangle", opts);
}

fn example(name: []const u8, opts: ExampleOpts) void {
    const exe = opts.b.addExecutable(
        name,
        opts.b.fmt("{s}/main.zig", .{name}),
    );

    opts.deps.addTo(exe);
    exe.linkLibC();
    exe.linkSystemLibrary("glfw3");

    exe.addLibPath("../../../wgpu-native/target/release");
    exe.linkSystemLibrary("wgpu_native");

    exe.setTarget(opts.target);
    exe.setBuildMode(opts.mode);
    exe.install();

    const run_cmd = exe.run();
    run_cmd.step.dependOn(opts.b.getInstallStep());
    if (opts.b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = opts.b.step(
        opts.b.fmt("run-{s}", .{name}),
        opts.b.fmt("Run the {s} example", .{name}),
    );
    run_step.dependOn(&run_cmd.step);
}

const ExampleOpts = struct {
    target: std.build.Target,
    mode: std.builtin.Mode,
    b: *std.build.Builder,
    deps: *Deps,
};
