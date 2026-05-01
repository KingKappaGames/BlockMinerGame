event_inherited();

source = noone;

image_blend = make_color_rgb(irandom_range(200, 255), irandom_range(200, 255), irandom_range(200, 255)); // lower range

duration = 300 + irandom(20);

depth -= 10;

hit = function(playSound = true) {
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 8);
	
	part_type_speed(starPart, 1.2, 1.4, -.05, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 25); // STARS
	
	if(playSound) {
		audio_play_sound_at(snd_fallOntoMud, x, y, 0, audioRefQuiet, audioMaxMedium, 2, false, 0, 1,, random_range(.8, 1.2));
	}
	
	instance_destroy();
}