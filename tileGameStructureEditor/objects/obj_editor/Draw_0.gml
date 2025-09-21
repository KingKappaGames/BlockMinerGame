var _tileVal = 0;
var _tileBreakVal = 0;
var _tileColor = 0;

draw_rectangle(displayOffsetX, displayOffsetY, displayOffsetX + width * tileSize, displayOffsetY + height * tileSize, true);

for (var _x = 0; _x < width; _x++) {
	for (var _y = 0; _y < height; _y++) {
		_tileVal = tileGrid[_x][_y];
		_tileColor = _tileVal >= 0 ? colors[_tileVal] : colorsDec[abs(_tileVal)];
		draw_rectangle_color(displayOffsetX + _x * tileSize, displayOffsetY + _y * tileSize, displayOffsetX + _x * tileSize + tileSize - 1, displayOffsetY + _y * tileSize + tileSize - 1, _tileColor, _tileColor, _tileColor, _tileColor, false);
		
		_tileBreakVal = clearGrid[_x][_y];
		if(_tileBreakVal == 1) {
			draw_sprite(spr_breakIcon, 0, displayOffsetX + (_x + .5) * tileSize, displayOffsetY + (_y + .5) * tileSize);
		}
		
		if(tileCenterX == _x && tileCenterY == _y) {
			draw_sprite(spr_originIcon, 0, displayOffsetX + (_x + .5) * tileSize, displayOffsetY + (_y + .5) * tileSize);
		}
	}
}