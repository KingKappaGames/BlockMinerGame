if (live_call()) return live_result;

event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;

trailPart = global.bossTrail;

HealthMax = 120;
Health = HealthMax;

knockbackMult = .4;

spell = noone;

speedDecay = .98;
speedDecayAir = .98;

moveDir = irandom(360);
moveSpeedBase = .13;
moveSpeed = moveSpeedBase;

dashSpeed = 15;

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

setState = function(stateSet) {
	live_auto_call
	
	endState();
	
	state = stateSet;
	
	if(stateSet == "idle") {
		stateTimer = 210;
		moveSpeed = moveSpeedBase;
	} else if(stateSet == "barrage") {
		stateTimer = 140;
		moveSpeed = moveSpeedBase * .5;
	} else if(stateSet == "circle") {
		stateTimer = 180;
		moveSpeed = moveSpeedBase * .2;
	} else if(stateSet == "laser") {
		stateTimer = 320;
		moveSpeed = moveSpeedBase * .4;
		
		spell = script_castSpell(E_spell.laser, x, y, x, y - 1, 0, 1);
	} else if(stateSet == "rush") {
		stateTimer = 150;
		moveSpeed = moveSpeedBase * .2;
	} else if(stateSet == "rise") {
		stateTimer = 180;
		moveSpeed = moveSpeedBase * .8;
	} else if(stateSet == "shockwave") {
		stateTimer = 380;
		moveSpeed = 0;
	}
	
	stateTimerMax = stateTimer;
}

endState = function() { // what do
	if(state == "idle") {
		
	} else if(state == "barrage") {
		
	} else if(state == "circle") {
		
	} else if(state == "laser") {
		spell = noone;
	}
}

newState = function() {
	setState(choose("idle", "idle", "barrage", "circle", "laser", "rush", "rise", "shockwave"));
}

#endregion

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
	
	setState("die");
	//uh, then what?
}