if (live_call()) return live_result;
	//
//if(duration == 40) {
	//rushForwardPart = part_type_create();
	//part_type_life(rushForwardPart, 62, 85);
	//part_type_shape(rushForwardPart, pt_shape_square);
	//part_type_size(rushForwardPart, .15, .21, -.002, 0);
	//part_type_orientation(rushForwardPart, 0, 360, 0, 0, false);
	//part_type_gravity(rushForwardPart, .04, 270);
//}

event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

var _dir = point_direction(0, 0, xChange, yChange);

part_type_speed(rushForwardPart, 3.2, 6.9, -.17, 0);
part_type_direction(rushForwardPart, _dir - 19, _dir + 19, 0, 0);
part_particles_create_color(sys, x + irandom_range(-9, 9), y + irandom_range(-9, 9), rushForwardPart, merge_color(image_blend, #442f00, random(.5)), 7);

if(irandom(3) == 0) {
	part_particles_create_color(sys, x + irandom_range(-9, 9), y + irandom_range(-9, 9), explosionPart, choose(c_green, c_lime), 1);
	
	part_type_speed(starPart, 2, 4, -.1, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 3);
	
}

duration--;

x += xChange;
y += yChange;

var _collision = collision_circle(x, y, 12 + irandom(7), obj_creature, false, false);
if(instance_exists(_collision) && _collision != global.player) {
	//script_placeTileAtPos(_collision.x, _collision.y, E_tile.banana, true);
	//script_placeTileAtPos(_collision.x, _collision.y - 20, E_tile.banana, true); // cursed
	//script_placeTileAtPos(_collision.x, _collision.y - 40, E_tile.banana, true);
	
	part_particles_create_color(sys, x, y, explosionPart, c_yellow, 21);
	
	part_type_speed(starPart, 3, 5.4, -.12, 0);
	part_particles_create_color(sys, x, y, starPart, c_white, 25);
	
	repeat(irandom_range(5, 7)) {
		var _banana = instance_create_layer(x, y, "Instances", obj_banana);
		_banana.xChange = random_range(-4, 4);
		_banana.yChange = random_range(-4, 4);
	}
	
	audio_play_sound(snd_explosion, 0, 0, .25);
	
	_collision.hit(1);
}

if(duration <= 0) {
	//audio_play_sound(snd_explosion, 0, 0, 2);
	instance_destroy();
}