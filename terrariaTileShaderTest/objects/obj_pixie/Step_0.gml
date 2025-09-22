event_inherited();

part_particles_create_color(sys, x + xChange + irandom_range(-radius, radius), y + yChange + irandom_range(-radius, radius), thickTrailPart, image_blend, 1);

x += xChange;
y += yChange;

var _speed = .5 + dsin(current_time * .073) * .5 + dsin(current_time * .262) * .05;
xChange += dcos(moveDir) * moveSpeed * _speed;
yChange -= dsin(moveDir) * moveSpeed * _speed;

xChange *= speedDecay;
yChange *= speedDecay;

moveDir += (dsin(current_time * .03) + dsin(current_time * .21) * .4) * 3 * (.5 + dsin(current_time * .0731) * .5); // eh


