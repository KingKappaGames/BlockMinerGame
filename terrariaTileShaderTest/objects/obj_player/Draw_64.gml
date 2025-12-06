if (live_call()) return live_result;

var _size = 28;

draw_circle(45, 45, _size, true);

if(Health >= 0) {
	var _healthPortion = Health / HealthMax;
	var _beat = animcurve_channel_evaluate(heartCurve, (current_time % 1000) / 1000);
	var _saturation = power(_healthPortion, .75);
	var _rawHealthForce = max(0, sqr(Health / 50) - .18);
	var _rawColorAdd = (255 * _saturation * _rawHealthForce);
	var _col = make_colour_rgb(min(255, 128 + 192 * _saturation + _rawColorAdd), clamp(96 - 96 * _saturation + _rawColorAdd, 0, 255), clamp(96 -  96 * _saturation + _rawColorAdd, 0, 255));
	
	var _beatStrength = 1.6 * ((_beat - 1) * _saturation + 1);
	draw_sprite_ext(spr_heart, 0, 110, 45, _beatStrength, _beatStrength, 0, _col, 1);
	
	if(keyboard_check_released(vk_enter)) {
		Health *= 1.1;
	}
}
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(110, 45, round(Health), .75, .75, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

shader_set(shd_fogDistortColor);

shader_set_uniform_f(shader_get_uniform(shd_fogDistortColor, "time"), current_time * .001);

var _scale = (_size / 64) * mana / manaMax;
draw_sprite_ext(spr_circleTexture, 0, 45, 45, _scale, _scale, 0, c_white, 1);

shader_set(shd_fogDistort);

shader_set_uniform_f(shader_get_uniform(shd_fogDistort, "time"), current_time * .001);

if(bombCount > 0)  {
	_scale = (11 + irandom(1)) / 65;
	draw_sprite_ext(spr_circleTexture, 0, 55, 100, _scale, _scale, 0, c_white, 1);
}
if(bombCount > 1)  {
	_scale = (11 + irandom(1)) / 65;
	draw_sprite_ext(spr_circleTexture, 0, 35, 130, _scale, _scale, 0, c_white, 1);
}
if(bombCount > 2)  {
	_scale = (11 + irandom(1)) / 64;
	draw_sprite_ext(spr_circleTexture, 0, 55, 160, _scale, _scale, 0, c_white, 1);
}

shader_reset();

draw_sprite(spr_spellIcons, spell, 45, 45);