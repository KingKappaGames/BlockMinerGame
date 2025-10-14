if (live_call()) return live_result;

if(inGame && !global.gamePaused) {
	var _camX = camera_get_view_x(cam);
	var _camY = camera_get_view_y(cam);
	var _camW = camera_get_view_width(cam);
	var _camH = camera_get_view_height(cam);
	
	draw_sprite_tiled_ext(spr_starryNight, 0, _camX * .95, _camY * .975, .5, .5, c_white, 1);
	
	var _parralaxMult = -.75;
	
	draw_sprite_ext(spr_backgroundRepeat, 0, _camX - 128 + (_camX * _parralaxMult) % 128, max(global.worldSizePixels * .26, _camY - 128 + (_camY * _parralaxMult) % 128), _camW / 128 + 2, _camH / 128 + 2, 0, c_white, 1);
}