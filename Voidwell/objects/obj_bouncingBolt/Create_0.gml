event_inherited();

source = noone;

image_blend = make_color_rgb(irandom_range(200, 255), irandom_range(200, 255), irandom_range(200, 255)); // lower range

duration = 300 + irandom(20);

depth -= 10;

bounceStrengthEnemy = .75;
bounceStrengthGround = .93;

checkHit = function() {
	var _speed = point_distance(0, 0, xChange, yChange);
	var _hitId = collision_circle(x + xChange, y + yChange, sqrt(_speed) * .5, obj_creature, false, false);
	if(instance_exists(_hitId) && source != _hitId && (allegiance != _hitId.allegiance)) {
		hit(_hitId);
	}
}

hit = function(target) {
	var _speed = point_distance(0, 0, xChange, yChange);
	var _originalDir = point_direction(0, 0, xChange, yChange);
	var _dir = _originalDir + random_range(160, 200);
	xChange = dcos(_dir) * _speed * bounceStrengthEnemy;
	yChange = -dsin(_dir) * _speed * bounceStrengthEnemy;
	
	target.hit(.2 + sqr(_speed * .11), _originalDir, .65 * _speed);
}