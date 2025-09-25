/// @desc Function Given a coordinate or tile position finds the nearest ground below and retruns the Y VALUE not the tile
/// @param {real} xx 
/// @param {real} yy 
/// @param {real} precisionInTiles The amount to jump when searching for the next tile, 1 is perfect, 2 or 4 ect would be fast and usually (the final placement will set to the exact ground anyway it's just a question of whether single floating blocks could get skipped.) Also I suppose a negative value could find the ceiling BUT it doesn't check for out of bounds upwards so it'll crash in open air cases and no I'm not adding that until i need to because it's not the use case (make a separate function if you do!!)
/// @param {bool} [useTiles]=false Whether the input coords are in tiles or not
/// @returns {any} The y of the ground (one pixel up from tile) OR -1 if no tile was found because you're over the void, it was too far, you're above the world, ect
function script_findGroundBelow(xx, yy, precisionInTiles = 4, useTiles = false, tileRangeBeforeFail = 100) { // maybe tiles over the world should just start inside the world?
	if(!useTiles) {
		xx = xx div tileSize;
		yy = yy div tileSize;
	}
	
	var _worldTileSize = global.tileRangeWorld;
	
	if(xx >= 0 && xx < _worldTileSize && yy >= 0 && yy < _worldTileSize) {
		var _tiles = global.worldTiles;
		
		var _limitY = yy + tileRangeBeforeFail;
		for (var _checkY = yy; _checkY < _limitY; _checkY += precisionInTiles) {
			if(_checkY >= _worldTileSize) {
				return -1;
			}
			
			if(_tiles[xx][_checkY] > 0) { // found solid ground
				_checkY -= precisionInTiles;
				for (var _checkBackI = _checkY + precisionInTiles - 1; _checkBackI > _checkY; _checkBackI--) { // get one step back and walk forward 1 tile at a time to verify the tile you hit isn't underground at that point (at least the back one step tile is over ground..)
					if(_tiles[xx][_checkBackI] <= 0) {
						return _checkBackI * tileSize + 15;
					}
				}
				
				return (_checkY - precisionInTiles) * tileSize + 15;
			}
		}
		
		return -1;
	} else {
		return -1;
	}
}