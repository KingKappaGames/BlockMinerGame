function script_createBlockParticles(tileIndex, centerX, centerY) {
	var _color = c_white;
	if(tileIndex > 0) {
		_color = tileColors[tileIndex];
	} else {
		_color = tileColorsDecorative[abs(tileIndex)]; // decorative tile array for negative range yo
	}
	
	repeat(7) {
		part_particles_create_color(sys, centerX + irandom_range(-tileSize * .5, tileSize * .5), centerY + irandom_range(-tileSize * .5, tileSize * .5), breakPart, _color, 3);
	}
}