if (live_call()) return live_result;

//if(instance_exists(obj_worm)) {
	//obj_worm.xChange = 0;
	//obj_worm.yChange = 0;
	//obj_worm.moveSpeed = 0;
//} else {
	//script_createWorm(x, y, 35, 2);
//}

var _person = instance_create_layer(x, y - 8, "Instances", obj_person);
_person.directionFacing = directionFacing;