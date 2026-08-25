event_inherited();

sprite_index = spr_pickaxeBlue;

essential = true;

pickUpRange = 32;
available = false; // whether it can be picked up overall
inRange = false;
accesable = false; // whether the item is available to the player based on criteria or level

levelRequirement = 0; // 0 = none

pickupType = "pickaxe";
pickupIndex = E_pickaxe.blue;

pickupText = "E to pickup";

drawPickupTextBase = function() {
	if(available) {
		if(pickupText != -1) {
			var _textX = (x * 2 + global.player.x) / 3;
			var _textY = (y * 2 + global.player.y) / 3 - 50;
			
			var _col = #ffff88;
			draw_text_transformed_color(_textX, _textY, pickupText, .25, .25, 0, _col, _col, _col, _col, 1);
		}
	}
}

drawPickupText = function() {
	drawPickupTextBase();
}

checkAccesable = function() {
	return true; // overriden by children
}

//parts

image_angle = choose(45, 135, 225, 315) + irandom_range(-8, 8); // i just prefer the diagonals
image_xscale = 2;
image_yscale = 2;

pickUp = function() { // overriden in children 
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	
	instance_destroy();
}



// im thinking pickaxe and other normal items can be randomly embeded in the ground and picked up like that
// magic spells can be floating orbs of light or something that have particle effects like bouts of fire or whatever
// and materials can be crystals or maybe orbs as well that place and destroy blocks around them to create a shell of that kind of material, all of the items will auto equip with a little effect
//     to show you have gained that ability (placing blocks is a crazy ability to gain yo)