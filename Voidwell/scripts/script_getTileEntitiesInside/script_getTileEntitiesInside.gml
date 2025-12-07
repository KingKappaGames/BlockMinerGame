function script_getTileEntitiesInside(worldTileX, worldTileY, listToFill, useCoordinates = false, objectType = obj_gameObject) {
	if(useCoordinates) {
		worldTileX = worldTileX div tileSize;
		worldTileY = worldTileY div tileSize; // this essentially is modding the tile back to the placement tile then remultipling the coords below
	}
	
	collision_rectangle_list(worldTileX * tileSize, worldTileY * tileSize, worldTileX * tileSize + tileSize, worldTileY * tileSize + tileSize, objectType, false, false, listToFill, false);
}