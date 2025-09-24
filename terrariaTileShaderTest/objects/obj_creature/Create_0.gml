event_inherited();

moveSpeed = 0;

HealthMax = 10;
Health = HealthMax;

hitFlash = 0;

directionFacing = 1;

hit = function(damage, hitDir = -1, hitForce = 0) {
	Health -= damage;
	
	if(Health <= 0) {
		die();
	} else {
		hitFlash = 6;
	}
	
	if(hitDir != -1) {
		xChange += dcos(hitDir) * hitForce;
		yChange -= dsin(hitDir) * hitForce   + hitForce; // hit in the direction plus a bit up because in 99% of cases that will be nice
	}
	
	part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, power(damage * .75, 1.5) * 2 + 1);
}

die = function() {
	
}