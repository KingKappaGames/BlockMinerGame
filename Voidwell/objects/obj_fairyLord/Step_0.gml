if (live_call()) return live_result;
	
global.bossTrail = part_type_create();
var _bossTrail = global.bossTrail;
part_type_life(_bossTrail, 150, 150);
part_type_shape(_bossTrail, pt_shape_disk);
part_type_size(_bossTrail, .4, .55, -.005, 0);
part_type_speed(_bossTrail, 0.0, .1, -.001, 0);
part_type_direction(_bossTrail, 0, 360, 0, 0);

trailPart = global.bossTrail;

part_particles_create(global.sys, x + irandom_range(-1000, 1000),  + irandom_range(-500, 500), global.thickTrail, 1);

event_inherited();

if(state == "die") {
	script_cameraShake(.2);
	
	xChange *= .9;
	yChange *= .9;
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
	part_particles_create(sysUnder, x + random_range(-6, 6), y + random_range(-6, 6), trailPart, 1);
	
	var _dirToHover = point_direction(x, y, player.x, player.y - floatOverHeight);
	var _distToHover = point_distance(x, y, player.x, player.y - floatOverHeight);
	var _dirToPlayer = point_direction(x, y, player.x, player.y);
	var _distToPlayer = point_distance(x, y, player.x, player.y);
	
	xChange += dcos(_dirToHover) * moveSpeed;
	yChange -= dsin(_dirToHover) * moveSpeed;
	
	//var _tileIn = inWorld ? max(worldTiles[x div tileSize][(y) div tileSize], 0) : 0;
	
	var _speed = .5 + dsin(current_time * .073) * .5 + dsin(current_time * .262) * .05;
	xChange += dcos(moveDir) * moveSpeed * _speed * .1;
	yChange -= dsin(moveDir) * moveSpeed * _speed * .1;
	
	xChange *= speedDecay;
	yChange *= speedDecay;
	
	moveDir += (dsin(current_time * .03) + dsin(current_time * .21) * .4) * 3 * (.5 + dsin(current_time * .0731) * .5); // eh
	
	if(_distToPlayer < 32) {
		if(global.timer % 5 == 0) {
			player.hit(3, _dirToPlayer, 6);
		}
	}
	
	if(state == "idle") {
		
	} else if(state == "barrage") {
		if(stateTimer < stateTimerMax - 15) {
			if(stateTimer % 10 == 0) {
				var _spell = script_castSpell(E_spell.bolt, x + irandom_range(-40, 40), y + irandom_range(-40, 40), global.player.x + irandom_range(-100, 100), global.player.y + irandom_range(-100, 100), .5);
				_spell.image_blend = c_white;
			}
		}
	} else if(state == "circle") {
		var _stateProgress = (stateTimerMax - stateTimer) / stateTimerMax;
		var _spinMult = min(1, _stateProgress * 3);
		var _spinDir = current_time * .24;
		x += lengthdir_x(6.4 * _spinMult, _spinDir);
		y += lengthdir_y(6.4 * _spinMult, _spinDir);
		
		if(stateTimer < stateTimerMax * .75) {
			if(stateTimer % 3 == 0) {
				script_castSpell(E_spell.streamer, x, y, x + lengthdir_x(100, _spinDir), y + lengthdir_y(100, _spinDir));
			}
		}
	} else if(state == "laser") {
		if(stateTimer < stateTimerMax * .9 && stateTimer > stateTimerMax * .125) {
			if(!instance_exists(spell)) {
				spell = script_castSpell(E_spell.laser, x, y, x, y - 1, 0, 1);
			} else {
				
				var _x = x;
				var _y = y;
				with(spell) {
					x = _x;
					y = _y;
					
					var _angleChange = angle_difference(_dirToPlayer, directionLaser);
					directionLaser += _angleChange * .04 + sign(_angleChange) * .05;
					duration = 10;
				}
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
				var _spell = script_castSpell(E_spell.bouncyBolt, x + irandom_range(-40, 40), y + irandom_range(-40, 40), x + irandom_range(-100, 100), y + irandom_range(-100, 100), .5);
				_spell.image_blend = c_white;
			}
		}
	} else if(state == "shockwave") {
		if(stateTimer == round(stateTimerMax * .3)) {
			var _shockwave = script_createShockwaveSpell(x, y, 50, 64, 1.032,, .1,, c_white);
			_shockwave.source = id;
		}
	}
	
	stateTimer--;
	if(stateTimer <= 0) {
		newState();
	}
}

//image_angle = point_direction(0, 0, xChange, yChange);
flapProgress = (flapProgress + .022) % 1;

x += xChange;
y += yChange;