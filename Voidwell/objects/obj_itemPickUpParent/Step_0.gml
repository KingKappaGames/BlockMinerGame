if(irandom(10) == 0) {
	if(point_distance(x, y, player.x, player.y) < pickUpRange) {
		available = true;
	} else {
		available = false;
	}
}