randomize();

window_set_caption(choose("It's alive!", "Uh-oh...", "Come to the dark side-", "What's that chemical smell?", "The lights are going dark all around the world.", "When will it all be over?", "The end is near.", "You don't belong here.", "You are my favorite."))

global.manager = id;

global.timer = 0;

splashIntroProgress = 0; // 0-1 representing black to icon to black to menu (fading between each)

inGame = false;
worldCurrent = 0;

global.pauseMenu = noone; // gets set to noone upon unpausing!
global.gamePaused = false;
pauseNextFrame = noone;
pauseSurfaceBuffer = buffer_create(2_073_600, buffer_fixed, 1); // 960, 540 application surface, doesn't change yo
pauseSurface = -1;

ppxSurface = -1;

tiles = -1; // maybe doesn't exist at times since manager is above the law... updated for world effects that need to run scripts with the variable

global.bossSpawned = false;

cursor_sprite = spr_cursor;
window_set_cursor(cr_none);

application_surface_draw_enable(false);

global.cameraShake = 0;

#region macros and enums set up



#macro c_random make_color_rgb(irandom_range(0, 255), irandom_range(0, 255), irandom_range(0, 255))

global.tileSprites =                 [spr_tile,                 spr_tile,                spr_tileCrystal,         spr_tile,                    spr_tileWood,            spr_tileFlesh,        spr_tileBanana,          spr_tileExplosive,  spr_tileMetal,                                                                        spr_tileWood, spr_tileWood];
global.tileColors =                  [c_black,                  c_green,                 c_aqua,                  #884411,                     #cbb29f,                 #ff8888,              #ffff00,                 #ff4014,            #393939,                                                                              #aaaaaa, #555555];
global.tilePlaceSounds =             [snd_placeBlock,           snd_placeBlock,          snd_placeBlock,          snd_placeBlockMud,           snd_placeBlock,          snd_placeBlockMud,     snd_banana,             snd_placeBlock,     snd_placeBlockMetal,                                                                  snd_placeBlock, snd_placeBlock];
global.tileBreakSounds =             [snd_breakBlockWood,       snd_breakBlockGrass,      snd_breakBlockCrystal,   snd_breakBlockMud,          snd_breakBlockWood,      snd_breakBlockWood,    snd_banana,             snd_breakBlockWood, snd_breakBlockMetal,                                                                  snd_breakBlockStone, snd_breakBlockStone];
global.tileStepSounds =              [snd_stepSoundStone,[snd_stepSoundMud1, snd_stepSoundMud2],snd_stepSoundStone,snd_stepSoundDirt,     snd_stepSoundStone, [snd_stepSoundMud1, snd_stepSoundMud2], snd_banana,      snd_stepSoundStone, [snd_stepSoundMetal1, snd_stepSoundMetal2, snd_stepSoundMetal3, snd_stepSoundMetal4], snd_stepSoundStone, snd_stepSoundStone];
global.tileFallSounds =              [snd_explosion,            snd_explosion,           snd_fallOntoCrystal,      snd_fallOntoMud,            snd_explosion,           snd_fallOntoMud,       snd_fallOntoMud,          snd_explosion,    snd_placeBlockMetal,                                                                  snd_explosion, snd_explosion];
global.tileFallDamage =              [0,                        .6,                      2.2,                       .8,                          1.2,                     .5,                    .75,                    .7,                 1.3,                                                                                  1.4, 1.6];

global.tilePlaceSoundsDecorative =   [snd_placeBlock,           snd_placeBlock,          snd_placeBlock,          snd_banana];                                            
global.tileBreakSoundsDecorative =   [snd_breakBlockWood,       snd_breakBlockWood,      snd_breakBlockCrystal,   snd_banana];                                            
global.tileSpritesDecorative =       [spr_pickaxe,              spr_tileGrassDecoration, spr_tileRockDecoration,  spr_tileMushroomDecoration];
global.tileColorsDecorative =        [c_black,                  c_green,                 c_ltgray,                c_red,                       #bba280];

#macro grav .13
#macro surfaceEffectsUpdateTick 30

//terrain testing macros for readability, I know it's jank but it works fine so idc
#macro isClear <= 0
#macro isSolid > 0
#macro isEmpty == 0

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

menuMusic = -1;
musicCurrentLayer = E_musicLayer.surface; // surface
musicDepthRef = [-.05, .42, .93, 1.05, 99];
musicDepthTracks = [0, 0, 0, 0, 0]; // sound ids for tracks of surface, depth, and underworld and either the song id (playing or ended) or a number representing a break in frames, eg 300 would mean count down 300 frames before starting the next track at that layer

#endregion

global.timer = 0; // count up and use for applying updates eveny n frames

#region menu/settings values set up
global.gameDifficultySelected = 1;
global.gameScreenShakeSelected = 2;
global.gameGoreSelected = 1;
global.gameWindowResolutionSelected = 2;
global.gameFullscreenSelected = 0;
global.gameColorFilterSelected = 0;
global.gameBrightnessSelected = 6;

global.gameEffectVolume = 5;
global.gameMusicVolume = 5
global.gameAmbientVolume = 5;

global.gameRainSelected = 0;
global.gameCorruptionSelected = 0;
global.corruptionBlocks = [-1, E_tile.empty, E_tile.flesh, E_tile.diamond, E_tile.metal, E_tile.explosive]; //["none", "break blocks", "flesh", "crystal", "metal", "explosives"];
#endregion

#region camera values
view_enabled = true;
view_camera[0] = camera_create();
view_visible[0] = true;

cam = view_camera[0];

surface_resize(application_surface, 1920, 1080);
view_set_wport(0, 1920);
view_set_hport(0, 1080);
#endregion

#region particle stuff
sys = part_system_create();
part_system_depth(sys, depth - 100); // above, idk
global.sys = sys;

sysUnder = part_system_create();
part_system_depth(sysUnder, depth + 250); // under everything else (not background tho)
global.sysUnder = sysUnder;

breakPart = global.breakPart; // annoying!

#endregion

#region filter layer things (and music depths)
cameraWorldDepth = .5;
cameraWorldDepthPrevious = cameraWorldDepth;

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
			
			refreshCondition(true);
		}
		
		instance_create_layer(_player.x, _player.y - 100, "Instances", obj_bouncingBookIntro);
		
		var _worldVolume = sqr(global.tileRangeWorld);
		
		repeat(_worldVolume / 10000) {
			script_createRobePickup(-1, irandom_range(200, _worldSizePixels - 200), irandom_range(200, _worldSizePixels - 200));
		}
		repeat(_worldVolume / 6000) {
			script_createPickaxe(-1, irandom_range(200, _worldSizePixels - 200), irandom_range(200, _worldSizePixels - 200));
		}
		repeat(_worldVolume / 25000) {
			var _materialOrb = script_createMaterialNode(irandom_range(200, _worldSizePixels - 200), irandom_range(200, _worldSizePixels - 200), irandom_range(1, 7));
		}
	}
	
	instance_destroy(obj_MainMenu); // hm
	
	script_centerCameraOnPlayer();
	
	global.tileManager.updateScreen(,, 1);
	
	cameraWorldDepth = global.player.y / global.worldSizePixels;
	updateDepthEffects();
	audio_sound_gain(musicDepthTracks[musicCurrentLayer], 0, 0);
	audio_sound_gain(musicDepthTracks[musicCurrentLayer], 1, 20000);
	audio_stop_sound(menuMusic);
	
	inGame = true;
	worldCurrent = worldIndex;
	tiles = global.worldTiles;
	
	if(!exists) {
		script_saveWorld("worldSave" + string(worldCurrent) + ".txt"); // save newly generated world
		var _cutscene = instance_create_layer(0, 0, "Instances", obj_cutscene);
		_cutscene.startedByManager = true;
		_cutscene.setCutscene("intro");
		script_setPauseState(true);
	}
}

exitGameWorld = function() {
	instance_activate_all();
	instance_destroy(obj_entity, false);
	instance_destroy(obj_tileManager);
	
	for(var _i = 0; _i < E_musicLayer.musicLayerCount; _i++) {
		if(script_isSoundPlaying(musicDepthTracks[_i])) {
			audio_sound_gain(musicDepthTracks[_i], 0, 5000); // these will keep playing yes but the songs are short and don't loop so just send them to the background and move on i guess?
		}
		
		musicDepthTracks[_i] = 0; // break the song ref... those who history forgot type craft
	}
	
	inGame = false;
	tiles = -1;
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

updateDepthEffects = function() {
	cameraWorldDepthPrevious = cameraWorldDepth;
	cameraWorldDepth = global.player.y / global.worldSizePixels;
	
	//if(irandom(100) == 0) {
		//ef_reverb.size = cameraWorldDepth * 2;
		//ef_reverb.mix = 0.3;
		//audio_bus_main.effects[0] = ef_reverb;
	//}
	
	var _abyssStrength = min((cameraWorldDepth - abyssEffectRange[0]) / (abyssEffectRange[1] - abyssEffectRange[0]), 1.0);
	if(_abyssStrength > 0) {
		layer_enable_fx(abyssLayer, true);
		abyssParams.g_Distort1Amount = 2.5 * sqr(_abyssStrength);
		abyssParams.g_Distort2Amount = 1.15 * sqr(_abyssStrength);
		abyssParams.g_GlintCol = [.075 * _abyssStrength, .07 * _abyssStrength, .145 * _abyssStrength, 1]; // push towards black to make disappear
		abyssParams.g_TintCol = [lerp(1, .27, _abyssStrength), 1 - _abyssStrength * .9, lerp(1, .5, _abyssStrength), 1]; // (push towards white to make disappear
		
		fx_set_parameters(abyssFilter, abyssParams);
	} else {
		layer_enable_fx(abyssLayer, false);
	}
	
	var _previousLayer = script_getMusicLayerFromDepth(cameraWorldDepthPrevious);
	musicCurrentLayer = script_getMusicLayerFromDepth(cameraWorldDepth);
	if(_previousLayer != musicCurrentLayer) {
		var _currentSong = musicDepthTracks[musicCurrentLayer];
		var _previousSong = musicDepthTracks[_previousLayer];
		if(script_isSoundPlaying(_currentSong)) { // idk how else to test audio viability, these songs are supposed to be sound indexs and so have ids in the hundreds of thousands? (400,000 seemingly) So i guess I'll just magnitude check it??
			audio_sound_gain(_currentSong, 1, 8000);
		}
		if(script_isSoundPlaying(_previousSong)) {
			audio_sound_gain(_previousSong, 0, 8000);
		}
	}
	
	for(var _i = E_musicLayer.musicLayerCount - 1; _i >= 0; _i--) {
		if(musicDepthTracks[_i] < 50000) { // timer not asset
			musicDepthTracks[_i] -= surfaceEffectsUpdateTick; // actually a timer..
			if(musicDepthTracks[_i] <= 0) {
				if(_i == musicCurrentLayer) {
					musicDepthTracks[_i] = audio_play_sound(script_getSongAtLayer(_i), 999, false);
					audio_sound_gain(musicDepthTracks[_i], 0, 0);
					audio_sound_gain(musicDepthTracks[_i], 1, 5000);
				} else {
					musicDepthTracks[_i] = irandom_range(3600, 14400);
				}
			}
		} else {
			if(!audio_is_playing(musicDepthTracks[_i])) {
				musicDepthTracks[_i] = irandom_range(3600, 14400); //song over, insert period of silence before next track starts
			}
		}
	}
}

initMainMenuScreen();

//shader_set_live(shd_fogDistort, true);
//shader_set_live(shd_fogDistortColor, true);
shader_set_live(shd_mosaic, true);

//bench mark initial with macro arrays and whatnot usually (60%) of the time holding barely 6000, so you see 5s and 4s but mostly low 6000s, got it?