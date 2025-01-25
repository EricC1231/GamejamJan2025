shader_type spatial;

uniform sampler2D image;
uniform vec3 color;

void vertex() {
	//VERTEX = vec3(VERTEX.x+((texture(image,VERTEX.xz *TIME/10.0).r-0.5)/3.0),
	//VERTEX.y+((texture(image,VERTEX.xz * TIME/10.0).r-0.5)/3.0),
	//VERTEX.z+((texture(image,VERTEX.xz * TIME/10.0).r-0.5)/3.0));
	VERTEX = vec3(VERTEX.x+sin(TIME*2.0+VERTEX.y)/10.0,
	VERTEX.y+sin(TIME*3.0+VERTEX.x)/10.0,VERTEX.z+sin(TIME+VERTEX.x)/10.0);
	// Called for every vertex the material is visible on.
}

void fragment() {
	ALPHA = 0.5;
	METALLIC = 0.4;
	ROUGHNESS = 0.1;
	EMISSION = vec3(0.5,0.5,0.5)+color;
	ALBEDO = color;
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
