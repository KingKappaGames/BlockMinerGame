varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;

void main()
{
	float x = v_vTexcoord.x + sin(v_vTexcoord.y * 11793.3 + time * 1271.123) * .00008;
	float y = v_vTexcoord.y + sin(v_vTexcoord.x * 7381.72 + time * 725.72) * .00008;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, vec2(x, y));
}
