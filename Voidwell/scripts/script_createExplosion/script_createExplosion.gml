function script_createExplosion(xx, yy, duration = 4, sizeMult = 1, sizeGrowMult = 1.26, debrisPieces = 4, debrisSprite = spr_chunk, debrisSpeedRange = 5, debrisSizeMax = 1, debrisSizeMin = 1, debrisDurationMult = 1, particleCountMult = 1) {
	var _whitenedColor = merge_color(image_blend, c_white, .5);
	
	script_createShockwaveSpell(xx, yy, duration, tileSize * 1.3 * sizeMult, sizeGrowMult,, 1,, _whitenedColor);
	
	repeat(debrisPieces) {
		var _debris = instance_create_layer(xx, yy, "Instances", obj_bouncingDebris);
		with(_debris) {
			xChange = random_range(-debrisSpeedRange, debrisSpeedRange) + random_range(-debrisSpeedRange, debrisSpeedRange);
			yChange = random_range(-debrisSpeedRange, debrisSpeedRange) + random_range(-debrisSpeedRange, debrisSpeedRange);
			
			var _scale = random_range(debrisSizeMin, debrisSizeMax);
			
			sprite_index = debrisSprite;
			image_xscale = _scale;
			image_yscale = _scale;
			
			duration *= debrisDurationMult;
		}
	}
	
	part_particles_create_color(sys, xx, yy, explosionPart, _whitenedColor, 25 * particleCountMult); // ExPLOSIVE PARTS
	part_type_speed(trailerPart, 2, 5, 0, 0);
	part_particles_create(sys, xx, yy, true, irandom_range(3, 4) * particleCountMult); // TRAILINGS
	part_type_speed(starPart, 2.1, 4, -.07, 0);
	part_particles_create_color(sys, xx, yy, starPart, c_white, irandom_range(7, 10) * particleCountMult); // STARS
}