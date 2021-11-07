struct VertexOut {
	[[builtin(position)]] pos: vec4<f32>;
	[[location(0)]] color: vec4<f32>;
};

var<private> colors: array<vec4<f32>,3> = array<vec4<f32>,3>(
	vec4<f32>(1., 0., 0., 1.),
	vec4<f32>(0., 1., 0., 1.),
	vec4<f32>(0., 0., 1., 1.),
);

[[stage(vertex)]]
fn vs_main([[builtin(vertex_index)]] vert_idx: u32) -> VertexOut {
    let x = f32(i32(vert_idx) - 1);
    let y = f32(i32(vert_idx & 1u) * 2 - 1);
    return VertexOut(
		vec4<f32>(x, y, 0.0, 1.0),
		colors[vert_idx],
    );
}

[[stage(fragment)]]
fn fs_main(in: VertexOut) -> [[location(0)]] vec4<f32> {
	return in.color;
}
