if(x + xChange < (global.worldSizePixels - tileSize) && (x + xChange) > tileSize && (y + yChange) < (global.worldSizePixels - tileSize) && (y + yChange) > tileSize) {
	inWorld = true;
} else {
	inWorld = false;
}