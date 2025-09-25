event_inherited();

if(inWorld) {
	var _tileStanding = max(global.worldTiles[x div tileSize][(y + 1) div tileSize], 0);

	if(_tileStanding > 0) {
		xChange *= speedDecay;
	} else {
		xChange *= speedDecayAir;
		yChange *= speedDecayAir;
		yChange += grav;
	}
	
	script_moveCollide();
} else {
	die();
}