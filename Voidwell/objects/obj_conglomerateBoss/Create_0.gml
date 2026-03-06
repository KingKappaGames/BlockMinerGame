event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;
trailPart = global.bossTrail;

source = noone;
sourceOffX = 0;
sourceOffY = 0;

HealthMax = 5;
Health = HealthMax;

knockbackMult = 1;

speedDecay = .8;
speedDecayAir = .98;

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

floatOverHeight = 140;

material = E_tile.dirt;
sprite_index = spr_tileBanana;
image_index = 0;

depth -= 5;

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
		
		audio_play_sound(snd_hit, 0, 0, random_range(.85, 1.25), undefined, random_range(1.2, 2.1));
		
		xChange += dcos(dir) * force * knockbackMult;
		yChange -= dsin(dir) * force * knockbackMult;
	}
	
	//knockdown
}

die = function(destroyBody = false) {
	audio_play_sound_at(snd_bugDie, x, y, 0, audioRefMedium, audioMaxMedium, 1, 0, 0, 1,, random_range(.9, 1.1));
	
	script_createBlockParticles(material, x, y);
	
	repeat(3) {
		var _debris = instance_create_layer(x, y, "Instances", obj_bouncingDebris);
		_debris.xChange = random_range(-5, 5) + random_range(-5, 5);
		_debris.yChange = random_range(-5, 5) + random_range(-5, 5);
	}

	instance_destroy();	
	
	//uh, then what?
}