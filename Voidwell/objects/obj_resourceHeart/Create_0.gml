event_inherited();

shimmerPart = global.radialShimmerPart;
smoothTrail = global.roundTrail;

image_blend = #ee0021;

direction = random(360);

speed = random_range(1.6, 3.2);

image_xscale = .22;
image_yscale = .22;

pickup = function(target) {
	target.hit(-irandom_range(1, 2), 0, 0, 0);
	
	repeat(12) {
		var _spawnX = x + irandom_range(-10, 10);
		var _spawnY = y - 8 + irandom_range(-10, 10);
		var _dir = point_direction(x, y, _spawnX, _spawnY);
		part_type_orientation(shimmerPart, _dir, _dir, 0, 0, false);
		part_type_direction(shimmerPart, _dir, _dir, 0, 0);
		part_type_speed(shimmerPart, 1, 1.9, -.02, 0);
		part_particles_create(sysUnder, _spawnX, _spawnY, shimmerPart, 1);
	}
	
	audio_play_sound_at(snd_banana, x, y, 0, audioRefMedium, audioMaxLoud, 2, false, 0, 1,, random_range(.8, 1.2));
	
	instance_destroy();
}

duration = 900 + irandom(240);

range = 18;

spin = random_range(-11, 11);