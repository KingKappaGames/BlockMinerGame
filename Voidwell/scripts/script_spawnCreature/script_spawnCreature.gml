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
			sprite_index = choose(spr_player, spr_playerCrystal, spr_playerGrass, spr_playerMetal);
	
			if(sprite_index == spr_playerCrystal) {
				HealthMax *= .7;
				Health = HealthMax;
				damage *= 3;
				moveSpeed *= .9;
			} else if(sprite_index == spr_playerMetal) {
				HealthMax *= 2;
				Health = HealthMax;
				damage *= 1.25;
				moveSpeed *= .7;
				knockbackMult = .2;
			} else if(sprite_index == spr_playerGrass) {
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