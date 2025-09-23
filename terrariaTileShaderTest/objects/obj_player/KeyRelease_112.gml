if (live_call()) return live_result;

//script_createRobePickup(robeType.bananaYellow, x, y - 100);
//instance_create_layer(x + 120, y - 100, "Instances", obj_itemPickUpFloat);
//instance_create_layer(x - 120, y - 100, "Instances", obj_itemPickUpStatic);

var _person = instance_create_layer(x, y, "Instances", obj_person);
_person.directionFacing = directionFacing;