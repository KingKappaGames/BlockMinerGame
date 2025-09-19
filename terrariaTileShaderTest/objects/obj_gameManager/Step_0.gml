timer++;

if(timer % 30 == 0) {
	cameraWorldDepth = global.player.y / worldSizePixels;
	
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
		abyssParams.g_TintCol = [lerp(1, .18, _abyssStrength), 1 - _abyssStrength, lerp(1, .3, _abyssStrength), 1]; // (push towards white to make disappear
		
		fx_set_parameters(abyssFilter, abyssParams);
	} else {
		layer_enable_fx(abyssLayer, false);
	}
	#endregion
}

var _camChange = keyboard_check(vk_subtract) - keyboard_check(vk_add);
if(_camChange != 0) {
	var _camScaleChange = 1 + _camChange * .01;
	camera_set_view_size(cam, clamp(camera_get_view_width(cam) * _camScaleChange, 240, 2560), clamp(camera_get_view_height(cam) * _camScaleChange, 135, 1440));
	global.tileManager.updateScreen();
}

if(keyboard_check_released(ord("F"))) {
	window_set_fullscreen(!window_get_fullscreen());
}

//show_debug_message($"CamX/Y: {camera_get_view_x(cam)}/{camera_get_view_y(cam)}   AND updateX/Y: {screenWorldX}/{screenWorldY}");



//SAVE GAME
if(keyboard_check_released(vk_end)) { 
	script_saveWorld();
}

if(keyboard_check_released(vk_home)) {
	script_loadWorld();
}