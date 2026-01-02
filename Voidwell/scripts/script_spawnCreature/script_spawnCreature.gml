function script_spawnCreature(creature, xx, yy, healthSet = undefined, directionFacing = undefined) {
	directionFacing ??= choose(-1, 1);
	
	var _creature = instance_create_layer(xx, yy, "Instances", creature);
	with(_creature) {
		if(!is_undefined(healthSet)) {
			Health = healthSet;
			HealthMax = healthSet;
		}
		directionFacing = directionFacing;
		
		if(object_index == obj_person) {
			material = choose(E_tile.empty, E_tile.diamond, E_tile.grass, E_tile.metal);
			sprite_index = script_getRobeSpriteForMaterial(material);
	
			if(material == E_tile.diamond) {
				HealthMax *= .7;
				Health = HealthMax;
				damage *= 3;
				moveSpeed *= .9;
			} else if(material == E_tile.metal) {
				HealthMax *= 2;
				Health = HealthMax;
				damage *= 1.25;
				moveSpeed *= .7;
				knockbackMult = .2;
			} else if(material == E_tile.grass) {
				HealthMax *= 1;
				Health = HealthMax;
				damage *= 1;
				moveSpeed *= 1.5;
				knockbackMult = 1.8;
			}
		}
	}
	
	return _creature;
}