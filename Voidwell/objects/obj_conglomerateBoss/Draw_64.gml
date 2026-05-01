if (live_call()) return live_result;

if(alive && conglomerateCore) {
	var _viewW = view_wport[view_camera[0]];
	var _viewH = view_hport[view_camera[0]];
	
	var _healthMax = 0;
	var _health = 0;
	with(obj_conglomerateBoss) {
		_health += Health;
		_healthMax += HealthMax;
	}
	
	var _healthPortion = _health / _healthMax;
	draw_rectangle_color(_viewW * .5 - _viewW * .3 * _healthPortion, _viewH * .92, _viewW * .5 + _viewW * .3 * _healthPortion, _viewH * .88, c_white, c_white, c_white, c_red, false);
	draw_rectangle_color(_viewW * .2, _viewH * .895, _viewW * .8, _viewH * .905, c_white, c_white, c_white, c_red, false);
}