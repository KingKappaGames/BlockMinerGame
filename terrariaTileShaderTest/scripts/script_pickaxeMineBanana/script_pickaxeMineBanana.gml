function script_pickaxeMineBanana(xx, yy) {
	if(irandom(3) == 0) {
		var _tiles = global.worldTiles;
		var _tileX = xx div tileSize;
		var _tileY = yy div tileSize;
		if(_tiles[_tileX][_tileY] > 0) {
			script_placeTileAtPos(xx, yy, E_tile.banana, true);
			script_createBlockParticles(E_tile.banana, _tileX * tileSize + tileSize * .5, _tileY * tileSize + tileSize * .5);
			
			if(_tiles[_tileX + 1][_tileY] <= 0) {
				_tileX++
			} else if(_tiles[_tileX - 1][_tileY] <= 0) {
				_tileX--
			} else if(_tiles[_tileX][_tileY - 1] <= 0) {
				_tileY--;
			} else if(_tiles[_tileX][_tileY + 1] <= 0) {
				_tileY++
			} else {
				_tileX = x div tileSize; // if cardinals not open then just place at calling x/y because screw em
				_tileY = (y - 5) div tileSize;
			}
			
			repeat(irandom_range(2, 4)) {
				var _banana = instance_create_layer((_tileX + .5) * tileSize, (_tileY + .5) * tileSize, "Instances", obj_banana); // maybe find a better way to place the things in non stuck tiles..
				_banana.xChange = random_range(-3.2, 3.2);
				_banana.yChange = random_range(-3.2, 3.2);
			}
			
			audio_play_sound(snd_chime, 1, 0);
		}
		
		return false;
	} else {
		return script_breakTileAtPos(xx, yy); // expand i guess
	}
}