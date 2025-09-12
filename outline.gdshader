shader_type canvas_item;

/* Outline shader (outer outline by sampling alpha around the pixel)
   - outline_color: color of the outline
   - outline_size: radius of the outline in pixels
   - threshold: alpha threshold to consider "solid" (0..1)
   - samples: how many directions to sample (8..32). More = smoother, slower.
*/

uniform vec4 outline_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float outline_size : hint_range(0.0, 64.0) = 4.0;
uniform float threshold : hint_range(0.0, 1.0) = 0.1;
uniform int samples : hint_range(4, 32) = 12;

void fragment() {
    // original texture color & alpha
    vec4 base = texture(TEXTURE, UV);
    float a = base.a;

    // convert pixel radius -> uv offset (TEXTURE_PIXEL_SIZE is vec2(1/tex_w, 1/tex_h))
    // Use x component (assumes square texels; it's fine for most 2D sprites).
    vec2 step = vec2(outline_size) * TEXTURE_PIXEL_SIZE.xy;

    // sample neighbors in evenly spaced directions, track max alpha found
    float maxNeighborAlpha = 0.0;
    for (int i = 0; i < samples; i++) {
        float ang = float(i) * (2.0 * PI / float(samples));
        vec2 off = vec2(cos(ang), sin(ang)) * step;
        float sA = texture(TEXTURE, UV + off).a;
        maxNeighborAlpha = max(maxNeighborAlpha, sA);
    }

    // if this pixel is transparent (or below threshold) but neighbors contain solid pixels
    if (a <= threshold && maxNeighborAlpha > threshold) {
        // draw the outline color (preserve its alpha)
        COLOR = outline_color;
    } else {
        // draw the original texture
        COLOR = base;
    }
}
