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

if(keyboard_check_pressed(ord("E"))) {
	if(available) {
		pickUp();
		keyboard_clear(ord("E"));
	} else {
		if(inRange) {
			sound_play(snd_spellFizzle, 1, 1, .2, .2);
		}
	}
}