event_inherited();

moveSpeed = 1;

speedDecay = .85;
speedDecayAir = .98;

damage = 1;

HealthMax = irandom_range(11, 15);
Health = HealthMax;

knockbackMult = .8;

material = -1; // if this person is a material robe (??)


spawn = function() {
	material = choose(E_tile.empty, E_tile.metal);
	sprite_index = spr_playerRed;//script_getRobeSpriteForMaterial(material);

	if(material == E_tile.metal) {
		HealthMax *= 2;
		Health = HealthMax;
		damage *= 1.25;
		moveSpeed *= .7;
		knockbackMult = .2;
	}
}

//previousDieFunc = die; // this doesn't work, the function id gets reset to this var and creates a loop when calling back one to itself. So prev can stay as whatever it was first set to (creature, i think? as a base..)
die = function(destroyBody = false) {
	previousDieFunc(destroyBody);
	
	if(!destroyBody) {
		script_createDebrisChunk(obj_debrisBody, x, y, xChange, yChange,, 1, 1, 300, sprite_index, image_index,,, false);
	}
	
	script_createBomb(x, y - 8, 0, 0, 1); // insta explode bomb
	
	repeat(irandom_range(3, 6)) {
		script_createBomb(x, y - 8, random(360), random_range(1.4, 5), irandom_range(50, 360)); // fragment bombs...
	}
	
	var _material = material;
	
	audio_play_sound_at(global.tileBreakSounds[_material], x, y, 0, audioRefMedium, audioMaxMedium, 1, 0, 0, 1,, random_range(.9, 1.1));
	
	part_particles_create_color(sys, x, y - 10, global.partPoofDustRadial, global.tileColors[_material], 20);
}

closeRangeLineOfSightRange = 200;
closeRangeLineOfSightChange = 30;
closeRangeLineOfSightBehavior = function(dir, dist, xx, yy) {
	repeat(1 + choose(0, 0, 0, 0, 0, 1, 1, 3)) {
		script_createBomb(x, y - 8, dir + random_range(-6, 6), random_range(3.8, 7), irandom_range(210, 360));
	}
	
	waitTimer = 30;
	
	audio_play_sound(snd_monsterSquak, 0, 0, random_range(.9, 1.15), undefined, random_range(.85, 1.25));
}