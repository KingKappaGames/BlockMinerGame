event_inherited();

if(parent == noone) {
	x += xChange;
	y += yChange;
	
	if(alive) {
		var _dirToPlayer = point_direction(x, y, global.player.x, global.player.y);
		
		xChange += dcos(_dirToPlayer) * moveSpeed * .22;
		yChange -= dsin(_dirToPlayer) * moveSpeed * .22;
		
		var _tileIn = inWorld ? max(global.worldTiles[x div tileSize][(y) div tileSize], 0) : 0;
		
		var _speed = .5 + dsin(current_time * .073) * .5 + dsin(current_time * .262) * .05;
		xChange += dcos(moveDir) * moveSpeed * _speed;
		yChange -= dsin(moveDir) * moveSpeed * _speed;
		
		xChange *= speedDecay;
		yChange *= speedDecay;
		
		moveDir += (dsin(current_time * .03) + dsin(current_time * .21) * .4) * 3 * (.5 + dsin(current_time * .0731) * .5); // eh
	} else {
		yChange += grav;
	}
	
	image_angle = point_direction(0, 0, xChange, yChange);
} else {
	if(parent != noone) {
		var _parentX = parent.x;
		var _parentY = parent.y;
		
		var _dir = point_direction(x, y, _parentX, _parentY);
		
		image_angle = _dir;
		
		x = _parentX - dcos(_dir) * 16;
		y = _parentY + dsin(_dir) * 16;
	}
}