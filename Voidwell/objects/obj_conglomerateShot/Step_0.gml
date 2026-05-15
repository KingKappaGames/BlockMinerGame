event_inherited();

checkHit();

if(irandom(2) == 0) {
	part_particles_create_color(sys, x + irandom_range(-2, 2), y + irandom_range(-2, 2), thickTrailPart, image_blend, 1);
}
//part_particles_create_color(sys, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), thickTrailPart, image_blend, 2);

duration--;

var _speed = point_distance(0, 0, xChange, yChange);

hitRadius = sqrt(_speed) * .5;
checkHit();

x += xChange;
y += yChange;

yChange += grav;


if(inWorld) {
	var _tileHitX = tiles[(x + xChange) div tileSize][(y) div tileSize];
	if(_tileHitX > 0) {
		destroy();
	}
	var _tileHitY = tiles[x div tileSize][(y + yChange) div tileSize];
	if(_tileHitY > 0) {
		destroy();
	}
}

if(duration <= 0) {
	hit(false);
}
