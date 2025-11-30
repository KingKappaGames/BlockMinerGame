event_inherited();

part_particles_create_color(sys, x + irandom_range(-2, 2), y + irandom_range(-2, 2), thickTrailPart, image_blend, 5);
part_particles_create_color(sys, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), thickTrailPart, image_blend, 5);

duration--;

var _hitId = collision_circle(x, y, 5, obj_creature, false, false);
if(instance_exists(_hitId) && source != _hitId) {
	duration = 0;
}

x += xChange;
y += yChange;

var _tileOn = inWorld ? worldTiles[x div tileSize][y div tileSize] : 0;

if(duration <= 0 || _tileOn > 0) {
	audio_play_sound_at(snd_explosion, x, y, 0, audioRefLoud, audioMaxLoud, 1, false, 0);
		
	script_createShockwaveSpell(x, y, 3, tileSize * 1.3, 1.26,, 1);
	
	repeat(3) {
		var _debris = instance_create_layer(x, y, "Instances", obj_bouncingDebris);
		_debris.xChange = random_range(-5, 5) + random_range(-5, 5);
		_debris.yChange = random_range(-5, 5) + random_range(-5, 5);
	}
	
	part_particles_create_color(sys, x, y, explosionPart, merge_color(image_blend, c_white, .5), 25); // EXPLOSIVE PARTS
	part_type_speed(trailerPart, 2, 5, 0, 0);
	part_particles_create(sys, x, y, true, irandom_range(3, 4)); // TRAILINGS
	part_type_speed(starPart, 2.1, 4, -.07, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, irandom_range(7, 10)); // STARS
	
	instance_destroy();
} else if(_tileOn < 0) {
	script_breakTileAtPos(x, y, .5);
}