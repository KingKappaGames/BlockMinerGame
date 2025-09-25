function script_spawnAmbientCreatures() {
	if(instance_number(obj_creature) < 10) {
		var _camCenterX = camera_get_view_x(cam);
		var _camCenterY = camera_get_view_y(cam);
		var _camW = camera_get_view_width(cam);
		
		var _dir = irandom(360);
		var _spawnX = _camCenterX + dcos(_dir) * _camW * .67;
		var _spawnY = _camCenterY - dsin(_dir) * _camW * .45;
		
		if(irandom(3) == 0) {
			script_createWorm(_spawnX, _spawnY, 20, 20);
		} else {
			script_spawnCreature(obj_person, _spawnX, _spawnY, 5);
		}
	}
}