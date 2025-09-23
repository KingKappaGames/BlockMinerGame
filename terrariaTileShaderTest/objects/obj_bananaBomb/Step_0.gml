if (live_call()) return live_result;

event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

if(irandom(3) == 0) {
	part_particles_create_color(sys, x + dcos(image_angle + 135) * 9, y - dsin(image_angle + 135) * 9, smokeTrailPart, c_yellow, 1);
}

yChange += grav; // gravity

script_moveCollide();

xChange *= speedDecay;

spinSpeed = xChange * -8; // match spin speed to "rolling" speed (assuming it perfectly matches but it would often times so..)

image_angle += spinSpeed;

duration--;
if(duration <= 0) {
	script_explodeTiles(x, y, 25, .15,,, false, true, .6);
	
	repeat(irandom_range(5, 8)) {
		script_placeTileAtPos(x + irandom_range(-90, 90) + irandom_range(-90, 90), y + irandom_range(-60, 60) + irandom_range(-60, 60), tileTypes.banana, true);
	}
	
	part_particles_create_color(sys, x, y, explosionPart, c_green, 25);
	part_particles_create_color(sys, x, y, explosionPart, c_yellow, 25);
	
	part_type_speed(trailerPart, 3.8, 5.6, 0, 0);
	part_particles_create_color(sys, x, y, trailerPart, c_yellow, 7);
	
	part_type_speed(starPart, 5, 7.4, -.14, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 42);
	
	
	repeat(irandom_range(15, 24)) {
		var _bomb = instance_create_layer(x, y, "Instances", obj_banana);
		_bomb.xChange = random_range(-8, 8);
		_bomb.yChange = random_range(-8, 8);
	}
	
	//audio_play_sound(snd_explosion, 0, 0, 2);
	
	instance_destroy();
}