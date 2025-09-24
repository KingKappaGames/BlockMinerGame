function script_createRobePickup(index, xx, yy) {
	var _robe = instance_create_layer(xx, yy, "Instances", obj_robePickup);
	_robe.robeIndex = index;
	
	_robe.sprite_index = script_getRobeSprite(index);
	
	return _robe;
	//what to do with this index...
}