event_inherited();

if(instance_number(obj_boss) <= 1) { // 1 being only me left and since i'm dissapearing next frame... no more bosses
	global.bossSpawned = false;
}