if(keyboard_check(vk_f1)) {
	draw_text_transformed(view_wport[0] * .5, 10, fps_real, 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 50, camera_get_view_x(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 90, camera_get_view_y(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 130, camera_get_view_width(cam), 3, 3, 0);
	draw_text_transformed(view_wport[0] * .5, 170, camera_get_view_height(cam), 3, 3, 0);
}