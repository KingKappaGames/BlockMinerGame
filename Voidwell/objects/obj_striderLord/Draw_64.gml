if (live_call()) return live_result;

if(alive) {
	var _viewW = view_wport[view_camera[0]];
	var _viewH = view_hport[view_camera[0]];
	var _health = Health / HealthMax;
	draw_rectangle_color(_viewW * .5 - _viewW * .3 * _health, _viewH * .9, _viewW * .5 + _viewW * .3 * _health, _viewH * .86, c_white, c_white, c_white, c_yellow, false);
	draw_rectangle_color(_viewW * .2, _viewH * .875, _viewW * .8, _viewH * .885, c_red, c_red, c_white, c_white, false);
} else {
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
			
			if(deathTimer == round(deathTimerMax * .7)) { // frame before switch
				var _cutscene = instance_create_layer(0, 0, "Instances", obj_cutscene);
				_cutscene.setCutscene("boss");
				script_setPauseState(true);
			}
		}
	}
}

draw_text(200, 200, state);