shader_type canvas_item;

uniform vec4 target_color : source_color = vec4(1.0, 0.0, 0.0, 1.0); // default red

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    COLOR = mix(tex_color, vec4(target_color.rgb, tex_color.a), 0.5);
}
