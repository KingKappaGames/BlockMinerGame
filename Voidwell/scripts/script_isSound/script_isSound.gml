function script_isSoundPlaying(sound) {
	return (sound > 50000 && audio_is_playing(sound)); // tries to remove asset ids from the mix (ids in the 10000s or below...)
}