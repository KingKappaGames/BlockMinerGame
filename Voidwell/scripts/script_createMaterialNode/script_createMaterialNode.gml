function script_createMaterialNode(xx, yy, type) {
	var _node = instance_create_layer(xx, yy, "Instances", obj_materialOrbNode);
	with(_node) {
		materialType = type;
		if(materialType == E_tile.explosive || materialType == E_tile.banana) {
			shockwaveDuration = 9; // shorter lived bursts but faster expanding, still smaller / less tiles than normal because explosives are laggy yo
			radiusExpand = 1.2;
			strengthMult = .3;
		}
		image_blend = materialType >= 0 ? global.tileColors[materialType] : global.tileColorsDecorative[abs(materialType)];
	}
	
	return _node;
}