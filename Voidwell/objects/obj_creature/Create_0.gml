event_inherited();

moveSpeed = 0;

HealthMax = 10;
Health = HealthMax;
alive = true;

knockbackMult = 1;

hitFlash = 0;

directionFacing = 1;

hit = function(damage, dir = 0, force = -1, destroyBody = false) {
	Health -= damage;
	
	audio_play_sound(snd_hit, 0, 0, random_range(.75, .9), undefined, random_range(.85, 1.25));
	
	if(object_index != obj_abyssLord) {
		if(irandom(12) == 0) {
			audio_play_sound(snd_monsterSquak, 0, 0, random_range(.9, 1.15), undefined, random_range(.85, 1.25));
		}
	}
	
	if(Health <= 0) {
		die();
	} else {
		hitFlash = 6;
	}
	
	if(force != -1) {
		xChange += dcos(dir) * force * knockbackMult;
		yChange -= (dsin(dir) * force   + force * .45) * knockbackMult; // hit in the direction plus a bit up because in 99% of cases that will be nice
	}
	
	if(global.gameGoreSelected != 0) {
		part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, power(damage * .75, 1.5) * 2 + 1);
	} else {
		part_particles_create_color(sys, x, y - 10, starPart, c_white, power(damage * .75, 1.5) + 1);
	}
}

die = function() {
	if(global.gameGoreSelected != 0) {
		part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, HealthMax * 3 + 15);
	} else {
		part_particles_create_color(sys, x, y - 10, starPart, c_white, HealthMax * 1 + 7);
	}
	audio_play_sound_at(snd_monsterSquak, x, y, 0, audioRefMedium, audioMaxMedium, 1, 0, 0, 1,, random_range(.9, 1.1));
	
	if(irandom(3) == 0) {
		script_createDebrisChunk(choose(obj_itemPickupDebris, obj_itemPickupDebrisGlass), x, y, random_range(-2, 2), random_range(-2, 2), irandom(E_item.itemCount - 1), 1, 1, 180);
	}
	
	instance_destroy();
}