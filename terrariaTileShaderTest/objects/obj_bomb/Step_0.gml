event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

part_particles_create_color(sys, x, y, smokeTrailPart, image_blend, 1);

yChange += grav; // gravity

script_moveCollide();

xChange *= speedDecay;

duration--;
if(duration <= 0) {
	script_explodeTiles(x, y, 220, .2,,, true, true, true);
	
	//part_particles_create_color(sys, x, y, explosionPart, image_blend, 120);
	
	//audio_play_sound(snd_explosion, 0, 0, 2);
	
	instance_destroy();
}