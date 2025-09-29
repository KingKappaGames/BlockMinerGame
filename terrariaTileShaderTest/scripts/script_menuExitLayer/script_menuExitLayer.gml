function script_menuExitLayer() {
	if(object_index == obj_pauseMenu) {
		optionPosition = 0;
		obj_pauseMenu.menuSelectOption();
	} else {
		if(optionGroup != 0) {
			optionPosition = 0;
			obj_MainMenu.menuSelectOption();
		} else {
			audio_play_sound(snd_MenuBeep, 100, false);
		}
	}
}