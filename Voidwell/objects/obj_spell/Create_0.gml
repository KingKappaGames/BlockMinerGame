event_inherited();

hitRadius = 5;

hitExclusions = [];
doExclusions = false;
hitCheckAhead = false;

checkHit = function() {
	if(allegiance != E_allegiance.hitNoone) {
		var _hitId = collision_circle(hitCheckAhead ? x + xChange : x, hitCheckAhead ? y + yChange : y, hitRadius, obj_creature, false, false);
		if(instance_exists(_hitId) && source != _hitId && (allegiance != _hitId.allegiance)) {
			if(doExclusions) {
				if(!array_contains(hitExclusions, _hitId)) {
					array_push(hitExclusions, _hitId);
				} else {
					exit;
				}
			} 
			
			hit(_hitId);
		}
	}
}

hit = function(target) {
	target.hit(1, point_direction(0, 0, xChange, yChange), 1.5);
	duration = 0;
}