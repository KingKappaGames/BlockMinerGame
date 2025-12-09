event_inherited();

var _hitCount = collision_line_list(x, y, x + lengthdir_x(lengthMax, directionLaser), y + lengthdir_y(lengthMax, directionLaser), obj_creature, false, false, hits, false);

for(var _i = _hitCount - 1; _i >= 0; _i--) {
	var _hit = hits[| _i];
	
	if(_hit != source) {
		if(instance_exists(_hit)) {
			if(!array_contains(hitsBlacklist, _hit)) {
				array_push(hitsBlacklist, _hit);
				
				_hit.hit(damageBase, directionLaser, knockbackBase);
			}
		}
	}
}

ds_list_clear(hits);

hitTimer--;
if(hitTimer <= 0) {
	hitsBlacklist = [];
	
	hitTimer = hitTimerMax;
}

duration--;
if(duration <= 0) {
	instance_destroy();
}