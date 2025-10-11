if (live_call()) return live_result;

event_inherited();
	
if(alive) {
	var _dirToPlayer = point_direction(x, y, player.x, player.y);
	var _distToPlayer = point_distance(x, y, player.x, player.y);
	
	xChange += dcos(_dirToPlayer) * moveSpeed * .21;
	yChange -= dsin(_dirToPlayer) * moveSpeed * .21;
	
	var _tileIn = inWorld ? max(worldTiles[x div tileSize][(y) div tileSize], 0) : 0;
	
	var _speed = .5 + dsin(current_time * .073) * .5 + dsin(current_time * .262) * .05;
	xChange += dcos(moveDir) * moveSpeed * _speed * .1;
	yChange -= dsin(moveDir) * moveSpeed * _speed * .1;
	
	xChange *= speedDecay;
	yChange *= speedDecay;
	
	moveDir += (dsin(current_time * .03) + dsin(current_time * .21) * .4) * 3 * (.5 + dsin(current_time * .0731) * .5); // eh
	
	if(_distToPlayer < 30) {
		player.hit(1, _dirToPlayer, 10);
	} else if(_distToPlayer > 80 && _distToPlayer < 350) {
		if(current_time % 3000 < 600) {
			var _spell = script_castSpell(E_spell.bolt, x + irandom_range(-30, 30) + irandom_range(-30, 30), y + irandom_range(-30, 30) + irandom_range(-30, 30), player.x + irandom_range(-10, 10), global.player.y + irandom_range(-10, 10), 1, 1);
		}
	}
	
	if(global.timer % 10 == 0) {
		var _tileX = x div tileSize;
		var _tileY = y div tileSize;
		script_breakTile(_tileX, _tileY, 1, 0, 1);
		script_breakTile(_tileX + 1, _tileY, 1, 0, 1);
		script_breakTile(_tileX - 1, _tileY, 1, 0, 1);
		script_breakTile(_tileX, _tileY + 1, 1, 0, 1);
		script_breakTile(_tileX, _tileY - 1, 1, 0, 1);
		script_breakTile(_tileX + 1, _tileY + 1, 1, 0, 1);
		script_breakTile(_tileX + 1, _tileY - 1, 1, 0, 1);
		script_breakTile(_tileX - 1, _tileY - 1, 1, 0, 1);
		script_breakTile(_tileX - 1, _tileY + 1, 1, 0, 1);
		script_breakTile(_tileX + 2, _tileY, 1, 0, 1);
		script_breakTile(_tileX - 2, _tileY, 1, 0, 1);
		script_breakTile(_tileX, _tileY + 2, 1, 0, 1);
		script_breakTile(_tileX, _tileY - 2, 1, 0, 1);
		
		global.tileManager.updateScreenStatic();
	}
} else {
	xChange *= .9;
	yChange *= .9;
	deathTimer++;
	if(deathTimer < deathTimerMax * .7) {
		if(deathTimer < deathTimerMax * .35) {
			part_type_direction(bloodSpurtPart, 0, 360, 0, 0);
			part_particles_create_color(sys, x, y, bloodSpurtPart, c_maroon, 10 - deathTimer / 15);
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
}

//image_angle = point_direction(0, 0, xChange, yChange);

x += xChange;
y += yChange;