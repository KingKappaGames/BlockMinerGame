randomize();

global.manager = id;

splashIntroProgress = 0; // 0-1 representing black to icon to black to menu (fading between each)

inGame = false;

#region macros and enums set up

enum spells {
	none = 0,
	bolt = 1,
	shockwave = 2,
	hold1 = 3,
	hold2 = 4
}

enum tileTypes {
	decMushroom = -3,
	decRock = -2,
	decGrass = -1,
	empty = 0,
	grass = 1,
	diamond = 2,
	dirt = 3,
	wood = 4,
}

#macro tileSprites [spr_tileGuideFrames, spr_tileGuideFrames, spr_tileGuideFramesCrystal, spr_tileGuideFrames, spr_tileGuideFramesWood]
#macro tileColors [c_black, c_green, c_aqua, #884411, #cbb29f]
#macro tileSpritesDecorative [spr_pickaxe, spr_tileGuideFramesGrassDecoration, spr_tileGuideFramesRockDecoration, spr_tileGuideFramesMushroomDecoration, spr_tileGuideFramesGrassDecoration, spr_tileGuideFramesGrassDecoration]
#macro tileColorsDecorative [c_black, c_green, c_ltgray, c_red, #bba280]
#macro grav .13

#region audio fall off values both for convenience and because the manual is very confusing and I want to stop screwing this up when I stop using audio stuff for a few months and come back to screw it up again
#macro audioRefTiny 75
#macro audioMaxTiny 320
#macro audioRefQuiet 150
#macro audioMaxQuiet 440
#macro audioRefMedium 240 // these aren't optimal or unique per sound (as they should be) but they at least ensure I'm not screwing up the ref values as I often do... (ref is the distance in which it halves I believe (or whatever your falloff ratio is) and max is how far out it should be audible at all)
#macro audioMaxMedium 740
#macro audioRefLoud 400
#macro audioMaxLoud 1300
#endregion

#endregion

#region audio nonsense
//ef_reverb = audio_effect_create(AudioEffectType.Reverb1);
//ef_reverb.size = 1.1;
//ef_reverb.mix = 0.3;
//audio_bus_main.effects[0] = ef_reverb;

audio_group_load(sndGrp_sfx);
audio_group_load(sndGrp_music);
audio_group_load(sndGrp_ambient);

#endregion

timer = 0; // count up and use for applying updates eveny n frames

#region menu/settings values set up
global.gameDifficultySelected = 1;
global.gameScreenShakeSelected = 2;
global.gameGoreSelected = 2;
global.gameWindowResolutionSelected = 2;
global.gameFullscreenSelected = 0;
global.gameColorFilterSelected = 0;

global.gameEffectVolume = 5;
global.gameMusicVolume = 5
global.gameAmbientVolume = 5;
#endregion

#region camera values
view_enabled = true;
view_camera[0] = camera_create();
view_visible[0] = true;

cam = view_camera[0];

surface_resize(application_surface, 960, 540);
view_set_wport(0, 960);
view_set_hport(0, 540);
#endregion

#region particle stuff
sys = part_system_create();
part_system_depth(sys, depth - 100); // above, idk
global.sys = sys;

sysUnder = part_system_create();
part_system_depth(sysUnder, depth + 250); // under everything else (not background tho)
global.sysUnder = sysUnder;

#region
global.breakPart = part_type_create();
var _break = global.breakPart;
part_type_life(_break, 27, 45);
part_type_shape(_break, pt_shape_square);
part_type_size(_break, .07, .105, -.002, 0);
part_type_alpha2(_break, 1, 0);
part_type_speed(_break, .3, 1.2, 0, 0);
part_type_direction(_break, 0, 360, 0, 0);
part_type_orientation(_break, 0, 360, 3, 5, false);
part_type_gravity(_break, .04, 270);

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

global.thickTrail = part_type_create();
var _thickTrail = global.thickTrail;
part_type_life(_thickTrail, 50, 70);
part_type_shape(_thickTrail, pt_shape_square);
part_type_size(_thickTrail, .1, .14, -.003, 0);
part_type_speed(_thickTrail, 0.0, .2, -.002, 0);
part_type_direction(_thickTrail, 0, 360, 0, 0);
part_type_orientation(_thickTrail, 0, 360, 0, 0, false);
part_type_gravity(_thickTrail, -.01, 270);

global.itemGlimmerPart = part_type_create();
var _itemGlimmer = global.itemGlimmerPart;
part_type_life(_itemGlimmer, 90, 300);
part_type_shape(_itemGlimmer, pt_shape_square);
part_type_size(_itemGlimmer, .06, .09, -.0004, 0);
part_type_speed(_itemGlimmer, 0.2, .4, -.001, 0);
part_type_direction(_itemGlimmer, 0, 360, 0, 0);
part_type_gravity(_itemGlimmer, -.003, 270);
#endregion

#endregion

#region filter layer things
cameraWorldDepth = .5;

abyssEffectRange = [.65, 1]; // normalized depth of world for this effect to range over
abyssLayer = layer_get_id("EffectAbyss");
abyssFilter = layer_get_fx(abyssLayer);
abyssParams = fx_get_parameters(abyssFilter);

vignetteEffectRange = [.25, 1]; // normalized depth of world for this effect to range over
#endregion

startGameWorld = function() {
	instance_destroy(obj_MainMenu); // hm
	
	var _tileManager = instance_create_layer(0, 0, "Instances", obj_tileManager);
	
	var _player = instance_create_layer(0, 0, "Instances", obj_player);
	
	var _worldTiles = global.worldTiles;
	var _px = _player.x;
	var _py = _player.y;
	for(var _i = 0; _i < tileRangeWorld; _i += 5) {
		if(_worldTiles[_px div tileSize][_py div tileSize + _i] > 0) {
			_player.y = _player.y + _i * tileSize - tileSize;
			break;
		}
	}
	
	camera_set_view_pos(cam, _player.x - camera_get_view_width(cam) * .5, _player.y - camera_get_view_height(cam) * .5);
	
	global.tileManager.updateScreen();
	
	repeat(5) {
		instance_create_layer(irandom_range(200, worldSizePixels - 200), irandom_range(200, worldSizePixels - 200), "Instances", obj_itemPickUpFloat);
	}
	repeat(10) {
		instance_create_layer(irandom_range(200, worldSizePixels - 200), irandom_range(200, worldSizePixels - 200), "Instances", obj_itemPickUpStatic);
	}
	
	inGame = true;
}

initMainMenuScreen = function() {
	camera_set_view_size(cam, 640, 360);
	camera_set_view_pos(cam, 0, 0);
	
	abyssLayer = layer_get_id("EffectAbyss");
	abyssFilter = layer_get_fx(abyssLayer);
	abyssParams = fx_get_parameters(abyssFilter);
	
	layer_enable_fx(abyssLayer, true);
	abyssParams.g_Distort1Amount = 2.5;
	abyssParams.g_Distort2Amount = 1.15;
	abyssParams.g_GlintCol = [0, 0, 0, 1];
	abyssParams.g_TintCol = [1, 1, 1, 1]; 
	
	fx_set_parameters(abyssFilter, abyssParams)
	
	instance_create_layer(x, y, "Instances", obj_MainMenu);
}

initMainMenuScreen();