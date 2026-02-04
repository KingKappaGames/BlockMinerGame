if (live_call()) return live_result;

event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;

trailPart = global.bossTrail;

HealthMax = 200;
Health = HealthMax;

knockbackMult = 1.5;

spell = noone;

speedDecay = .85;
speedDecayAir = .98;
speedDecayAirBase = .98;

moveDir = irandom(360);
moveSpeedBase = .12;
moveSpeed = moveSpeedBase;

leapSpeed = 6.3;
rushSpeed = 9;

deathTimer = 0;
deathTimerMax = 500;

knockbackSpellStrength = 1;

depth -= 5; // go ahead of tiles.. you a boss bro

hitGround = function(verticalSpeed, tileHit) { // does various bounce and fall damage related things?
	if(verticalSpeed < -1.5) {
		setState("bonk");
		hit(ceil(abs(verticalSpeed)), 0, 0);
	}
}

/// @desc Check tiles in a normalized way in the world map (eg +1 x is forward, not +1 coord, and +1 y is up, not down.)
/// @param {real} xx The relative x movement (normalized to forward vs backward, not left vs right!)
/// @param {real} yy The relative y movement flipped so that +1 is up 1!
move = function(xx, yy) {
	var _debug = tiles[x div tileSize + xx * directionFacing][y div tileSize - yy];
	return _debug;
}

waitTimer = 0;

#region states 
state = "idle";
stateTimer = 0;
stateTimerMax = 0;


//jump up and eventually land, "jump" state, while in air slow to a stop and do either a "barrage" of shots that knocks him back, a "laser" that knocks him back, a "dash", a "pound", summon "shockwave"(s), or just fall to ground, where you enter "land" state. 
//Other than these there can be a teleport to get out of stuck spots, simply jumping it back to the surface. All of his moves should have heavy knockback effects on HIM so that he's constantly getting launched everywhere and doing his aerial moves from that movement. But what else?
// pause and blast upwards to destroy thing overhead (does this when blocked in a jump?) followed immediately by a jump

setState = function(stateSet, duration = undefined, info = undefined) {
	live_auto_call
	
	endState();
	
	state = stateSet;
	
	if(stateSet == "idle") {
		duration ??= 210;
		moveSpeed = moveSpeedBase;
	} else if(stateSet == "fall") {
		duration ??= 210;
		moveSpeed = moveSpeedBase;
	} else if(stateSet == "barrage") {
		duration ??= 140;
		speedDecayAir = .8;
	} else if(stateSet == "leap") {
		duration ??= 210 + irandom(60); // how long until some kind of air move or switch to generic falling state
		var _dir = 0;
		var _speed = 0;
		if(!is_undefined(info)) {
			if(array_length(info) == 1) {
				_dir = info[0];
				_speed = leapSpeed;
			} else {
				_dir = info[0];
				_speed = info[1];
			}
		} else {
			_dir = random_range(30, 150);
			_speed = random_range(leapSpeed * .9, leapSpeed * 1.1);
		}
		
		xChange = lengthdir_x(_speed, _dir);
		yChange = lengthdir_y(_speed, _dir);
		
		speedDecayAir = 1;
	} else if(stateSet == "laser") {
		duration ??= 180;
		moveSpeed = moveSpeedBase * .4;
		speedDecayAir = .9;
	} else if(stateSet == "rush") {
		duration ??= 150;
		moveSpeed = moveSpeedBase * .2;
		speedDecayAir = .99;
	} else if(stateSet == "clearAbove") {
		duration ??= 150;
		moveSpeed = 0;
	} else if(stateSet == "spire") { // creates a spire of material and uses it to launch up, the classic anime post jump..
		duration ??= 45;
	} else if(stateSet == "createNode") { // creates floating ball that it can use as anchor points to rope to or swing from (always follows this up by grappling to this node?)
		duration ??= 45;
	} else if(stateSet == "grapple") {
		
	} else if(stateSet == "swing") {
		duration ??= 70;
	} else if(stateSet == "bonk") {
		audio_play_sound_at(snd_bugDie, x, y, 0, audioRefLoud, audioMaxLoud, 1, false, 0,,, random_range(.9, 1.1));
		duration ??= 80;
	}
	
	if(duration == -1) {
		duration = 9999999; // it'll keep counting down to see but won't do anything, whatever
	}
	
	stateTimer = duration;
	stateTimerMax = stateTimer;
}

endState = function() { // what do
	if(state == "idle") {
		
	} else if(state == "barrage") {
		speedDecayAir = speedDecayAirBase;
	} else if(state == "leap") {
		speedDecayAir = speedDecayAirBase;
	} else if(state == "laser") {
		spell = noone;
		speedDecayAir = .8;
	} else if(state == "rush") {
		speedDecayAir = speedDecayAirBase;
	} else if(state == "shockwave") {
		speedDecayAir = speedDecayAirBase;
	}
}

newState = function() {
	var _tX = x div tileSize;
	var _tY = y div tileSize;
	var _tiles = tiles;
	if(_tiles[_tX][_tY - 1] isSolid || _tiles[_tX][_tY - 2] isSolid || _tiles[_tX][_tY - 3] isSolid) {
		setState("clearAbove");
	} else if(state == "spire") {
		setState("leap", 90, [random_range(63, 117)]);
	} else if(state == "idle") {
		setState(choose("idle", "idle", "barrage", "leap", "laser", "rush", "spire"));
	} else if(state == "jump" || state == "fall") {
		setState(choose("barrage", "rush", "laser"));
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

die = function() {
	alive = false;
	
	setState("die");
	//uh, then what?
}