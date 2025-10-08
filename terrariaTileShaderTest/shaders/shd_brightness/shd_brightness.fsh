varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float strength;

void main() {
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord ) * vec4(vec3(1.0 + strength), 1.0);

}
