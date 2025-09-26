function script_tileBreakEffects(xx, yy, index) { // (xx + .5) * tileSize, (yy + .5) * tileSize     FOR the position at center of tile, anyhow.
	if(index == E_tile.banana) {
		repeat(3) {
			var _banana = instance_create_layer((xx + .5) * tileSize, (yy + .5) * tileSize, "Instances", obj_banana);
			_banana.xChange = random_range(-3, 3);
			_banana.yChange = random_range(-3, 3);
		}
	} else if(index == E_tile.explosive) {
		var _worldX = (xx + .5) * tileSize;
		var _worldY = (yy + .5) * tileSize;
		
		audio_play_sound_at(snd_explosion, _worldX, _worldY, 0, audioRefLoud, audioMaxLoud, 1, false, 0);
		
		script_createShockwaveSpell(_worldX, _worldY, 5, tileSize * 1.4, 1.26,, .8);
		
		part_particles_create_color(sys, _worldX, _worldY, explosionPart, c_orange, 25); // EXPLOSIVE PARTS
		
		var _trailerPart = global.overwrittenTrailerPart;
		part_type_speed(_trailerPart, 3, 5, 0, 0);
		part_particles_create(sys, _worldX, _worldY, _trailerPart, irandom_range(2, 3)); // TRAILINGS
		
		part_type_speed(starPart, 3.1, 5.4, -.08, 0);
		part_particles_create_color(sys, _worldX, _worldY, starPart, c_white, irandom_range(7, 10)); // STARS
	//} else if(index == E_tile.) {
		
	} else {
		//nothing for default
	}
}