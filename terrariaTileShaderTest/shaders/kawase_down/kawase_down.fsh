varying vec2 vertex_texture_coordinate;

uniform vec2 texel_dimensions;
uniform float sample_distance;

void main() {
    
    vec2 sample_offset = texel_dimensions * sample_distance;
    
    vec2 sample_coordinate[4];
    sample_coordinate[0] = -sample_offset;
    sample_coordinate[1] = sample_offset;
    sample_coordinate[2] = vec2(sample_offset.x, -sample_offset.y);
    sample_coordinate[3] = -vec2(sample_offset.x, -sample_offset.y);
    
    
    vec4 pixel_color = texture2D(gm_BaseTexture, vertex_texture_coordinate) * 4.0;
    
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[0]);
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[1]);
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[2]);
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[3]);
    
    pixel_color = pixel_color * 0.125;
    
    gl_FragColor = pixel_color;
    
}