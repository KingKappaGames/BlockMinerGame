event_inherited();

image_blend = c_white;

image_angle = irandom(360);

duration = 350 + irandom(60);

speedDecay = .99;

horizontalBounce = -.9;
verticalBounce = -.8;

spinSpeed = random_range(-15, 15);

hitGround = function(verticalSpeed, tileHit) { // does various bounce and fall damage related things?
	xChange *= random_range(-.8, 1.4) + random_range(-1.2, 1.2);
	
	spinSpeed = spinSpeed * .9 + random_range(-7, 7);
	
	audio_play_sound_at(snd_banana, 0, 0, 0, audioRefQuiet, audioMaxQuiet, 2, false, 0);
	
	duration = duration * .75 - 12;
}

depth += choose(-10, 10);