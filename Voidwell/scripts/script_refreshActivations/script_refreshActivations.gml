function script_refreshActivations(despawnDistance = undefined) {
	instance_activate_all();
	
	var _camW = camera_get_view_width(cam);
	var _camCenterX = camera_get_view_x(cam) + _camW * .5;
	var _camCenterY = camera_get_view_y(cam) + camera_get_view_height(cam) * .5;
	
	despawnDistance = _camW * 1.2 + 2000;
	
	with(obj_entity) {
		if(point_distance(x, y, _camCenterX, _camCenterY) > despawnDistance) {
			if(essential) {
				instance_deactivate_object(id);
			} else {
				instance_destroy(id, false);
			}
		}
	}
	
	instance_activate_object(global.player); // hm
	instance_activate_object(global.player.robePreviousId); // hmmmmmmmmmmm
}