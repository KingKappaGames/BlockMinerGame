if(pauseNextFrame != noone) {
	if(!surface_exists(pauseSurface)) {
		pauseSurface = surface_create(1920, 1080);
	}
	
	surface_copy(pauseSurface, 0, 0, application_surface);
	buffer_get_surface(pauseSurfaceBuffer, pauseSurface, 0);
}
