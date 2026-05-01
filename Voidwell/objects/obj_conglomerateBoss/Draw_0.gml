if (live_call()) return live_result;

event_inherited();

draw_text_transformed(x, y - 100, state, .5, .5, 0);
//draw_text(x, y - 150, conglomerateCore);
//draw_text(x, y - 200, stateTimer);

//draw_sprite_ext(sprite_index, image_index, x, y, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);