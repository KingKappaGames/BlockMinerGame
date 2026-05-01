duration--;

if(duration <= 0) {
	instance_destroy();
} else {
	if(blockKnockdown) {
		var _camX = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) * .5;
		var _camY = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) * .5;
		
		var _tileX, _tileY;
		
		repeat(25 * strength) {
			var _x = _camX + irandom_range(-550, 550);
			var _y = _camY + irandom_range(-420, 420);
			
			_tileX = clamp(_x div tileSize, 0, global.tileRangeWorld - 2);
			_tileY = clamp(_y div tileSize, 0, global.tileRangeWorld - 2);
			
			var _tile = tiles[_tileX][_tileY];
			var _tileBelow = tiles[_tileX][_tileY + 1];
			
			if(_tile isSolid && _tileBelow isClear) { // if the block can fall anyway, don't loosen blocks that will just resettle the same place
				script_breakTile(_tileX, _tileY, .5, false);
	
				script_createMovingTile(_tileX * tileSize + tileSize * .5, _tileY * tileSize + tileSize * .5, 0, 0, _tile);
			}
		}
		
		script_cameraShake(.1 + strength * .1);
	}
	
	global.tileManager.updateScreenStatic();
}