varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 resolution;
uniform float threshold;

void main() {
	vec2 tileMod = vec2(mod(v_vTexcoord.x, 1.0/resolution.x), mod(v_vTexcoord.y, 1.0/resolution.y));
	
	vec4 colorMod = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord - tileMod);
	
	float luminance = (colorMod.r * .2125 + colorMod.g * .7154 + colorMod.b * .0721); //originalCol.r * 0.2125 + originalCol.g * 0.7154 + originalCol.b * .0721
	
	vec2 tileModNormal = vec2(tileMod.x * resolution.x - .5, tileMod.y * resolution.y - .5); // ranges -.5 to .5 for relative mosaic dot center at this pixel
	
	if(sqrt(pow(tileModNormal.x, 2.0) + pow(tileModNormal.y, 2.0)) > min((.3 + luminance * .3) * threshold, .6)) {
		gl_FragColor = vec4(0.055,  0.035, 0.065, 1.0); // background color
		return;
	}
	
    gl_FragColor = colorMod;
}
