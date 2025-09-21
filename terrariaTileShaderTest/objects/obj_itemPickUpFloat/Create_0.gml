event_inherited();

sprite_index = spr_talisman;

image_xscale = 2;
image_yscale = 2;

originX = x;
originY = y;

bobRange = 30;
bobTimeScale = .12; // over current_time as a direction

xChange = 0;
yChange = 0;

moveSpeed = .1;
speedDecay = .98;

depth -= 10;

explosionPart = global.explosionPart;
glimmerPart = global.itemGlimmerPart;

pickUp = function() {
	var _player = global.player;
	
	_player.setPickaxe(spr_pickaxeBlue, 72, 10);
	
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	
	instance_destroy();
}

// when close enough to be obvious that the player is trying to approach the item lerp the camera towards the item to create a two sided scene, yk what i'm saying?