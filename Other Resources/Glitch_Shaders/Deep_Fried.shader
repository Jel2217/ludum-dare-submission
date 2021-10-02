shader_type canvas_item;

void fragment() {
	vec3 c = textureLod(SCREEN_TEXTURE, SCREEN_UV, 0.0).rgb;
	c = mod(c + vec3(0.3), vec3(1.0));
	c.rgb = mix(vec3(dot(vec3(1.0), c.rgb) * 0.35), c.rgb, 100.0);
	COLOR.rgb = c;
}
