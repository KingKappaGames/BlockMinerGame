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
		
		xChange *= speedDecayAir;
		yChange *= speedDecayAir;
		
		if(_distToPlayer < 21) {
			if(global.timer % 10 == 0) {
				player.hit(3, _dirToPlayer, 3);
			}
		}
	}
}

x += xChange;
y += yChange;

//image_angle = point_direction(0, 0, xChange, yChange);