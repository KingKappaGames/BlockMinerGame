event_inherited();

source = noone;

shimmerPart = global.radialShimmerPart;

image_blend = make_color_rgb(255, irandom_range(0, 100), irandom_range(0, 150)); // lower range

duration = 300 + irandom(120);

depth -= 10;

bounceStrengthGround = .93;

riseSpeed = .004;

bounceSound = snd_smokePoof;

speedDecay = .99;

expire = function() {
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 8);
	
	part_type_speed(starPart, 1.2, 1.4, -.05, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 5); // STARS
	
	audio_play_sound_at(snd_breakBlockCrystal, x, y, 0, audioRefQuiet, audioMaxMedium, 2, false, 0, 1,, random_range(.8, 1.2));
}