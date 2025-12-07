draw_circle_color(x, y, 3 + irandom(1), image_blend, image_blend, false);

var _wickLen = 3 + duration / 30;
var _cos = dcos(image_angle + 135);
var _sin = dsin(image_angle + 135);

draw_line(x + _cos * 3, y - _sin * 3, x + _cos * _wickLen, y - _sin * _wickLen);

if(irandom(3) == 0) {
	part_particles_create_color(sys, x + _cos * _wickLen, y - _sin * _wickLen, thickTrailPart, c_yellow, 1);
}