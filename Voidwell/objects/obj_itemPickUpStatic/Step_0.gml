event_inherited();

if(available) {
	if(keyboard_check_pressed(ord("E"))) {
		pickUp();
		keyboard_clear(ord("E"));
	}
}

if(object_index != obj_robePickup && object_index != obj_book) {
	// per instance yo VVV move to instance by instance basis
	if(irandom(10) == 0) {
		part_particles_create_color(sysUnder, x + random_range(-10, 10), y + random_range(-12, 12), glimmerPart, #ffff77, 2);
	}
}