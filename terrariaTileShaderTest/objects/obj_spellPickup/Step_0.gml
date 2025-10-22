event_inherited();

if(irandom(4) == 0) {
	var _spawnX = x + irandom_range(-25, 25);
	var _spawnY = y - 8 + irandom_range(-25, 25);
	var _dir = point_direction(x, y - 8, _spawnX, _spawnY);
	part_type_orientation(shimmerPart, _dir, _dir, 0, 0, false);
	part_type_direction(shimmerPart, _dir, _dir, 0, 0);
	part_type_speed(shimmerPart, 1, 1.9, -.02, 0);
	part_particles_create(sys, _spawnX, _spawnY, shimmerPart, 1);
}