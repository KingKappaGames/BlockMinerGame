function scr_getHeldItemTimer(index) {
	var _timer = 0;
	
	if(index == E_item.clusterBomb) {
		_timer = 3200;
	} else if(index == E_item.fairySummon) {
		_timer = 0;
	} else if(index == E_item.heartLantern) {
		_timer = 2400;
	} else if(index == E_item.materialSpray) {
		_timer = 600;
	} else if(index == E_item.memento) {
		_timer = 0;
	} else if(index == E_item.tremorInducer) {
		_timer = 1800;
	}
	
	return _timer;
}