function script_setPauseState(pauseState){
	if(pauseState == false) {
		global.gamePaused = false;
		
		instance_activate_all();
		
		audio_resume_all();
		
		script_refreshActivations();
		
		part_system_automatic_update(global.sys, true);
		part_system_automatic_update(global.sysUnder, true);
		part_system_automatic_update(global.sysOutline, true);
		part_system_automatic_draw(global.sys, true);
		part_system_automatic_draw(global.sysUnder, true);
	} else if(pauseState == true) {
		global.gamePaused = true;
		
		instance_deactivate_all(true);
		instance_activate_object(obj_execParent);
		instance_deactivate_object(global.tileManager); // you actually don't want/need tile manager despite it being an exec
		
		audio_pause_all();
		
		var _musicSet = global.manager.musicDepthTracks;
		for(var _i = array_length(_musicSet) - 1; _i >= 0; _i--) { // unpause music
			if(audio_exists(_musicSet[_i])) {
				audio_resume_sound(_musicSet[_i]);
			}
		}
		
		part_system_automatic_update(global.sys, false);
		part_system_automatic_update(global.sysUnder, false);
		part_system_automatic_update(global.sysOutline, false);
		part_system_automatic_draw(global.sys, false);
		part_system_automatic_draw(global.sysUnder, false);
	}
}