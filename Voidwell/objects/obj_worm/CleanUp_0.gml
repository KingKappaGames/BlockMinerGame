if(connected) {
	var _child = child;
	var _chain = 1;
	while(instance_exists(_child)) {
		with(_child) {
			hitFlash = 11;
			connected = false;
			alive = false;
			_child = child;
		}
		
		_chain++;
	}
	
	if(instance_exists(head)) {
		head.hit(_chain * 2, 0, 0);
	}
}

if(instance_exists(parent)) {
	parent.child = noone;
}

if(instance_exists(child)) {
	child.parent = noone;
}

// break the refs on either side