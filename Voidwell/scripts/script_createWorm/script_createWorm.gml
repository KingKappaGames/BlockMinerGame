function script_createWorm(xx, yy, length, healthSet = length, color = undefined, visualType = undefined) {
	var _previousSegment = noone;
	var _head = noone;
	
	color ??= choose("random", "white", "red", "purple");
	
	var _col = 0;
	if(color == "random") {
		_col = 1;
	} else if(color == "red") {
		_col = 2;
	} else if(color == "white") {
		_col = 3;
	} else if(color == "purple") {
		_col = 4;
	}
	
	var _headSpr = spr_wormHead;
	var _bodySpr = spr_wormBody;
	var _tailSpr = spr_wormTail;
	
	var _randomVisualSet = is_undefined(visualType);
	visualType ??= irandom(2);
	if(visualType == 1) {
		_headSpr = spr_wormHeadSmooth;
		_bodySpr = spr_wormBodySmooth;
		_tailSpr = spr_wormTailSmooth;
	} else if(visualType == 2) {
		_headSpr = spr_wormHeadThick;
		_bodySpr = spr_wormBodyThick;
		_tailSpr = spr_wormTailThick;
		
		if(_randomVisualSet) {
			healthSet *= 2;
			length += 6;
		}
	}
	
	for(var _i = 0; _i < length; _i++) {
		var _seg = instance_create_layer(xx, yy, "Instances", obj_worm);
		
		if(_col == 1) {
			_seg.image_blend = c_random;
		} else if(_col == 2) {
			_seg.image_blend = make_color_rgb(160 - _i * 7 + irandom(50), irandom(50), irandom(50));
		} else if(_col == 3) {
			var _rand = irandom(30);
			var _variant = 60 + sin(_i * .7) * 60;
			_seg.image_blend = make_color_rgb(255 - _variant - _rand, 255 - _variant - _rand, 255 - _variant - _rand);
		} else if(_col == 4) {
			_seg.image_blend = make_color_rgb(160 - _i * 8 + irandom(50), irandom(50), 170 - _i * 3 + irandom(50));
		}
		
		if(_i == 0) {
			_head = _seg;
			_seg.sprite_index = _headSpr;
			_seg.HealthMax = healthSet;
			_seg.Health = healthSet;
		} else if(_i == length - 1) {
			_seg.tail = true;
			_seg.sprite_index = _tailSpr;
			_seg.parent = _previousSegment;
			_previousSegment.child = _seg;
		} else {
			_seg.sprite_index = _bodySpr;
			_seg.parent = _previousSegment;
			_previousSegment.child = _seg;
		}
		
		_seg.head = _head;
		
		_previousSegment = _seg;
	}
	
	return _head;
}