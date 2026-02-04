//show_debug_message(tileScreenHeight)
//show_debug_message(tileScreenWidth)
//show_debug_message(camera_get_view_width(view_camera[0]))
//show_debug_message(camera_get_view_height(view_camera[0]))

if(global.timer % 10 == 0) {
	part_particles_create_color(global.sysOutline, camera_get_view_x(view_camera[0]) + irandom_range(-1000, 1000), camera_get_view_y(view_camera[0]) + irandom_range(-500, 800), global.itemGlimmerPart, #efbfff, 1);
	
	if(global.timer % 80 == 0) {
		script_spawnAmbientCreatures();
	}
}