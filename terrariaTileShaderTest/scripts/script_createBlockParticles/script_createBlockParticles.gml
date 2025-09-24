function script_createBlockParticles(tileIndex, centerX, centerY) {
	var _color = c_white;
	if(tileIndex > 0) {
		_color = global.tileColors[tileIndex];
	} else {
		_color = global.tileColorsDecorative[abs(tileIndex)]; // decorative tile array for negative range yo
	}
	
	var _sys = sys; // did you know localizing instance variables is faster? Also using an interim step like this is more readable because it allows you to custom name per use or make modifications with a terniary or something, it's just better design
	repeat(7) {
		part_particles_create_color(_sys, centerX + irandom_range(-tileSize * .5, tileSize * .5), centerY + irandom_range(-tileSize * .5, tileSize * .5), breakPart, _color, 3);
	}
}