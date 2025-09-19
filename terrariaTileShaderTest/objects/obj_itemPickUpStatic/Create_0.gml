event_inherited();

sprite_index = spr_pickaxeBlue;

pickUpRange = 32;
available = false; // whether it can be picked up

glimmerPart = global.itemGlimmerPart;
explosionPart = global.explosionPart;

image_angle = choose(45, 135, 225, 315) + irandom_range(-8, 8); // i just prefer the diagonals
image_xscale = 2;
image_yscale = 2;

depth += 10;

pickUp = function() {
	var _player = global.player;
	
	_player.setPickaxe(spr_pickaxeBlue);
	
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	
	instance_destroy();
}



// im thinking pickaxe and other normal items can be randomly embeded in the ground and picked up like that
// magic spells can be floating orbs of light or something that have particle effects like bouts of fire or whatever
// and materials can be crystals or maybe orbs as well that place and destroy blocks around them to create a shell of that kind of material, all of the items will auto equip with a little effect
//     to show you have gained that ability (placing blocks is a crazy ability to gain yo)