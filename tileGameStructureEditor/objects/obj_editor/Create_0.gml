tileGrid[0][0] = 0; // "2d" array of 0 length
clearGrid[0][0] = 0;

displayHeld = false;
displayOffsetX = 960; // 1080 p halfs
displayOffsetY = 540;

width = 1;
height = 1;

tileCenterX = 0;
tileCenterY = 0;

tileSize = 40;
#macro minTileIndex -3
#macro maxTileIndex 11

inputTimer = 0;
inputTimerMax = 5;

colors = [c_black, c_green, c_aqua, #994400, #eecca8];
colorsDec = [c_black, c_lime, c_grey, c_maroon, c_blue];

placingIndex = 0;

changeSizeGrid = function(leftChange = 0, upChange = 0, rightChange = 0, downChange = 0) {
	if(leftChange == -1 && width <= 1) {
		return;
	}
	if(upChange == -1 && height <= 1) {
		return;
	}
	if(rightChange == -1 && width <= 1) {
		return;
	}
	if(downChange == -1 && height <= 1) {
		return;
	}
	
	if(leftChange > 0) {
		displayOffsetX -= tileSize;
		array_insert(tileGrid, 0, array_create(height, 0));
		array_insert(clearGrid, 0, array_create(height, 0));
	} else if(leftChange < 0) {
		displayOffsetX += tileSize;
		array_delete(tileGrid, 0, 1);
		array_delete(clearGrid, 0, 1);
	}
	
	if(upChange > 0) {
		displayOffsetY -= tileSize;
		for(var _horizontalI = 0; _horizontalI < width; _horizontalI++) {
			array_insert(tileGrid[_horizontalI], 0, 0);
			array_insert(clearGrid[_horizontalI], 0, 0);
		}
	} else if(upChange < 0) {
		displayOffsetY += tileSize;
		for(var _horizontalI = 0; _horizontalI < width; _horizontalI++) {
			array_delete(tileGrid[_horizontalI], 0, 1);
			array_delete(clearGrid[_horizontalI], 0, 1);
		}
	}
	
	if(rightChange > 0) {
		array_push(tileGrid, array_create(height, 0));
		array_push(clearGrid, array_create(height, 0));
	} else if(rightChange < 0) {
		array_delete(tileGrid, width - 1, 1);
		array_delete(clearGrid, width - 1, 1);
	}
	
	if(downChange > 0) {
		for(var _horizontalI = 0; _horizontalI < width; _horizontalI++) {
			array_push(tileGrid[_horizontalI], 0);
			array_push(clearGrid[_horizontalI], 0);
		}
	} else if(downChange < 0) {
		for(var _horizontalI = 0; _horizontalI < width; _horizontalI++) {
			array_delete(tileGrid[_horizontalI], height - 1, 1);
			array_delete(clearGrid[_horizontalI], height - 1, 1);
		}
	}
	
	width = array_length(tileGrid);
	height = array_length(tileGrid[0]);
}