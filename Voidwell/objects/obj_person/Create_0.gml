event_inherited();

speedDecay = .85;
speedDecayAir = .98;

debugTileDraw = [];

waitTimer = 0;

damage = 2;

HealthMax = irandom_range(8, 12);
Health = HealthMax;

knockbackMult = 1.6;

material = -1; // if this person is a material robe

closeRangeLineOfSightRange = 70;
closeRangeLineOfSightChange = 15;
closeRangeLineOfSightBehavior = function(dir, dist, xx, yy) {
	yChange = -sqrt(abs(yy - y)) * .6 + .8;
	xChange = (xx - x) * .055;
	waitTimer = 30;
	
	audio_play_sound(snd_monsterSquak, 0, 0, random_range(.9, 1.15), undefined, random_range(.85, 1.25));
}

spawn = function() {
	material = choose(E_tile.empty, E_tile.diamond, E_tile.grass, E_tile.metal);
	sprite_index = script_getRobeSpriteForMaterial(material);

	if(material == E_tile.diamond) {
		HealthMax *= .7;
		Health = HealthMax;
		damage *= 3;
		moveSpeed *= .9;
	} else if(material == E_tile.metal) {
		HealthMax *= 2;
		Health = HealthMax;
		damage *= 1.25;
		moveSpeed *= .7;
		knockbackMult = .2;
	} else if(material == E_tile.grass) {
		HealthMax *= 1;
		Health = HealthMax;
		damage *= 1;
		moveSpeed *= 1.5;
		knockbackMult = 1.8;
	}
}

/// @desc Check tiles in a normalized way in the world map (eg +1 x is forward, not +1 coord, and +1 y is up, not down.)
/// @param {real} xx The relative x movement (normalized to forward vs backward, not left vs right!)
/// @param {real} yy The relative y movement flipped so that +1 is up 1!
move = function(xx, yy) {
	return tiles[x div tileSize + xx * directionFacing][y div tileSize - yy];
}

previousDieFunc = die;
die = function(destroyBody = false) {
	previousDieFunc(destroyBody);
	
	if(!destroyBody) {
		script_createDebrisChunk(obj_debrisBody, x, y, xChange, yChange,, 1, 1, 300, sprite_index, image_index,,, false);
	}
	
	var _material = material;
	
	audio_play_sound_at(global.tileBreakSounds[_material], x, y, 0, audioRefMedium, audioMaxMedium, 1, 0, 0, 1,, random_range(.9, 1.1));
	
	part_particles_create_color(sys, x, y - 10, global.partPoofDustRadial, global.tileColors[_material], 20);
}