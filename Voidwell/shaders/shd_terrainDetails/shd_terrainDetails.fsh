varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 pos;

uniform vec2 camSize;

uniform float aspectRatio; // when you zoom in the dots go further towards the origin 0,0..?

float random (in vec2 st) { // grabbed from the book of shaders demos for noise, I do not claim to have made this at all, just messing with it
    return fract(sin(dot(st.xy, vec2(12.9898,78.233))) * (43758.5453123));
}

float round_(float x) {
    return float(int(x+sign(x)*0.5));
}

void main() {
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );

	if(random( vec2(round_((v_vTexcoord.x + pos.x / camSize.x) * 130. * aspectRatio) * .01, round_((v_vTexcoord.y + pos.y / camSize.y) * 130.) * .01) ) > .997) {
		gl_FragColor.rgb += (1.0-gl_FragColor.rgb) * .3;
	}
}
