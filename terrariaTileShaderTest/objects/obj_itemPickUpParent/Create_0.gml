event_inherited();

sprite_index = spr_pickaxeBlue;

essential = true;

pickUpRange = 32;
available = false; // whether it can be picked up

pickupType = "pickaxe";
pickupIndex = E_pickaxe.blue;

//parts

image_angle = choose(45, 135, 225, 315) + irandom_range(-8, 8); // i just prefer the diagonals
image_xscale = 2;
image_yscale = 2;

pickUp = function() {
	var _player = player;
	
	if(pickupType == "pickaxe") {
		var _droppedPickaxe = instance_create_layer(_player.x, _player.y, "Instances", object_index);
		_droppedPickaxe.pickupIndex = _player.pickaxeIndex;
		_droppedPickaxe.sprite_index = script_getPickaxeSprite(_player.pickaxeIndex);
		
		_player.setPickaxe(pickupIndex);
	} else if(pickupType == "robe") {
		_player.setRobe(id);
	}
	
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	
	instance_destroy();
}



// im thinking pickaxe and other normal items can be randomly embeded in the ground and picked up like that
// magic spells can be floating orbs of light or something that have particle effects like bouts of fire or whatever
// and materials can be crystals or maybe orbs as well that place and destroy blocks around them to create a shell of that kind of material, all of the items will auto equip with a little effect
//     to show you have gained that ability (placing blocks is a crazy ability to gain yo)