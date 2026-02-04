if (live_call()) return live_result;
	
setRobe(ceil(current_time % 3000 / 400), false, true, false);
//
//script_createDebrisChunk(choose(obj_itemPickupDebris, obj_itemPickupDebrisGlass), x, y, random_range(-2, 2), random_range(-2, 2), irandom(E_item.itemCount - 1));
//
//script_spawnCreature(obj_person, x + 100, y, 5);

//if(instance_exists(obj_worm)) {
	//obj_worm.xChange = 0;
	//obj_worm.yChange = 0;
	//obj_worm.moveSpeed = 0;
//} else {
	//script_createWorm(x, y, 35, 2);
//}