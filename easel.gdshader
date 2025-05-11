shader_type canvas_item;
uniform sampler2D red_canvas;
uniform sampler2D blue_canvas;

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	vec4 red_drawing = texture(red_canvas, UV);
	vec4 blue_drawing = texture(blue_canvas, UV);
	float how_red = texture_color.r / (texture_color.r + texture_color.b);
	vec4 painting = mix(blue_drawing, red_drawing, how_red);
	COLOR = painting;
	//COLOR.rgb = vec3(texture_color.a);
	//COLOR.a = 1.0;
}