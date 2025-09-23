event_inherited();

if(available) {
	if(keyboard_check_pressed(ord("E"))) {
		pickUp();
		keyboard_clear(ord("E"));
	}
}
// per instance yo VVV move to instance by instance basis
if(irandom(10) == 0) {
	part_particles_create_color(sysUnder, x, y, glimmerPart, c_yellow, 2);
}