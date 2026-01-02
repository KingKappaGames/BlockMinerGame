event_inherited();

pickUp = function() {
	var _player = player;
	
	var _droppedPickaxe = instance_create_layer(_player.x, _player.y, "Instances", object_index);
	_droppedPickaxe.pickupIndex = _player.pickaxeIndex;
	_droppedPickaxe.sprite_index = script_getPickaxeSprite(_player.pickaxeIndex);
	
	_player.setPickaxe(pickupIndex);
	
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	
	instance_destroy();
}