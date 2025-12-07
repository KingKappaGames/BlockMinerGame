attribute vec3 in_Position;
attribute vec4 in_Colour;
attribute vec2 in_Texture_Coordinate;

varying vec2 vertex_texture_coordinate;

void main() {
    
    vec4 vertex_model_position = vec4(in_Position, 1.0);
    
    vertex_texture_coordinate = in_Texture_Coordinate;
    
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * vertex_model_position;
    
}