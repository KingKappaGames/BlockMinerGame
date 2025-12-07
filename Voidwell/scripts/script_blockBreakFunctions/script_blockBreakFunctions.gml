function script_tileBreakEffects(xx, yy, index) { // chaos is how mashed around the block effect is by this breaking, mostly intended to "scatter" explosives in big bunches
	if(index == E_tile.banana) {
		repeat(3) {
			var _banana = instance_create_layer((xx + .5) * tileSize, (yy + .5) * tileSize, "Instances", obj_banana);
			_banana.xChange = random_range(-3, 3);
			_banana.yChange = random_range(-3, 3);
		}
	} else if(index == E_tile.explosive) {
		var _explosiveCount = instance_number(obj_spellShockwave) + 2; // rough estimate
		var _worldX = (xx + .5) * tileSize + irandom_range(-_explosiveCount, _explosiveCount);
		var _worldY = (yy + .5) * tileSize + irandom_range(-_explosiveCount, _explosiveCount);
		
		audio_play_sound_at(snd_explosion, _worldX, _worldY, 0, audioRefLoud, audioMaxLoud, 1, false, 0);
		
		script_createShockwaveSpell(_worldX, _worldY, 5, tileSize * 1.4, 1.26,, .8,, #ffffff);
		
		part_particles_create_color(sys, _worldX, _worldY, explosionPart, c_orange, 20); // EXPLOSIVE PARTS
		
		repeat(2) {
			var _debris = instance_create_layer(x, y, "Instances", obj_bouncingDebris);
			_debris.xChange = random_range(-5, 5) + random_range(-5, 5);
			_debris.yChange = random_range(-5, 5) + random_range(-5, 5);
		}
		
		var _trailerPart = global.overwrittenTrailerPart;
		part_type_speed(_trailerPart, 3, 5, 0, 0);
		part_particles_create(sys, _worldX, _worldY, _trailerPart, irandom_range(1, 2)); // TRAILINGS
		
		part_type_speed(starPart, 3.1, 5.4, -.08, 0);
		part_particles_create_color(sys, _worldX, _worldY, starPart, c_white, irandom_range(5, 8)); // STARS
	//} else if(index == E_tile.) {
		
	} else {
		//nothing for default
	}
}