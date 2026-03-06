event_inherited();

image_blend = make_color_rgb(power(random(1), 2.0) * 255, power(random(1), 4.0) * 255, power(random(1), 4.0) * 255);

duration = 240;

speedDecay = .98;

spinSpeed = random_range(-3, 3);

horizontalBounce = -.7;
verticalBounce = -.4;

depth -= 10;