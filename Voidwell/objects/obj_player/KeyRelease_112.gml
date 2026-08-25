if (live_call()) return live_result;



//var _person = instance_create_layer(x, y - 8, "Instances", obj_worm);
//_person.directionFacing = directionFacing;

//var _robe = script_createRobePickup(E_robe.abyssLord, x, y);
//_robe.image_xscale = directionFacing;
//instance_create_layer(x + 120, y - 100, "Instances", obj_itemPickUpFloat);
//instance_create_layer(x - 120, y - 100, "Instances", obj_itemPickUpStatic);

var _rand = irandom(3);
if(_rand == 0) {
	var _person = instance_create_layer(x, y - 100, "Instances", obj_abyssLord);
} else if(_rand == 1) {
	instance_create_layer(x, y - 100, "Instances", obj_striderLord);
} else if(_rand == 2) {
	script_createConglomerate(mouse_x, mouse_y, 30, 1);
} else if(_rand == 3) {
	script_spawnCreature(obj_fairyLord, x, y - 100);
}

//script_spawnCreature(obj_burstingSack, mouse_x, mouse_y);

//instance_create_layer(x, y - 100, "Instances", obj_striderLord);

//instance_create_layer(x, y, "Instances", obj_book);

//var _worm = script_createWorm(x, y - 50, 25);

//var _person = instance_create_layer(x, y - 100, "Instances", obj_abyssLord);
//_person.directionFacing = directionFacing;