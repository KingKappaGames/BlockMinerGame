event_inherited();

sprite_index = spr_bookDebris;
image_blend = c_white; // lower range

image_angle = irandom(360);
duration = 120 + irandom(60);

speedDecay = .995;

horizontalBounce = -.5;
verticalBounce = -.7;

spinSpeed = random_range(-15, 15);

hitGround = function(verticalSpeed, tileHit) { // does various bounce and fall damage related things?
	xChange += random_range(-.3, .3);
	
	//audio_play_sound_at(snd_banana, x, y, 0, audioRefQuiet, audioMaxQuiet, 2, false, 0);
}

depth -= 10;