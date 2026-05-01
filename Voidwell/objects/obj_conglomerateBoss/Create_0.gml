if (live_call()) return live_result;

event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;
trailPart = global.bossTrail;

source = noone;
sourceOffX = 0;
sourceOffY = 0;

conglomerateCore = false;

separate = false; // whether this object should act on its own or just follow 

HealthMax = 5;
Health = HealthMax;

knockbackMult = 1;

speedDecay = .8;
speedDecayAir = .98;

speedDecay = .98;
speedDecayAir = .96;
speedDecayAirBase = .96;

moveDir = irandom(360);
moveSpeedBase = .11;
moveSpeed = moveSpeedBase;

dashSpeed = 8.8;

deathTimer = 0;
deathTimerMax = 350;

depth -= 5; // go ahead of tiles.. you a boss bro

spell = noone;

floatOverHeight = 120;

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
	
	separate = false; // default false
	
	if(stateSet == "idle") {
		duration ??= 210;
		moveSpeed = moveSpeedBase;
	} else if(stateSet == "barrage") {
		duration ??= 140;
		moveSpeed = moveSpeedBase * .5;
	} else if(stateSet == "rush") {
		duration ??= 300;
		moveSpeed = moveSpeedBase * .2;
		speedDecayAir = 1;
	} else if(stateSet == "rise") {
		duration ??= 180;
		moveSpeed = moveSpeedBase * .8;
	} else if(stateSet == "condense") {
		duration ??= 300;
		
		if(conglomerateCore) { // pause to wait
			moveSpeed = 0;
			speedDecayAir = .99;
			
			with(obj_conglomerateBoss) {
				if(id != other.id) {
					setState("condense");
				}
			}
		} else { // normal movement
			moveSpeed = moveSpeedBase * 1.25;
			speedDecayAir = speedDecayAirBase - .085;
		}
		
		separate = true;
	} else if(stateSet == "scatter") {
		duration ??= 150 + irandom(150);
		moveSpeed = moveSpeedBase;
		speedDecayAir = .975;
		
		separate = true;
	} else if(stateSet == "scatterFall") {
		duration ??= 90 + irandom(270);
		moveSpeed = moveSpeedBase;
		speedDecayAir = .95;
		
		separate = true;
	} else if(stateSet == "swarmSource") {
		duration ??= 150 + irandom(150);
		moveSpeed = moveSpeedBase * 1.25;
		speedDecayAir = lerp(speedDecayAirBase, 1, .5);
		
		separate = true;
	} else if(stateSet == "idleAttached") {
		duration ??= 140 + irandom(200);
		
		separate = false;
	} else if(stateSet == "chaseSolo") {
		duration ??= 180 + irandom(120);
		
		moveSpeed = moveSpeedBase;
		speedDecayAir = speedDecayAir = lerp(speedDecayAirBase, 1, .5);
		
		separate = true;
	} else if(stateSet == "breakIntoEnemyAttached") {
		duration ??= 60 + irandom(30);
	} else if(stateSet == "shotAttached") {
		duration ??= 60 + irandom(30);
	}
	
	stateTimer = duration;
	stateTimerMax = stateTimer;
}

endState = function() { // what do
	if(state == "idle") {
		
	} else if(state == "barrage") {
		
	} else if(state == "rush") {
		speedDecayAir = speedDecayAirBase;
	} else if(state == "rise") {
		
	} else if(state == "condense") {
		
	} else if(state == "scatter") {
		
	} else if(state == "scatterFall") {
		
	} else if(state == "idleAttached") {
		
	} else if(state == "chaseSolo") {
		
	} else if(state == "breakIntoEnemyAttached") {
		
	} else if(state == "swarmSource") {
		
	} else if(state == "shotAttached") {
		
	} else if(state == "breakIntoEnemyAttached") {
		
	}
}

newState = function() {
	if(conglomerateCore) {
		if(state == "idle") {
			var _separateCount = 0;
			with(obj_conglomerateBoss) {
				if(separate) {
					_separateCount++;
				}
			}
			
			if((irandom(3) == 0) && _separateCount >= instance_number(obj_conglomerateBoss) * .33) { // if over a 1/3 of the pieces are detached then gather them up (sometimes)
				setState("condense"); // do main core states
			} else {
				if(irandom(7) == 0) {
					with(obj_conglomerateBoss) {
						if(id != other) {
							setState("scatter");
						}
					}
				} else {
					setState(choose("idle", "idle", "barrage", "rush", "rise")); // do main core states
				}
			}
		} else {
			setState("idle");
		}
	} else {
		if(separate) {
			if(state == "swarmSource") {
				setState(choose("chaseSolo", "condense", "swarmSource")); // do piece states when free flying
			} else {
				setState("swarmSource");
			}
		} else {
			if(state == "idleAttached") {
				
				if(!conglomerateCore && random(1) < .01) {
					setState("breakIntoEnemyAttached");
				} else {
					setState(choose("idleAttached", "idleAttached", "shotAttached", "idleAttached", "shotAttached", "idleAttached", "shotAttached")); // do piece states when attached to body
				}
			} else {
				setState("idleAttached");
			}
		}
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
		
		if(irandom(3) == 0) {
			msg("HELLO HIT PASS CHECK BUT DAMAGE = " + string(damage));
			
			repeat(irandom(damage * 3 + 1)) {
				image_xscale *= 1 - damage * .05;
				image_yscale *= 1 - damage * .05;
				
				var _debris = instance_create_layer(x, y, "Instances", obj_bouncingDebris);
				_debris.xChange = random_range(-5, 5) + random_range(-5, 5);
				_debris.yChange = random_range(-5, 5) + random_range(-5, 5);
				_debris.image_blend = c_maroon;
			}
		}
	}
}

die = function(destroyBody = false) {
	if(state != "die") {
		audio_play_sound_at(snd_bugDie, x, y, 0, audioRefMedium, audioMaxMedium, 1, 0, 0, 1,, random_range(.9, 1.1));
		
		script_createBlockParticles(material, x, y);
		
		repeat(3) {
			var _debris = instance_create_layer(x, y, "Instances", obj_bouncingDebris);
			_debris.xChange = random_range(-5, 5) + random_range(-5, 5);
			_debris.yChange = random_range(-5, 5) + random_range(-5, 5);
		}
	
		if(conglomerateCore) { 
			
			var _anyPartAlive = false;
			with(obj_conglomerateBoss) {
				if(Health > 0) {
					_anyPartAlive = true;
				}
			}
			
			if(_anyPartAlive) {
				var _newCore = id;
				while(_newCore == id) {
					_newCore = instance_find(object_index, irandom(instance_number(object_index) - 1));
				}
				
				with(_newCore) {
					conglomerateCore = true; // transfer core status to some other piece when dying
					HealthMax += 10;
					image_xscale = lerp(image_xscale, 10, .5);
					image_yscale = lerp(image_yscale, 10, .5);
					Health = HealthMax;
					knockbackMult = .4;
				}
				
				with(obj_conglomerateBoss) {
					source = _newCore;
					
					setState("scatterFall");
					
					xChange = random_range(-5, 5) + random_range(-4, 4);
					yChange = random_range(-3, 3) + random_range(-3, 3);
				}
				
				instance_destroy();
			} else {
				setState("die");
			}
		} else {
			instance_destroy();
		}
		
		//uh, then what?
	}
}