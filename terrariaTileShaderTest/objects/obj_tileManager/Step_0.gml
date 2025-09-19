var _camChange = keyboard_check(vk_subtract) - keyboard_check(vk_add);
if(_camChange != 0) {
	var _camScaleChange = 1 + _camChange * .01;
	camera_set_view_size(cam, clamp(camera_get_view_width(cam) * _camScaleChange, 480, 2160), clamp(camera_get_view_height(cam) * _camScaleChange, 270, 1440));
	updateScreen();
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