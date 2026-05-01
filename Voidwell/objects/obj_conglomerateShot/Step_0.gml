event_inherited();

if(irandom(2) == 0) {
	part_particles_create_color(sys, x + irandom_range(-2, 2), y + irandom_range(-2, 2), thickTrailPart, image_blend, 1);
}
//part_particles_create_color(sys, x - xChange * .5 + irandom_range(-2, 2), y - yChange * .5 + irandom_range(-2, 2), thickTrailPart, image_blend, 2);

duration--;

var _speed = point_distance(0, 0, xChange, yChange);

var _hitId = collision_circle(x + xChange, y + yChange, sqrt(_speed) * .5, obj_creature, false, false);
if(instance_exists(_hitId) && source != _hitId && _hitId.object_index != obj_conglomerateBoss) { // meg, just make conglomerate not be able to hit itself
	_hitId.hit(.2 + sqr(_speed * .11), point_direction(0, 0, xChange, yChange), .65 * _speed);
	
	
}

x += xChange;
y += yChange;

yChange += grav;


if(inWorld) {
	var _tileHitX = tiles[(x + xChange) div tileSize][(y) div tileSize];
	if(_tileHitX > 0) {
		hit();
	}
	var _tileHitY = tiles[x div tileSize][(y + yChange) div tileSize];
	if(_tileHitY > 0) {
		hit();
	}
}

if(duration <= 0) {
	hit(false);
}
