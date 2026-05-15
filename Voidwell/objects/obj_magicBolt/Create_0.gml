event_inherited();

source = noone;

image_blend = make_color_rgb(irandom(24), irandom(24), irandom(36)); // lower range

duration = 120;

depth -= 10;

breakTileChance = .05;

hitRadius = 5;

hit = function(target) {
	target.hit(1, point_direction(0, 0, xChange, yChange), 1.5);
	duration = 0;
}