//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;

void main()
{
	float x = v_vTexcoord.x + sin(v_vTexcoord.y * 38.3 + time * 7.123) * .03;
	float y = v_vTexcoord.y + sin(v_vTexcoord.x * 9.72 + time * 2.72) * .017;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vec2(x, y));
}
