event_inherited();

part_particles_create_color(sys, x + irandom_range(-2, 2), y + irandom_range(-2, 2), thickTrailPart, image_blend, 2);
part_particles_create_color(sys, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), thickTrailPart, image_blend, 2);

duration--;

var _hitId = collision_circle(x, y, 5, obj_creature, false, false);
if(instance_exists(_hitId) && source != _hitId) {
	_hitId.hit(1, point_direction(0, 0, xChange, yChange), 1.5);
	duration = 0;
}

x += xChange;
y += yChange;


var _tileOn = inWorld ? worldTiles[x div tileSize][y div tileSize] : 0;

if(duration <= 0 || _tileOn > 0) {
	if(_tileOn > 0) {
		if(irandom(20) == 0) {
			script_breakTileAtPos(x, y, .8);
		}
	}
	
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 5);
	
	part_type_speed(starPart, 1.2, 1.7, -.05, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 3); // STARS
	
	audio_play_sound(snd_smokePoof, 0, 0, 1);
	
	instance_destroy();
} else if(_tileOn < 0) {
	script_breakTileAtPos(x, y, .5);
}
