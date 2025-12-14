if (live_call()) return live_result;

if(keyboard_check(vk_f1)) {
	draw_text_transformed(view_wport[0] * .5, 10, fps_real, 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 50, camera_get_view_x(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 90, camera_get_view_y(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 130, camera_get_view_width(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 170, camera_get_view_height(cam), 3, 3, 0);
}

//draw_text(300, 20, musicCurrentLayer);
//draw_text(300, 50, musicDepthTracks);
//draw_text(300, 80, cameraWorldDepth);
//draw_text(300, 110, cameraWorldDepthPrevious);

//var _camX = camera_get_view_x(cam);
//var _camY = camera_get_view_y(cam);
//var _camW = camera_get_view_width(cam);
//_camH = camera_get_view_height(cam);

if(inGame) {
	if(!global.gamePaused) {
		var _vignetteStrength = min((cameraWorldDepth - vignetteEffectRange[0]) / (vignetteEffectRange[1] - vignetteEffectRange[0]), 1.0);
		if(_vignetteStrength > 0) {
			var _screenWidth = view_wport[0];
			draw_sprite_ext(spr_vignetteRough, 0, _screenWidth * .5, view_hport[0] * .5, 1.5 * _screenWidth / 128 - _vignetteStrength * 7.7, 1.5 * _screenWidth / 128 - _vignetteStrength * 7.7, 0, c_white, _vignetteStrength * 1.22);
		}
	}
} else {
	if(splashIntroProgress < 1) {
		if(splashIntroProgress < .2) {
			draw_sprite_stretched(spr_splashScreen, 0, 0, 0, view_wport[0], view_hport[0]);
			draw_set_alpha(1 - (splashIntroProgress * 5));
			draw_rectangle_color(0, 0, view_wport[0], view_hport[0], c_black, c_black, c_black, c_black, false); // fading to splash icon first third
			draw_set_alpha(1);
		} else if(splashIntroProgress < .6) { // showing splash icon
			draw_sprite_stretched(spr_splashScreen, 0, 0, 0, view_wport[0], view_hport[0]);
		} else if(splashIntroProgress < .8) { // fading to black
			draw_sprite_stretched(spr_splashScreen, 0, 0, 0, view_wport[0], view_hport[0]);
			draw_set_alpha(((splashIntroProgress - .6) * 5));
			draw_rectangle_color(0, 0, view_wport[0], view_hport[0], c_black, c_black, c_black, c_black, false); // fading to splash icon first third
			draw_set_alpha(1);
		} else {
			draw_set_alpha(1 - ((splashIntroProgress - .8) * 5));
			draw_rectangle_color(0, 0, view_wport[0], view_hport[0], c_black, c_black, c_black, c_black, false); // fading to splash icon first third
			draw_set_alpha(1);
		}
		
		splashIntroProgress += .03;
	}
}

draw_text(200, 280, global.bossSpawned);