if (live_call()) return live_result;

//event_inherited();
	
//part_particles_create_color(global.sysOutline, x + irandom_range(-1000, 1000),  + irandom_range(-500, 800), global.itemGlimmerPart, c_yellow, 1);

event_inherited();

if(state == "die") {
	script_cameraShake(.1);
	
	if(irandom(41) == 0) {
		image_xscale *= .8;
		image_yscale *= .8;
		
		part_particles_create_color(sys, x + random_range(-24, 24), y + random_range(-24, 24), trailerPart, image_blend, irandom(10));
	}
	
	part_particles_create_color(sys, x + random_range(-24, 24), y + random_range(-24, 24), breakPart, image_blend, irandom(4));
	
	xChange *= .9;
	yChange *= .9;
	
	yChange += grav;
	
	deathTimer++;
	if(deathTimer < deathTimerMax * .7) {
		if(deathTimer < deathTimerMax * .35) {
			if(global.gameGoreSelected != 0) {
				part_type_direction(bloodSpurtPart, 0, 360, 0, 0);
				part_particles_create_color(sys, x, y, bloodSpurtPart, c_maroon, 10 - deathTimer / 15);
			}
		}
		
		if(random(1) < ((deathTimer - 50) * .008)) {
			var _spawnX = x + irandom_range(-25, 25);
			var _spawnY = y - 8 + irandom_range(-25, 25);
			var _dir = point_direction(x, y - 8, _spawnX, _spawnY);
			part_type_orientation(radialGlimmer, _dir, _dir, 0, 0, false);
			part_type_direction(radialGlimmer, _dir, _dir, 0, 0);
			part_type_speed(radialGlimmer, 5, 7, -.05, 0);
			part_particles_create(sys, _spawnX, _spawnY, radialGlimmer, 1);
		}
	}
	
	if(deathTimer >= deathTimerMax) {
		instance_destroy();
	}
} else {
	if(irandom(7) == 0) {
		part_particles_create_color(sysUnder, x + random_range(-6, 6), y + random_range(-6, 6), trailPart, merge_color(#aa3311, #30110f, random(1)), 1);
	}
	
	var _dirToPlayer = point_direction(x, y, player.x, player.y);
	var _distToPlayer = point_distance(x, y, player.x, player.y);
	
	if(_distToPlayer < 32) {
		if(global.timer % 5 == 0) {
			player.hit(3, _dirToPlayer, 6);
		}
	}
	
	if(conglomerateCore) {
		
		var _dirToHover = point_direction(x, y, player.x, player.y - floatOverHeight);
		var _distToHover = point_distance(x, y, player.x, player.y - floatOverHeight);
		
		xChange += dcos(_dirToHover) * moveSpeed;
		yChange -= dsin(_dirToHover) * moveSpeed;
		
		//var _tileIn = inWorld ? max(worldTiles[x div tileSize][(y) div tileSize], 0) : 0;
		
		var _speed = .5 + dsin(current_time * .073) * .5 + dsin(current_time * .262) * .05;
		xChange += dcos(moveDir) * moveSpeed * _speed * .1;
		yChange -= dsin(moveDir) * moveSpeed * _speed * .1;
		
		xChange *= speedDecay;
		yChange *= speedDecay;
		
		moveDir += (dsin(current_time * .03) + dsin(current_time * .21) * .4) * 3 * (.5 + dsin(current_time * .0731) * .5); // eh
		
		if(state == "idle") {
			
		} else if(state == "barrage") {
			if(stateTimer < stateTimerMax - 15) {
				if(stateTimer % 10 == 0) {
					var _spell = script_castSpell(E_spell.conglomerateShot, x + irandom_range(-40, 40), y + irandom_range(-40, 40), global.player.x + irandom_range(-100, 100), global.player.y + irandom_range(-100, 100), .5);
					_spell.image_blend = c_white;
				}
			}
		} else if(state == "rush") {
			if(stateTimer % round(stateTimerMax * .27) == 0) {
				xChange = lengthdir_x(dashSpeed, _dirToPlayer);
				yChange = lengthdir_y(dashSpeed, _dirToPlayer);
			}
		} else if(state == "rise") {
			yChange -= moveSpeed * 1.2;
			
			if(stateTimer > stateTimerMax * .5) {
				if(stateTimer % 10 == 0) {
					var _spell = script_castSpell(E_spell.conglomerateShot, x + irandom_range(-40, 40), y + irandom_range(-40, 40), x + irandom_range(-100, 100), y + irandom_range(-100, 100), .5);
					_spell.image_blend = c_white;
				}
			}
		}
		
		x += xChange;
		y += yChange;
	} else if(separate) {
		
		if(state == "condense") {
			var _dir = point_direction(x, y, source.x, source.y);
			xChange += lengthdir_x(moveSpeed, _dir);
			yChange += lengthdir_y(moveSpeed, _dir);
			
			if(point_distance(x, y, source.x, source.y) < 80) {
				if(irandom(20) == 0) {
					setState("idleAttached");
				}
			}
		} else if(state == "swarmSource") {
			var _dir = point_direction(x, y, source.x, source.y) + sin(current_time * .173 + Health) * 15;
			xChange += lengthdir_x(moveSpeed, _dir);
			yChange += lengthdir_y(moveSpeed, _dir);
		} else if(state == "chaseSolo") {
			var _dir = _dirToPlayer + sin(current_time * .173 + Health) * 15;
			xChange += lengthdir_x(moveSpeed, _dir);
			yChange += lengthdir_y(moveSpeed, _dir);
		} else if(state == "scatter") {
			var _dir = ((dsin(current_time * .07 + Health) + dsin(current_time * .17 + Health) * .4) * 3 * (.5 + dsin(current_time * .0631) * .5)) * 360;
			
			xChange += lengthdir_x(moveSpeed, _dir);
			yChange += lengthdir_y(moveSpeed, _dir); // fly random
			
			_dir = point_direction(x, y, source.x, source.y); // approach source, this helps keep the pieces on screen and not flying away into nothing...
			xChange += lengthdir_x(moveSpeed, _dir);
			yChange += lengthdir_y(moveSpeed, _dir);
		} else if(state == "scatterFall") {
			yChange += grav * .7;
			
			script_moveCollide();
		}
		
		if(state != "scatterFall") {
			x += xChange;
			y += yChange;
		}
		
		xChange *= speedDecay;
		yChange *= speedDecay;
	} else {
		
		if(state == "breakIntoEnemyAttached") {
			if(stateTimer <= 1) {
				repeat(3) {
					var _summon = script_spawnCreature(obj_person, x, y, 8);
					_summon.xChange = random_range(-3, 3) + xChange;
					_summon.yChange = random_range(-3, 3) + yChange;
				}
				
				die();
			}
		} else if(state == "shotAttached") {
			if(stateTimer == round(stateTimerMax * .2)) {
				script_castSpell(E_spell.conglomerateShot, x, y, player.x, player.y, 2, 1, material);
			}
			
			
		}
		
		x = source.x + sourceOffX;
		y = source.y + sourceOffY;
	}
	
	stateTimer--;
	if(stateTimer <= 0) {
		newState();
	}
}

//image_angle = point_direction(0, 0, xChange, yChange);