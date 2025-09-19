global.tileManager = id;

cam = view_camera[0];

#region tile grid set up for world and screen/camera
#macro tileSize 16
#macro tileRangeWorld 2000
#macro worldSizePixels 32000 // make sure to update this, it won't show the value if I don't write it directly here so (tileSize * tileRangeWorld) isn't ideal.. (with the parenthesis or else it'll break the pemdas grouping which is crazy...)
#macro screenBorder 3
#macro spawnX tileSize * tileRangeWorld * .5
#macro spawnY tileSize * tileRangeWorld * .125

tiles = array_create(tileRangeWorld); // one dimension of the grid, generate the rest later in the generateWorld script
global.worldTiles = tiles;

tileScreenWidth = camera_get_view_width(cam) div tileSize + 2;
tileScreenHeight = camera_get_view_height(cam) div tileSize + 2;
tilesScreen = array_create(tileScreenWidth);
for (var _i = 0; _i < tileScreenWidth; _i++) {
	tilesScreen[_i] = array_create(tileScreenHeight); // 2d array of tiles 16x16 for demo purposes
}

global.screenTiles = tilesScreen;

screenWorldTileX = round(tileRangeWorld * .5);
screenWorldTileY = round(tileRangeWorld * .5);
global.screenTileLeft = screenWorldTileX;
global.screenTileTop = screenWorldTileY;

screenWorldX = 0;
screenWorldY = 0;

updateScreen = function(rightX = undefined, topY = undefined) {
	rightX ??= camera_get_view_x(cam);
	topY ??= camera_get_view_y(cam);
	
	var _screenTileX = clamp((rightX - screenBorder * tileSize) div tileSize, 0, tileRangeWorld - tileScreenWidth);
	var _screenTileY = clamp((topY - screenBorder * tileSize) div tileSize, 0, tileRangeWorld - tileScreenHeight);
	
	if(_screenTileX != screenWorldTileX || _screenTileY != screenWorldTileY) {
		screenWorldTileX = _screenTileX;
		screenWorldTileY = _screenTileY;
		global.screenTileLeft = _screenTileX;
		global.screenTileTop = _screenTileY;
		
		screenWorldX = _screenTileX * tileSize;
		screenWorldY = _screenTileY * tileSize; // not interested in the actual screen pos, just the tile position, this is a redundant value for convenience to not have to re-multiply tile size all the time
		
		var _width = camera_get_view_width(cam);
		var _height = camera_get_view_height(cam);
		tileScreenWidth = _width div tileSize + screenBorder * 2;
		tileScreenHeight = _height div tileSize + screenBorder * 2;
		
		if(array_length(tilesScreen) != tileScreenWidth) {
			var _prevLength = array_length(tilesScreen);
			array_resize(tilesScreen, tileScreenWidth);
			
			for(var _fillI = _prevLength; _fillI < tileScreenWidth; _fillI++) {
				tilesScreen[_fillI] = array_create(tileScreenHeight);
			}
		}
		
		for (var _i = 0; _i < tileScreenWidth; _i++) {
			array_copy(tilesScreen[_i], 0, tiles[screenWorldTileX + _i], screenWorldTileY, tileScreenHeight); // fills 2d array of screen with world sections at this position [x][y]
		}
	}
}

/// @desc Function Just updates the tiles in this position and size of screen, does not move the screen or update the position values, use when breaking or placing things that need to reflect across tile grids but not move or change the cameras. (updating camera and position values is half the work so this is faster)
updateScreenStatic = function() {
	for (var _i = 0; _i < tileScreenWidth; _i++) {
		array_copy(tilesScreen[_i], 0, tiles[screenWorldTileX + _i], screenWorldTileY, tileScreenHeight); // fills 2d array of screen with world sections at this position [x][y]
	}
}

#endregion

generateWorld = function(type = "normal") {
	if(type == "normal") {
		for (var _worldX = 0; _worldX < tileRangeWorld; _worldX++) {
			tiles[_worldX] = array_create(tileRangeWorld);
			
			for (var _worldY = 0; _worldY < tileRangeWorld; _worldY++) {
				var _tileType = 0;
				
				var _worldDepth = clamp(_worldY / tileRangeWorld, 0, 1);
				
				var _noise = _worldDepth * 4 + dsin(_worldX * 4) * .02 + dsin(_worldX * 1.3) * .04;
				
				_tileType = clamp(round(_noise), 0, 4);
				
				if(_tileType > 1) {
					if((dsin(screenWorldTileX * 13.9) + dsin(screenWorldTileX * 149.1) * .8 + dsin(screenWorldTileX * 410.8) * .4) > .5) {
						if(dsin(screenWorldTileY * 48.3) > .4) {
							_tileType = 0; // you're looking at caves buddy
						}
					}
				}
				
				tiles[_worldX][_worldY] = _tileType;
			}
		}
	} else if(type == "layers") {
		for (var _worldX = 0; _worldX < tileRangeWorld; _worldX++) {
			tiles[_worldX] = array_create(tileRangeWorld);
			
			for (var _worldY = 0; _worldY < tileRangeWorld; _worldY++) {
				tiles[_worldX][_worldY] = (_worldY % 50 < 15) ? 0 : irandom(3);
			}
		}
	} else if(type == "random") {
		for (var _worldX = 0; _worldX < tileRangeWorld; _worldX++) {
			tiles[_worldX] = array_create(tileRangeWorld);
			
			for (var _worldY = 0; _worldY < tileRangeWorld; _worldY++) {
				tiles[_worldX][_worldY] = irandom(3);
			}
		}
	}
}

generateWorld("normal");