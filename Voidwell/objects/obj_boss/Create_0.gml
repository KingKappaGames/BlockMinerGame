event_inherited();

global.bossSpawned = true;

healthBarColorTop = c_yellow;
healthBarColorBottom = c_white;

/// @desc Function Only runs in draw gui! Draws the health bar of the boss
drawHealthBar = function() {
	var _viewW = view_wport[view_camera[0]];
	var _viewH = view_hport[view_camera[0]];
	var _health = Health / HealthMax;
	draw_rectangle_color(_viewW * .5 - _viewW * .3 * _health, _viewH * .915, _viewW * .5 + _viewW * .3 * _health, _viewH * .885, healthBarColorTop, healthBarColorTop, healthBarColorBottom, healthBarColorBottom, false);
	draw_rectangle_color(_viewW * .2, _viewH * .895, _viewW * .8, _viewH * .905, healthBarColorBottom, healthBarColorTop, healthBarColorTop, healthBarColorBottom, false);
}