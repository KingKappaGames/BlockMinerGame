//if (live_call()) return live_result;

direction += dsin(current_time * .3854) * .552 - dsin(current_time * .1842) * .271;

image_angle += spin;

if(global.timer % 6 == 0) {
	var _near = instance_nearest(x, y, obj_creature);
	if(_near != noone) {
		var _dist = point_distance(x, y, _near.x, _near.y);
		var _pullRange = range * 9;
		if(_dist < range) {
			pickup(_near);
		} else if(_dist < _pullRange) {
			var _pullStrength = 1 - sqr(_dist / _pullRange);
			motion_add(point_direction(x, y, _near.x, _near.y), 1.1 * _pullStrength);
			speed = min(speed, 3);
		}
	}
}

part_type_size_x(smoothTrail, speed * .04, speed * .04, -.001, 0);
part_type_size_y(smoothTrail, .045, .045, -.001, 0);
part_type_orientation(smoothTrail, direction, direction, 0, 0, 0);
part_particles_create_color(sysUnder, x, y, smoothTrail, c_white, 1);

duration--;
if(duration < 0) {
	
	
	instance_destroy();
}