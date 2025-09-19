if(keyboard_check(vk_f1)) {
	draw_text_transformed(view_wport[0] * .5, 10, fps_real, 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 50, camera_get_view_x(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 90, camera_get_view_y(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 130, camera_get_view_width(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 170, camera_get_view_height(cam), 3, 3, 0);
}

//var _camX = camera_get_view_x(cam);
//var _camY = camera_get_view_y(cam);
//var _camW = camera_get_view_width(cam);
//_camH = camera_get_view_height(cam);

var _vignetteStrength = min((cameraWorldDepth - vignetteEffectRange[0]) / (vignetteEffectRange[1] - vignetteEffectRange[0]), 1.0);
if(_vignetteStrength > 0) {
	var _screenWidth = view_wport[0];
	draw_sprite_ext(spr_vignetteRough, 0, _screenWidth * .5, view_hport[0] * .5, 1.5 * _screenWidth / 128 - _vignetteStrength * 8.4, 1.5 * _screenWidth / 128 - _vignetteStrength * 8.4, 0, c_white, _vignetteStrength * 1.25);
}