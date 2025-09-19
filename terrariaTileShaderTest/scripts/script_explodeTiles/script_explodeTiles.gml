function script_explodeTiles(xx = x, yy = y, breakTries = 150, distAdd = .25, angleIncrementMin = 20, angleIncrementMax = 70, doParticles = false, doSound = false, doBrokenTileSounds = false) { // LOCAL SCOPE
	var _angle = 0;
	var _dist = tileSize;
	var _xx = 0;
	var _yy = 0;
	repeat(breakTries) {
		_dist = _dist + distAdd;
		_angle += irandom_range(angleIncrementMin, angleIncrementMax);
		_xx = xx + dcos(_angle) * _dist + irandom_range(-tileSize, tileSize);
		_yy = yy - dsin(_angle) * _dist + irandom_range(-tileSize, tileSize);
		script_breakTileAtPos(_xx, _yy, doBrokenTileSounds);
		//instance_create_layer(_xx, _yy, "Instances", obj_debugMark);
	}
	
	if(doParticles) {
		part_particles_create_color(sys, x, y, explosionPart, image_blend, 120);
	}
	
	if(doSound) {
		audio_play_sound_at(snd_explosion, xx, yy, 0, audioRefLoud, audioMaxLoud, 1, 0, 1, 2);
	}
}