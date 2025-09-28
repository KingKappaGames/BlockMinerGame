//if (live_call()) return live_result;

var _baseX = global.manager.camWidth / 2 - menuWidth / 2;
var _baseY = view_hport[0] / 2 - menuHeight / 2;

if(surface_exists(pauseSurface)) {
	shader_set(shd_blur);
	
	shader_set_uniform_f(shader_get_uniform(shd_blur, "size"), 1920, 1080, 24);
	
	draw_surface_ext(pauseSurface, 0, 0, 1, 1, 0, c_white, 1);
	
	shader_reset();
} else {
	pauseSurface = surface_create(1920, 1080);
	buffer_set_surface(pauseSurfaceBuffer, pauseSurface, 0); // re-enable! This was breaking live code but is necessary!
}
draw_set_halign(menuAlign);
draw_sprite_ext(sprite_index, image_index, _baseX, _baseY, menuWidth / sprite_width, menuHeight / sprite_height, 0, c_white, 1);

for(var _iterator = 0; _iterator < optionAmount; _iterator++) {
	var _textColor = c_white;
	if(_iterator == optionPosition) {
		_textColor = c_yellow;
	}
	draw_text_transformed_color(_baseX + menuWidth / 2 + menuTextOffset, _baseY + menuBorder + _iterator * optionHeight, options[optionGroup][_iterator], 1.6, 2.4, 0, _textColor, _textColor, _textColor, _textColor, 1);
}

if(optionGroup == 4) { // custom draw groups
	draw_sprite_ext(spr_controlDiagram, 0, _baseX + 100, 260, 2, 2, 0, c_white, 1);
} else if(optionGroup == 2) {
	draw_sprite_ext(spr_optionMeter, gameEffectVolume,  _baseX + menuWidth / 2 + menuTextOffset + 50, _baseY - 9 + menuBorder + optionHeight * 1, 2, 2, 0, c_white, 1);
	draw_sprite_ext(spr_optionMeter, gameMusicVolume,   _baseX + menuWidth / 2 + menuTextOffset + 50, _baseY - 9 + menuBorder + optionHeight * 2, 2, 2, 0, c_white, 1);
	draw_sprite_ext(spr_optionMeter, gameSpecialVolume, _baseX + menuWidth / 2 + menuTextOffset + 50, _baseY - 9 + menuBorder + optionHeight * 3, 2, 2, 0, c_white, 1);
	draw_sprite_ext(spr_optionMeter, gameAmbientVolume, _baseX + menuWidth / 2 + menuTextOffset + 50, _baseY - 9 + menuBorder + optionHeight * 4, 2, 2, 0, c_white, 1);
} else if(optionGroup == 3) {
	draw_set_halign(fa_left)
	var _fullscreenVar = "";
	if(window_get_fullscreen()) {
		_fullscreenVar = "*";
	}
	draw_text_transformed(_baseX + menuWidth / 2 + menuTextOffset + 60, _baseY + menuBorder + 1 * optionHeight, string(gameWindowResolutionOptions[gameWindowResolutionSelected][0]) + ", " + string(gameWindowResolutionOptions[gameWindowResolutionSelected][1]) + _fullscreenVar, 1.6, 2.4, 0);
	draw_text_transformed(_baseX + menuWidth / 2 + menuTextOffset + 60, _baseY + menuBorder + 2 * optionHeight, string(gameFullscreenDisplayOptions[gameFullscreenSelected]), 1.6, 2.4, 0);
	draw_text_transformed(_baseX + menuWidth / 2 + menuTextOffset + 60, _baseY + menuBorder + 3 * optionHeight, string(gameVsyncOptions[gameVsyncSelected]), 1.6, 2.4, 0);
	draw_text_transformed(_baseX + menuWidth / 2 + menuTextOffset + 60, _baseY + menuBorder + 4 * optionHeight, gameColorFilterDisplayOptions[gameColorFilterSelected], 1.6, 2.4, 0);
} else if(optionGroup == 5) {
	draw_set_halign(fa_left)
	draw_text_transformed(_baseX + menuWidth / 2 + menuTextOffset + 50, _baseY + menuBorder + 1 * optionHeight, string(gameDifficultyDisplayOptions[gameDifficultySelected]), 1.6, 2.4, 0);
	draw_text_transformed(_baseX + menuWidth / 2 + menuTextOffset + 50, _baseY + menuBorder + 2 * optionHeight, string(gameScreenShakeDisplayOptions[gameScreenShakeSelected]), 1.6, 2.4, 0);
	draw_text_transformed(_baseX + menuWidth / 2 + menuTextOffset + 50, _baseY + menuBorder + 3 * optionHeight, gameGoreDisplayOptions[gameGoreSelected], 1.6, 2.4, 0);
	draw_text_transformed(_baseX + menuWidth / 2 + menuTextOffset + 50, _baseY + menuBorder + 4 * optionHeight, gameViewRotationDisplayOptions[gameViewRotationSelected], 1.6, 2.4, 0);
} else if(optionGroup == 0) {
	if(gameSaved == 1) {
		draw_text_transformed_color(_baseX + menuWidth / 2 + menuTextOffset + 130, _baseY + menuBorder + 2 * optionHeight, "X", 1.6, 2.4, 0, c_green, c_green, c_green, c_green, 1);
	}
}


draw_set_halign(fa_left);