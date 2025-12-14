/// @desc Function Given the tile to check checks down from there (inclusive) until it reaches the max depth below then returns -1 if no bottom found in that range or the depth as a relative, so 4 for for tiles down, not the y position
/// @param {any*} tileX The tile x of the first check (index)
/// @param {real} firstTileY The tile y of the first check (index)
/// @param {real} depthCheckMax How many tiles to check downwards, inlusive, so 3 means current tile then two more and then fail
/// @returns {real} -1 or depth (below check tile origin y)
function script_checkDepthAtTile(tileX, firstTileY, depthCheckMax) {
	depthCheckMax = min(depthCheckMax, global.tileRangeWorld - firstTileY);
	
	var _func = function(val, ind) { 
		if(val > 0) { 
			return true; 
		} else {
			return false;
		}
	};
	
	var _foundY = array_find_index(tiles[tileX], _func, firstTileY, depthCheckMax);
	return _foundY == -1 ? -1 : _foundY - firstTileY; // search this column of the world for a solid block until a give up depth
}