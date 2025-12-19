function script_createConglomerate(xx, yy, pieces, healthSetMult = 1, material = undefined) {
	material ??= irandom(E_tile.tileIndexMax);
	
	var _initial = undefined;
	
	var _creationProgress = 0;
	var _scale = 0;
	var _placementDist = 0;
	var _dir = 0;
	
	for(var _i = 0; _i < pieces; _i++) {
		_creationProgress = _i / pieces;
		_scale = 3 * (1 - _creationProgress) + 1;
		_placementDist = irandom_range(_creationProgress * 15 + 5, _creationProgress * 40 + 10);
		_dir = random(360);
		
		var _part = script_spawnCreature(obj_conglomerateBoss, xx + lengthdir_x(_placementDist, _dir), yy + lengthdir_y(_placementDist, _dir),, choose(-1, 1));
		
		with(_part) {
			sprite_index = global.tileSprites[material];
			image_speed = 0;
			image_blend = global.tileColors[material];
			
			image_xscale = _scale;
			image_yscale = _scale;
			
			Health *= _scale;
			HealthMax *= _scale;
			
			sourceOffX = x - xx;
			sourceOffY = y - yy;
			
			if(is_undefined(_initial)) {
				_initial = id; // store the initial
				image_xscale *= 1.5;
				image_yscale *= 1.5;
				Health *= 2;
				HealthMax *= 2;
			} else {
				var _x = x;
				
				x += 100000;
			
				source = instance_nearest(_x, y, obj_conglomerateBoss);
				
				x -= 100000;
			}
		}
	}
	
	return _initial;
}