if(x + xChange < tileRangeWorld * tileSize - tileSize && x + xChange > tileSize && y + yChange < tileRangeWorld * tileSize - tileSize && y + yChange > tileSize) {
	inWorld = true;
} else {
	inWorld = false;
}