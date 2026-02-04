event_inherited();

image_angle = 0;

makeTrailParts = false;

speedDecay = .8;

horizontalBounce = -.5;
verticalBounce = -.37;

spinSpeed = random_range(-8, 8);
spinDecay = .98;

hitGround = function(verticalSpeed, tileHit) { // does various bounce and fall damage related things?
	//live_name = "bodyBounceFunc"; // Unique identifier for GMLive
   // if (live_call(0, 0)) return live_result;
	
	if(abs(yChange) > 1.5) {
		xChange += random_range(-.6, .6);
		
		audio_play_sound_at(snd_banana, x, y, 0, audioRefQuiet, audioMaxQuiet, 2, false, 0);
	}
	
	var _dif = angle_difference(image_angle, 90);
	if(abs(_dif) > 90) {
		_dif = ((-180 * sign(_dif)) + _dif);
	}
	
	spinSpeed -= _dif * .06 * (power(abs(yChange), 1.2) + .025);
}

depth += 10;