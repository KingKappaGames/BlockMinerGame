event_inherited();

source = noone;

//image_blend = make_color_rgb(irandom_range(180, 255), irandom_range(180, 255), irandom_range(180, 255));
image_blend = make_color_rgb(irandom_range(0, 35), irandom_range(0, 35), irandom_range(0, 35));

duration = 13;

radius = tileSize;
radiusMult = 1.165;

strength = 1; // the multiplier on how much to try to break or place things

materialType = 0; // THIS SPELL CAN MAKE OR BREAK TILES (0/clear being break)

dealDamage = true;
hitList = ds_list_create();

depth -= 101; // over part over layer!

audio_play_sound_at(snd_staticBlast, x, y, 0, audioRefMedium, audioMaxMedium, 1, 0, 0, 1, undefined, random_range(.95, 1.05));