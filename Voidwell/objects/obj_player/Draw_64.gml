if (live_call()) return live_result;

var _mouseX = device_mouse_x_to_gui(0);
var _mouseY = device_mouse_y_to_gui(0);

var _size = 56;

draw_circle(90, 90, _size, true);

if(Health >= 0) {
	var _healthPortion = Health / HealthMax;
	var _beat = animcurve_channel_evaluate(heartCurve, (current_time % 1000) / 1000);
	var _saturation = power(_healthPortion, .75);
	var _rawHealthForce = max(0, sqr(Health / 50) - .18);
	var _rawColorAdd = (255 * _saturation * _rawHealthForce);
	var _col = make_colour_rgb(min(255, 128 + 192 * _saturation + _rawColorAdd), clamp(96 - 96 * _saturation + _rawColorAdd, 0, 255), clamp(96 -  96 * _saturation + _rawColorAdd, 0, 255));
	
	var _beatStrength = 3.2 * ((_beat - 1) * _saturation + 1);
	draw_sprite_ext(spr_heart, 0, 220, 90, _beatStrength, _beatStrength, 0, _col, 1);
	
	if(keyboard_check_released(vk_enter)) {
		Health *= 1.1;
	}
}
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(220, 90, round(Health), 1.5, 1.5, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

shader_set(shd_fogDistortColor);

shader_set_uniform_f(shader_get_uniform(shd_fogDistortColor, "time"), current_time * .001);

var _scale = (_size / 64) * mana / manaMax;
draw_sprite_ext(spr_circleTexture, 0, 90, 90, _scale, _scale, 0, c_white, 1);

shader_set(shd_fogDistort);

shader_set_uniform_f(shader_get_uniform(shd_fogDistort, "time"), current_time * .001);

for(var _i = 0; _i < bombCount; _i++) {
	_scale = (11 + irandom(1)) / 32;
	draw_sprite_ext(spr_circleTexture, 0, 110 - _i % 2 * 40, 320 + _i * 60, _scale, _scale, 0, c_white, 1);
}

shader_reset();

draw_sprite_ext(spr_spellIcons, spell, 90, 90, 2, 2, 0, c_white, 1);

draw_circle(90, 220, 48, true);
draw_sprite_ext(spr_itemHeldIcons, heldItem, 90, 220, 2, 2, 0, c_white, 1);

msg(window_mouse_get_x());



if(point_distance(90, 220, _mouseX, _mouseY) < 48) {
	heldItemTextAlpha = min(1, heldItemTextAlpha + .09);
} else {
	heldItemTextAlpha *= .52;
}

if(heldItemTextAlpha > .01) {
	draw_set_valign(fa_middle);
	draw_text_transformed_color(_mouseX + 50, _mouseY, heldItemText, 1.7 * sqrt(heldItemTextAlpha), 1.7 * sqrt(heldItemTextAlpha), dsin(current_time * .2), c_white, c_white, c_white, c_white, heldItemTextAlpha);
	draw_set_valign(fa_top);
}