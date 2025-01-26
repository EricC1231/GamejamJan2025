shader_type spatial;

uniform sampler2D image;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = texture(image,UV.xy*100.0).r * vec3(sin(TIME)/2.0+0.5,sin(TIME*2.0)/2.0+0.5,sin(TIME*.5)/2.0+0.5);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
