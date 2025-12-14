if (live_call()) return live_result;



//var _person = instance_create_layer(x, y - 8, "Instances", obj_worm);
//_person.directionFacing = directionFacing;

//var _robe = script_createRobePickup(E_robe.abyssLord, x, y);
//_robe.image_xscale = directionFacing;
//instance_create_layer(x + 120, y - 100, "Instances", obj_itemPickUpFloat);
//instance_create_layer(x - 120, y - 100, "Instances", obj_itemPickUpStatic);

instance_create_layer(x, y - 100, "Instances", obj_striderLord);

//instance_create_layer(x, y, "Instances", obj_book);

//var _worm = script_createWorm(x, y - 50, 25);

//var _person = instance_create_layer(x, y - 100, "Instances", obj_abyssLord);
//_person.directionFacing = directionFacing;