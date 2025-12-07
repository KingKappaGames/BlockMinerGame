varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 resolution;

void main() {
	vec2 tileMod = vec2(mod(v_vTexcoord.x, 1.0/resolution.x), mod(v_vTexcoord.y, 1.0/resolution.y));

    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord - tileMod);
}
