function scr_getHeldItemTimer(index) {
	var _timer = 0;
	
	if(index == E_item.clusterBomb) {
		_timer = 3600;
	} else if(index == E_item.fairySummon) {
		_timer = 0;
	} else if(index == E_item.heartLantern) {
		_timer = 3600;
	} else if(index == E_item.materialSpray) {
		_timer = 900;
	} else if(index == E_item.memento) {
		_timer = 0;
	} else if(index == E_item.tremorInducer) {
		_timer = 2400;
	}
	
	return _timer;
}