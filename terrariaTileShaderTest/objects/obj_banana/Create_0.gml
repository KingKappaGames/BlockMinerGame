event_inherited();

image_blend = c_white;

image_angle = irandom(360);

duration = 500 + irandom(60);

speedDecay = .99;

horizontalBounce = -.9;
verticalBounce = -.8;

spinSpeed = random_range(-15, 15);

hitGround = function(verticalSpeed, tileHit) { // does various bounce and fall damage related things?
	xChange *= random_range(-.8, 1.) + random_range(-3.2, 3.2);
	
	yChange -= random(1);
	
	spinSpeed = spinSpeed * .9 + random_range(-7, 7);
	
	audio_play_sound(snd_banana, 0, 0);
	
	duration = duration * .85 - 10;
}

depth += choose(-10, 10);