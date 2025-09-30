randomize();

global.manager = id;

global.timer = 0;

splashIntroProgress = 0; // 0-1 representing black to icon to black to menu (fading between each)

inGame = false;
worldCurrent = 0;

global.pauseMenu = noone; // gets set to noone upon unpausing!
global.gamePaused = false;
pauseNextFrame = false;
pauseSurfaceBuffer = buffer_create(2_073_600, buffer_fixed, 1); // 960, 540 application surface, doesn't change yo
pauseSurface = -1;

cursor_sprite = spr_cursor;
window_set_cursor(cr_none);

application_surface_draw_enable(false);

#region macros and enums set up

enum E_spell {
	none = 0,
	bolt = 1,
	shockwave = 2,
	bananaShimmer = 3,
	explosiveBolt = 4,
}

enum E_robe {
	basicPurple = 0,
	superRed = 1,
	teleporterWhite = 2,
	bananaYellow = 3,
	materialGrass = 4,
}

enum E_pickaxe {
	basicRed = 0,
	blue = 1,
	long = 2,
	banana = 3,
}

enum E_tile { // ideas, meat, bones, black crystal, hot lava rock, explosiveSomething?, smooth granite, bookBlock (block of books yes), toad block (yeah), 
	decMushroom = -3,
	decRock = -2,
	decGrass = -1,
	empty = 0,
	grass = 1,
	diamond = 2,
	dirt = 3,
	wood = 4,
	flesh = 5,
	banana = 6,
	explosive = 7,
	metal = 8,
}

#macro c_random make_color_rgb(irandom_range(0, 255), irandom_range(0, 255), irandom_range(0, 255))

global.tileSprites =                 [spr_tile,                 spr_tile,                spr_tileCrystal,         spr_tile,                    spr_tileWood,            spr_tileFlesh,        spr_tileBanana,          spr_tileExplosive,  spr_tileMetal];
global.tileColors =                  [c_black,                  c_green,                 c_aqua,                  #884411,                     #cbb29f,                 #ff8888,              #ffff00,                 #ff4014,            #393939];
global.tilePlaceSounds =             [snd_placeBlock,           snd_placeBlock,          snd_placeBlock,          snd_placeBlockMud,           snd_placeBlock,          snd_placeBlockMud,     snd_banana,             snd_placeBlock,     snd_placeBlockMetal];
global.tileBreakSounds =             [snd_breakBlockWood,       snd_breakBlockWood,      snd_breakBlockCrystal,   snd_breakBlockMud,           snd_breakBlockWood,      snd_breakBlockWood,    snd_banana,             snd_breakBlockWood, snd_breakBlockMetal];
global.tileStepSounds =              [snd_stepSoundStone,[snd_stepSoundMud1, snd_stepSoundMud2],snd_stepSoundStone,snd_stepSoundDirt,      snd_stepSoundStone,[snd_stepSoundMud1, snd_stepSoundMud2],snd_banana,     snd_stepSoundStone,[snd_stepSoundMetal1, snd_stepSoundMetal2, snd_stepSoundMetal3, snd_stepSoundMetal4]];
global.tileFallSounds =              [snd_explosion,            snd_explosion,           snd_explosion,           snd_fallOntoMud,             snd_explosion,           snd_fallOntoMud,       snd_fallOntoMud,          snd_explosion,      snd_explosion];
global.tileFallDamage =              [0,                        .6,                      2,                       .8,                          1.2,                     .5,                    .75,                    .7,                 1.4];

global.tilePlaceSoundsDecorative =   [snd_placeBlock,           snd_placeBlock,          snd_placeBlock,          snd_banana];                                            
global.tileBreakSoundsDecorative =   [snd_breakBlockWood,       snd_breakBlockWood,      snd_breakBlockCrystal,   snd_banana];                                            
global.tileSpritesDecorative =       [spr_pickaxe,              spr_tileGrassDecoration, spr_tileRockDecoration,  spr_tileMushroomDecoration];
global.tileColorsDecorative =        [c_black,                  c_green,                 c_ltgray,                c_red,                       #bba280];


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

global.timer = 0; // count up and use for applying updates eveny n frames

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

#region PARTICLE definitions
global.breakPart = part_type_create();
var _break = global.breakPart;
part_type_life(_break, 27, 45);
part_type_shape(_break, pt_shape_square);
part_type_size(_break, .07, .105, -.002, 0);
part_type_alpha2(_break, 1, 0);
part_type_speed(_break, .25, 1.05, 0, 0);
part_type_direction(_break, 0, 360, 0, 0);
part_type_orientation(_break, 0, 360, 3, 5, false);
part_type_gravity(_break, .032, 270);

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

global.starPart = part_type_create();
var _star = global.starPart;
part_type_life(_star, 150, 180);
part_type_sprite(_star, spr_starShape, false, false, false);
part_type_size(_star, .15, .5, -.0025, 0); // limiting factor hopefully
part_type_speed(_star, 1.6, 4.8, -.18, 0); // do override this when you want though, should be set per effect in game
part_type_direction(_star, 0, 360, 0, 0);
part_type_orientation(_star, 0, 360, 3, 5, false);

global.radialShimmerPart = part_type_create();
var _radialShimmer = global.radialShimmerPart;
part_type_life(_radialShimmer, 110, 130);
part_type_sprite(_radialShimmer, spr_roundBeamShape, false, false, false);
part_type_size(_radialShimmer, .35, .7, -.0065, 0); // limiting factor hopefully
part_type_speed(_radialShimmer, 1, 1.9, -.02, 0); // do override this when you want though, should be set per effect in game
part_type_direction(_radialShimmer, 0, 360, 0, 0);

global.roundTrail = part_type_create();
var _roundTrail = global.roundTrail;
part_type_life(_roundTrail, 45, 55);
part_type_shape(_roundTrail, pt_shape_square);
part_type_size(_roundTrail, .05, .05, -.001, 0);
part_type_alpha2(_roundTrail, 1, .3);
part_type_speed(_roundTrail, 0, .4, -.004, 0);
part_type_direction(_roundTrail, 0, 360, 0, 0);
part_type_orientation(_roundTrail, 0, 0, 1.7, 0, 0);
part_type_color1(_roundTrail, #ffffff)

global.overwrittenTrailerPart = part_type_create(); // no visuals?
var _trailerPart = global.overwrittenTrailerPart;
part_type_life(_trailerPart, 25, 90);
part_type_direction(_trailerPart, 0, 360, 0, 0); // over write speed per particle use case in code, no default
part_type_gravity(_trailerPart, .04, 270);
part_type_step(_trailerPart, -2, _roundTrail);

global.smokeTrailPart = part_type_create();
var _smokeTrail = global.smokeTrailPart;
part_type_life(_smokeTrail, 75, 110);
part_type_shape(_smokeTrail, pt_shape_square);
part_type_size(_smokeTrail, .02, .02, .001, 0);
part_type_alpha2(_smokeTrail, 1, 0);
part_type_speed(_smokeTrail, 0.15, .3, -.008, 0);
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

global.bloodSpurt = part_type_create();
var _bloodSpurt = global.bloodSpurt;
part_type_life(_bloodSpurt, 35, 70);
part_type_shape(_bloodSpurt, pt_shape_disk);
part_type_size(_bloodSpurt, .08, .13, -.003, 0);
part_type_speed(_bloodSpurt, 1.5, 2.7, -.003, 0);
part_type_gravity(_bloodSpurt, .02, 270);

global.rushPart = part_type_create();
var _rushPart = global.rushPart;
part_type_life(_rushPart, 62, 85);
part_type_shape(_rushPart, pt_shape_square);
part_type_size(_rushPart, .15, .21, -.002, 0);
part_type_orientation(_rushPart, 0, 360, 0, 0, false);
part_type_gravity(_rushPart, .04, 270);

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

startGameWorld = function(worldIndex, exists = false) {
	var _tileManager = instance_create_layer(0, 0, "Instances", obj_tileManager);
	
	var _worldSizePixels;
	var _worldSizeTiles;
	
	if(exists) {
		var _fileName = "worldSave" + string(worldCurrent) + ".txt";
		
		script_loadWorld(_fileName);
		
		_worldSizePixels = global.worldSizePixels;
	} else {
		var _menu = obj_MainMenu.id;
		_tileManager.generateWorld(_menu.worldOptionGenerationTypeOptions[_menu.worldOptionGenerationTypeSelected], _menu.worldOptionSizeOptions[_menu.worldOptionSizeSelected], _menu.worldOptionStructureMultOptions[_menu.worldOptionStructureMultSelected], _menu.worldOptionFlatOptions[_menu.worldOptionFlatSelected]);
		
		var _player = instance_create_layer(0, 0, "Instances", obj_player);
		
		_worldSizePixels = global.worldSizePixels;
		
		with(_player) { // place player at random position if new world
			x = irandom_range(100, _worldSizePixels - 100);
			y = script_findGroundBelow(x, 0, 5, false, _worldSizePixels * .9); // find that mfing ground
			if(y == -1) {
				y = 1000; 
			}
		}
	}
	
	instance_destroy(obj_MainMenu); // hm
	
	script_centerCameraOnPlayer();
	
	global.tileManager.updateScreen(,, 1);
	
	repeat(3) {
		instance_create_layer(irandom_range(200, _worldSizePixels - 200), irandom_range(200, _worldSizePixels - 200), "Instances", obj_itemPickUpFloat);
	}
	repeat(4) {
		instance_create_layer(irandom_range(200, _worldSizePixels - 200), irandom_range(200, _worldSizePixels - 200), "Instances", obj_itemPickUpStatic);
	}
	repeat(3) {
		var _materialOrb = instance_create_layer(irandom_range(200, _worldSizePixels - 200), irandom_range(200, _worldSizePixels - 200), "Instances", obj_materialOrbNode);
		with(_materialOrb) {
			materialType = irandom_range(1, 7);
			if(materialType == E_tile.explosive || materialType == E_tile.banana) {
				shockwaveDuration = 9; // shorter lived bursts but faster expanding, still smaller / less tiles than normal because explosives are laggy yo
				radiusExpand = 1.2;
				strengthMult = .3;
			}
			image_blend = materialType >= 0 ? global.tileColors[materialType] : global.tileColorsDecorative[abs(materialType)];
		}
	}
	
	inGame = true;
	worldCurrent = worldIndex;
	
	if(!exists) {
		script_saveWorld("worldSave" + string(worldCurrent) + ".txt"); // save newly generated world
	}
}

exitGameWorld = function() {
	instance_activate_all();
	instance_destroy(obj_entity, false);
	instance_destroy(obj_tileManager);
	
	inGame = false;
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

shader_set_live(shd_fogDistort, true);
shader_set_live(shd_fogDistortColor, true);


//bench mark initial with macro arrays and whatnot usually (60%) of the time holding barely 6000, so you see 5s and 4s but mostly low 6000s, got it?