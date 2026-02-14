event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

yChange += grav; // gravity

script_moveCollide();

xChange *= speedDecay;

spinSpeed = xChange * -8; // match spin speed to "rolling" speed (assuming it perfectly matches but it would often times so..)

image_angle += spinSpeed;

duration--;
if(duration <= 0) {
	audio_play_sound_at(snd_explosion, x, y, 0, audioRefLoud, audioMaxLoud, 1, false, 0);
	
	var _xx = x;
	var _yy = y;
	
	with(obj_bomb) {
		var _dist = point_distance(_xx, _yy, x, y);
		
		if(_dist < 125) {
			_dist = 1 - sqr(_dist / 125);
			var _dir = point_direction(_xx, _yy, x, y);
			xChange += lengthdir_x(_dist, _dir) * 5.8;
			yChange += lengthdir_y(_dist, _dir) * 5.8;
		}
	}
	
	if(irandom(120) == 0) { // TODO make this an option? Like, tremor frequency in the options, could be a cool thing to customize, i dunno
		script_createTremor(x, y, irandom_range(240, 500), random_range(.12, .5), true);
	}
	
	script_createVisual(x, y, 24, spr_explosionFXgreyscale,,, 2.1);
	
	script_createShockwaveSpell(x, y, 4, tileSize * 1.5, 1.24,, 1.5);
	
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 25); // EXPLOSIVE PARTS
	part_type_speed(trailerPart, 1.5, 3.7, 0, 0);
	part_particles_create(sys, x, y, trailerPart, irandom_range(3, 4)); // TRAILINGS
	part_type_speed(starPart, 2.8, 5, -.07, 0);
	part_particles_create(sys, x, y, starPart, irandom_range(7, 10)); // STARS
	
	instance_destroy();
}