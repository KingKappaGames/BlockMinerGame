event_inherited();

speedDecay = .85;
speedDecayAir = .98;

debugTileDraw = [];

waitTimer = 0;

damage = 2;

HealthMax = irandom_range(6, 10);
Health = HealthMax;

knockbackMult = 1.6;

tiles = global.worldTiles; // hold value each frame

/// @desc Check tiles in a normalized way in the world map (eg +1 x is forward, not +1 coord, and +1 y is up, not down.)
/// @param {real} xx The relative x movement (normalized to forward vs backward, not left vs right!)
/// @param {real} yy The relative y movement flipped so that +1 is up 1!
move = function(xx, yy) {
	var _debug = tiles[x div tileSize + xx * directionFacing][y div tileSize - yy];
	return _debug;
}