varying vec2 vertex_texture_coordinate;

uniform vec2 texel_dimensions;

uniform vec3 red_bleed;
uniform vec3 green_bleed;
uniform vec3 blue_bleed;


void main() {
    
    
    float red = texture2D(gm_BaseTexture, vertex_texture_coordinate + ((red_bleed.xy * red_bleed.z) * texel_dimensions)).r;
    float green = texture2D(gm_BaseTexture, vertex_texture_coordinate + ((green_bleed.xy * green_bleed.z) * texel_dimensions)).g;
    float blue = texture2D(gm_BaseTexture, vertex_texture_coordinate + ((blue_bleed.xy * blue_bleed.z) * texel_dimensions)).b;
    
    float alpha = texture2D(gm_BaseTexture, vertex_texture_coordinate).a;
    
    gl_FragColor = vec4(red, green, blue, alpha);
    
}