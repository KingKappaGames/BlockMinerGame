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
		
	script_createShockwaveSpell(x, y, 3, tileSize * 1.5, 1.26,, 1.5);
	
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 25); // EXPLOSIVE PARTS
	part_type_speed(trailerPart, 1.5, 3.7, 0, 0);
	part_particles_create(sys, x, y, trailerPart, irandom_range(3, 4)); // TRAILINGS
	part_type_speed(starPart, 2.6, 4, -.07, 0);
	part_particles_create(sys, x, y, starPart, irandom_range(7, 10)); // STARS
	
	instance_destroy();
}