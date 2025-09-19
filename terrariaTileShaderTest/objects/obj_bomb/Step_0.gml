event_inherited();

if(!inWorld) {
	instance_destroy();
	exit;
}

part_particles_create_color(sys, x, y, smokeTrailPart, image_blend, 1);

yChange += grav; // gravity

script_moveCollide();

xChange *= speedDecay;

duration--;
if(duration <= 0) {
	var _angle = 0;
	var _dist = tileSize;
	var _xx = 0;
	var _yy = 0;
	repeat(350) {
		_dist = _dist + .25;
		_angle += irandom_range(20, 70);
		_xx = x + dcos(_angle) * _dist + irandom_range(-tileSize, tileSize);
		_yy = y - dsin(_angle) * _dist + irandom_range(-tileSize, tileSize);
		script_breakTileAtPos(_xx, _yy);
		//instance_create_layer(_xx, _yy, "Instances", obj_debugMark);
	}
	
	part_particles_create_color(sys, x, y, explosionPart, image_blend, 120);
	
	audio_play_sound(snd_explosion, 0, 0, 2);
	
	instance_destroy();
}