function script_createShockwaveSpell(xx, yy, durationSet = 13, radiusStart = tileSize, radiusMultSet = 1.165, materialTypeSet = 0, strengthSet = 1, dealDamageSet = true/*, caster = noone*/) {
	var _spell = instance_create_layer(xx, yy, "Instances", obj_spellShockwave);
	
	with(_spell) {
		duration = durationSet;
		materialType = materialTypeSet;
		radiusMult = radiusMultSet;
		radius = radiusStart;
		strength = strengthSet;
		dealDamage = dealDamageSet;
		//source = caster;
		
		image_blend = materialType >= 0 ? global.tileColors[materialType] : global.tileColorsDecorative[abs(materialType)];
	
		radiusExpand = radiusMultSet;
	}

	return _spell;
}