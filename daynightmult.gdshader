shader_type canvas_item;

uniform sampler2D daymult;
uniform sampler2D nightmult;
uniform float day;
uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 mult_out = mix(texture(daymult, UV), texture(nightmult, UV), day);
	mult_out.rgb = mix(vec3(1.0), mult_out.rgb, mult_out.a);
	COLOR.rgb = texture(SCREEN_TEXTURE, SCREEN_UV).rgb * mult_out.rgb;
	COLOR.a = 1.0;
}