/// @desc  Function Description
/// @param {asset.gmsound} snd  the sound to play
/// @param {real} [vol]=1 Base volume to play at
/// @param {real} [pitch]=1 Base pitch to play at
/// @param {real} [volumeVariance]=0 How much to add or remove randomly from volume
/// @param {real} [pitchVariance]=0 How much to add or remove randomly from pitch
/// @param {bool} [loop]=false Whether to loop the sound forever..?
/// @param {bool} [priority]=0 The priority of the sound to play (higher is more important, use range like 0-10 or something - it's arbitrary)
/// @returns {id} Description
//
function sound_play(sound, vol = 1, pitch = 1, volumeVariance = 0, pitchVariance = 0, loop = false, priority = 0) {
	return audio_play_sound(sound, priority, loop, vol + random_range(-volumeVariance, volumeVariance), undefined, pitch + random_range(-pitchVariance, pitchVariance));
}

function sound_play_at(sound, xx, yy, vol = 1, pitch = 1, volumeVariance = 0, pitchVariance = 0, loop = false, priority = 0, falloffRef = audioRefMedium, falloffMax = audioMaxMedium, falloffFactor = 1) {
	return audio_play_sound_at(sound, xx, yy, 0, falloffRef, falloffMax, falloffFactor, loop, priority, vol + random_range(-volumeVariance, volumeVariance), undefined, pitch + random_range(-pitchVariance, pitchVariance));
}