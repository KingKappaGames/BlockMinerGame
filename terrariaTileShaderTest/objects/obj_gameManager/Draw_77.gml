if (live_call()) return live_result;

var _visualOption = global.gameColorFilterSelected;

var _windowW = window_get_width();
var _windowH = window_get_height();

if(_visualOption == 5) {
	computer_lab_nineteen_eighty_and_six();
}

gpu_set_blendenable(false);
if(_visualOption != 0) {
	if(_visualOption == 1) { // color blind
		//shader_set();
	} else if(_visualOption == 2) { // grey scale
		shader_set(shd_saturate);
		
		shader_set_uniform_f(shader_get_uniform(shd_saturate, "strength"), 0);
	} else if(_visualOption == 3) { // muted
		shader_set(shd_saturate);
		
		shader_set_uniform_f(shader_get_uniform(shd_saturate, "strength"), .36);
	} else if(_visualOption == 4) { // vibrant
		shader_set(shd_saturate);
		
		shader_set_uniform_f(shader_get_uniform(shd_saturate, "strength"), 2.25);
	} else if(_visualOption == 6) { // mosaic dots
		shader_set(shd_mosaic);
		
		shader_set_uniform_f(shader_get_uniform(shd_mosaic, "resolution"), 320, 180);
		shader_set_uniform_f(shader_get_uniform(shd_mosaic, "threshold"), .7);
	} else if(_visualOption == 7) { // mosaic tile
		shader_set(shd_mosaic);
		
		shader_set_uniform_f(shader_get_uniform(shd_mosaic, "resolution"), 320, 180);
		shader_set_uniform_f(shader_get_uniform(shd_mosaic, "threshold"), 1.3);
	} else if(_visualOption == 8) { // pixelate
		shader_set(shd_pixelate);
		
		shader_set_uniform_f(shader_get_uniform(shd_pixelate, "resolution"), 320, 180);
	}
}
draw_surface_stretched(application_surface, 0, 0, _windowW, _windowH);

if(_visualOption != 0) {
	shader_reset();
}
gpu_set_blendenable(true);
