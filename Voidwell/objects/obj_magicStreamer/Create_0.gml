event_inherited();

image_blend = make_color_rgb(irandom_range(100, 255), irandom_range(100, 255), irandom_range(100, 255)); // lower range

duration = 150;

spin = random_range(-1.8, 1.8);

depth -= 10;

partStreamer = global.partStreamerSpellTrail;

image_yscale = .4;
image_xscale = .8;

hitRadius = 5;

hit = function(target) {
	var _moveDir = point_direction(0, 0, xChange, yChange);
	
	audio_play_sound(snd_hitStabMeat, 0, 0, .8,, random_range(.8, 1.2));
	
	var _gore = global.gameGoreSelected;
	if(_gore != 0) {
		part_type_direction(bloodSpurtPart, _moveDir - 200, _moveDir - 160, -.03, 0);
		part_particles_create_color(sys, x, y, bloodSpurtPart, c_maroon, 3);
	}
	
	part_type_speed(starPart, .6, 1.2, -.03, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 1); // STARS
	
	target.hit(.5, point_direction(0, 0, xChange, yChange), .6);
	duration = 0;
}