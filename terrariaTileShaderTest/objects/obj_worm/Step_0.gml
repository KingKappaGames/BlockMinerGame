event_inherited();

if(parent == noone) {
	x += xChange;
	y += yChange;
	
	if(alive) {
		var _dirToPlayer = point_direction(x, y, global.player.x, global.player.y);
		
		xChange += dcos(_dirToPlayer) * moveSpeed * .55;
		yChange -= dsin(_dirToPlayer) * moveSpeed * .55;
		
		var _tileIn = inWorld ? max(global.worldTiles[x div tileSize][(y) div tileSize], 0) : 0;
		
		var _speed = .5 + dsin(current_time * .073) * .5 + dsin(current_time * .262) * .05;
		xChange += dcos(moveDir) * moveSpeed * _speed * .7;
		yChange -= dsin(moveDir) * moveSpeed * _speed * .7;
		
		xChange *= speedDecay;
		yChange *= speedDecay;
		
		moveDir += (dsin(current_time * .03) + dsin(current_time * .21) * .4) * 3 * (.5 + dsin(current_time * .0731) * .5); // eh
		
		if(collision_circle(x, y, 5, obj_player, false, false) != noone) {
			global.player.hit(1, _dirToPlayer, 4);
		}
	} else {
		yChange += grav;
		
		part_type_direction(bloodSpurtPart, image_angle - 20, image_angle + 20, 0, 0);
		part_particles_create_color(sys, x, y, bloodSpurtPart, c_maroon, 2);
	}
	
	image_angle = point_direction(0, 0, xChange, yChange);
} else {
	if(parent != noone) { // instance check when at all times clean up will set to noone so not necessary to check exists here
		var _parentX = parent.x;
		var _parentY = parent.y;
		
		var _dir = point_direction(x, y, _parentX, _parentY);
		
		image_angle = _dir;
		
		x = _parentX - dcos(_dir) * 16;
		y = _parentY + dsin(_dir) * 16;
		
		if(child == noone) {
			if(sprite_index != spr_wormTail) { // this isn't robust for other sprites of worms but... Oh well?
				part_type_direction(bloodSpurtPart, image_angle - 200, image_angle - 160, 0, 0);
				part_particles_create_color(sys, x, y, bloodSpurtPart, c_maroon, 2);
			}
		}
	}
}