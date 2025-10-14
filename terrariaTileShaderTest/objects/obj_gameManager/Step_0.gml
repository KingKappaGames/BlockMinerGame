if (live_call()) return live_result;

global.timer++;

if(inGame) { 
	if(pauseNextFrame != noone) {
		var _pauseObject = instance_create_layer(x, y, "Instances", pauseNextFrame);
		_pauseObject.pauseSurface = pauseSurface;
		script_setPauseState(true);
		pauseNextFrame = noone;
	} else {
		if(global.timer % surfaceEffectsUpdateTick == 0) {
			updateDepthEffects();
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