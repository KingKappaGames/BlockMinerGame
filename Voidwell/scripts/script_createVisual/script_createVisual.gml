function script_createVisual(xx, yy, durationSet, sprite, imageStart = 0, imageEnd = sprite_get_number(sprite), scale = 1, depthSet = depth, color = undefined) {
	var _visual = instance_create_depth(xx, yy, depthSet, obj_visual);
	with(_visual) {
		duration = durationSet;
		sprite_index = sprite;
		image_index = imageStart;
		
		image_speed = 60 * (imageEnd - imageStart) / durationSet;
		
		scale *= random_range(.8, 1.2);
		
		image_xscale = scale;
		image_yscale = scale;
		
		image_angle = random(360);
		
		if(!is_undefined(color)) {
			image_blend = color;
		}
	}
	
	return _visual;
}