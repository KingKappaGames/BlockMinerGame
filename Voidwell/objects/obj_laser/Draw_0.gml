if (live_call()) return live_result;

draw_line_width_color(x, y, x + lengthdir_x(length, directionLaser), y + lengthdir_y(length, directionLaser), random_range(.65, 1.5) * duration * .8, image_blend, image_blend);