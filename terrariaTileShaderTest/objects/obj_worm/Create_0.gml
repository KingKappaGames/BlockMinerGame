event_inherited();

HealthMax = 25;
Health = HealthMax;

speedDecay = .97;
speedDecayAir = .98;

moveDir = irandom(360);
moveSpeed = .21;

depth += 5; // go behind tiles.. 

head = noone;

tail = false;

parent = noone;
child = noone;

alive = true;
connected = true;

hit = function(damage, dir = 90, force = 0, destroySegment = false) {
	if(destroySegment) {
		instance_destroy();
	} else {
		if(alive) {
			if(head == id) {
				Health -= damage;
				var _killed = false;
				
				if(Health <= 0) {
					alive = false;
					_killed = true;
				} else {
					hitFlash = 7;
				}
				
				xChange += dcos(dir) * force;
				yChange -= dsin(dir) * force;
				
				var _child = child;
				while(instance_exists(_child)) {
					with(_child) {
						if(_killed) {
							alive = false;
						}
						
						hitFlash = 7;
						_child = child;
					}
				}
			} else { // hitting segment
				if(connected) {
					head.hit(damage, dir, force);
				}
			}
		}
	}
}

die = function() {
	
}