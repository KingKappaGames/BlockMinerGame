event_inherited();

source = noone;

image_blend = #888888; // lower range

duration = 420;

depth += 10;

partDebris = global.partDebrisKnock;

tileOnPrevious = E_tile.empty;

image_yscale = .6;
image_xscale = 1.75;

stuck = false;
stuckToId = noone;
stuckToIdRelativeX = 0;
stuckToIdRelativeY = 0;

doExclusions = true;
hitCheckAhead = true;

hit = function(target) {
	var _speed = point_distance(0, 0, xChange, yChange);
	
	audio_play_sound(snd_hitStabMeat, 0, 0, .8,, random_range(.8, 1.2));
	
	var _gore = global.gameGoreSelected;
	if(_gore != 0) {
		part_type_direction(bloodSpurtPart, image_angle - 200, image_angle - 160, -.03, 0);
		part_particles_create_color(sys, x, y, bloodSpurtPart, c_maroon, 5 + round(_speed * 1.5));
	}
	
	part_type_speed(starPart, .6, 1.2, -.03, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 3); // STARS
	
	xChange *= .95;
	yChange *= .95;
	
	xChange -= sign(xChange) * .25;
	yChange -= sign(yChange) * .25;
	
	var _stuckInEnemy = false;
	if(_speed < 3.25) {
		_stuckInEnemy = true;
		stuck = true;
		stuckToId = target;
		stuckToIdRelativeX = x - target.x;
		stuckToIdRelativeY = y - target.y;
		
		duration = 1800;
		
		target.moveSpeed *= .6;
	}
	
	target.hit(_speed * .4, point_direction(0, 0, xChange, yChange), _stuckInEnemy ? _speed : 2 / (_speed * .4 + .25));
}