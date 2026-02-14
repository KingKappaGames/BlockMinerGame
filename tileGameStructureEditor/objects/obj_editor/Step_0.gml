if (live_call()) return live_result;

var _change = 1;
if(keyboard_check(vk_shift)) {
	_change *= -1;
}

if(keyboard_check_pressed(vk_up) || keyboard_check_pressed(vk_left) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(vk_down)) {
	inputTimer = 0; // if manually hitting the key always send
}

if(inputTimer <= 0) {
	if(keyboard_check(vk_left)) {
		changeSizeGrid(_change);
		inputTimer = inputTimerMax;
	} else if(keyboard_check(vk_up)) {
		changeSizeGrid(, _change);
		inputTimer = inputTimerMax;
	} else if(keyboard_check(vk_right)) {
		changeSizeGrid(,, _change);
		inputTimer = inputTimerMax;
	} else if(keyboard_check(vk_down)) {
		changeSizeGrid(,,, _change);
		inputTimer = inputTimerMax;
	}
} else {
	inputTimer--;
}

var _tileHoverX = (mouse_x - displayOffsetX) div tileSize;
var _tileHoverY = (mouse_y - displayOffsetY) div tileSize;
if(_tileHoverX > -1 && _tileHoverX < width && _tileHoverY > -1 && _tileHoverY < height) {
	if(mouse_check_button(mb_left)) {
		if(keyboard_check(vk_control)) {
			clearGrid[_tileHoverX][_tileHoverY] = true;
		} else {
			tileGrid[_tileHoverX][_tileHoverY] = placingIndex;
		}
	} else if(mouse_check_button(mb_right)) {
		if(keyboard_check(vk_control)) {
			clearGrid[_tileHoverX][_tileHoverY] = false; // toggle clearable status
		} else {
			tileGrid[_tileHoverX][_tileHoverY] = 0;
		}
	}
}

if(keyboard_check_released(ord("O"))) {
	tileCenterX = _tileHoverX;
	tileCenterY = _tileHoverY;
}

if(mouse_check_button_released(mb_middle)) {
	displayHeld = false;
} else if(mouse_check_button_pressed(mb_middle)) {
	displayHeld = true;
} else if(displayHeld) {
	displayOffsetX += window_mouse_get_delta_x();
	displayOffsetY += window_mouse_get_delta_y();
}

if(keyboard_check_released(ord("A"))) {
	placingIndex = clamp(placingIndex - 1, minTileIndex, maxTileIndex);
}

if(keyboard_check_released(ord("D"))) {
	
	placingIndex = clamp(placingIndex + 1, minTileIndex, maxTileIndex);
}




if(keyboard_check_released(vk_enter)) {
	var _tileGrid = tileGrid;
	var _clearGrid = clearGrid;
	var _structureInfo = {
		tileData : _tileGrid,
		tileClearData : _clearGrid,
		tileOriginX : tileCenterX,
		tileOriginY : tileCenterY,
	}
	
	var _dataString = json_stringify(_structureInfo);
	
	var _dataBuffer = buffer_create(string_byte_length(_dataString) + 1, buffer_fixed, 1);
	buffer_write(_dataBuffer, buffer_string, _dataString);
	
	buffer_save(_dataBuffer, "exampleStructure.txt");
	
	buffer_delete(_dataBuffer);
}

if(keyboard_check_released(vk_insert)) {
	var _dataBuffer = buffer_load("bananaTree.txt");
	
	var _dataString = buffer_read(_dataBuffer, buffer_string);
	
	var _data = json_parse(_dataString);
	
	tileGrid = _data.tileData;
	clearGrid = _data.tileClearData;
	tileCenterX = _data.tileOriginX;
	tileCenterY = _data.tileOriginY;
	
	width = array_length(tileGrid);
	height = array_length(tileGrid[0]);
	
	displayOffsetX = 540;
	displayOffsetY = 960 - height * tileSize;
	
	buffer_delete(_dataBuffer);
}

if(keyboard_check_released(ord("F"))) {
	window_set_fullscreen(!window_get_fullscreen());
}