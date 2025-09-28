event_inherited();

moveSpeed = 0;

HealthMax = 10;
Health = HealthMax;
alive = true;

knockbackMult = 1;

hitFlash = 0;

directionFacing = 1;

hit = function(damage, dir = -1, force = 0, destroyBody = false) {
	Health -= damage;
	
	if(Health <= 0) {
		die();
	} else {
		hitFlash = 6;
	}
	
	if(force != -1) {
		xChange += dcos(dir) * force * knockbackMult;
		yChange -= (dsin(dir) * force   + force) * knockbackMult; // hit in the direction plus a bit up because in 99% of cases that will be nice
	}
	
	part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, power(damage * .75, 1.5) * 2 + 1);
}

die = function() {
	part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, HealthMax * 3 + 15);
	audio_play_sound(snd_chime, 1, 0);
	
	instance_destroy();
}