function script_createPickaxe(index = -1, xx = x, yy = y) {
	var _pickaxe = instance_create_layer(xx, yy, "Instances", choose(obj_itemPickUpFloat, obj_itemPickUpStatic));
	
	if(index == -1) {
		index = choose(E_pickaxe.basicRed, E_pickaxe.blue, E_pickaxe.banana, E_pickaxe.long, E_pickaxe.cycle);
	}
	
	with(_pickaxe) {
		pickupType = "pickaxe";
		pickupIndex = index;
		
		sprite_index = script_getPickaxeSprite(index);
	}
	
	return _pickaxe;
}