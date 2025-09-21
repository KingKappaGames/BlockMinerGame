function script_loadStructure(rightTileX, topTileY, filename) {
	var _dataBuffer = buffer_load(filename);
	
	var _dataString = buffer_read(_dataBuffer, buffer_string);

	var _data = json_parse(_dataString);
		
	var _sTileGrid = _data.tileData;
	var _sClearGrid = _data.tileClearData;
	var _originX = _data.tileOriginX;
	var _originY = _data.tileOriginY;
	
	rightTileX -= _originX;
	topTileY -= _originY;
	
	var _sWidth = array_length(_sTileGrid);
	var _sHeight = array_length(_sClearGrid[0]);
	
	buffer_delete(_dataBuffer);
	
	// V V V PLACING TILES FROM STRUCTURE GRID INTO WORLD GRID V V V 
	
	var _tileWorldVal = 0;
	
	var _placeTileValue = 0;
	var _clearVal = 0;
	
	var _placeTileX = 0;
	var _placeTileY = 0;
	
	var _worldTiles = global.worldTiles;
	
	for (var _x = 0; _x < _sWidth; _x++) {
		for (var _y = 0; _y < _sHeight; _y++) {
			_placeTileX = rightTileX + _x;
			_placeTileY = topTileY + _y;
			
			if(_placeTileX > 0 && _placeTileX < tileRangeWorld - 1 && _placeTileY > 0 && _placeTileY < tileRangeWorld - 1) { // bound by one
				_tileWorldVal = _worldTiles[_placeTileX][_placeTileY];
				_placeTileValue = _sTileGrid[_x][_y];
				_clearVal = _sClearGrid[_x][_y];
				
				if(_tileWorldVal == 0) {
					if(_placeTileValue != 0) { // avoid redundancy i guess
						_worldTiles[_placeTileX][_placeTileY] = _placeTileValue;
					}
				} else {
					if(_tileWorldVal < 0) { // decoration tiles
						if(_tileWorldVal != _placeTileValue) { // avoid redundancy i guess
							_worldTiles[_placeTileX][_placeTileY] = _placeTileValue;
						}
					} else { // real tiles
						if(_tileWorldVal != _placeTileValue) { // avoid redundancy i guess
							if(_clearVal) { // if you should replace existing tiles
								_worldTiles[_placeTileX][_placeTileY] = _placeTileValue; // overwrite idc
							} // else you got stubbed bro
						}
					}
				}
			}
		}
	}
}