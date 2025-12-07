event_inherited();

radius = irandom_range(3, 6);
partRadius = radius * .7;

moveDir = irandom(360);
moveSpeed = .13;

speedDecay = .93;

image_blend = c_random;

depth += 5; // go behind tiles.. 