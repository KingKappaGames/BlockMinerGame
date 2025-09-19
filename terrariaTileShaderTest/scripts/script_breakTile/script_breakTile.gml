function script_breakTile(worldTileX, worldTileY, playSound = true) {
	if(worldTileX < 0 || worldTileX >= tileRangeWorld || worldTileY < 0 || worldTileY >= tileRangeWorld) {
		exit;
	}
	
	var _manager = global.tileManager;

	var _worldTiles = global.worldTiles;
	var _tileIndex = _worldTiles[worldTileX][worldTileY];
	
	if(_tileIndex != 0) {
		script_createBlockParticles(_tileIndex, worldTileX * tileSize + tileSize * .5, worldTileY * tileSize + tileSize * .5);
		
		if(playSound) {
			if(_tileIndex == 2) {
				audio_play_sound_at(snd_breakBlockCrystal, x, y, 0, audioRefQuiet, audioMaxQuiet, 1, 0, 0);
			} else {
				audio_play_sound_at(snd_breakBlockWood, x, y, 0, audioRefQuiet, audioMaxQuiet, 1, 0, 0);
			}
		}
		
		_worldTiles[worldTileX][worldTileY] = 0;
		_manager.updateScreenStatic();
	}
	
}

function script_breakTileAtPos(worldX, worldY, playSound = true) {
	//gml_pragma("forceinline");
	script_breakTile(worldX div tileSize, worldY div tileSize, playSound); // wrapper for coords instead of tile index
}