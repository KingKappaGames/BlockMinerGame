event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;

HealthMax = 8;
Health = HealthMax;

knockbackMult = 1;

speedDecay = .8;
speedDecayAir = .97;

spinSpeed = random_range(-3, 3);

moveDir = irandom(360);
moveSpeed = .13;

horizontalBounce = -.75;
verticalBounce = -.35;

dashSpeed = 3.1;
dashTimeMinimum = current_time + 5000;
dashStateTimer = 0;

deathTimer = 0;
deathTimerMax = 1500;

image_speed = 3;

image_blend = c_random;

depth -= 5;

hit = function(damage, dir = 0, force = 0, destroyBody = false) {
	if(alive) {
		Health -= damage;
		
		if(Health <= 0) {
			die();
		} else {
			hitFlash = 5;
		}
		
		audio_play_sound(snd_hit, 0, 0, random_range(.85, 1.25), undefined, random_range(1.2, 2.1));
		
		xChange += dcos(dir) * force * knockbackMult;
		yChange -= dsin(dir) * force * knockbackMult;
		
		spinSpeed += random_range(-knockbackMult * force, knockbackMult * force);
	}
	
	//knockdown
}

die = function() { 
	audio_play_sound_at(snd_staticBlast, x, y, 0, audioRefLoud, audioMaxLoud, 1, 0, 0, 1,, random_range(.9, 1.1));
	
	repeat(4 + irandom(3)) {
		var _pixie = script_spawnCreature(obj_pixie, x, y);
		with(_pixie) {
			xChange = random_range(-5, 5) + random_range(-5, 5);
			yChange = random_range(-5, 5) + random_range(-5, 5);
		}
	}
	
	script_createExplosion(x, y, 5, 1, 1.2, 12,, 6, 2.1, 1, 2);
	
	instance_destroy();
	
	//uh, then what?
}