event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

if(irandom(3) == 0) {
	part_particles_create_color(sys, x + irandom_range(-tileSize * .5, tileSize * .5), y + irandom_range(-tileSize * .5, tileSize * .5), partTrail, image_blend, 1);
}


yChange += grav; // gravity

var _tileHitting = tiles[(x + xChange) div tileSize][(y + yChange) div tileSize];
if(_tileHitting isSolid) {
	script_placeTileAtPos(x, y, material, true, true);
	instance_destroy();
}

x += xChange;
y += yChange;

duration--;
if(duration <= 0) { 
	part_particles_create_color(sys, x + irandom_range(-tileSize * .5, tileSize * .5), y + irandom_range(-tileSize * .5, tileSize * .5), global.partSwirl, image_blend, 4);
	part_particles_create_color(sys, x + irandom_range(-tileSize * .5, tileSize * .5), y + irandom_range(-tileSize * .5, tileSize * .5), global.breakPart, image_blend, 15);
	
	audio_play_sound_at(global.tileBreakSounds[material], x, y, 0, audioRefQuiet, audioMaxQuiet, 2, false, 0, .5,, random_range(.8, 1.05));
	
	instance_destroy();
}