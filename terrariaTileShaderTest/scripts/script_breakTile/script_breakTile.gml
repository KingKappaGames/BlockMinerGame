/// @desc Function Break a tile and handle results
/// @param {real} worldTileX The tile x index
/// @param {real} worldTileY The tile y index
/// @param {bool} [soundVolume]=true Whether to play the breaking sound for this tile
/// @param {bool} [updateScreen]=true Whether to update the screen after this tile, if this is part of a chain or group breaking (explosions for ex) then don't do this, the update should be wherever the thing orchestrating is
/// @returns {bool} Whether a tile was broken, regardless of which
function script_breakTile(worldTileX, worldTileY, soundVolume = 1, updateScreen = true) {
	if(worldTileX < 0 || worldTileX >= global.tileRangeWorld || worldTileY < 0 || worldTileY >= global.tileRangeWorld) {
		exit;
	}

	var _worldTiles = global.worldTiles;
	var _tileIndex = _worldTiles[worldTileX][worldTileY];
	
	if(_tileIndex != 0) {
		script_createBlockParticles(_tileIndex, worldTileX * tileSize + tileSize * .5, worldTileY * tileSize + tileSize * .5);
		
		if(soundVolume != 0) {
			if(_tileIndex == 2) {
				audio_play_sound_at(snd_breakBlockCrystal, x, y, 0, audioRefQuiet, audioMaxQuiet, 1, 0, 0, soundVolume);
			} else {
				audio_play_sound_at(snd_breakBlockWood, x, y, 0, audioRefQuiet, audioMaxQuiet, 1, 0, 0, soundVolume);
			}
		}
		
		_worldTiles[worldTileX][worldTileY] = 0;
		
		if(worldTileY > 0 && _worldTiles[worldTileX][worldTileY - 1] < 0) { // decoration
			script_breakTile(worldTileX, worldTileY - 1, soundVolume, false); // try to only update the screen once per "action" so multiple blocks breaking at once only needs to update the screen once
		}
			
		if(updateScreen) {
			global.tileManager.updateScreenStatic();
		}
		
		return true;
	} else {
		return false;
	}
}

function script_breakTileAtPos(worldX, worldY, soundVolume = 1, updateScreen = true) {
	gml_pragma("forceinline");
	return script_breakTile(worldX div tileSize, worldY div tileSize, soundVolume); // wrapper for coords instead of tile index
}