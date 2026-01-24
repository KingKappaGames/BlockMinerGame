event_inherited();

//part_particles_create_color(sys, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), thickTrailPart, image_blend, 2);

duration--;

var _speed = point_distance(0, 0, xChange, yChange);

x += xChange;
y += yChange;

if(inWorld) {
	var _tileHitX = tiles[(x + xChange) div tileSize][(y) div tileSize];
	if(_tileHitX > 0) {
		xChange *= -bounceStrengthGround;
		if(_speed > 1.25) {
			audio_play_sound_at(bounceSound, x, y, 0, audioRefQuiet, audioMaxMedium, 2, false, 0, .2 + _speed * .032,, random_range(.7, 1.08));
		}
	}
	var _tileHitY = tiles[x div tileSize][(y + yChange) div tileSize];
	if(_tileHitY > 0) {
		yChange *= -bounceStrengthGround;
		if(_speed > 1.25) {
			audio_play_sound_at(bounceSound, x, y, 0, audioRefQuiet, audioMaxMedium, 2, false, 0, .2 + _speed * .032,, random_range(.7, 1.08));
		}
	}
}

if(duration <= 0) {
	expire();
	
	instance_destroy();
}
