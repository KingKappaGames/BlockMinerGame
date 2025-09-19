function script_placeTile(worldTileX, worldTileY, tileIndex) {
	if(worldTileX < 0 || worldTileX > tileRangeWorld || worldTileY < 0 || worldTileY > tileRangeWorld) {
		exit;
	}
	
	var _manager = global.tileManager;
	var _screenLeft = global.screenTileLeft;
	var _screenTop = global.screenTileTop;
	
	if(worldTileX >= _screenLeft && worldTileX < _screenLeft + _manager.tileScreenWidth) {
		if(worldTileY >= _screenTop && worldTileY < _screenTop + _manager.tileScreenHeight) {
			if(global.worldTiles[worldTileX][worldTileY] == 0) {
				audio_play_sound(snd_placeBlock, 0, 0);
			
				global.worldTiles[worldTileX][worldTileY] = tileIndex;
				_manager.updateScreenStatic();
			}
		}
	}
	
}

function script_placeTileAtPos(worldX, worldY, tileIndex) {
	//gml_pragma("forceinline");
	script_placeTile(worldX div tileSize, worldY div tileSize, tileIndex); // wrapper for coords instead of tile index
}