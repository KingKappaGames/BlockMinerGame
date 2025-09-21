event_inherited();

sys = global.sys;
smokeTrailPart = global.smokeTrailPart; // localizing globals... Hm
breakPart = global.breakPart;

image_blend = make_color_rgb(irandom_range(180, 255), irandom_range(180, 255), irandom_range(180, 255));

duration = 13;

radius = tileSize;

depth -= 10;