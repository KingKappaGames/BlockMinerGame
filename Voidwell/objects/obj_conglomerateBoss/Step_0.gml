if (live_call()) return live_result;

//event_inherited();
	
if(alive) {
	if(instance_exists(source)) {
		x = source.x + sourceOffX;
		y = source.y + sourceOffY;
		
		xChange = 0;
		yChange = 0;
	} else {
		var _dirToPlayer = point_direction(x, y, player.x, player.y);
		var _distToPlayer = point_distance(x, y, player.x, player.y);
		
		xChange += dcos(_dirToPlayer) * moveSpeed * .21;
		yChange -= dsin(_dirToPlayer) * moveSpeed * .21;
		
		var _speed = .5 + dsin(current_time * .073) * .5 + dsin(current_time * .262) * .05;
		xChange += dcos(moveDir) * moveSpeed * _speed * .1;
		yChange -= dsin(moveDir) * moveSpeed * _speed * .1;
		
		moveDir += (dsin(current_time * .03) + dsin(current_time * .21) * .4) * 3 * (.5 + dsin(current_time * .0731) * .5); // eh
		
		if(_distToPlayer < 16) {
			if(global.timer % 15 == 0) {
				player.hit(3, _dirToPlayer, 3);
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

x += xChange;
y += yChange;

//image_angle = point_direction(0, 0, xChange, yChange);