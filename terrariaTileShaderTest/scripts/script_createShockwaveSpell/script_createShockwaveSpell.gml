function script_createShockwaveSpell(xx, yy, duration = 13, radiusStart = tileSize, radiusMult = 1.165, materialType = 0, strength = 1) {
	var _spell = instance_create_layer(xx, yy, "Instances", obj_spellShockwave);
	
	_spell.duration = duration;
	_spell.materialType = materialType;
	_spell.radiusMult = radiusMult;
	_spell.radius = radiusStart;
	_spell.strength = strength;
	
	return _spell;
}