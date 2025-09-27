event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;

HealthMax = 40;
Health = HealthMax;

knockbackMult = .4;

speedDecay = .98;
speedDecayAir = .98;

moveDir = irandom(360);
moveSpeed = .21;

deathTimer = 0;
deathTimerMax = 500;

image_blend = c_random;

depth -= 5; // go ahead of tiles.. you a boss bro

hit = function(damage, dir, force, destroyBody = false) {
	if(alive) {
		Health -= damage;
		
		if(Health <= 0) {
			die();
		} else {
			hitFlash = 5;
		}
		
		xChange += dcos(dir) * force * knockbackMult;
		yChange -= dsin(dir) * force * knockbackMult;
	}
}

die = function() {
	alive = false;
	//uh, then what?
}