if(pauseNextFrame == true) {
	if(!surface_exists(pauseSurface)) {
		pauseSurface = surface_create(960, 540);
	}
	
	surface_copy(pauseSurface, 0, 0, application_surface);
	buffer_get_surface(pauseSurfaceBuffer, pauseSurface, 0);
}
