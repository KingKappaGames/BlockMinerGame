if (live_call()) return live_result;

var _camX = VIEW_X;
var _camY = VIEW_Y;
var _camW = VIEW_W;
var _camH = VIEW_H;

var _guiW = GUI_W;
var _guiH = GUI_H;

if(inRange) {
	var _textX = (x * 2 + global.player.x) / 3;
	var _textY = (y * 2 + global.player.y) / 3 - 50;
	
	_textX = ((_textX - _camX) / _camW) * _guiW;
	_textY = ((_textY - _camY) / _camH) * _guiH;
	
	if(pickupText != -1) {
		var _col = #ffff88;
		draw_text_transformed_color(_textX, _textY, pickupText, 1., 1., 0, _col, _col, _col, _col, 1);
	}
	
	if(levelRequirement != 0) { 
		var _col = accesable ? #ffff88 : #778888;
		draw_text_transformed_color(_textX, _textY - 30, $"{global.gameInfo.level}/{levelRequirement}", 1., 1., 0, _col, _col, _col, _col, 1);
	}
}