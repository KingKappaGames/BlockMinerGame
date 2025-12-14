if (live_call()) return live_result;

if(deathTimer < deathTimerMax * .7) {
	event_inherited();
	
	if(deathTimer > 0) {
		var _size = deathTimer / 90;
		var _color = #ffff88;
		draw_set_alpha(.2);
		draw_circle_color(x, y - 8, (25 + irandom(10)) * _size, _color, _color, false);
		draw_set_alpha(.45);
		draw_circle_color(x, y - 8, (16 + irandom(3)) * _size, _color, _color, false);
		draw_set_alpha(1);
	}
}

//draw_sprite_ext(sprite_index, image_index, x, y, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);