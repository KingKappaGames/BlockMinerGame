if (live_call()) return live_result;

event_inherited();

part_particles_create_color(sys, x + irandom_range(-2, 2), y + irandom_range(-2, 2), thickTrailPart, image_blend, 5);
part_particles_create_color(sys, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), thickTrailPart, image_blend, 5);

checkHit();

duration--;

x += xChange;
y += yChange;

xChange *= speedDecay;
yChange *= speedDecay;

yChange += grav * .27;

var _tileOn = inWorld ? tiles[x div tileSize][y div tileSize] : 0;

if(duration <= 0 || _tileOn > 0) {
	audio_play_sound_at(snd_explosion, x, y, 0, audioRefLoud, audioMaxLoud, 1, false, 0);
	
	script_createVisual(x, y, 24, spr_explosionFXgreyscale,,, 1.7);
		
	script_createShockwaveSpell(x, y, 12, tileSize * 1., 1.12, materialType, .04,,, .25);
	
	part_particles_create_color(sys, x, y, explosionPart, merge_color(image_blend, c_white, .5), 25); // EXPLOSIVE PARTS
	part_type_speed(trailerPart, 2, 5, 0, 0);
	part_particles_create(sys, x, y, true, irandom_range(3, 4)); // TRAILINGS
	part_type_speed(starPart, 2.1, 4, -.07, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, irandom_range(7, 10)); // STARS
	
	instance_destroy();
} else if(_tileOn < 0) {
	script_breakTileAtPos(x, y, .5);
}