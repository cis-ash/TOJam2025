shader_type canvas_item;
uniform sampler2D mask_texture;
uniform float fraction = 0.0;
uniform float margin = 0.1;

void fragment() {
	vec3 original = texture(TEXTURE, UV).rgb;
	vec3 grey = vec3((0.2125 * original.r) + (0.7154 * original.g) + (0.0721 * original.b));
	float mask = texture(mask_texture, UV).r;
	float mix_amount = smoothstep(mask - margin, mask + margin, fraction);
	COLOR.rgb = mix(grey, original, mix_amount);
	
}