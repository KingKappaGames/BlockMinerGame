varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;

void main()
{
	float x = v_vTexcoord.x + sin(v_vTexcoord.y * 38.3 + time * 7.123) * .03;
	float y = v_vTexcoord.y + sin(v_vTexcoord.x * 9.72 + time * 2.72) * .017;
	vec4 col = texture2D( gm_BaseTexture, vec2(x, y));
	
	if(col.a < .007) {
		discard;
	}
	
    gl_FragColor = v_vColour * col;
}
