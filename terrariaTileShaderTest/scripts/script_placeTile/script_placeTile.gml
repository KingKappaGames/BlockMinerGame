function script_placeTile(worldTileX, worldTileY, tileIndex, replaceExisting = false, coverEntities = false) {
	if(worldTileX < 0 || worldTileX >= tileRangeWorld || worldTileY < 0 || worldTileY >= tileRangeWorld) { // if out of world bounds completely
		return;
	}
	
	var _manager = global.tileManager;
	var _screenLeft = global.screenTileLeft;
	var _screenTop = global.screenTileTop;
	
	if(!coverEntities) {
		var _entities = ds_list_create();
		script_getTileEntitiesInside(worldTileX, worldTileY, _entities);
		var _size = ds_list_size(_entities);
		
		ds_list_destroy(_entities);
		
		if(_size != 0) {
			return;
		}
	}
	
	var _oldTile = global.worldTiles[worldTileX][worldTileY];
	if(_oldTile != 0) {
		if(replaceExisting || _oldTile < 0) { // always break decoration tiles whne placed-over
			script_breakTile(worldTileX, worldTileY, true, false);
		} else {
			return;
		}
	}
	
	audio_play_sound_at(snd_placeBlock, worldTileX * tileSize, worldTileY * tileSize, 0, audioRefTiny, audioMaxTiny, 1, 0, 0, 1);
	global.worldTiles[worldTileX][worldTileY] = tileIndex;
	
	_manager.updateScreenStatic();
}

function script_placeTileAtPos(worldX, worldY, tileIndex, replaceExisting = false) {
	//gml_pragma("forceinline");
	script_placeTile(worldX div tileSize, worldY div tileSize, tileIndex, replaceExisting); // wrapper for coords instead of tile index
	
}