if (live_call()) return live_result;

var _camX = camera_get_view_x(cam); 
var _camY = camera_get_view_y(cam);
var _camW = camera_get_view_width(cam);
var _camH = camera_get_view_height(cam);

if(scenePosition >= 0 && scenePosition < sceneCount - 1) {
	draw_rectangle_color(_camX, _camY, _camX + _camW, _camY + _camH, #0A040A, #0A040A, #0A040A, #0A040A, false);
}

if(scenePosition >= 0) {
	draw_sprite_ext(spriteList[scenePosition], imageList[scenePosition], _camX, _camY, scale, scale, 0, c_white, 1 - transition * 2); // fade out from 0 to .5
	
	draw_text_ext_transformed_color(_camX + _camW * .1, _camY + _camH * .7, textList[scenePosition], 30, _camW, .8, .8, 0, c_yellow, c_yellow, #EEE4B1, #EEE4B1, 1 - transition * 2);
}

if(scenePosition < sceneCount - 1) {
	draw_sprite_ext(spriteList[scenePosition + 1], imageList[scenePosition + 1], _camX, _camY, scale, scale, 0, c_white, transition * 1.5 - .5); // fade in from .5 to 1
	var _textSource = textList[scenePosition + 1];
	var _text = string_copy(_textSource, 1, textProgress);
	draw_text_ext_transformed_color(_camX + _camW * .1, _camY + _camH * .7, _text, 30, _camW, .8, .8, 0, c_yellow, c_yellow, #EEE4B1, #EEE4B1, 1);
}