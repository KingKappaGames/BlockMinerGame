event_inherited();

radius *= radiusMult;

var _angle = 0;
repeat((radius * .5 + 8) * strength) {
	_angle += 138.508;
	if(materialType == 0) {
		script_breakTileAtPos(x + dcos(_angle) * radius * .9 + irandom_range(-15, 15), y - dsin(_angle) * radius * .9 + irandom_range(-15, 15), .15, false);
	} else {
		script_placeTileAtPos(x + dcos(_angle) * radius * .9 + irandom_range(-15, 15), y - dsin(_angle) * radius * .9 + irandom_range(-15, 15), materialType, true, true);
	}
	
	global.tileManager.updateScreenStatic();
}

if(dealDamage) {
	ds_list_clear(hitList);
	
	collision_circle_list(x, y, radius, obj_creature, false, false, hitList, false);

	var _hitId;
	var _hitX;
	var _hitY;
	for(var _hitI = ds_list_size(hitList) - 1; _hitI >= 0; _hitI--) {
		_hitId = hitList[| _hitI];
		
		_hitX = _hitId.x;
		_hitY = _hitId.y;
		var _distForce = 1 - power(point_distance(x, y, _hitX, _hitY) / radius, 2);
		var _dir = point_direction(x, y, _hitX, _hitY);
		
		_hitId.hit(1, _dir, _distForce, true);
	}
}

duration--;
if(duration <= 0) { 
	//part_particles_create_color(sys, x, y, explosionPart, image_blend, 120);
	
	//audio_play_sound(snd_explosion, 0, 0, 2);
	
	instance_destroy();
}