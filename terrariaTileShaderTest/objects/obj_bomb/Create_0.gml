event_inherited();

smokeTrailPart = global.smokeTrailPart; // localizing globals... Hm
explosionPart = global.explosionPart;

image_blend = make_color_rgb(irandom(255), irandom(255), irandom(255));

duration = 240;

speedDecay = .98;

horizontalBounce = -.7;
verticalBounce = -.4;

depth -= 10;