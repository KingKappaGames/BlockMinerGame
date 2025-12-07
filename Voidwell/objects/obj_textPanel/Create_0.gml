depth -= 100;

active = true;

source = noone;

displayData = {
	text : "",
	textX : 15,
	textY : 15,
	textScale : .7,
};

width = 0;
height = 0;

widthMax = 240;
heightMax = 240;

lerpRateOpen = .24;
lerpRateClose = .29;

displaySprite = -1;

bakeText = function() {
	widthMax = string_width_ext(displayData.text, textLineSeperation, (widthMax - displayData.textX - textBubbleMargin) / displayData.textScale) * displayData.textScale + textBubbleMargin * 2 + displayData.textY;
	heightMax = string_height_ext(displayData.text, textLineSeperation, (widthMax - displayData.textX - textBubbleMargin) / displayData.textScale) * displayData.textScale + textBubbleMargin * 2 + displayData.textY + inputKeyPopupIconHeight;
	
	var _surf = surface_create(widthMax, heightMax);
	
	surface_set_target(_surf);
	draw_sprite_ext(spr_popupTextBackgroundDark, 0, 0, 0, widthMax / sprite_get_width(spr_popupTextBackgroundDark), (heightMax - inputKeyPopupIconHeight) / sprite_get_height(spr_popupTextBackgroundDark), 0, c_white, 1);
	//draw_set_color(c_white);
	draw_text_ext_transformed(displayData.textX, displayData.textY, displayData.text, textLineSeperation, (widthMax - displayData.textX - textBubbleMargin) / displayData.textScale, displayData.textScale, displayData.textScale, 0);
	//draw_set_color(c_white);
	draw_sprite(spr_inputIconFrame, 0, widthMax * .5, heightMax - inputKeyPopupIconHeight);
	draw_sprite(spr_inputIcon, 0, widthMax * .5, heightMax - inputKeyPopupIconHeight);
	
	surface_reset_target();
	
	displaySprite = sprite_create_from_surface(_surf, 0, 0, widthMax, heightMax, false, false, widthMax * .5, heightMax * .5);
	
	y = source.y + textBubbleYOff - heightMax * .5;
}