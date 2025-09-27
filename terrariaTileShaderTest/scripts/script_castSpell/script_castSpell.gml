function script_castSpell(spellIndex, xx, yy, targetX, targetY, speedMult = 1, damageMult = 1) {
	var _spell = noone;
	
	if(spellIndex == 0)  {
		// none
	} else if(spellIndex == E_spell.bolt) {
		var _dir = point_direction(xx, yy, targetX, targetY) + irandom_range(-2, 2);
		
		_spell = instance_create_layer(xx, yy, "Instances", obj_magicBolt);
		_spell.xChange = dcos(_dir) * 11.5 * speedMult;
		_spell.yChange = -dsin(_dir) * 11.5 * speedMult;
	} else if(spellIndex == E_spell.shockwave) {
		_spell = instance_create_layer(targetX, targetY, "Instances", obj_spellShockwave);
	} else if(spellIndex == E_spell.bananaShimmer) {
		var _dir = point_direction(xx, yy, targetX, targetY) + irandom_range(-4, 4);
		
		_spell = instance_create_layer(xx, yy, "Instances", obj_bananaShimmer);
		_spell.xChange = dcos(_dir) * 3.2 * speedMult;
		_spell.yChange = -dsin(_dir) * 3.2 * speedMult;
	} else if(spellIndex == E_spell.explosiveBolt) {
		var _dir = point_direction(xx, yy, targetX, targetY) + irandom_range(-4, 4);
		
		_spell = instance_create_layer(xx, yy, "Instances", obj_explosiveBolt);
		_spell.xChange = dcos(_dir) * 10 * speedMult;
		_spell.yChange = -dsin(_dir) * 10 * speedMult;
	}
	
	_spell.source = id;
	
	return _spell;
}

/*

y + spellYOff - 10
x + spellXOff