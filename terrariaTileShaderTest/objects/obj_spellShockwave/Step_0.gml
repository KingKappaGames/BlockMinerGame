event_inherited();

radius *= radiusMult;

var _angle = 0;
repeat((radius * .5 + 8) * strength) {
	_angle += 138.508;
	if(materialType == 0) {
		script_breakTileAtPos(x + dcos(_angle) * radius * .9 + irandom_range(-15, 15), y - dsin(_angle) * radius * .9 + irandom_range(-15, 15), .15, false);
	} else {
		script_placeTileAtPos(x + dcos(_angle) * radius * .9 + irandom_range(-15, 15), y - dsin(_angle) * radius * .9 + irandom_range(-15, 15), materialType, true);
	}
	
	global.tileManager.updateScreenStatic();
}

duration--;
if(duration <= 0) { 
	//part_particles_create_color(sys, x, y, explosionPart, image_blend, 120);
	
	//audio_play_sound(snd_explosion, 0, 0, 2);
	
	instance_destroy();
}