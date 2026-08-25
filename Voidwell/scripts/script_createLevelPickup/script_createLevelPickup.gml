function script_createLevelPickup(xx, yy) {
	var _node = instance_create_layer(xx, yy, "Instances", obj_levelPickup);
	with(_node) {
		image_blend = c_random;
	}
	
	return _node;
}