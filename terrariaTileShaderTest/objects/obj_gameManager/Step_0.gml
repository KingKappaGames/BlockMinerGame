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