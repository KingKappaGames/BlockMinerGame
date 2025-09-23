if (live_call()) return live_result;

if(!loadNextFrame) {
	draw_set_halign(menuAlign);
	
	for(var _iterator = 0; _iterator < optionAmount; _iterator++) {
		var _textColor = c_white;
		if(_iterator == optionPosition) {
			_textColor = c_yellow;
		}
		draw_text_transformed_color(x + menuWidth / 2 + menuTextOffset, y + menuBorder + _iterator * optionHeight, options[optionGroup][_iterator], 1, 1, 0, _textColor, _textColor, _textColor, _textColor, 1);
	}
	
	if(optionGroup == 4) { // custom draw groups
		draw_sprite(spr_controlDiagram, 0, x + 25, y + 52);
	} else if(optionGroup == 2) {
		draw_sprite(spr_optionMeter, gameEffectVolume, x + 205, y + 65);
		draw_sprite(spr_optionMeter, gameMusicVolume, x + 205, y + 105);
		draw_sprite(spr_optionMeter, gameAmbientVolume, x + 205, y + 145);
	} else if(optionGroup == 3) {
		draw_set_halign(fa_left)
		var _fullscreenVar = "";
		if(window_get_fullscreen()) {
			_fullscreenVar = "*";
		}
		draw_text_transformed(x + 185, y + 65, string(gameWindowResolutionOptions[gameWindowResolutionSelected][0]) + ", " + string(gameWindowResolutionOptions[gameWindowResolutionSelected][1]) + _fullscreenVar, 1, 1.5, 0);
		draw_text_transformed(x + 185, y + 105, string(gameFullscreenDisplayOptions[gameFullscreenSelected]), 1, 1.5, 0);
		draw_text_transformed(x + 185, y + 145, gameColorFilterDisplayOptions[gameColorFilterSelected], 1, 1.5, 0);
	} else if(optionGroup == 5) {
		draw_set_halign(fa_left)
		draw_text_transformed(x + 185, y + 65, string(gameDifficultyDisplayOptions[gameDifficultySelected]), 1, 1.5, 0);
		draw_text_transformed(x + 185, y + 105, string(gameScreenShakeDisplayOptions[gameScreenShakeSelected]), 1, 1.5, 0);
		draw_text_transformed(x + 185, y + 145, gameGoreDisplayOptions[gameGoreSelected], 1, 1.5, 0);
	} else if(optionGroup == 6) { // map gen option screen
		draw_set_halign(fa_left);
		draw_text_transformed(x + 185, y + 65, worldOptionGenerationTypeOptions[worldOptionGenerationTypeSelected], 1, 1.5, 0);
		draw_text_transformed(x + 185, y + 105, string(worldOptionSizeOptions[worldOptionSizeSelected]), 1, 1.5, 0);
		draw_text_transformed(x + 185, y + 145, string(worldOptionStructureMultOptions[worldOptionStructureMultSelected]), 1, 1.5, 0);
		draw_text_transformed(x + 185, y + 185, string(worldOptionFlatOptions[worldOptionFlatSelected]), 1, 1.5, 0);
	} else if(optionGroup == 7) { // map select screen
		var _map1Frame = 0;
		var _map2Frame = 0;
		var _map3Frame = 0;
		if(map1) {
			_map1Frame = 1;
			draw_sprite_ext(spr_deleteWorldIcons, map1DeletePrompt ? 1 : 0, x + 51, y + 222, 1, 1, 0, optionPosition == 4 ? c_yellow : c_white, 1);
		}
		if(map2) {
			_map2Frame = 1;
			draw_sprite_ext(spr_deleteWorldIcons, map2DeletePrompt ? 1 : 0, x + 120, y + 222, 1, 1, 0, optionPosition == 5 ? c_yellow : c_white, 1);
		}
		if(map3) {
			_map3Frame = 1;
			draw_sprite_ext(spr_deleteWorldIcons, map3DeletePrompt ? 1 : 0, x + 188, y + 222, 1, 1, 0, optionPosition == 6 ? c_yellow : c_white, 1);
		}
		draw_sprite_ext(spr_mapIconSprite, _map1Frame, x + 52, y + 125, 1, 1, 0, optionPosition == 1 ? c_yellow : c_white, 1);
		draw_sprite_ext(spr_mapIconSprite, _map2Frame, x + 120, y + 125, 1, 1, 0, optionPosition == 2 ? c_yellow : c_white, 1);
		draw_sprite_ext(spr_mapIconSprite, _map3Frame, x + 188, y + 125, 1, 1, 0, optionPosition == 3 ? c_yellow : c_white, 1); 
	}
	
	draw_text(mouse_x, mouse_y, $"{mouse_x - x}/{mouse_y - y}");
	
	draw_set_halign(fa_left);
}