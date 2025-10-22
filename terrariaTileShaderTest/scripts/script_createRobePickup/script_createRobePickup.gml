function script_createRobePickup(index = -1, xx = x, yy = y) {
	var _robe = instance_create_layer(xx, yy, "Instances", obj_robePickup);
	
	if(index == -1) {
		index = choose(E_robe.superRed, E_robe.bananaYellow, E_robe.teleporterWhite, E_robe.materialGrass, E_robe.materialMetal, E_robe.materialCrystal, E_robe.materialFlesh);
	}
	
	_robe.robeIndex = index;
	
	_robe.sprite_index = script_getRobeSprite(index);
	
	return _robe;
	//what to do with this index...
}