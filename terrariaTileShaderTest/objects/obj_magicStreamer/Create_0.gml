event_inherited();

source = noone;

image_blend = make_color_rgb(irandom_range(100, 255), irandom_range(100, 255), irandom_range(100, 255)); // lower range

duration = 90;

spin = random_range(-1.8, 1.8);

depth -= 10;

global.partStreamerSpellTrail = part_type_create();
var _streamerTrail = global.partStreamerSpellTrail;
part_type_life(_streamerTrail, 30, 40);
part_type_shape(_streamerTrail, pt_shape_square);
part_type_size(_streamerTrail, .06, .06, -.001, 0);
part_type_alpha2(_streamerTrail, 1, .3);
part_type_speed(_streamerTrail, 0, .3, -.004, 0);
part_type_direction(_streamerTrail, 0, 360, 0, 0);
part_type_orientation(_streamerTrail, 0, 0, 1.7, 0, 0);
part_type_color1(_streamerTrail, #ffffff);

partStreamer = global.partStreamerSpellTrail;

image_yscale = .4;
image_xscale = .8;