function script_placeTile(worldTileX, worldTileY, tileIndex, replaceExisting = false, coverEntities = false) {
	if(worldTileY < 0 || worldTileY >= global.tileRangeWorld || worldTileX < 0 || worldTileX >= global.tileRangeWorld) { // if out of world bounds completely
		return false;
	}
	
	var _manager = global.tileManager;
	var _worldTiles = global.worldTiles;
	
	if(!coverEntities) {
		var _entities = ds_list_create();
		script_getTileEntitiesInside(worldTileX, worldTileY, _entities);
		var _size = ds_list_size(_entities);
		
		ds_list_destroy(_entities);
		
		if(_size != 0) {
			return false;
		}
	}
	
	var _oldTile = _worldTiles[worldTileX][worldTileY];
	if(_oldTile != 0) {
		if(replaceExisting || _oldTile < 0) { // always break decoration tiles whne placed-over
			script_breakTile(worldTileX, worldTileY, .5, false, false);
		} else {
			return false;
		}
	}
	
	audio_play_sound_at(tileIndex >= 0 ? global.tilePlaceSounds[tileIndex] : global.tilePlaceSoundsDecorative[abs(tileIndex)], worldTileX * tileSize, worldTileY * tileSize, 0, audioRefTiny, audioMaxTiny, 1, 0, 0, 1);
	
	_worldTiles[worldTileX][worldTileY] = tileIndex;
	
	_manager.updateScreenStatic();
	
	return true;
}

function script_placeTileAtPos(worldX, worldY, tileIndex, replaceExisting = false, coverEntities = false) {
	gml_pragma("forceinline");
	return script_placeTile(worldX div tileSize, worldY div tileSize, tileIndex, replaceExisting, coverEntities); // wrapper for coords instead of tile index
	
}