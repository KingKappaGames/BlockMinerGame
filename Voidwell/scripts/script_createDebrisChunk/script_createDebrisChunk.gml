function script_createDebrisChunk(type, xx, yy, xChangeSet, yChangeSet, itemIndex = undefined, visualScaleMin = 1, visualScaleMax = 1, durationSet = 180, spriteOverride = undefined, imageOverride = undefined) {
	var _debris = instance_create_layer(xx, yy, "Instances", type);
	with(_debris) {
		xChange = xChangeSet;
		yChange = yChangeSet;
		
		if(!is_undefined(spriteOverride)) {
			sprite_index = spriteOverride;
		}
		
		if(!is_undefined(imageOverride)) {
			image_index = imageOverride;
		}
		
		var _scale = random_range(visualScaleMin, visualScaleMax);
		
		image_xscale = _scale;
		image_yscale = _scale;
		
		duration = durationSet;
		
		if(!is_undefined(itemIndex)) {
			_debris.item = itemIndex;
			
			if(is_undefined(spriteOverride)) {
				sprite_index = script_getItemDebrisSprite(itemIndex);
			}
		}
	}
	
	return _debris;
}