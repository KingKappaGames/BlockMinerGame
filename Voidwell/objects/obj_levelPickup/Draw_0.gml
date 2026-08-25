var _color = #aaffff;

var _radius = 18;

draw_set_alpha(.2);
draw_circle_color(x, y - 8, _radius + irandom(10), _color, _color, false);
draw_set_alpha(.45);
draw_circle_color(x, y - 8, _radius * .75 + irandom(3), _color, _color, false);
draw_set_alpha(1);

draw_circle(x, y, 1000, true);