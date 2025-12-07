if (live_call()) return live_result;

if(surface_exists(pauseSurface)) {
	shader_set(shd_blur);
	
	shader_set_uniform_f(shader_get_uniform(shd_blur, "size"), 960, 540, 4);
	
	draw_surface_stretched(pauseSurface, camera_get_view_x(cam), camera_get_view_y(cam), camera_get_view_width(cam), camera_get_view_height(cam));
	
	shader_reset();
} else {
	pauseSurface = surface_create(960, 540);
	buffer_set_surface(global.manager.pauseSurfaceBuffer, pauseSurface, 0);
}

draw_sprite_ext(sprite_index, image_index, x, y, menuWidth / sprite_width, menuHeight / sprite_height, 0, c_white, 1);