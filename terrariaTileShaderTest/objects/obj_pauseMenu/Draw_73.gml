if (live_call()) return live_result;

draw_set_halign(menuAlign);

for(var _iterator = 0; _iterator < optionAmount; _iterator++) {
	var _textColor = c_white;
	if(_iterator == optionPosition) {
		_textColor = c_yellow;
	}
	
	if(_iterator == 0) {
		draw_set_halign(fa_center);
		draw_text_transformed_color(x + menuWidth / 2, y + menuBorder + _iterator * optionHeight, options[optionGroup][_iterator], 1, 1, 0, _textColor, _textColor, _textColor, _textColor, 1);
		draw_set_halign(menuAlign);
	} else {
		var _alpha = 1;
		if(optionGroup == 0 && _iterator = 2 && gameSaved) {
			_alpha = .5;
		}
		draw_text_transformed_color(x + menuWidth / 2 + menuTextOffset, y + menuBorder + _iterator * optionHeight, options[optionGroup][_iterator], 1, 1, 0, _textColor, _textColor, _textColor, _textColor, _alpha);
	}
}

if(optionGroup == 4) { // custom draw groups
	draw_sprite(spr_controlDiagram, 0, x + 25, y + 52);
} else if(optionGroup == 2) {
	draw_sprite(spr_optionMeter, gameEffectVolume, x + 245, y + 58);
	draw_sprite(spr_optionMeter, gameMusicVolume, x + 245, y + 98);
	draw_sprite(spr_optionMeter, gameAmbientVolume, x + 245, y + 138);
} else if(optionGroup == 3) {
	draw_set_halign(fa_left)
	var _fullscreenVar = "";
	if(window_get_fullscreen()) {
		_fullscreenVar = "*";
	}
	draw_text_transformed(x + 180, y + 59, string(gameWindowResolutionOptions[gameWindowResolutionSelected][0]) + ", " + string(gameWindowResolutionOptions[gameWindowResolutionSelected][1]) + _fullscreenVar, 1, 1, 0);
	draw_text_transformed(x + 180, y + 98, string(gameFullscreenDisplayOptions[gameFullscreenSelected]), 1, 1, 0);
	draw_text_transformed(x + 180, y + 139, gameColorFilterDisplayOptions[gameColorFilterSelected], 1, 1, 0);
} else if(optionGroup == 5) {
	draw_set_halign(fa_left)
	draw_text_transformed(x + 215, y + 60, string(gameDifficultyDisplayOptions[gameDifficultySelected]), 1, 1, 0);
	draw_text_transformed(x + 215, y + 100, string(gameScreenShakeDisplayOptions[gameScreenShakeSelected]), 1, 1, 0);
	draw_text_transformed(x + 215, y + 140, gameGoreDisplayOptions[gameGoreSelected], 1, 1, 0);
}
	
draw_set_halign(fa_left);