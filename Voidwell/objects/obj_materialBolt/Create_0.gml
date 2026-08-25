event_inherited();

materialType = 0; // THIS SPELL CAN MAKE OR BREAK TILES (0/clear being break)

image_blend = make_color_rgb(irandom(24), irandom(24), irandom(36)); // lower range

duration = 150;

depth -= 10;

hitRadius = 5;

speedDecay = .99;

hit = function(target) {
	target.hit(1, point_direction(0, 0, xChange, yChange), 1.5); // extra point of damage to direct hits... ?
	duration = 0;
}