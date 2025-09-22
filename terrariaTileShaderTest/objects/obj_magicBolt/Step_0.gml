event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

part_particles_create_color(sys, x + irandom_range(-2, 2), y + irandom_range(-2, 2), global.thickTrail, image_blend, 2);
part_particles_create_color(sys, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), global.thickTrail, image_blend, 2);

duration--;

x += xChange;
y += yChange;

var _tileOn = global.worldTiles[x div tileSize][y div tileSize];

if(duration <= 0 || _tileOn > 0) {
	if(irandom(25) == 0) {
		script_breakTileAtPos(x, y, .8);
	}
	
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 5);
	
	//audio_play_sound(snd_explosion, 0, 0, 2);
	
	instance_destroy();
} else if(_tileOn < 0) {
	script_breakTileAtPos(x, y, .5);
}
