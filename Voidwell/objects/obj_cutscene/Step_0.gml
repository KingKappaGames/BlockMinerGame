if (live_call()) return live_result;

if(transition > 0 && transition != 1) {
	transition += startedByManager && (scenePosition == -1 || scenePosition == sceneCount - 1) ? .002 : .009; // opening cutscene should be slower on the first fade in to give that frame some space
	if(transition >= 1) {
		transition = 1;
		if(scenePosition >= sceneCount - 1) {
			script_setPauseState(false);
			instance_destroy();
		}
	} else if(scenePosition >= sceneCount - 1 && startedByManager && global.gamePaused && transition > .5) { // half way to done on last scene WHILE exiting from game load (without background)
		script_setPauseState(false);
	}
} else if(textProgress < textProgressMax) {
	if(global.timer % 4 == 0) {
		if(periodStopTime > 0) {
			periodStopTime--;
		} else {
			var _char = string_char_at(textList[scenePosition + 1], textProgress + 1);
			
			if(_char == " ") { // don't type write spaces
				textProgress += 2;
			} else {
				textProgress++;
				if(_char == ".") {
					periodStopTime = periodStopTimeRef;
				}
			}
			
			audio_play_sound(choose(snd_click1, snd_click2, snd_click3), 0, 0);
		}
	}
}

if(scenePosition < sceneCount - 1) {
	if(keyboard_check_released(vk_space) || keyboard_check_released(ord("E")) || mouse_check_button_released(mb_left) || mouse_check_button_released(mb_right)) {
		if(textProgress >= textProgressMax) {
			startTransition();
		} else {
			textProgress = textProgressMax;
		}
	}
}