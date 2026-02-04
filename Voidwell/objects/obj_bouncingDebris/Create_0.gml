event_inherited();

image_blend = make_color_rgb(irandom_range(220, 255), irandom_range(220, 255), irandom_range(220, 255)); // lower range

image_angle = irandom(360);

makeTrailParts = true;
partTrail = global.partStreamerSpellTrail;

duration = 80 + irandom(90);

speedDecay = .97;

horizontalBounce = -.65;
verticalBounce = -.45;

spinSpeed = random_range(-13, 13);

hitGround = function(verticalSpeed, tileHit) { // does various bounce and fall damage related things?
	if(yChange > 1) {
		xChange += random_range(-.6, .6);
	}
	
	//audio_play_sound_at(snd_banana, x, y, 0, audioRefQuiet, audioMaxQuiet, 2, false, 0);
}

depth += 10;