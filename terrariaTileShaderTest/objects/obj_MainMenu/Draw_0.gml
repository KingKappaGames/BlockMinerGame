if (live_call()) return live_result;

draw_sprite_tiled_ext(spr_starryNightFree, 0, 0, -current_time * .03, .5, .5, c_white, 1);

if(loadNextFrame) {
	draw_sprite_ext(spr_loadingTextIcon, 0, x + menuWidth / 2, y + camera_get_view_height(cam) * .2, 1, 1, 0, c_white, 1);	
} else {
	draw_sprite_ext(sprite_index, image_index, x, y, menuWidth / sprite_width, menuHeight / sprite_height, 0, c_white, 1);
	
	if(optionGroup == 0) {
		var _sin = dsin(current_time / 30);
		draw_sprite_ext(spr_gameTitle, 0, x + menuWidth / 2, y - 20, .67, .67, 0, make_color_rgb(255, 230 + _sin * 25, 230 + _sin * 25), 1);
	}
}