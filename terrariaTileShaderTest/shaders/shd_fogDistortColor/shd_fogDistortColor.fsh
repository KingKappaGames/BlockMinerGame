varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float time;

//const float posterizationLevels = 50.0;

void main() {
	float x = v_vTexcoord.x + sin(v_vTexcoord.y * 38.3 + time * 9.123) * .023;
	float y = v_vTexcoord.y + sin(v_vTexcoord.x * 9.72 + time * 17.72) * .011;
	
	float dist = sqrt(pow(x - .5, 2.0) + pow(y - .5, 2.0));
	
	if(dist > .481 && dist < .5) {
		gl_FragColor = vec4(1.0, 1.0, 1.0, v_vColour.a);
		return;
	}
	
	vec4 randCol = v_vColour;
	
	//float deposterize = (1.0 / posterizationLevels);
	
	//randCol.r *=  floor((.35 + sin((x * .827 + y * 1.74) + time * .043) * .15) * posterizationLevels) * deposterize;
	//randCol.g *= floor((.05 + sin((x * .47 + y * 2.29 + cos(time)) + time * .021) * .15) * posterizationLevels) * deposterize;
	//randCol.b *= floor((.65 + sin(((x * 6.17 * sin(time + x)) + y * 15.19) + time * .0283) * .15) * posterizationLevels) * deposterize;
	
	randCol.r *= .35 + sin((x * .827 + y * 1.74) + time * .043) * .15;
	randCol.g *= .05 + sin((x * .47 + y * 2.29 + cos(time)) + time * .021) * .15;
	randCol.b *= .65 + sin(((x * 6.17 * sin(time + x)) + y * 15.19) + time * .0283) * .15;
	
    gl_FragColor = randCol * texture2D( gm_BaseTexture, vec2(x, y));
}
