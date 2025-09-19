if(irandom(10) == 0) {
	var _player = global.player;
	if(point_distance(x, y, global.player.x, global.player.y) < pickUpRange) {
		available = true;
	} else {
		available = false;
	}
}