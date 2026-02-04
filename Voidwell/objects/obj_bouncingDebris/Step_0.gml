event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

if(makeTrailParts) {
	part_particles_create_color(sys, x, y, partTrail, image_blend, 1);
}

yChange += grav; // gravity

script_moveCollide();

image_angle += spinSpeed;

duration--;
if(duration <= 0) { 
	part_particles_create_color(sys, x + irandom_range(-4, 4), y + irandom_range(-4, 4), global.partSwirl, image_blend, 7);
	
	audio_play_sound_at(snd_spellFizzle, x, y, 0, audioRefQuiet, audioMaxQuiet, 2, false, 0, .4,, random_range(.8, 1.05));
	
	instance_destroy();
}