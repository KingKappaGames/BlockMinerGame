event_inherited();

sprite_index = spr_bottle;
image_blend = c_white; // lower range

image_angle = irandom(360);
duration = 120 + irandom(60);

speedDecay = .995;

horizontalBounce = -.35;
verticalBounce = -.4;

spinSpeed = random_range(-15, 15);

item = E_item.fairySummon;

hitGround = function(verticalSpeed, tileHit) { // does various bounce and fall damage related things?
	xChange += random_range(-.3, .3);
	
	if(point_distance(0, 0, xChange, yChange) < 1.6) {
		duration = 0;
	}
	
	audio_play_sound_at(snd_placeBlockMetal, x, y, 0, audioRefMedium, audioMaxMedium, 1, false, 0,,, random_range(1.2, 2));
	
	//audio_play_sound_at(snd_banana, x, y, 0, audioRefQuiet, audioMaxQuiet, 2, false, 0);
}

depth -= 5;