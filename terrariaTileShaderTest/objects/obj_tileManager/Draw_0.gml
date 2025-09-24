var _tileVal = 0;
var _tileX = 0;
var _tileY = 0;
var _color = c_white;
var _tileFrameIndex = 0;

var _tSprite = global.tileSprites;
var _tCol = global.tileColors;

var _tSpriteDec = global.tileSpritesDecorative;
var _tColDec = global.tileColorsDecorative;

//maybe add functions to the tile index so like, tile index 6 could have a smoke effect and tile index 3 could have smoke and glow and hurting you know? It could be stored as a ref to index data

for(var _x = 1; _x < tileScreenWidth - 1; _x++) {
	for(var _y = 1; _y < tileScreenHeight - 1; _y++) { // draw all tiles at least one tile in to avoid edge checking (the camera border should make them not appear anyway..)
		_tileVal = tilesScreen[_x][_y];
		
		if(_tileVal != 0) {
			if(_tileVal < 0) { // decorative (non blending) tiles
				_color = _tColDec[abs(_tileVal)];
				
				_tileFrameIndex = ((screenWorldTileY + _y) * 17 + (screenWorldTileX + _x) * 73) % 3; //clamp(dsin(current_time) * 7 + 4, 0, 10); // bah (arbitary mix up values)
				
				draw_sprite_ext(_tSpriteDec[abs(_tileVal)], _tileFrameIndex, screenWorldX + _x * tileSize + tileSize * .5, screenWorldY + _y * tileSize + tileSize * .5, 1, 1, 0, _color, 1);
			} else { // physical, real tiles
				//_color = tileColors[_tileVal];
				
				_color = _tCol[_tileVal];
			 
				#region get tile index from surrounding arrangement
				
				_tileFrameIndex = 0;
				
				var _tileUp = tilesScreen[_x][_y - 1];
				var _tileDown = tilesScreen[_x][_y + 1];
				var _tileLeft = tilesScreen[_x - 1][_y];
				var _tileRight = tilesScreen[_x + 1][_y];
				
				if(_tileLeft > 0) {
					_tileFrameIndex += 8;
				}
				if(_tileUp > 0) {
					_tileFrameIndex += 4;
				}
				if(_tileRight > 0) {
					_tileFrameIndex += 2;
				}
				if(_tileDown > 0) {
					_tileFrameIndex += 1;
				}
				
				#endregion
				
				//if(irandom(10000) == 0 || (_x == 1 && _y == 1)) {
					//show_debug_message($"_tileFrameIndex: {_tileFrameIndex}   _x: {_x}   _y: {_y}   _color: {_color}    screenWorldX: {screenWorldX}    screenWorldY: {screenWorldY}");
				//}
				
				draw_sprite_ext(_tSprite[_tileVal], _tileFrameIndex, screenWorldX + _x * tileSize + tileSize * .5, screenWorldY + _y * tileSize + tileSize * .5, 1, 1, 0, _color, 1);
			}
			
			//draw_text_transformed(screenWorldX + _x * tileSize + tileSize * .375, screenWorldY + _y * tileSize + tileSize * .25, _tileVal, .5, .5, 0);
			//draw_rectangle_color(screenWorldX + _x * tileSize, screenWorldY + _y * tileSize, screenWorldX + _x * tileSize + tileSize - 1, screenWorldY + _y * tileSize + tileSize - 1, _color, _color, _color, _color, false);
		}
		
		//draw_text(_x * tileSize + tileSize * .5, _y * tileSize + tileSize * .5, _tileVal)
	}
}

/*
Take our tileArray for the screen and normalize the top left and bottom right, this is our range
In the shader we have our range, normalized to screen coordiantes, and a texture for the tiles to draw (specific to the tile we want) (though probably just color for now)
Then we need to pass the array for the screen to the shader, this array will hold the tile index (the shader will have the color / texture of the tile itself)
We also need to pass the tile permutation texture as a sampler / stage

Then inside the shader each pixel will do a fun thing, it will establish the nearest four tiles (as diagonals, so up left, up right, down left, down right) to see which tiles might contribute pixels to this area
Then with each of those tiles it will need to calculate 
 */