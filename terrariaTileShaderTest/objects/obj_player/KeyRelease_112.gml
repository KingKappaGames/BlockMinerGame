if (live_call()) return live_result;

var _robe = script_createRobePickup(E_robe.teleporterWhite, x, y);
_robe.image_xscale = directionFacing;
//instance_create_layer(x + 120, y - 100, "Instances", obj_itemPickUpFloat);
//instance_create_layer(x - 120, y - 100, "Instances", obj_itemPickUpStatic);

//var _worm = script_createWorm(x, y - 50, 10);

//var _person = instance_create_layer(x, y - 100, "Instances", obj_abyssLord);
//_person.directionFacing = directionFacing;