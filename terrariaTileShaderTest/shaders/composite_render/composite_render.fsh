varying vec2 vertex_texture_coordinate;

uniform vec2 surface_dimensions;

uniform sampler2D noise_texture;
uniform vec2 noise_dimensions;
uniform float noise_intensity;
uniform float noise_blend;

uniform float scanline_intensity;

uniform sampler2D bleed_texture;
uniform float bleed_mix;

uniform float scale_factor;

void main() {
    
    vec4 pixel_color = texture2D(gm_BaseTexture, vertex_texture_coordinate);
    vec3 bleed_color = texture2D(bleed_texture, vertex_texture_coordinate).rgb;
    
	float texel_factor = 1.0 / scale_factor;
	
    vec2 pixel_coordinate = vertex_texture_coordinate * surface_dimensions * texel_factor;
    vec2 fractional_coordinate = fract(pixel_coordinate);
    
    float vertical_scanline_factor = 1.0 - smoothstep(0.0, scanline_intensity, abs(fractional_coordinate.y - texel_factor));
    float noise_color = texture2D(noise_texture, (vertex_texture_coordinate * surface_dimensions) / noise_dimensions).r * noise_intensity;
    
    pixel_color.rgb = mix(pixel_color.rgb, pixel_color.rgb * (1.0 - noise_blend), vertical_scanline_factor - noise_color);
    
    pixel_color.rgb = (min(pixel_color.rgb + bleed_color, vec3(1.0, 1.0, 1.0)) * bleed_mix + pixel_color.rgb * (1.0 - bleed_mix));
    
    gl_FragColor = pixel_color;
    
}