function script_spawnAmbientCreatures() {
	var _camCenterX = camera_get_view_x(cam);
	var _camCenterY = camera_get_view_y(cam);
	var _camW = camera_get_view_width(cam);
	
	var _dir = irandom(360);
	var _spawnX = _camCenterX + dcos(_dir) * _camW * .67;
	var _spawnY = _camCenterY - dsin(_dir) * _camW * .45;
	
	if(_spawnX < tileSize || _spawnY < tileSize || _spawnX >= global.worldSizePixels - tileSize || _spawnY >= global.worldSizePixels - tileSize) { exit; } // don't spawn outside of the map... (maybe it depends on the enemy?)
	
	if(irandom(25) == 0) {
		if(irandom(1) == 0) {
			script_createWorm(_spawnX, _spawnY, 20);
		} else {
			script_spawnCreature(obj_pixie, _spawnX, _spawnY);
		}
	} else if(irandom(200) == 0 && _camCenterY > global.worldSizePixels * .97 - 250) {
		script_spawnCreature(obj_abyssLord, _spawnX, _spawnY);
	} else {
		if(global.worldTiles[_spawnX div tileSize][_spawnY div tileSize] <= 0) {
			if(global.worldTiles[_spawnX div tileSize][_spawnY div tileSize + 1] > 0) { // standing over solid ground
				script_spawnCreature(obj_person, _spawnX, _spawnY, 5);
			}
		}
	}
}