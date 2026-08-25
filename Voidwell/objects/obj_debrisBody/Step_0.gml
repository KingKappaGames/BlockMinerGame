event_inherited();

spinSpeed *= spinDecay;

var _tileOn = inWorld ? tiles[x div tileSize][(y + 8) div tileSize] : 0;
if(_tileOn) {
	xChange *= speedDecay;
}