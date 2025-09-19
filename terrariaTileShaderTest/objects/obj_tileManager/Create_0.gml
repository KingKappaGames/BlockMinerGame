randomize();

global.tileManager = id;

#macro tileColors [c_black, c_green, c_aqua, #884411, #bba280] // hmmmm

#region camera values
view_enabled = true;
view_camera[0] = camera_create();
view_visible[0] = true;

cam = view_camera[0];

surface_resize(application_surface, 960, 540);
camera_set_view_size(cam, 640, 360);
camera_set_view_pos(cam, 0, 0);
#endregion

#macro grav .13

#region tile grid set up for world and screen/camera
#macro tileSize 16
#macro tileRangeWorld 1000
#macro screenBorder 3
#macro spawnX tileSize * tileRangeWorld * .5
#macro spawnY tileSize * tileRangeWorld * .5

tiles = array_create(tileRangeWorld);
for (var _worldX = 0; _worldX < tileRangeWorld; _worldX++) {
	tiles[_worldX] = array_create(tileRangeWorld); // 2d array of tiles 16x16 for demo purposes
	
	for (var _worldY = 0; _worldY < tileRangeWorld; _worldY++) {
		tiles[_worldX][_worldY] = (_worldY % 50 < 15) ? 0 : irandom(3);
	}
}

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

#region particle stuff
sys = part_system_create();
part_system_depth(sys, depth - 100); // above, idk
global.sys = sys;

#region
global.breakPart = part_type_create();
var _break = global.breakPart;
part_type_life(_break, 27, 45);
part_type_shape(_break, pt_shape_square);
part_type_size(_break, .07, .105, -.002, 0);
part_type_alpha2(_break, 1, 0);
part_type_speed(_break, 0, 1.4, 0, 0);
part_type_direction(_break, 0, 360, 0, 0);
part_type_orientation(_break, 0, 360, 3, 5, false);
part_type_gravity(_break, .05, 270);

global.explosionPart = part_type_create();
var _explosionPart = global.explosionPart;
part_type_life(_explosionPart, 20, 42);
part_type_shape(_explosionPart, pt_shape_square);
part_type_size(_explosionPart, .1, .14, -.002, 0);
part_type_size_x(_explosionPart, .3, .3, 0, 0);
part_type_alpha2(_explosionPart, 1, 0);
part_type_speed(_explosionPart, 1.6, 4.8, -.18, 0);
part_type_direction(_explosionPart, 0, 360, 0, 0);
part_type_orientation(_explosionPart, 0, 360, 3, 5, false);

global.smokeTrailPart = part_type_create();
var _smokeTrail = global.smokeTrailPart;
part_type_life(_smokeTrail, 75, 110);
part_type_shape(_smokeTrail, pt_shape_square);
part_type_size(_smokeTrail, .02, .02, .001, 0);
part_type_alpha2(_smokeTrail, 1, 0);
part_type_speed(_smokeTrail, 0.2, .5, -.004, 0);
part_type_direction(_smokeTrail, 0, 360, 0, 0);
part_type_gravity(_smokeTrail, -.01, 270);
#endregion

#endregion

instance_create_layer(0, 0, "Instances", obj_player);