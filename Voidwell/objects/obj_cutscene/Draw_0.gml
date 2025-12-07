if (live_call()) return live_result;

if(!startedByManager) {
	if(surface_exists(pauseSurface)) {
		shader_set(shd_blur);
		
		var _blur = scenePosition == -1 ? 32 * transition : 8 * (1 - transition);
		
		shader_set_uniform_f(shader_get_uniform(shd_blur, "size"), 960, 540, _blur);
		
		draw_surface_stretched(pauseSurface, camera_get_view_x(cam), camera_get_view_y(cam), camera_get_view_width(cam), camera_get_view_height(cam));
		
		shader_reset();
	} else {
		pauseSurface = surface_create(960, 540);
		buffer_set_surface(global.manager.pauseSurfaceBuffer, pauseSurface, 0);
	}
} else {
	if(scenePosition == sceneCount - 1) {
		draw_set_alpha((1 - transition) * 1.4);
		draw_rectangle_color(camera_get_view_x(cam), camera_get_view_y(cam), camera_get_view_x(cam) + camera_get_view_width(cam), camera_get_view_y(cam) + camera_get_view_height(cam), #080003, #080003, #0A040A, #0A040A, false);
		draw_set_alpha(1);
	} else {
		draw_rectangle_color(camera_get_view_x(cam), camera_get_view_y(cam), camera_get_view_x(cam) + camera_get_view_width(cam), camera_get_view_y(cam) + camera_get_view_height(cam), #080003, #080003, #0A040A, #0A040A, false);
	}
}