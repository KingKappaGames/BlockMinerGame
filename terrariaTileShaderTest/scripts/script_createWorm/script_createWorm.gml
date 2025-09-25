function script_createWorm(xx, yy, length, healthSet = length) {
	var _previousSegment = noone;
	var _head = noone;
	
	for(var _i = 0; _i < length; _i++) {
		var _seg = instance_create_layer(xx, yy, "Instances", obj_worm);
		
		if(_i == 0) {
			_head = _seg;
			_seg.sprite_index = spr_wormHead;
			_seg.HealthMax = healthSet;
			_seg.Health = healthSet;
		} else if(_i == length - 1) {
			_seg.sprite_index = spr_wormTail;
			_seg.parent = _previousSegment;
			_previousSegment.child = _seg;
		} else {
			_seg.sprite_index = spr_wormBody;
			_seg.parent = _previousSegment;
			_previousSegment.child = _seg;
		}
		
		_seg.head = _head;
		
		_previousSegment = _seg;
	}
	
	return _head;
}