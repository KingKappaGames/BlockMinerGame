function script_isTileEmpty(worldTileX, worldTileY, useCoordinates = false) {
	if(useCoordinates) {
		worldTileX = worldTileX div tileSize;
		worldTileY = worldTileY div tileSize;
	}
	
	var _objectFound = collision_rectangle(worldTileX * tileSize, worldTileY * tileSize, worldTileX * tileSize + tileSize, worldTileY * tileSize + tileSize, obj_gameObject, false, false);
	if(instance_exists(_objectFound)) {
		return _objectFound;
	} else {
		return true;
	}
}