if (live_call()) return live_result;
	
global.partDebrisKnock = part_type_create();
var _debrisKnock = global.partDebrisKnock;
part_type_life(_debrisKnock, 60, 90);
part_type_shape(_debrisKnock, pt_shape_square);
part_type_size(_debrisKnock, 0.05, .15, 0, 0);
part_type_gravity(_debrisKnock, .003, 90);
part_type_alpha3(_debrisKnock, 1, .8, 0);

event_inherited();

//part_particles_create_color(sysUnder, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), thickTrailPart, #ffff88, 1);

duration--;

if(!stuck) {
	checkHit();

	x += xChange;
	y += yChange;
	
	image_angle = point_direction(0, 0, xChange, yChange);
	
	
	var _tileOn = inWorld ? tiles[x div tileSize][y div tileSize] : 0;
	
	if(_tileOn > 0) {
		var _resistance = 0;
		if(_tileOn == E_tile.metal || _tileOn == E_tile.stone || _tileOn == E_tile.diamond) { // strong resistance
			_resistance = .8;
		} else if(_tileOn == E_tile.wood) { // medium
			_resistance = .91;
		} else {
			_resistance = .93; // weak
		}
		
		var _speed = point_distance(0, 0, xChange, yChange);
		
		if(tileOnPrevious == E_tile.empty) {
			//do entering stuff
			
			xChange *= power(_resistance, 6);
			yChange *= power(_resistance, 6);
			
			part_type_direction(partDebris, image_angle - 235, image_angle - 125, 0, 0);
			part_type_speed(partDebris, 0, _speed * .03 + .25, -.01, 0);
			part_particles_create_color(sys, x, y, partDebris, global.tileColors[_tileOn], 3 + round(_speed));
			
			audio_play_sound_at(global.tileBreakSounds[_tileOn], x, y, 0, audioRefMedium, audioMaxMedium, 2, false, 0, .25 + _speed * .07);
		}
		
		xChange *= _resistance;
		yChange *= _resistance;
		
		if(_speed < 2.1) {
			stuck = true;
			
			duration = 600;
		}
		
		tileOnPrevious = _tileOn;
	} else {
		yChange += grav; // this particular spell has gravity.. Cool (only when outside of blocks tho)
		
		if(tileOnPrevious != E_tile.empty) {
			var _speed = point_distance(0, 0, xChange, yChange);
			
			//do exiting stuff
			part_type_direction(partDebris, image_angle - 45, image_angle + 45, 0, 0);
			part_particles_create_color(sys, x, y, partDebris, global.tileColors[tileOnPrevious], 5 + round(_speed));
			
			audio_play_sound_at(global.tileBreakSounds[tileOnPrevious], x, y, 0, audioRefMedium, audioMaxMedium, 2, false, 0, .25 + _speed * .07);
		}
		
		tileOnPrevious = E_tile.empty; // could be deco but same diff
	}
} else {
	if(stuckToId != noone) {
		if(instance_exists(stuckToId)) {
			x = stuckToId.x + stuckToIdRelativeX;
			y = stuckToId.y + stuckToIdRelativeY;
		} else {
			duration = 300;
			stuck = false;
			stuckToId = noone;
		}
	}
}

if(duration <= 0) {
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 5);
	
	part_type_speed(starPart, 1.2, 1.7, -.05, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 3); // STARS
	
	instance_destroy();
}