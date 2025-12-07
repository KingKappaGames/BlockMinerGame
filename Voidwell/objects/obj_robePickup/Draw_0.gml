var _color = #ffff88;

draw_set_alpha(.2);
draw_circle_color(x, y - 8, 25 + irandom(10), _color, _color, false);
draw_set_alpha(.45);
draw_circle_color(x, y - 8, 16 + irandom(3), _color, _color, false);
draw_set_alpha(1);

event_inherited();

//draw_text(x, y - 50, pickupIndex);