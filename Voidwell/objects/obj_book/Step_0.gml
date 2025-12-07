if(!active) {
	if(irandom(10) == 0) {
		if(point_distance(x, y, player.x, player.y) < pickUpRange) {
			available = true;
		} else {
			available = false;
		}
	}
	
	if(available) {
		if(keyboard_check_pressed(ord("E"))) {
			pickUp();
			keyboard_clear(ord("E"));
		}
	}
} else {
	var _camX = camera_get_view_x(view_camera[0]);
	var _camY = camera_get_view_y(view_camera[0]);
	var _camW = camera_get_view_width(view_camera[0]);
	var _camH = camera_get_view_height(view_camera[0]);
	if(x > _camX && x < _camX + _camW && y > _camY && y < _camY + _camH) { // in camera
		var _passed = false;
		var _criteria = criteria[state];
		
		if(_criteria == mb_left || _criteria == mb_middle || _criteria == mb_right) { // if checking mouse buttons
			_passed =  mouse_check_button_released(_criteria);
		} else {
			_passed =  keyboard_check_released(_criteria);
		}
		if(_passed) {
			advance();
		}
	} else {
		deactivate();
	}
}

if(irandom(30) == 0) {
	var _spawnX = x + irandom_range(-25, 25);
	var _spawnY = y - 8 + irandom_range(-25, 25);
	var _dir = point_direction(x, y - 8, _spawnX, _spawnY);
	part_type_orientation(shimmerPart, _dir, _dir, 0, 0, false);
	part_type_direction(shimmerPart, _dir, _dir, 0, 0);
	part_type_speed(shimmerPart, 1, 1.9, -.02, 0);
	part_particles_create(sysUnder, _spawnX, _spawnY, shimmerPart, 1);
}