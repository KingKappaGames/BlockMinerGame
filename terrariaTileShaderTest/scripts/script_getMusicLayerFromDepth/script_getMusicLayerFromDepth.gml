function script_getMusicLayerFromDepth(worldDepth) {
	var _layer = 0;
	
	with(global.manager) {
		for(var _i = 0; _i < E_musicLayer.musicLayerCount; _i++) {
			if(worldDepth < musicDepthRef[_i]) {
				return _i;
			}
		}
	}
	
	return E_musicLayer.musicLayerCount - 1;
}