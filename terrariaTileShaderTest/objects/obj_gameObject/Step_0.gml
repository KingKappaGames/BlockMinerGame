if(x + xChange < (tileRangeWorld - 1) * tileSize && x + xChange > tileSize && y + yChange < (tileRangeWorld - 1) * tileSize && y + yChange > tileSize) {
	inWorld = true;
} else {
	inWorld = false;
}