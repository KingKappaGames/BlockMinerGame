function script_menuExitLayer() {
	//if(object_index == obj_PauseMenu) {
		//optionPosition = 0;
		//obj_PauseMenu.pauseMenuSelectOption();
	//} else {
		if(optionGroup != 0) {
			optionPosition = 0;
			obj_MainMenu.menuSelectOption();
		} else {
			audio_play_sound(snd_MenuBeep, 100, false);
		}
	//}
}