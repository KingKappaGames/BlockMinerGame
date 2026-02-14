function script_spawnAmbientCreatures() {
	if(global.bossSpawned) { 
		if(irandom(3) != 0) { // tank spawn rates while boss exists
			exit;
		}
	}
	var _camW = camera_get_view_width(cam);
	var _camH = camera_get_view_height(cam);
	var _camCenterX = camera_get_view_x(cam) + _camW * .5;
	var _camCenterY = camera_get_view_y(cam) + _camH * .5;
	
	var _dir = irandom(360);
	var _spawnX = _camCenterX + dcos(_dir) * _camW * .6;
	var _spawnY = _camCenterY - dsin(_dir) * _camH * .6;
	
	if(_spawnX < tileSize || _spawnY < tileSize || _spawnX >= global.worldSizePixels - tileSize || _spawnY >= global.worldSizePixels - tileSize) { exit; } // don't spawn outside of the map... (maybe it depends on the enemy?)
	
	if(irandom(30) == 0) {
		if(irandom(2) == 0) {
			if(_camCenterY > global.worldSizePixels * .68) { // is this not backwards? Greater than depth = normal worm? Or did i not want giant worms spawning underground...
				script_createWorm(_spawnX, _spawnY, 18);
			} else {
				script_createWorm(_spawnX, _spawnY, 18,,, irandom(1));
			}
		} else {
			script_spawnCreature(obj_pixie, _spawnX, _spawnY);
		}
	} else if(irandom(200) == 0 && _camCenterY > global.worldSizePixels * .96 - 250) {
		script_spawnCreature(obj_abyssLord, _spawnX, _spawnY);
	} else {
		if(tiles[_spawnX div tileSize][_spawnY div tileSize] isClear) {
			if(tiles[_spawnX div tileSize][_spawnY div tileSize + 1] isSolid) { // standing over solid ground
				if(irandom(5) == 0 && _camCenterY > global.worldSizePixels * .48) {
					script_spawnCreature(obj_bombThrower, _spawnX, _spawnY);
				} else {
					script_spawnCreature(obj_person, _spawnX, _spawnY);
				}
			} else {
				if(irandom(20 + instance_number(obj_creature)) == 0) {
					script_spawnCreature(choose(obj_flyingEnemy, obj_flyingEnemy, obj_burstingSack), _spawnX, _spawnY);
				}
			}
		}
	}
}