function script_moveCollide() {
	var _worldTiles = global.worldTiles;
	
	var _tileOnX = _worldTiles[(x + xChange) div tileSize][y div tileSize];
	
	if(_tileOnX > 0) {
		x = x - (x % tileSize) + .1;
		if(xChange > 0) {
			x += tileSize - .2; // push to left or right edge of tile if hitting wall in that direction (horizontally)
		}
		xChange *= horizontalBounce;
	}
	
	x += xChange;
	
	var _tileOnY = _worldTiles[x div tileSize][(y + yChange) div tileSize];
	
	if(_tileOnY > 0) {
		y = y - (y % tileSize) + .1;
		if(yChange > 0) {
			y += tileSize - .2; // push to top or bottom edge of tile if hitting wall in that direction (vertically)
		}
		
		hitGround(yChange, _tileOnY);
		
		yChange *= verticalBounce;
	}
	
	y += yChange;
}