event_inherited();

smokeTrailPart = global.thickTrail; // localizing globals... Hm
explosionPart = global.explosionPart;
trailerPart = global.overwrittenTrailerPart;
starPart = global.starPart;


image_blend = c_white;

duration = 360;

speedDecay = .99;

spinSpeed = random_range(-3, 3);

horizontalBounce = -.8;
verticalBounce = -.77;

depth -= 10;