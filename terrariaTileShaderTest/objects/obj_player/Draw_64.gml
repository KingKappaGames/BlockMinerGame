if (live_call()) return live_result;

var _size = 28;

draw_circle(45, 45, _size, true);

draw_text_transformed(90, 18, round(Health), 2, 2, 0);

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