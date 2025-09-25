function script_spawnCreature(creature, xx, yy, healthSet, directionFacing = undefined) {
	directionFacing ??= choose(-1, 1);
	
	var _creature = instance_create_layer(xx, yy, "Instances", creature);
	with(_creature) {
		Health = healthSet;
		HealthMax = healthSet;
		directionFacing = directionFacing;
	}
}