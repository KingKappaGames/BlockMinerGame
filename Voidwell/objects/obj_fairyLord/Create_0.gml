if (live_call()) return live_result;

event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;

trailPart = global.bossTrail;

HealthMax = 200;
Health = HealthMax;

knockbackMult = .5;

spell = noone;

speedDecay = .98;
speedDecayAir = .98;
speedDecayAirBase = .98;

moveDir = irandom(360);
moveSpeedBase = .12;
moveSpeed = moveSpeedBase;

dashSpeed = 9.5;

deathTimer = 0;
deathTimerMax = 500;

depth -= 5; // go ahead of tiles.. you a boss bro

flapProgress = 0;
wingFlapChannel = animcurve_get_channel(curve_wingFlap, 0);

floatOverHeight = 100;

#region states 
state = "idle";
stateTimer = 0;
stateTimerMax = 0;

setState = function(stateSet, duration = undefined) {
	live_auto_call
	
	endState();
	
	state = stateSet;
	
	if(stateSet == "idle") {
		duration ??= 210;
		moveSpeed = moveSpeedBase;
	} else if(stateSet == "barrage") {
		duration ??= 140;
		moveSpeed = moveSpeedBase * .5;
	} else if(stateSet == "circle") {
		duration ??= 210;
		moveSpeed = moveSpeedBase * .2;
	} else if(stateSet == "laser") {
		duration ??= 240;
		moveSpeed = moveSpeedBase * .4;
	} else if(stateSet == "rush") {
		duration ??= 300;
		moveSpeed = moveSpeedBase * .2;
		speedDecayAir = 1;
	} else if(stateSet == "rise") {
		duration ??= 180;
		moveSpeed = moveSpeedBase * .8;
	} else if(stateSet == "shockwave") {
		duration ??= 380;
		moveSpeed = 0;
		speedDecayAir = .992; // easier to push away
	}
	
	stateTimer = duration;
	stateTimerMax = stateTimer;
}

endState = function() { // what do
	if(state == "idle") {
		
	} else if(state == "barrage") {
		
	} else if(state == "circle") {
		
	} else if(state == "laser") {
		spell = noone;
	} else if(state == "rush") {
		speedDecayAir = speedDecayAirBase;
	} else if(state == "rise") {
		
	} else if(state == "shockwave") {
		speedDecayAir = speedDecayAirBase;
	}
}

newState = function() {
	if(state == "idle") {
		setState(choose("idle", "idle", "barrage", "circle", "laser", "rush", "rise", "shockwave"));
	} else {
		setState("idle", 45);
	}
}

#endregion

hit = function(damage, dir = 0, force = 0, destroyBody = false) {
	if(alive) {
		Health -= damage;
		
		if(Health <= 0) {
			die(destroyBody);
		} else {
			hitFlash = 5;
		}
		
		xChange += dcos(dir) * force * knockbackMult;
		yChange -= dsin(dir) * force * knockbackMult;
	}
}

die = function(destroyBody = false) {
	alive = false;
	
	setState("die");
	//uh, then what?
}