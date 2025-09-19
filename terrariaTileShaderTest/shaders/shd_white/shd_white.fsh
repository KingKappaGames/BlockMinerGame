varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float alpha;

void main() {
    vec4 col = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	float brightness = sqrt(col.r * 0.2125 + col.g * 0.7154 + col.b * 0.0721); // force the pixels to be somewhat washed out and towards 1 / white
	
	gl_FragColor = vec4(brightness, brightness, brightness, alpha * col.a);
}
