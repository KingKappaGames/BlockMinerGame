event_inherited();

var _range = 15;
if(irandom(4) == 0) {
	var _spawnX = x + irandom_range(-_range, _range);
	var _spawnY = y - 8 + irandom_range(-_range, _range);
	var _dir = point_direction(x, y - 8, _spawnX, _spawnY);
	part_type_orientation(shimmerPart, _dir, _dir, 0, 0, false);
	part_type_direction(shimmerPart, _dir, _dir, 0, 0);
	part_type_speed(shimmerPart, 1, 1.9, -.02, 0);
	part_particles_create(sysUnder, _spawnX, _spawnY, shimmerPart, 1);
	
	if(irandom(120) == 0) {
		part_particles_create(sys, _spawnX, _spawnY, shimmerPart, 1);
	}
}