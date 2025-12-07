varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float strength;

void main() {
	vec4 originalCol = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec3 grayCol = vec3(originalCol.r * 0.2125 + originalCol.g * 0.7154 + originalCol.b * .0721);
	
    gl_FragColor = vec4(mix(grayCol, originalCol.rgb, strength), 1.0);

}
