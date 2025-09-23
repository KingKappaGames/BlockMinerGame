event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

//part_particles_create_color(sys, x, y, smokeTrailPart, image_blend, 1);

yChange += grav; // gravity

script_moveCollide();

xChange *= speedDecay;

image_angle += spinSpeed;

duration--;
if(duration <= 0) { 
	//part_particles_create_color(sys, x, y, explosionPart, image_blend, 120);
	
	//audio_play_sound(snd_explosion, 0, 0, 2);
	
	instance_destroy();
}