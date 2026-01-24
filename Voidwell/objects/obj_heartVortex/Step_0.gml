//if (live_call()) return live_result;

event_inherited();

part_type_speed(shimmerPart, 1, 1.9, -.02, 0);
part_particles_create_color(sys, x, y, shimmerPart, image_blend, 1);

yChange -= riseSpeed; // slight upwards draw

var _dir = point_direction(x, y, global.player.x, global.player.y);
xChange += lengthdir_x(riseSpeed, _dir);
yChange += lengthdir_y(riseSpeed, _dir);

if(duration % 30 == 0) {
	instance_create_depth(x, y, depth, obj_resourceHeart);
}