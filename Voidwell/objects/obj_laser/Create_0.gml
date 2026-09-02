if (live_call()) return live_result;

event_inherited();

directionLaser = 0;

lengthMax = 1200;
length = lengthMax;

hitsBlacklist = [];
hits = ds_list_create();

hitTimerMax = 10;
hitTimer = 0;

duration = 2;

source = noone;

damageBase = 1;
knockbackBase = 1;

sound = audio_play_sound(snd_electricityBlast, 5, true, 1, 0, 1);
audio_sound_loop_start(sound, 1.5); // does not sound good because this sound has a consistent fall to it, i need something with a natural loop for at least a half second or something
audio_sound_loop_end(sound, 1.65);