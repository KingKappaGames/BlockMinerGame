event_inherited();

radius *= 1.165;

var _angle = 0;
repeat(radius * .5 + 8) {
	_angle += 16.73;
	script_breakTileAtPos(x + dcos(_angle) * radius * .9 + irandom_range(-15, 15), y - dsin(_angle) * radius * .9 + irandom_range(-15, 15),, false);
	
	global.tileManager.updateScreenStatic();
}

duration--;
if(duration <= 0) { 
	//part_particles_create_color(sys, x, y, explosionPart, image_blend, 120);
	
	//audio_play_sound(snd_explosion, 0, 0, 2);
	
	instance_destroy();
}