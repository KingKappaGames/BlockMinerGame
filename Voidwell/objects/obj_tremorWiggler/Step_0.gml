duration--;

if(duration <= 0) {
	instance_destroy();
} else {
	if(blockKnockdown) {
		var _tileX, _tileY;
		
		repeat(10 * strength) {
			var _x = x + irandom_range(-500, 500);
			var _y = y + irandom_range(-300, 300);
			
			_tileX = _x div tileSize;
			_tileY = _y div tileSize;
			
			var _tile = tiles[_tileX][_tileY];
			var _tileBelow = tiles[_tileX][_tileY + 1];
			
			if(_tile isSolid && _tileBelow isClear) { // if the block can fall anyway, don't loosen blocks that will just resettle the same place
				script_breakTileAtPos(_x, _y, .5, false);
	
				script_createMovingTile(_tileX * tileSize + tileSize * .5, _tileY * tileSize + tileSize * .5, 0, 0, _tile);
			}
		}
		
		script_cameraShake(.1 + strength * .1);
	}
	
	global.tileManager.updateScreenStatic();
}