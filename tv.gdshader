shader_type canvas_item;

uniform vec4 overlay_color : source_color = vec4(1.0);
uniform float flicker_strength : hint_range(0.0, 1.0) = 0.2;
uniform float time_speed : hint_range(0.0, 10.0) = 3.0;

float rand(vec2 co) {
    return fract(sin(dot(co, vec2(12.9898,78.233))) * 43758.5453);
}

void fragment() {
    // Flicker factor between 1 - flicker_strength and 1 + flicker_strength
    float noise = rand(UV + TIME);
    float flicker = 1.0 + (sin(TIME * time_speed) * 0.5 + noise * 0.5 - 0.5) * flicker_strength;

    // Apply flicker to the overlay color
    COLOR = overlay_color * flicker;
}
