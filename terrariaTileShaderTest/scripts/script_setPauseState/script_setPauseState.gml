function script_setPauseState(pauseState, storeScreen = 0){
	var _particleSystemRef = global.particleSys;
	var _particleSystemRefSmoke = global.particleSysSmoke;
	
	if(pauseState == false) {
		global.gamePaused = false;
		instance_activate_all();
		audio_resume_all();
		
		script_refreshActivations();
		
		part_system_automatic_update(_particleSystemRef, true); //update every particle system with pause effect
		part_system_automatic_update(_particleSystemRefSmoke, true); //update every particle system with pause effect
	} else if(pauseState == true) {
		global.gamePaused = true;
		if(storeScreen == 1) {
			if(surface_exists(pauseSurface)) {
				surface_copy(pauseSurface, 0, 0, application_surface);
				buffer_get_surface(pauseSurfaceBuffer, pauseSurface, 0);
			} else {
				pauseSurface = surface_create(1920, 1080);
				
				if(surface_exists(application_surface)) {
					surface_copy(pauseSurface, 0, 0, application_surface);
				} // else draw default main menu screen?
				buffer_get_surface(pauseSurfaceBuffer, pauseSurface, 0);
			}
		}
		
		instance_deactivate_all(true);
		instance_activate_object(obj_PauseMenu);
		instance_activate_object(obj_manager);
		instance_activate_object(obj_normalShaderManager);
		instance_activate_object(obj_gmlive);
		instance_activate_object(input_controller_object);
		audio_pause_all();
		audio_resume_sound(snd_ruinsPlanetAmbiance)
		audio_resume_sound(spr_lushPlanetAmbiance)
		part_system_automatic_update(_particleSystemRef, false);
		part_system_automatic_update(_particleSystemRefSmoke, false);
	}
}