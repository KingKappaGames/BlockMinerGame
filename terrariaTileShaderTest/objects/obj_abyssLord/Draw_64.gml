if (live_call()) return live_result;

if(deathTimer > 0) {
	var _timer = deathTimer * 1.42;
	if(_timer > deathTimerMax) {
		var _alphaLower = ((_timer - deathTimerMax) / (deathTimerMax * .3)); // .25 / (.25 * .66)
		draw_set_alpha(1.5 - _alphaLower);
		draw_rectangle(-1, -1, view_wport[0] + 1, view_hport[0] + 1, false);
		draw_set_alpha(1);
	} else {
		draw_set_alpha(power(_timer / deathTimerMax, .4));
		draw_circle_color((x - camera_get_view_x(cam)) * (view_wport[0] / camera_get_view_width(cam)), (y - camera_get_view_y(cam)) * (view_hport[0] / camera_get_view_height(cam)), 1200 * power(max(0, _timer / deathTimerMax - .2) * 1.5, 3), c_white, c_white, false);
		draw_set_alpha(_timer / deathTimerMax);
	}
}