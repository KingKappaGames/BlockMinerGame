varying vec2 vertex_texture_coordinate;

uniform vec2 texel_dimensions;
uniform float sample_distance;

void main() {
    
    vec2 sample_offset = texel_dimensions * sample_distance;
    
    vec2 sample_coordinate[8];
    sample_coordinate[0] = vec2(-texel_dimensions.x, 0.0);
    sample_coordinate[1] = vec2(-sample_offset.x, sample_offset.y);
    sample_coordinate[2] = vec2(0.0, texel_dimensions.y);
    sample_coordinate[3] = vec2(sample_offset.x, sample_offset.y);
    sample_coordinate[4] = vec2(texel_dimensions.x, 0.0);
    sample_coordinate[5] = vec2(sample_offset.x, -sample_offset.y);
    sample_coordinate[6] = vec2(0.0, -texel_dimensions.y);
    sample_coordinate[7] = vec2(-sample_offset.x, -sample_offset.y);
    
    vec4 pixel_color = vec4(0.0, 0.0, 0.0, 0.0);
    
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[0]);
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[1]) * 2.0;
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[2]);
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[3]) * 2.0;
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[4]);
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[5]) * 2.0;
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[6]);
    pixel_color = pixel_color +  texture2D(gm_BaseTexture, vertex_texture_coordinate + sample_coordinate[7]) * 2.0;
    
    pixel_color = pixel_color * 0.0833333333333333;
    
    gl_FragColor = pixel_color;
    
}