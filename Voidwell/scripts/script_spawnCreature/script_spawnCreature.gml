function script_spawnCreature(creature, xx, yy, healthSet = undefined, directionFacing = undefined) {
	directionFacing ??= choose(-1, 1);
	
	var _creature = instance_create_layer(xx, yy, "Instances", creature);
	with(_creature) {
		if(!is_undefined(healthSet)) {
			Health = healthSet;
			HealthMax = healthSet;
		}
		directionFacing = directionFacing;
		
		spawn();
	}
	
	return _creature;
}