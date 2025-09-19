function script_breakTile(worldTileX, worldTileY) {
	if(worldTileX < 0 || worldTileX >= tileRangeWorld || worldTileY < 0 || worldTileY >= tileRangeWorld) {
		exit;
	}
	
	var _manager = global.tileManager;

	var _worldTiles = global.worldTiles;
	var _tileIndex = _worldTiles[worldTileX][worldTileY];
	
	if(_tileIndex != 0) {
		script_createBlockParticles(_tileIndex, worldTileX * tileSize + tileSize * .5, worldTileY * tileSize + tileSize * .5);
		
		if(_tileIndex == 2) {
			audio_play_sound(snd_breakBlockCrystal, 0, 0);
		} else {
			audio_play_sound(snd_breakBlockWood, 0, 0);
		}
		
		_worldTiles[worldTileX][worldTileY] = 0;
		_manager.updateScreenStatic();
	}
	
}

function script_breakTileAtPos(worldX, worldY) {
	//gml_pragma("forceinline");
	script_breakTile(worldX div tileSize, worldY div tileSize); // wrapper for coords instead of tile index
}