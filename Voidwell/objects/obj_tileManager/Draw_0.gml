var _camX = camera_get_view_x(view_camera[0]);
var _camY = camera_get_view_y(view_camera[0]);
var _camW = camera_get_view_width(view_camera[0]);
var _camH = camera_get_view_height(view_camera[0]);

var _surf = getScreenSurf();
surface_set_target(_surf);

draw_clear_alpha(c_black, 0);

var _tileVal = 0;
var _tileX = 0;
var _tileY = 0;
var _color = c_white;
var _tileFrameIndex = 0;

var _tSprite = global.tileSprites;
var _tCol = global.tileColors;

var _tSpriteDec = global.tileSpritesDecorative;
var _tColDec = global.tileColorsDecorative;

var _tileScreen = tilesScreen;
var _screenWorldX = screenWorldX;
var _screenWorldY = screenWorldY; // yes this is meaningfully faster
var _screenWorldTileX = screenWorldTileX;
var _screenWorldTileY = screenWorldTileY; // since drawing the tiles is slow go through effort of localizing these big loop vars (that might get called 2000 times a frame here...)
var _screenTileWidth = tileScreenWidth;
var _screenTileHeight = tileScreenHeight;

//maybe add functions to the tile index so like, tile index 6 could have a smoke effect and tile index 3 could have smoke and glow and hurting you know? It could be stored as a ref to index data

for(var _x = 1; _x < _screenTileWidth - 1; _x++) {
	for(var _y = 1; _y < _screenTileHeight - 1; _y++) { // draw all tiles at least one tile in to avoid edge checking (the camera border should make them not appear anyway..)
		_tileVal = _tileScreen[_x][_y];
		
		if(_tileVal != 0) {
			if(_tileVal < 0) { // decorative (non blending) tiles
				_color = _tColDec[abs(_tileVal)];
				
				_tileFrameIndex = ((_screenWorldTileX + _x) * 17 + (_screenWorldTileY + _y) * 73) % 5; //clamp(dsin(current_time) * 7 + 4, 0, 10); // bah (arbitary mix up values)
				
				draw_sprite_ext(_tSpriteDec[abs(_tileVal)], _tileFrameIndex, _x * tileSize + tileSize * .5, _y * tileSize + tileSize * .5, _tileFrameIndex % 2 == 0 ? 1 : 1, 1, 0, _color, 1);
			} else { // physical, real tiles
				//_color = tileColors[_tileVal];
				
				_color = _tCol[_tileVal];
			 
				#region get tile index from surrounding arrangement
				
				_tileFrameIndex = 0;
				
				var _tileUp = _tileScreen[_x][_y - 1];
				var _tileDown = _tileScreen[_x][_y + 1];
				var _tileLeft = _tileScreen[_x - 1][_y];
				var _tileRight = _tileScreen[_x + 1][_y];
				
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
				
				draw_sprite_ext(_tSprite[_tileVal], _tileFrameIndex, _x * tileSize + tileSize * .5, _y * tileSize + tileSize * .5, 1, 1, 0, _color, 1);
			}
			
			//draw_text_transformed(screenWorldX + _x * tileSize + tileSize * .375, screenWorldY + _y * tileSize + tileSize * .25, _tileVal, .5, .5, 0);
			//draw_rectangle_color(screenWorldX + _x * tileSize, screenWorldY + _y * tileSize, screenWorldX + _x * tileSize + tileSize - 1, screenWorldY + _y * tileSize + tileSize - 1, _color, _color, _color, _color, false);
		}
		
		//draw_text(_x * tileSize + tileSize * .5, _y * tileSize + tileSize * .5, _tileVal)
	}
}

surface_reset_target();

shader_set(shd_terrainDetails);

var _drawX = _camX - (_camX - screenWorldX);
var _drawY = _camY - (_camY - screenWorldY);

shader_set_uniform_f(shader_get_uniform(shd_terrainDetails, "pos"), screenWorldX, screenWorldY);
shader_set_uniform_f(shader_get_uniform(shd_terrainDetails, "camSize"), surface_get_width(_surf), surface_get_height(_surf));
shader_set_uniform_f(shader_get_uniform(shd_terrainDetails, "aspectRatio"), surface_get_width(_surf) / surface_get_height(_surf));

var _camToGuiScale = view_wport[0] / _camW;
draw_surface(screenSurf, _drawX, _drawY);

shader_reset();

//if(global.timer % 30 == 0) {
	//show_debug_message($"View size: {view_wport[0]}/{view_hport[0]} and CamSize: {_camW}/{_camH} and pos: {_camX}/{_camY} and screenUpdateXY: {screenWorldX}/{screenWorldY} and surf size: {surface_get_width(screenSurf)}/{surface_get_height(screenSurf)}");
//}

/*
Take our tileArray for the screen and normalize the top left and bottom right, this is our range
In the shader we have our range, normalized to screen coordiantes, and a texture for the tiles to draw (specific to the tile we want) (though probably just color for now)
Then we need to pass the array for the screen to the shader, this array will hold the tile index (the shader will have the color / texture of the tile itself)
We also need to pass the tile permutation texture as a sampler / stage

Then inside the shader each pixel will do a fun thing, it will establish the nearest four tiles (as diagonals, so up left, up right, down left, down right) to see which tiles might contribute pixels to this area
Then with each of those tiles it will need to calculate 
 */