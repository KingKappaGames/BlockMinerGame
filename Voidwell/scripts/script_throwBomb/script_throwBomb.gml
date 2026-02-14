function script_createBomb(xx, yy, dir, spd, durationSet = 240) { // ect
	with(instance_create_layer(xx, yy, "Instances", obj_bomb)) {
		xChange = lengthdir_x(spd, dir);
		yChange = lengthdir_y(spd, dir);
		duration = durationSet;
		
		return id;
	}
}