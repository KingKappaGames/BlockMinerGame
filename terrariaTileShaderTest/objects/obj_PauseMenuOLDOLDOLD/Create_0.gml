//if (live_call()) return live_result;

draw_set_font(fnt_spaceMenu);

//show_debug_message("AAAAAAAAAAAAAHHHHHHHHHHHHHHHHHHHHHHHHHHHH")

pauseSurfaceBuffer = buffer_create(8294400, buffer_fixed, 1);
pauseSurface = -1;

gameSaved = 0;

menuWidth = 1920;
menuHeight = 1080;

options[0][0] = "RESUME";
options[0][1] = "OPTIONS";
options[0][2] = "SAVE";
options[0][3] = "QUIT (desk top!)";

options[1][0] = "RETURN";
options[1][1] = "SOUND SETTINGS";
options[1][2] = "VISUAL SETTINGS";
options[1][3] = "GAME SETTINGS";
options[1][4] = "CONTROLS";

options[2][0] = "RETURN";
options[2][1] = "EFFECTS VOLUME";
options[2][2] = "MUSIC VOLUME";
options[2][3] = "SPECIAL VOLUME";
options[2][4] = "AMBIENT VOLUME";

options[3][0] = "RETURN";
options[3][1] = "RESOLUTION";
options[3][2] = "WINDOW";
options[3][3] = "VSYNC";
options[3][4] = "COLORS";

options[4][0] = "RETURN";

options[5][0] = "RETURN";
options[5][1] = "DIFFICULTY";
options[5][2] = "SCREEN SHAKE";
options[5][3] = "GORE"; // todo
options[5][4] = "VIEW ROTATION";

optionPosition = 0;
optionGroup = 0;
optionAmount = 4;

optionHeight = 140;
menuBorder = 80;
menuAlign = fa_left;
menuTextOffset = 0;

x = camera_get_view_x(view_camera[0]) + camera_get_view_width(view_camera[0]) / 2 - menuWidth / 2;
y = camera_get_view_y(view_camera[0]) + camera_get_view_height(view_camera[0]) / 2 - menuHeight / 2;

depth -= 10;

//game settings in menu
//gameDifficultyDisplayOptions = ["polite", "everyman", "champion"];
//gameDifficultySelected = global.gameDifficultySelected;

//gameScreenShakeDisplayOptions = ["none", "minimal", "default", "jittery", "mistakes"];
//gameScreenShakeSelected = global.gameScreenShakeSelected;

gameWindowResolutionSelected = global.gameWindowResolutionSelected;
gameWindowResolutionOptions = [[480, 270], [1280, 720], [1920, 1080], [2560, 1440]];

gameFullscreenSelected = global.gameFullscreenSelected;
gameFullscreenOptions = [false, true];
gameFullscreenDisplayOptions = ["WINDOWED", "FULLSCREEN"];

gameVsyncSelected = global.gameVsyncSelected;
gameVsyncOptions = [false, true];
gameVsyncOptions = ["DISABLED", "NO..."];

gameColorFilterSelected = global.gameColorFilterSelected;
gameColorFilterDisplayOptions = ["NORMAL", "COLOR BLIND", "GREY-SCALE", "VIBRANT"];

gameDifficultySelected = global.gameDifficultySelected;
gameDifficultyDisplayOptions = ["SIMPLE", "MEDIUM", "PIONEER"];
gameScreenShakeSelected = global.gameScreenShakeSelected;
gameScreenShakeDisplayOptions = ["NONE", "MINIMAL", "DEFAULT", "SHAKEY", "AWFUL"];
gameGoreSelected = global.gameGoreSelected;
gameGoreDisplayOptions = ["NONE", "MINIMAL", "REGULAR"];
gameViewRotationSelected = global.gameCameraRotationSelected;
gameViewRotationDisplayOptions = ["FIXED", "FOLLOW", "ONLY PLAYER", "ONLY SHIP"];

gameEffectVolume = global.gameEffectVolume;
gameMusicVolume = global.gameMusicVolume;
gameSpecialVolume = global.gameSpecialVolume;
gameAmbientVolume = global.gameAmbientVolume;

#region menu change field
pauseMenuChangeField = function(fieldChange){
	if(fieldChange != 0) {
		audio_play_sound(snd_menuBeep, 100, false);
		if(optionGroup == 2) {
			if(optionPosition == 1) {
				gameEffectVolume = clamp(gameEffectVolume + fieldChange, 0, 10);
				audio_group_set_gain(sndGrp_sfx, gameEffectVolume / 5, 0);
			} else if(optionPosition == 2) {
				gameMusicVolume = clamp(gameMusicVolume + fieldChange, 0, 10);
				audio_group_set_gain(sndGrp_music, gameMusicVolume / 5, 0);
			} else if(optionPosition == 3) {
				gameSpecialVolume = clamp(gameSpecialVolume + fieldChange, 0, 10);
				audio_group_set_gain(sndGrp_direct, gameSpecialVolume / 5, 0);
			} else if(optionPosition == 4) {
				gameAmbientVolume = clamp(gameAmbientVolume + fieldChange, 0, 10);
				audio_group_set_gain(sndGrp_ambient, gameAmbientVolume / 5, 0);
			}
		} else if(optionGroup == 3) {
			if(optionPosition == 1) {
				//change resolution
				gameWindowResolutionSelected = clamp(gameWindowResolutionSelected + fieldChange, 0, 3);
				window_set_size(gameWindowResolutionOptions[gameWindowResolutionSelected][0], gameWindowResolutionOptions[gameWindowResolutionSelected][1]);
			} else if(optionPosition == 2) {
				//change window configuration
				gameFullscreenSelected = clamp(gameFullscreenSelected + fieldChange, 0, 1);
				window_set_fullscreen(gameFullscreenOptions[gameFullscreenSelected]);
			} else if(optionPosition == 3) {
				//toggle vsync
				gameVsyncSelected = clamp(gameVsyncSelected + fieldChange, 0, 1);
				//window_set_vsync(gameVysncOptions[gameVsyncSelected]); //dont...
			} else if(optionPosition == 4) {
				//change color profile, ex color blind mode
				gameColorFilterSelected = clamp(gameColorFilterSelected + fieldChange, 0, 3);
				if(gameColorFilterSelected == 0) {
					//set filter normal?
				} else if(gameColorFilterSelected == 1) {
					//set filter color blind mode
				} else if(gameColorFilterSelected == 2) {
					//set filter grey scale
				}
			}
		} else if(optionGroup == 5) {
			if(optionPosition == 1) {
				gameDifficultySelected = clamp(gameDifficultySelected + fieldChange, 0, 2);
			} else if(optionPosition == 2) {
				gameScreenShakeSelected = clamp(gameScreenShakeSelected + fieldChange, 0, 4);
			} if(optionPosition == 3) { // gore
				gameGoreSelected = clamp(gameGoreSelected + fieldChange, 0, 2);
			} else if(optionPosition == 4) { // view rotation
				gameViewRotationSelected = clamp(gameViewRotationSelected + fieldChange, 0, 3);
			}
		} // so on for more option groups
	}
}
#endregion

#region menu select option
pauseMenuSelectOption = function(){
	if(optionGroup == 0) {
		if(optionPosition == 0) {
			audio_play_sound(snd_menuBeep, 100, false);
			input_verb_consume("escape"); // TODO does this need to specify the thing that called it?
			instance_destroy();
		} else if(optionPosition == 1) {
			pauseMenuSwitchOptionGroup(1);
		} else if(optionPosition == 2) {
			//with(obj_dataStorageManager) {
			//	event_user(0);
			//}
			gameSaved = 1;
			audio_play_sound(snd_menuBeep, 100, false);
		} else if(optionPosition == 3) {
			game_end();
		}
	} else if(optionGroup == 1) {
		if(optionPosition == 0) {
			pauseMenuSwitchOptionGroup(0);
		} else if(optionPosition == 1) {
			pauseMenuSwitchOptionGroup(2, 1);
		} else if(optionPosition == 2) {
			pauseMenuSwitchOptionGroup(3, 1);
		} else if(optionPosition == 3) {
			pauseMenuSwitchOptionGroup(5, 1);
		} else if(optionPosition == 4) {
			pauseMenuSwitchOptionGroup(4, 1);
		}
	} else if(optionGroup == 2) {
		if(optionPosition == 0) {
			pauseMenuSwitchOptionGroup(1);
		} else if(optionPosition == 1) {
			audio_play_sound(snd_menuBlip, 100, false);
		} else if(optionPosition == 2) {
			audio_play_sound(snd_menuBlip, 100, false);
		} else if(optionPosition == 3) {
			audio_play_sound(snd_menuBlip, 100, false);
		} else if(optionPosition == 4) {
			audio_play_sound(snd_menuBlip, 100, false);
		}
	} else if(optionGroup == 3) {
		if(optionPosition == 0) {
			pauseMenuSwitchOptionGroup(1);
		} else if(optionPosition == 1) {
			audio_play_sound(snd_menuBlip, 100, false);
		} else if(optionPosition == 2) {
			audio_play_sound(snd_menuBlip, 100, false);
		} else if(optionPosition == 3) {
			audio_play_sound(snd_menuBlip, 100, false);
		} else if(optionPosition == 4) {
			audio_play_sound(snd_menuBlip, 100, false);
		}
	} else if(optionGroup == 4) {
		if(optionPosition == 0) {
			pauseMenuSwitchOptionGroup(1);
		}
	} else if(optionGroup == 5) {
		if(optionPosition == 0) {
			pauseMenuSwitchOptionGroup(1);
		}
	}// so on for more option groups
}
#endregion

#region menu switch option group
pauseMenuSwitchOptionGroup = function(newOptionGroup, hardCoded = 0){
	optionGroup = newOptionGroup;
	optionPosition = 0;
	menuAlign = fa_middle;
	menuTextOffset = 0;
	
	//basic references
	optionAmount = array_length(options[optionGroup]);
	if(hardCoded != 1) {
		//resize menu
		var _maxOptionWidth = 0;
		var _holdWidth = 0;
		for(var optionIterator = 0; optionIterator < optionAmount; optionIterator++) {
			_holdWidth = 1.5 * string_width(options[optionGroup][optionIterator]);
			if(_holdWidth > _maxOptionWidth) {
				_maxOptionWidth = _holdWidth;
			}
		}
		menuWidth = menuBorder * 2 + _maxOptionWidth;
		menuHeight = menuBorder * 2 + optionAmount * optionHeight;
	} else {
		if(newOptionGroup == 4) {
			menuAlign = fa_middle;
			menuWidth = 1600;
			menuHeight = 960;
		} else if(newOptionGroup == 2) {
			menuAlign = fa_right;
			menuWidth = 1200;
			menuHeight = 2 * menuBorder + optionAmount * optionHeight;
			menuTextOffset = 80; 
		} else if(newOptionGroup == 3) {
			menuAlign = fa_right;
			menuWidth = 1000;
			menuTextOffset = -25; 
			menuHeight = 2 * menuBorder + optionAmount * optionHeight;
		} else if(newOptionGroup == 5) {
			menuAlign = fa_right;
			menuTextOffset = 40;
			menuWidth = 1050;
			menuHeight = 2 * menuBorder + optionAmount * optionHeight;
		}
	}

	//play sound for switching screen thing
	audio_play_sound(snd_menuBeep, 100, false);
}
#endregion

#region switch position
pauseMenuSwitchPosition = function(positionChange){
	if(positionChange != 0) {
		optionPosition = clamp(optionPosition + positionChange, 0, optionAmount - 1);
		audio_play_sound(snd_menuBlip, 100, false);
	}
}
#endregion

closeLayer = function() {
	optionPosition = 0;
	pauseMenuSelectOption();
}

pauseMenuSwitchOptionGroup(0);

script_setPauseState(1, 1);