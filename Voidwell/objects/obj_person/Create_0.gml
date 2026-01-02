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

/// @desc Check tiles in a normalized way in the world map (eg +1 x is forward, not +1 coord, and +1 y is up, not down.)
/// @param {real} xx The relative x movement (normalized to forward vs backward, not left vs right!)
/// @param {real} yy The relative y movement flipped so that +1 is up 1!
move = function(xx, yy) {
	var _debug = tiles[x div tileSize + xx * directionFacing][y div tileSize - yy];
	return _debug;
}

previousDieFunc = die;
die = function() {
	previousDieFunc();
	
	var _material = material;
	
	audio_play_sound_at(global.tileBreakSounds[_material], x, y, 0, audioRefMedium, audioMaxMedium, 1, 0, 0, 1,, random_range(.9, 1.1));
	
	part_particles_create_color(sys, x, y - 10, global.partPoofDustRadial, global.tileColors[_material], 20);
}