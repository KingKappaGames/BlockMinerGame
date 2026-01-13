if (live_call()) return live_result;

draw_set_font(fnt_menuText);
//global.soundManager.songStart(snd_BackgroundMenuCrafts, false, 2.4);

cam = view_camera[0];

menuWidth = 500;
menuHeight = 440;

mapSelected = 0;
map1 = file_exists("worldSave1.txt");
map2 = file_exists("worldSave2.txt");
map3 = file_exists("worldSave3.txt");
map1DeletePrompt = false;
map2DeletePrompt = false;
map3DeletePrompt = false;

options[0][0] = "START";
options[0][1] = "OPTIONS";
options[0][2] = "CREDITS";
options[0][3] = "EXIT";

options[1][0] = "RETURN";
options[1][1] = "SOUND SETTINGS";
options[1][2] = "VISUAL SETTINGS";
options[1][3] = "GAME SETTINGS";
options[1][4] = "CONTROLS";
options[1][5] = "EVENTS";

options[2][0] = "RETURN";
options[2][1] = "EFFECTS VOLUME";
options[2][2] = "MUSIC VOLUME";
options[2][3] = "AMBIENT VOLUME";

options[3][0] = "RETURN";
options[3][1] = "RESOLUTION";
options[3][2] = "WINDOW";
options[3][3] = "COLORS";
options[3][4] = "BRIGHTNESS";

options[4][0] = "RETURN";

options[5][0] = "RETURN";
options[5][1] = "DIFFICULTY";
options[5][2] = "SCREEN SHAKE";
options[5][3] = "GORE";

options[6][0] = "RETURN";
options[6][1] = "GENERATION TYPE";
options[6][2] = "SIZE";
options[6][3] = "STRUCTURE MULTIPLIER";
options[6][4] = "FLAT";
options[6][5] = "CREATE!";

options[7][0] = "RETURN";
options[7][1] = "";
options[7][2] = ""; // no titles
options[7][3] = "";

options[8][0] = "RETURN";
options[8][1] = "RAIN";
options[8][2] = "CORRUPTION";


optionPosition = 0;
optionGroup = 0;
optionAmount = 4;

optionHeight = 35;
menuBorder = 20;
menuAlign = fa_middle;
menuTextOffset = 0;

mouseSelecting = false;
loadNextFrame = 0; // 0 or map index for which to load next frame

x = room_width / 2 - menuWidth / 2;
y = room_height / 2 - menuHeight / 2;

//game settings in menu
gameDifficultyDisplayOptions = ["polite", "everyman", "champion"];
gameDifficultySelected = global.gameDifficultySelected;

gameScreenShakeDisplayOptions = ["none", "minimal", "default", "jittery", "mistakes"];
gameScreenShakeSelected = global.gameScreenShakeSelected;

gameGoreDisplayOptions = ["disabled", "enabled"];
gameGoreSelected = global.gameGoreSelected;

gameWindowResolutionSelected = global.gameWindowResolutionSelected;
gameWindowResolutionOptions = [[480, 270], [1280, 720], [1920, 1080], [2560, 1440]];

gameFullscreenSelected = global.gameFullscreenSelected;
gameFullscreenOptions = [false, true];
gameFullscreenDisplayOptions = ["windowed", "Fullscreen"];

gameColorFilterSelected = global.gameColorFilterSelected;
gameColorFilterDisplayOptions = ["normal", "CB not working", "grey-scale", "muted", "vibrant", "computer lab", "mosaic dots", "mosaic tiles", "pure pixel ):"];

gameBrightnessSelected = global.gameBrightnessSelected;
gameBrightnessOptions = [-3, -2, -1, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]; // 3 being neutral, all others being increments of brighter or darker in .2 for now, might change tho

gameEffectVolume = global.gameEffectVolume;
gameMusicVolume = global.gameMusicVolume;
gameAmbientVolume = global.gameAmbientVolume;

gameRainSelected = global.gameRainSelected;
gameRainOptions = ["none", "bombs", "banana bombs", "enemies", "blocks"];

gameCorruptionSelected = global.gameCorruptionSelected;
gameCorruptionOptions = ["none", "break blocks", "flesh", "crystal", "metal", "explosives"];

worldOptionSizeSelected = 3;
worldOptionSizeOptions = [100, 250, 500, 1000, 1500, 2000, 3000, 4000, 5000, 8000];

worldOptionGenerationTypeSelected = 0;
worldOptionGenerationTypeOptions = ["biomes", "overworld", "normal", "layers", "random"];

worldOptionStructureMultSelected = 4;
worldOptionStructureMultOptions = [0, .1, .25, .5, 1, 1.25, 1.5, 2, 3, 5, 10, 25];

worldOptionFlatSelected = 0;
worldOptionFlatOptions = [false, true];

#region initialize menu
initializeMenu = function() {
	window_set_size(gameWindowResolutionOptions[gameWindowResolutionSelected][0], gameWindowResolutionOptions[gameWindowResolutionSelected][1]);
	window_center();
	
	x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - menuWidth / 2;
	y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - menuHeight / 2;
			
	audio_group_set_gain(sndGrp_sfx, gameEffectVolume / 10, 0);
	audio_group_set_gain(sndGrp_music, gameMusicVolume / 10, 0);
	audio_group_set_gain(sndGrp_ambient, gameAmbientVolume / 10, 0);
}
#endregion

#region menu change field
menuChangeField = function(fieldChange) {
	live_auto_call
	
	if(fieldChange != 0) {
		audio_play_sound(snd_click1, 100, false);
		if(optionGroup == 2) {
			if(optionPosition == 1) {
				gameEffectVolume = clamp(gameEffectVolume + fieldChange, 0, 10);
				audio_group_set_gain(sndGrp_sfx, gameEffectVolume / 10, 0);
			} else if(optionPosition == 2) {
				gameMusicVolume = clamp(gameMusicVolume + fieldChange, 0, 10);
				audio_group_set_gain(sndGrp_music, gameMusicVolume / 10, 0);
			} else if(optionPosition == 3) {
				gameAmbientVolume = clamp(gameAmbientVolume + fieldChange, 0, 10);
				audio_group_set_gain(sndGrp_ambient, gameAmbientVolume / 10, 0);
			}
		} else if(optionGroup == 3) {
			if(optionPosition == 1) {
				//change resolution
				gameWindowResolutionSelected = clamp(gameWindowResolutionSelected + fieldChange, 0, 3);
				window_set_size(gameWindowResolutionOptions[gameWindowResolutionSelected][0], gameWindowResolutionOptions[gameWindowResolutionSelected][1]);
				window_center();
			} else if(optionPosition == 2) {
				//change window configuration
				gameFullscreenSelected = clamp(gameFullscreenSelected + fieldChange, 0, 1);
				window_set_fullscreen(gameFullscreenOptions[gameFullscreenSelected]);
			} else if(optionPosition == 3) {
				//change color profile, ex color blind mode
				gameColorFilterSelected = clamp(gameColorFilterSelected + fieldChange, 0, array_length(gameColorFilterDisplayOptions) - 1);
				global.gameColorFilterSelected = gameColorFilterSelected;
			} else if(optionPosition == 4) {
				//change color profile, ex color blind mode
				gameBrightnessSelected = clamp(gameBrightnessSelected + fieldChange, 0, array_length(gameBrightnessOptions) - 1);
				global.gameBrightnessSelected = gameBrightnessSelected;
			}
		} else if(optionGroup == 5) {
			if(optionPosition == 1) {
				gameDifficultySelected = clamp(gameDifficultySelected + fieldChange, 0, 2);
			} else if(optionPosition == 2) {
				gameScreenShakeSelected = clamp(gameScreenShakeSelected + fieldChange, 0, 4);
			} if(optionPosition == 3) {
				gameGoreSelected = clamp(gameGoreSelected + fieldChange, 0, 1);
			}
		} else if(optionGroup == 6) { // world gen options
			if(optionPosition == 1) {
				worldOptionGenerationTypeSelected = clamp(worldOptionGenerationTypeSelected + fieldChange, 0, array_length(worldOptionGenerationTypeOptions) - 1);
			} else if(optionPosition == 2) {
				worldOptionSizeSelected = clamp(worldOptionSizeSelected + fieldChange, 0, array_length(worldOptionSizeOptions) - 1);
			} else if(optionPosition == 3) {
				worldOptionStructureMultSelected = clamp(worldOptionStructureMultSelected + fieldChange, 0, array_length(worldOptionStructureMultOptions) - 1);
			} else if(optionPosition == 4) {
				worldOptionFlatSelected = clamp(worldOptionFlatSelected + fieldChange, 0, array_length(worldOptionFlatOptions) - 1);
			}
		} else if(optionGroup == 8) {
			if(optionPosition == 1) {
				gameRainSelected = clamp(gameRainSelected + fieldChange, 0, array_length(gameRainOptions) - 1);
			} else if(optionPosition == 2) {
				gameCorruptionSelected = clamp(gameCorruptionSelected + fieldChange, 0, array_length(gameCorruptionOptions) - 1);
			}
		}
	}
}
#endregion

#region menu select option
menuSelectOption = function(intent = 0) { // -1 for decrease option, 0 for none, 1 for increase (this is a way to pass through mouse clicks instead of left and right to change values
	live_auto_call
	
	if(optionGroup == 0) {
		if(optionPosition == 0) {
			audio_play_sound(snd_click1, 100, false);
			menuSwitchOptionGroup(7, 1);
		} else if(optionPosition == 1) {
			menuSwitchOptionGroup(1);
		} else if(optionPosition == 2) {
			audio_play_sound(snd_click1, 100, false);
			//room_goto(rm_credits);
		} else if(optionPosition == 3) {
			game_end();
		}
	} else if(optionGroup == 1) { // options
		if(optionPosition == 0) {
			menuSwitchOptionGroup(0);
		} else  {
			if(optionPosition == 0) {
				menuSwitchOptionGroup(0);
			} else if(optionPosition == 1) {
				menuSwitchOptionGroup(2, 1);
			} else if(optionPosition == 2) {
				menuSwitchOptionGroup(3, 1);
			} else if(optionPosition == 3) {
				menuSwitchOptionGroup(5, 1);
			} else if(optionPosition == 4) {
				menuSwitchOptionGroup(4, 1);
			} else if(optionPosition == 5) {
				menuSwitchOptionGroup(8, 1);
			}
		}
	} else if(optionGroup == 2) { // sound
		if(optionPosition == 0) {
			menuSwitchOptionGroup(1);
		} else {
			menuChangeField(intent);
		}
	} else if(optionGroup == 3) { // visuals
		if(optionPosition == 0) {
			menuSwitchOptionGroup(1);
		} else {
			menuChangeField(intent);
		}
	} else if(optionGroup == 4) { // controls
		if(optionPosition == 0) {
			menuSwitchOptionGroup(1);
		}
	} else if(optionGroup == 5) { // game settings
		if(optionPosition == 0) {
			menuSwitchOptionGroup(1);
		} else {
			menuChangeField(intent);
		}
	} else if(optionGroup == 6) { // map generation config
		if(optionPosition == 0) {
			menuSwitchOptionGroup(7, 1);
		} else if(optionPosition == optionAmount - 1) { // last one idk
			loadNextFrame = mapSelected;
		} else {
			menuChangeField(intent);
		}
	} else if(optionGroup == 7) { // map select screen
		if(optionPosition == 0) {
			mapSelected = 0;
			menuSwitchOptionGroup(0);
		} else if(optionPosition == 1) {
			mapSelected = 1;
			if(map1) {
				loadNextFrame = 1;
			} else {
				menuSwitchOptionGroup(6);
			}
			//if world1 exists then play it, otherwise go to create screen
		} else if(optionPosition == 2) {
			mapSelected = 2;
			if(map2) {
				loadNextFrame = 2; // on map 1..?
			} else {
				menuSwitchOptionGroup(6);
			}
		} else if(optionPosition == 3) {
			mapSelected = 3;
			if(map3) {
				loadNextFrame = 3; // on map 1..?
			} else {
				menuSwitchOptionGroup(6);
			}
		} else if(optionPosition == 4) {
			if(map1) {
				if(map1DeletePrompt) {
					audio_play_sound(snd_smokePoof, 1, 0, 2);
					file_delete("worldSave1.txt");
					map1 = false;
				} else {
					map1DeletePrompt = true;
				}
			}
		} else if(optionPosition == 5) {
			if(map2) {
				if(map2DeletePrompt) {
					audio_play_sound(snd_smokePoof, 1, 0, 2);
					file_delete("worldSave2.txt");
					map2 = false;
				} else {
					map2DeletePrompt = true;
				}
			}
		} else if(optionPosition == 6) {
			if(map3) {
				if(map3DeletePrompt) {
					audio_play_sound(snd_smokePoof, 1, 0, 2);
					file_delete("worldSave3.txt");
					map3 = false;
				} else {
					map3DeletePrompt = true;
				}
			}
		}
	} else if(optionGroup == 8) { // gameplay settings
		if(optionPosition == 0) {
			menuSwitchOptionGroup(1);
		} else {
			menuChangeField(intent);
		}
	}
}
#endregion

#region menu switch option group
menuSwitchOptionGroup = function(newOptionGroup, hardCoded = 0, playSound = true){
	live_auto_call
	
	optionGroup = newOptionGroup;
	optionPosition = 0;
	menuAlign = fa_middle;
	menuTextOffset = 0;
	menuBorder = 20;
	
	if(newOptionGroup == 0) {
		optionHeight = 35;
	} else {
		optionHeight = 40;
	}
	
	//basic references
	optionAmount = array_length(options[optionGroup]);
	var _maxOptionWidth = 0;
	var _holdWidth = 0;
	for(var optionIterator = 0; optionIterator < optionAmount; optionIterator++) {
		_holdWidth = 1 * string_width(options[optionGroup][optionIterator]);
		if(_holdWidth > _maxOptionWidth) {
			_maxOptionWidth = _holdWidth;
		}
	}
	menuWidth = menuBorder * 2 + _maxOptionWidth + 10;
	menuHeight = menuBorder * 2 + optionAmount * optionHeight;
	
	if(newOptionGroup == 2) {
		menuAlign = fa_right;
		menuWidth = 400;
		menuTextOffset = 40;
	} else if(newOptionGroup == 3) {
		menuAlign = fa_right;
		menuWidth = 420;
		menuTextOffset = -8;
	} else if(newOptionGroup == 4) {
		menuAlign = fa_middle;
		menuWidth = 400;
		menuHeight = 240;
	} else if(newOptionGroup == 5) {
		menuAlign = fa_right;
		menuWidth = 370;
		menuTextOffset = 20;
	} else if(newOptionGroup == 6) { // map gen options
		menuAlign = fa_right;
		menuWidth = 540;
		menuTextOffset = 51	;
	} else if(newOptionGroup == 7) { // map select
		menuAlign = fa_center;
		menuWidth = 240;
		menuHeight = 300;
		menuBorder = 25;
		menuTextOffset = 0;
		optionHeight = 90;
	} else if(newOptionGroup == 8) {
		menuAlign = fa_right;
		menuWidth = 400;
		menuTextOffset = -25;
	}

	x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - menuWidth / 2;
	y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - menuHeight / 2;
	
	//play sound for switching screen thing
	if(playSound) {
		audio_play_sound(snd_click1, 100, false);
	}
}
#endregion

#region menu switch position
menuSwitchPosition = function(positionChange) {
	if(positionChange != 0) {
		optionPosition = clamp(optionPosition + positionChange, 0, optionAmount - 1);
		audio_play_sound(snd_click3, 100, false);
	}
}
#endregion

menuSwitchOptionGroup(0,, false);

initializeMenu();