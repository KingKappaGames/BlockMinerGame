function script_createTremor(xx = x, yy = y, durationSet, strengthSet, knockdownBlocks = true, volumeSet = 1, soundToRepeat = snd_rumbleLong) {
	var _tremor = instance_create_layer(xx, yy, "Instances", obj_tremorWiggler);
	
	with(_tremor) {
		duration = durationSet;
		
		strength = strengthSet;
		
		blockKnockdown = knockdownBlocks;
		
		volume = volumeSet;
		
		sound = soundToRepeat;
		
		if(volume > 0 && soundToRepeat != -1) {
			soundPlaying = audio_play_sound(sound, 0, true, volume);
		}
	}
	
	return _tremor;
}