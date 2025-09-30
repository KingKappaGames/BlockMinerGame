if (live_call()) return live_result;

global.pauseMenu = id; // gets set to noone upon unpausing!

draw_set_font(fnt_menuText);
//global.soundManager.songStart(snd_BackgroundMenuCrafts, false, 2.4);

cam = view_camera[0];

pauseSurface = -1;

menuWidth = 500;
menuHeight = 440;

options[0][0] = "RESUME";
options[0][1] = "OPTIONS";
options[0][2] = "SAVE WORLD";
options[0][3] = "QUIT";

options[1][0] = "RETURN";
options[1][1] = "SOUND SETTINGS";
options[1][2] = "VISUAL SETTINGS";
options[1][3] = "GAME SETTINGS";
options[1][4] = "CONTROLS";

options[2][0] = "RETURN";
options[2][1] = "EFFECTS VOLUME";
options[2][2] = "MUSIC VOLUME";
options[2][3] = "AMBIENT VOLUME";

options[3][0] = "RETURN";
options[3][1] = "RESOLUTION";
options[3][2] = "WINDOW";
options[3][3] = "COLORS";

options[4][0] = "RETURN";

options[5][0] = "RETURN";
options[5][1] = "DIFFICULTY";
options[5][2] = "SCREEN SHAKE";
options[5][3] = "GORE";

optionPosition = 0;
optionGroup = 0;
optionAmount = 4;

optionHeight = 35;
menuBorder = 20;
menuAlign = fa_middle;
menuTextOffset = 0;

mouseSelecting = false;

gameSaved = false;

x = room_width / 2 - menuWidth / 2;
y = room_height / 2 - menuHeight / 2;

//game settings in menu
gameDifficultyDisplayOptions = ["polite", "everyman", "champion"];
gameDifficultySelected = global.gameDifficultySelected;

gameScreenShakeDisplayOptions = ["none", "minimal", "default", "jittery", "mistakes"];
gameScreenShakeSelected = global.gameScreenShakeSelected;

gameGoreDisplayOptions = ["none", "minimal", "default"];
gameGoreSelected = global.gameGoreSelected;

gameWindowResolutionSelected = global.gameWindowResolutionSelected;
gameWindowResolutionOptions = [[480, 270], [1280, 720], [1920, 1080], [2560, 1440]];

gameFullscreenSelected = global.gameFullscreenSelected;
gameFullscreenOptions = [false, true];
gameFullscreenDisplayOptions = ["windowed", "Fullscreen"];

gameColorFilterSelected = global.gameColorFilterSelected;
gameColorFilterDisplayOptions = ["normal", "color blind", "grey-scale", "vibrant", "computer lab"];

gameEffectVolume = global.gameEffectVolume;
gameMusicVolume = global.gameMusicVolume;
gameAmbientVolume = global.gameAmbientVolume;

#region initialize menu
initializeMenu = function(){
	window_set_size(gameWindowResolutionOptions[gameWindowResolutionSelected][0], gameWindowResolutionOptions[gameWindowResolutionSelected][1]);
	window_center();
	
	x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - menuWidth / 2;
	y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - menuHeight / 2;
}
#endregion

#region menu change field
menuChangeField = function(fieldChange) {
	if(fieldChange != 0) {
		audio_play_sound(snd_MenuBeep, 100, false);
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
				gameColorFilterSelected = clamp(gameColorFilterSelected + fieldChange, 0, 4);
				global.gameColorFilterSelected = gameColorFilterSelected;
			}
		} else if(optionGroup == 5) {
			if(optionPosition == 1) {
				gameDifficultySelected = clamp(gameDifficultySelected + fieldChange, 0, 2);
			} else if(optionPosition == 2) {
				gameScreenShakeSelected = clamp(gameScreenShakeSelected + fieldChange, 0, 4);
			} if(optionPosition == 3) {
				gameGoreSelected = clamp(gameGoreSelected + fieldChange, 0, 2);
			}
		}
	}
}
#endregion

#region menu select option
menuSelectOption = function(intent = 0) { // -1 for decrease option, 0 for none, 1 for increase (this is a way to pass through mouse clicks instead of left and right to change values	
	if(optionGroup == 0) {
		if(optionPosition == 0) {
			audio_play_sound(snd_MenuBeep, 100, false);
			instance_destroy();
			script_setPauseState(false);
		} else if(optionPosition == 1) {
			menuSwitchOptionGroup(1);
		} else if(optionPosition == 2) {
			audio_play_sound(snd_MenuBeep, 100, false);
			
			script_saveWorld("worldSave" + string(global.manager.worldCurrent) + ".txt");
			
			gameSaved = true;
		} else if(optionPosition == 3) {
			instance_destroy();
			
			script_setPauseState(false); // unpause while moving to main menu
			
			global.manager.exitGameWorld();
			global.manager.initMainMenuScreen();
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
	}

	x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - menuWidth / 2;
	y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - menuHeight / 2;
	
	//play sound for switching screen thing
	if(playSound) {
		audio_play_sound(snd_MenuBeep, 100, false);
	}
}
#endregion

#region menu switch position
menuSwitchPosition = function(positionChange) {
	if(positionChange != 0) {
		optionPosition = clamp(optionPosition + positionChange, 0, optionAmount - 1);
		audio_play_sound(snd_MenuBlip, 100, false);
	}
}
#endregion

menuSwitchOptionGroup(0,, false);

initializeMenu();