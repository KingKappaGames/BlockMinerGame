function script_createMovingTile(xx, yy, xChangeSet, yChangeSet, materialSet) {
	var _tile =instance_create_layer(xx, yy, "Instances", obj_tileMovingDebris);
	with(_tile) {
		xChange = xChangeSet;
		yChange = yChangeSet;
		
		material = materialSet;
		
		sprite_index = global.tileSprites[material];
		image_blend = global.tileColors[material];
	}

	return _tile;
}