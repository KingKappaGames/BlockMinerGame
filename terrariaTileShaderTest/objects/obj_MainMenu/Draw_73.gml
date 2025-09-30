if (live_call()) return live_result;

if(!loadNextFrame) {
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
			draw_text_transformed_color(x + menuWidth / 2 + menuTextOffset, y + menuBorder + _iterator * optionHeight, options[optionGroup][_iterator], 1, 1, 0, _textColor, _textColor, _textColor, _textColor, 1);
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
		draw_text_transformed(x + 220, y + 59, string(gameWindowResolutionOptions[gameWindowResolutionSelected][0]) + ", " + string(gameWindowResolutionOptions[gameWindowResolutionSelected][1]) + _fullscreenVar, 1, 1, 0);
		draw_text_transformed(x + 220, y + 98, string(gameFullscreenDisplayOptions[gameFullscreenSelected]), 1, 1, 0);
		draw_text_transformed(x + 220, y + 139, gameColorFilterDisplayOptions[gameColorFilterSelected], 1, 1, 0);
	} else if(optionGroup == 5) {
		draw_set_halign(fa_left)
		draw_text_transformed(x + 215, y + 60, string(gameDifficultyDisplayOptions[gameDifficultySelected]), 1, 1, 0);
		draw_text_transformed(x + 215, y + 100, string(gameScreenShakeDisplayOptions[gameScreenShakeSelected]), 1, 1, 0);
		draw_text_transformed(x + 215, y + 140, gameGoreDisplayOptions[gameGoreSelected], 1, 1, 0);
	} else if(optionGroup == 6) { // map gen option screen
		draw_set_halign(fa_left);
		draw_text_transformed(x + 338, y + 60, worldOptionGenerationTypeOptions[worldOptionGenerationTypeSelected], 1, 1, 0);
		draw_text_transformed(x + 338, y + 100, string(worldOptionSizeOptions[worldOptionSizeSelected]), 1, 1, 0);
		draw_text_transformed(x + 338, y + 140, string(worldOptionStructureMultOptions[worldOptionStructureMultSelected]), 1, 1, 0);
		draw_text_transformed(x + 338, y + 180, worldOptionFlatOptions[worldOptionFlatSelected] ? "True" : "False", 1, 1, 0); // thanks to string(bool) returning 0 or 1 yo
	} else if(optionGroup == 7) { // map select screen
		var _map1Frame = 0;
		var _map2Frame = 0;
		var _map3Frame = 0;
		if(map1) {
			_map1Frame = 1;
			draw_sprite_ext(spr_deleteWorldIcons, map1DeletePrompt ? 1 : 0, x + 51, y + 242, 1, 1, 0, optionPosition == 4 ? c_yellow : c_white, 1);
		}
		if(map2) {
			_map2Frame = 2;
			draw_sprite_ext(spr_deleteWorldIcons, map2DeletePrompt ? 1 : 0, x + 120, y + 242, 1, 1, 0, optionPosition == 5 ? c_yellow : c_white, 1);
		}
		if(map3) {
			_map3Frame = 3;
			draw_sprite_ext(spr_deleteWorldIcons, map3DeletePrompt ? 1 : 0, x + 188, y + 242, 1, 1, 0, optionPosition == 6 ? c_yellow : c_white, 1);
		}
		draw_sprite_ext(spr_mapIconSprite, _map1Frame, x + 52, y + 142, 1, 1, 0, optionPosition == 1 ? c_yellow : c_white, 1);
		draw_sprite_ext(spr_mapIconSprite, _map2Frame, x + 120, y + 142, 1, 1, 0, optionPosition == 2 ? c_yellow : c_white, 1);
		draw_sprite_ext(spr_mapIconSprite, _map3Frame, x + 188, y + 142, 1, 1, 0, optionPosition == 3 ? c_yellow : c_white, 1); 
	}
	
	draw_set_halign(fa_left);
}