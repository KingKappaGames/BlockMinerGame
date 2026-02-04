if (live_call()) return live_result;
	
if(!surface_exists(partOutlineSurf)) {
	partOutlineSurf = surface_create(camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]));
}

if(!global.gamePaused) {
	part_system_position(sysOutline, -camera_get_view_x(view_camera[0]), -camera_get_view_y(view_camera[0]));
	
	surface_set_target(partOutlineSurf);
	
	draw_clear_alpha(c_black, .0);
	
	gpu_set_blendmode(bm_eq_add);
	
	part_system_drawit(sysOutline);
	
	gpu_set_blendmode(bm_normal);
	
	surface_reset_target();
	
	outline_draw_surface(partOutlineSurf, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]), ol_config(1, c_white, .75, 1));
}