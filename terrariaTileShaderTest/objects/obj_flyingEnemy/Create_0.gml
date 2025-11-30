event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;

HealthMax = 8;
Health = HealthMax;

knockbackMult = 1;

speedDecay = .8;
speedDecayAir = .97;

moveDir = irandom(360);
moveSpeed = .21;

horizontalBounce = -.75;
verticalBounce = -.35;

dashSpeed = 4.4;
dashTimeMinimum = current_time + 5000;
dashStateTimer = 0;

standingSprite = spr_mothStanding;
flyingSprite = spr_mothFlying;
dashSprite = spr_mothDashing;
deadSprite = spr_mothDead;

deathTimer = 0;
deathTimerMax = 800;

image_speed = 15;

image_blend = c_random;

depth -= 5;

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
	
	//knockdown
}

die = function() {
	alive = false;
	
	sprite_index = deadSprite;
	image_angle = irandom(360);
	//uh, then what?
}