if (live_call()) return live_result;

if(irandom(10) == 0) {
	if(point_distance(x, y, player.x, player.y) < pickUpRange) {
		inRange = true;
	} else {
		inRange = false;
	}
	
	accesable = checkAccesable();
	
	available = accesable && inRange;
}

if(available) {
	if(keyboard_check_pressed(ord("E"))) {
		pickUp();
		keyboard_clear(ord("E"));
	}
}