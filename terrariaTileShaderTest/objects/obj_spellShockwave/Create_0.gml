event_inherited();

//image_blend = make_color_rgb(irandom_range(180, 255), irandom_range(180, 255), irandom_range(180, 255));
image_blend = make_color_rgb(irandom_range(0, 35), irandom_range(0, 35), irandom_range(0, 35));

duration = 13;

radius = tileSize;
radiusMult = 1.165;

strength = 1; // the multiplier on how much to try to break or place things

materialType = 0; // THIS SPELL CAN MAKE OR BREAK TILES (0/clear being break)

depth -= 101; // over part over layer!