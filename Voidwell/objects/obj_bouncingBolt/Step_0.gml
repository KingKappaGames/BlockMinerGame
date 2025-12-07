event_inherited();

if(irandom(5) == 0) {
	part_type_speed(starPart, 0, .9, -.02, 0);
	part_particles_create_color(sys, x + irandom_range(-2, 2), y + irandom_range(-2, 2), starPart, image_blend, 1);
}
//part_particles_create_color(sys, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), thickTrailPart, image_blend, 2);

duration--;

var _speed = point_distance(0, 0, xChange, yChange);

var _hitId = collision_circle(x + xChange, y + yChange, sqrt(_speed) * .5, obj_creature, false, false);
if(instance_exists(_hitId) && source != _hitId) {
	var _originalDir = point_direction(0, 0, xChange, yChange);
	var _dir = _originalDir + random_range(160, 200);
	xChange = dcos(_dir) * _speed * bounceStrengthEnemy;
	yChange = -dsin(_dir) * _speed * bounceStrengthEnemy;
	
	_hitId.hit(.2 + sqr(_speed * .09), _originalDir, .65 * _speed);
}

x += xChange;
y += yChange;

yChange += grav;


if(inWorld) {
	var _tileHitX = worldTiles[(x + xChange) div tileSize][(y) div tileSize];
	if(_tileHitX > 0) {
		xChange *= -bounceStrengthGround;
		if(_speed > 1.25) {
			audio_play_sound_at(global.tileBreakSounds[_tileHitX], x, y, 0, audioRefQuiet, audioMaxMedium, 2, false, 0, .2 + _speed * .032,, random_range(.7, 1.08));
		}
	}
	var _tileHitY = worldTiles[x div tileSize][(y + yChange) div tileSize];
	if(_tileHitY > 0) {
		yChange *= -bounceStrengthGround;
		if(_speed > 1.25) {
			audio_play_sound_at(global.tileBreakSounds[_tileHitY], x, y, 0, audioRefQuiet, audioMaxMedium, 2, false, 0, .2 + _speed * .032,, random_range(.7, 1.08));
		}
	}
}

if(duration <= 0) {
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 8);
	
	part_type_speed(starPart, 1.2, 1.4, -.05, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 5); // STARS
	
	audio_play_sound_at(snd_hitChink, x, y, 0, audioRefQuiet, audioMaxMedium, 2, false, 0, 1,, random_range(.8, 1.2));
	
	instance_destroy();
}
