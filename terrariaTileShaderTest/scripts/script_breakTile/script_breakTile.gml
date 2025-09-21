/// @desc Function Break a tile and handle results
/// @param {real} worldTileX The tile x index
/// @param {real} worldTileY The tile y index
/// @param {bool} [playSound]=true Whether to play the breaking sound for this tile
/// @param {bool} [updateScreen]=true Whether to update the screen after this tile, if this is part of a chain or group breaking (explosions for ex) then don't do this, the update should be wherever the thing orchestrating is
/// @returns {bool} Whether a tile was broken, regardless of which
function script_breakTile(worldTileX, worldTileY, playSound = true, updateScreen = true) {
	if(worldTileX < 0 || worldTileX >= tileRangeWorld || worldTileY < 0 || worldTileY >= tileRangeWorld) {
		exit;
	}

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
		
		if(_worldTiles[worldTileX][worldTileY - 1] < 0) { // decoration
			script_breakTile(worldTileX, worldTileY - 1,, false); // try to only update the screen once per "action" so multiple blocks breaking at once only needs to update the screen once
		}
			
		if(updateScreen) {
			global.tileManager.updateScreenStatic();
		}
		
		return true;
	} else {
		return false;
	}
}

function script_breakTileAtPos(worldX, worldY, playSound = true, updateScreen = true) {
	//gml_pragma("forceinline");
	return script_breakTile(worldX div tileSize, worldY div tileSize, playSound); // wrapper for coords instead of tile index
}