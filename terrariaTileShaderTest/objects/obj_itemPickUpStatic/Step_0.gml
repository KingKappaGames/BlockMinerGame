event_inherited();

if(irandom(10) == 0) {
	part_particles_create_color(sysUnder, x, y, glimmerPart, c_yellow, 2);
}

if(available) {
	if(keyboard_check_pressed(ord("E"))) {
		pickUp();
	}
}