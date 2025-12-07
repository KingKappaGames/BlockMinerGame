/// @desc Function Break a tile and handle results
/// @param {real} worldTileX The tile x index
/// @param {real} worldTileY The tile y index
/// @param {bool} [soundVolume]=true Whether to play the breaking sound for this tile
/// @param {bool} [updateScreen]=true Whether to update the screen after this tile, if this is part of a chain or group breaking (explosions for ex) then don't do this, the update should be wherever the thing orchestrating is
/// @param {bool} [doBreakEffects]=true Whether to run the break effect script that will do certain effects specific to the block, explosive blocks will blow up, terrain might spawn enemies, crystal might give some magic power.. ect
/// @returns {bool} Whether a tile was broken, regardless of which
function script_breakTile(worldTileX, worldTileY, soundVolume = 1, updateScreen = true, doBreakEffects = true) {
	if(worldTileX < 0 || worldTileX >= global.tileRangeWorld || worldTileY < 0 || worldTileY >= global.tileRangeWorld) {
		exit;
	}

	var _worldTiles = worldTiles;
	var _tileIndex = _worldTiles[worldTileX][worldTileY];
	
	if(_tileIndex != 0) {
		script_createBlockParticles(_tileIndex, worldTileX * tileSize + tileSize * .5, worldTileY * tileSize + tileSize * .5); // in theory each tile could store custom break visual effects (or just different particles) in the break effect script but for now I'll leave it
		
		if(doBreakEffects) {
			script_tileBreakEffects(worldTileX, worldTileY, _tileIndex);
		}
		
		if(soundVolume != 0) {
			audio_play_sound_at(_tileIndex >= 0 ? global.tileBreakSounds[_tileIndex] : global.tileBreakSoundsDecorative[abs(_tileIndex)], worldTileX * tileSize, worldTileY * tileSize, 0, audioRefQuiet, audioMaxQuiet, 1, 0, 0, soundVolume);
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