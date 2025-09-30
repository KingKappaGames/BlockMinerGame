if(global.gameColorFilterSelected == 4) {
	computer_lab_nineteen_eighty_and_six();
}

gpu_set_blendenable(false);
draw_surface_stretched(application_surface, 0, 0, window_get_width(), window_get_height());
gpu_set_blendenable(true);
