//if (live_call()) return live_result;

event_inherited();
	
if(alive) {
	var _dirToPlayer = point_direction(x, y, player.x, player.y);
	var _distToPlayer = point_distance(x, y, player.x, player.y);
	
	xChange += dcos(_dirToPlayer) * moveSpeed * .21;
	yChange -= dsin(_dirToPlayer) * moveSpeed * .21;
	
	var _speed = .5 + dsin(current_time * .073) * .5 + dsin(current_time * .262) * .05;
	xChange += dcos(moveDir) * moveSpeed * _speed * .1;
	yChange -= dsin(moveDir) * moveSpeed * _speed * .1;
	
	moveDir += (dsin(current_time * .03) + dsin(current_time * .21) * .4) * 3 * (.5 + dsin(current_time * .0731) * .5); // eh
	
	if(dashStateTimer > 0) {
		dashStateTimer--;
	} else {
		directionFacing = xChange > 0 ? 1 : -1;
		
		if(inWorld) {
			var _tileOn = tiles[x div tileSize][(y + 1) div tileSize];
			if(_tileOn > 0) {
				if(sprite_index != standingSprite) {
					sprite_index = standingSprite;
					image_speed = 2;
				}
				
				xChange *= speedDecay;
				yChange *= speedDecay;
			} else {
				if(sprite_index != flyingSprite) {
					sprite_index = flyingSprite;
					image_speed = 15;
				}
				
				xChange *= speedDecayAir;
				yChange *= speedDecayAir;
			}
		}
	}
	
	if(_distToPlayer < 16) {
		if(global.timer % 15 == 0) {
			if(dashStateTimer > 0) {
				player.hit(3, _dirToPlayer, 3);
			} else {
				player.hit(1, _dirToPlayer, 1.2);
			}
		}
	} else if(_distToPlayer > 80 && _distToPlayer < 350) {
		if(dashStateTimer <= 0) {
			if(dashTimeMinimum < current_time) {
				xChange += dcos(_dirToPlayer) * dashSpeed;
				yChange -= dsin(_dirToPlayer) * dashSpeed;
				dashTimeMinimum = current_time + irandom_range(2000, 6000) - global.gameDifficultySelected * 500;
				dashStateTimer = 40 + irandom(10);
				sprite_index = dashSprite;
				
				//var _spell = script_castSpell(E_spell.bolt, x + irandom_range(-30, 30) + irandom_range(-30, 30), y + irandom_range(-30, 30) + irandom_range(-30, 30), player.x + irandom_range(-10, 10), global.player.y + irandom_range(-10, 10), 1, 1);
			}
		}
	}
} else {
	deathTimer++;
	
	yChange += grav * .75; // bugs have less gravity yo
	
	xChange *= speedDecay;
	yChange *= .98; // hard coded, yes. CAI
	
	if(irandom(11) == 0) {
		part_particles_create_color(sys, x + irandom_range(-8, 8), y + irandom_range(-8, 8), global.partSwirl, #aa9933, 1 + irandom(1));
	}
	
	if(deathTimer >= deathTimerMax) {
		instance_destroy();
	}
}

if(inWorld) {
	script_moveCollide();
} else {
	x += xChange;
	y += yChange;
}

//image_angle = point_direction(0, 0, xChange, yChange);