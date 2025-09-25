global.tileManager = id;

cam = view_camera[0];

#region tile grid set up for world and screen/camera
#macro tileSize 16
global.tileRangeWorld = 0;
global.worldSizePixels = 0; // make sure to update this, it won't show the value if I don't write it directly here so (tileSize * tileRangeWorld) isn't ideal.. (with the parenthesis or else it'll break the pemdas grouping which is crazy...)
#macro screenBorder 3
global.spawnX = 0;
global.spawnY = 0;

tiles = array_create(0); // one dimension of the grid, generate the rest later in the generateWorld script

tileScreenWidth = 0;
tileScreenHeight = 0;
tilesScreen = array_create(tileScreenWidth);

global.screenTiles = tilesScreen;

screenWorldTileX = 0;
screenWorldTileY = 0;
global.screenTileLeft = screenWorldTileX;
global.screenTileTop = screenWorldTileY;

screenWorldX = 0;
screenWorldY = 0;

updateScreen = function(rightX = undefined, topY = undefined, sizeChanged = false) {
	rightX ??= camera_get_view_x(cam);
	topY ??= camera_get_view_y(cam);
	
	var _tileWorldRange = global.tileRangeWorld;
	
	var _screenTileX = clamp((rightX - screenBorder * tileSize) div tileSize, 0, _tileWorldRange - tileScreenWidth);
	var _screenTileY = clamp((topY - screenBorder * tileSize) div tileSize, 0, _tileWorldRange - tileScreenHeight);
	
	if(_screenTileX != screenWorldTileX || _screenTileY != screenWorldTileY || sizeChanged) {
		screenWorldTileX = _screenTileX;
		screenWorldTileY = _screenTileY;
		global.screenTileLeft = _screenTileX;
		global.screenTileTop = _screenTileY;
		
		screenWorldX = _screenTileX * tileSize;
		screenWorldY = _screenTileY * tileSize; // not interested in the actual screen pos, just the tile position, this is a redundant value for convenience to not have to re-multiply tile size all the time
		
		var _width = camera_get_view_width(cam);
		var _height = camera_get_view_height(cam);
		tileScreenWidth = min(_width div tileSize + screenBorder * 2, _tileWorldRange - _screenTileX);
		tileScreenHeight = min(_height div tileSize + screenBorder * 2, _tileWorldRange - _screenTileY);
		
		if(array_length(tilesScreen) != tileScreenWidth || array_length(tilesScreen[0]) != tileScreenHeight) {
			var _prevLength = array_length(tilesScreen);
			array_resize(tilesScreen, tileScreenWidth);
			
			for(var _fillI = _prevLength; _fillI < tileScreenWidth; _fillI++) {
				tilesScreen[_fillI] = array_create(tileScreenHeight);
			}
		}
		
		for (var _i = 0; _i < tileScreenWidth; _i++) {
			array_copy(tilesScreen[_i], 0, tiles[screenWorldTileX + _i], screenWorldTileY, tileScreenHeight); // fills 2d array of screen with world sections at this position [x][y]
		}
		
		script_spawnAmbientCreatures();
	}
}

/// @desc Function Just updates the tiles in this position and size of screen, does not move the screen or update the position values, use when breaking or placing things that need to reflect across tile grids but not move or change the cameras. (updating camera and position values is half the work so this is faster)
updateScreenStatic = function() {
	for (var _i = 0; _i < tileScreenWidth; _i++) {
		array_copy(tilesScreen[_i], 0, tiles[screenWorldTileX + _i], screenWorldTileY, tileScreenHeight); // fills 2d array of screen with world sections at this position [x][y]
	}
}

#endregion

generateWorld = function(type = "normal", size = 1000, structureMult = 1, flat = false) { // size doesn't do anything atm (since I'd prefer to keep size as a macro for speed..)
	show_debug_message("GENERATING WORLD");
	
	array_resize(tiles, 0); // clear to nothing
	array_resize(tiles, size); // restack to proper size (doing it this way because breaking the ref would be super annoying!)
	
	if(type == "overworld") {
		var _tileType = 0;
		var _worldXNormal = 0;
		var _worldYNormal = 0; // init hold values
		var _posX = 0;
		var _posY = 0;
		var _noise = 0;
		var _caveNoise = 0;
		
		//CORE LOOP OF FIRST PASS (BASE TERRAIN STRUCTURES)
		for (var _worldX = 0; _worldX < size; _worldX++) {
			tiles[_worldX] = array_create(size); // CREATE SECOND DIMENSION (ABSOLUTELY NECESSARY HERE, because the array isn't initialized til here)
			for (var _worldY = 0; _worldY < size; _worldY++) {
				
				//ESTABLISH WORLD VALUES FOR POSITION AND SUCH (normals and otherwise)
				
				_worldXNormal = _worldX / size;
				_worldYNormal = _worldY / size;
				
				_posX = _worldXNormal * 55.0;
				_posY = _worldYNormal * 140.0;
				
				
				//########################### GENERATING VALUES START ################################### (literally all arbitrary, I made this in shader toy just eyeballing all the values and ported them over here. Redo it in shadertoy if you're editing, don't try to update them here in game maker, that's folly)
		
				if(flat) {
					_noise = 0; // I do believe that this is where the up and down terrain of the map comes from..?
				} else {
					_noise = (-.8 + _worldYNormal * 5.) + sin(_worldXNormal * 23.1) * .07 + sin(_worldXNormal * 73.7) * .03 + sin(_worldXNormal * 317.3) * .015; // this is free for all, on either side it will clamp and compress to an index or set up basic values
				}
		
			    _caveNoise = power((perlin(_posX * .61, _posY * .61) + perlin(_posX * 1.7, _posY * 1.7) * .5 + perlin(_posX * 2.9, _posY * 2.9) * .166) * .58, .67); //  + perlin(_posX * 2.5, _posY * 2.5)
			
			    if(_caveNoise > .63 + power(1.0 - _worldYNormal, 1.5) * .3) { // how dense stuff is, completely arbitrary  (replace 1.5!!)
			        _noise = 0.0;
			    } else {
			        _noise += ((-.35 + _caveNoise) * 4.) * power(max(0, _worldYNormal - 0.23), .5);
			    }
				
				_tileType = clamp(round(_noise), 0, 4);
		
				//########################### GENERATING VALUES DONE ####################################
				
				tiles[_worldX][_worldY] = _tileType;
			}
		}
		
		//POST MODIFICATION TO GENERATED BASE (second pass)
		
		for (var _worldX = 2; _worldX < size - 2; _worldX++) {
			for (var _worldY = 2; _worldY < size - 2; _worldY++) {
				if(irandom(10000 / structureMult) == 0) { // spawning structures randomly through the world   STRUCTURES
					if(tiles[_worldX][_worldY] == 0) { // basic check for building on empty space but something below, ISH. I'm well aware this is extremely shoddy checking but it took 90 seconds so whatever
						if(tiles[_worldX][_worldY + 2] > 0) { // basic check for building on empty space but something below, ISH. I'm well aware this is extremely shoddy checking but it took 90 seconds so whatever
							script_loadStructure(_worldX, _worldY, "STRUCTUREDATA/exampleStructure.txt");
						}
					}
				} else { // DECORATION TILES
					if(irandom(2) == 0){ // just kinda don't 2/3 of the time.. (dont place grass)
						if(tiles[_worldX][_worldY] == E_tile.grass) {
							if(tiles[_worldX][_worldY - 1] == E_tile.empty) {
								tiles[_worldX][_worldY - 1] = E_tile.decGrass; // place grass above all empty grass blocks
							}
						}
					} else if(irandom(9) == 0) {
						if(tiles[_worldX][_worldY] > 1) { // some kind of non grass for now..
							if(tiles[_worldX][_worldY - 1] == E_tile.empty) {
								tiles[_worldX][_worldY - 1] = E_tile.decRock; // place grass above all empty grass blocks
							}
						}
					} else if(irandom(8) == 0) {
						if(tiles[_worldX][_worldY] == E_tile.dirt) { // some kind of non grass for now..
							if(tiles[_worldX][_worldY - 1] == E_tile.empty) {
								tiles[_worldX][_worldY - 1] = E_tile.decMushroom; // place grass above all empty grass blocks
							}
						}
					}
				}
			}
		}
		
		//END OF ALL ##############################################################################################################################################
	} else if(type == "normal") {
		for (var _worldX = 0; _worldX < size; _worldX++) {
			tiles[_worldX] = array_create(size);
			
			for (var _worldY = 0; _worldY < size; _worldY++) {
				var _tileType = 0;
				
				var _worldDepth = clamp(_worldY / size, 0, 1);
				
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
		for (var _worldX = 0; _worldX < size; _worldX++) {
			tiles[_worldX] = array_create(size);
			
			for (var _worldY = 0; _worldY < size; _worldY++) {
				tiles[_worldX][_worldY] = (_worldY % 50 < 15) ? 0 : irandom(3);
			}
		}
	} else if(type == "random") {
		for (var _worldX = 0; _worldX < size; _worldX++) {
			tiles[_worldX] = array_create(size);
			
			for (var _worldY = 0; _worldY < size; _worldY++) {
				tiles[_worldX][_worldY] = irandom(3);
			}
		}
	}
	
	global.worldTiles = tiles;
	
	global.tileRangeWorld = size;
	global.worldSizePixels = size * tileSize;
}