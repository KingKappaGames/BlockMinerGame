global.timer++;

if(inGame) { 
	if(global.timer % 30 == 0) {
		cameraWorldDepth = global.player.y / global.worldSizePixels;
		
		//if(irandom(100) == 0) {
			//ef_reverb.size = cameraWorldDepth * 2;
			//ef_reverb.mix = 0.3;
			//audio_bus_main.effects[0] = ef_reverb;
		//}
		
		#region effect controls
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
		#endregion
	}
	
	//show_debug_message($"CamX/Y: {camera_get_view_x(cam)}/{camera_get_view_y(cam)}   AND updateX/Y: {screenWorldX}/{screenWorldY}");
	
	if(keyboard_check_released(vk_escape)) {
		script_saveWorld("worldSave" + string(worldCurrent) + ".txt");
		
		exitGameWorld();
		
		initMainMenuScreen();
	}
}

if(keyboard_check_released(ord("F"))) {
	var _newFullScreen = !window_get_fullscreen();
	window_set_fullscreen(_newFullScreen);
	
	if(!inGame) {
		if(_newFullScreen) {
			obj_MainMenu.gameFullscreenSelected = 1;
		} else {
			obj_MainMenu.gameFullscreenSelected = 0;
		}
	}
}