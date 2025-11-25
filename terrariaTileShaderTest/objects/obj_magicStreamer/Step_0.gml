event_inherited();

if(irandom(25) == 0) {
	spin = spin * choose(1, -1, -1) + random_range(-1.3, 1.3);
}

var _moveDir = point_direction(0, 0, xChange, yChange);
var _speed = point_distance(0, 0, xChange, yChange) * .992;
_moveDir += spin;
xChange = lengthdir_x(_speed, _moveDir);
yChange = lengthdir_y(_speed, _moveDir);
image_angle = _moveDir;

part_particles_create_color(sys, x, y, partStreamer, image_blend, 1);
part_particles_create_color(sys, x - xChange * .33, y - yChange * .33, partStreamer, image_blend, 1);
part_particles_create_color(sys, x - xChange * .66, y - yChange * .66, partStreamer, image_blend, 1);

duration--;

var _hitId = collision_circle(x, y, 5, obj_creature, false, false);
if(instance_exists(_hitId) && source != _hitId) {
	audio_play_sound(snd_hitStabMeat, 0, 0, .8,, random_range(.8, 1.2));
	
	var _gore = global.gameGoreSelected;
	if(_gore != 0) {
		part_type_direction(bloodSpurtPart, _moveDir - 200, _moveDir - 160, -.03, 0);
		part_particles_create_color(sys, x, y, bloodSpurtPart, c_maroon, 3);
	}
	
	part_type_speed(starPart, .6, 1.2, -.03, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 1); // STARS
	
	_hitId.hit(.5, point_direction(0, 0, xChange, yChange), .6);
	duration = 0;
}

x += xChange;
y += yChange;


var _tileOn = inWorld ? worldTiles[x div tileSize][y div tileSize] : 0;

if(duration <= 0 || _tileOn > 0) {
	if(_tileOn > 0) {
		audio_play_sound(snd_hitChink, 0, 0, .7,, random_range(.75, 1.45));
		part_particles_create_color(sys, x, y, thickTrailPart, image_blend, 5);
	
		part_type_speed(starPart, .5, 1.2, -.03, 0);
		part_particles_create_color(sys, x, y, starPart, c_white, 1 + irandom(1)); // STARS
		
		if(irandom(100) == 0) {
			script_breakTileAtPos(x, y, .8);
		}
	}
	
	instance_destroy();
} else if(_tileOn < 0) {
	script_breakTileAtPos(x, y, .5);
}
