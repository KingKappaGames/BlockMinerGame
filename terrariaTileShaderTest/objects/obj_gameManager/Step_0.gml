if (live_call()) return live_result;

global.timer++;

if(inGame) { 
	if(pauseNextFrame != noone) {
		var _pauseObject = instance_create_layer(x, y, "Instances", pauseNextFrame);
		_pauseObject.pauseSurface = pauseSurface;
		script_setPauseState(true);
		pauseNextFrame = noone;
	} else {
		if(!global.gamePaused) {
			if(global.timer % surfaceEffectsUpdateTick == 0) {
				updateDepthEffects();
				
				var _rainEvent = global.gameRainSelected;
				if(_rainEvent != 0) {
					if(irandom(7) == 0) {
						var _rainType = noone;
						if(_rainEvent == 1) {
							_rainType = obj_bomb;
						} else if(_rainEvent == 2) {
							_rainType = obj_bananaBomb;
						} else if(_rainEvent == 3) {
							if(irandom(2) == 0) {
								_rainType = obj_person;
							}
						}
						
						if(_rainEvent != noone) {
							var _bomb = instance_create_layer(camera_get_view_x(cam) + irandom(camera_get_view_width(cam)), 100, "Instances", _rainType);
							_bomb.xChange = random_range(-6, 6);
							_bomb.duration = 720;
						}
					}
				}
			}
		}
		
		//show_debug_message($"CamX/Y: {camera_get_view_x(cam)}/{camera_get_view_y(cam)}   AND updateX/Y: {screenWorldX}/{screenWorldY}");
		
		if(keyboard_check_released(vk_escape)) {
			pauseNextFrame = obj_pauseMenu;
		} else if(keyboard_check_released(vk_backspace)) {
			pauseNextFrame = obj_cutscene;
		}
	}
} else if(instance_exists(obj_MainMenu)) {
	if(splashIntroProgress > 1) {
		if(audio_group_is_loaded(sndGrp_music) && !audio_is_playing(snd_mainMenuMusic)) {
			menuMusic = audio_play_sound(snd_mainMenuMusic, 999, 1);
			audio_sound_gain(menuMusic, 0, 0);
			audio_sound_gain(menuMusic, 1, 12000);
		}
	}
}

if(keyboard_check_released(ord("F"))) {
	var _newFullScreen = !window_get_fullscreen();
	window_set_fullscreen(_newFullScreen);
	
	if(!inGame) {
		obj_MainMenu.gameFullscreenSelected = _newFullScreen;
	} else {
		if(global.pauseMenu != noone) {
			global.pauseMenu.gameFullscreenSelected = _newFullScreen;
		}
	}
}