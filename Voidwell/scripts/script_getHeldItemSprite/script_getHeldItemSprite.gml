function script_getHeldItemSprite(itemIndex) {
	if(itemIndex == E_item.none) {
		return spr_box4;
	} else if(itemIndex == E_item.memento) {
		return spr_resourceHeldIcons;
	} else if(itemIndex == E_item.fairySummon) {
		return spr_resourceHeldIcons;
	} else if(itemIndex == E_item.clusterBomb) {
		return spr_resourceHeldIcons;
	} else if(itemIndex == E_item.materialSpray) {
		return spr_resourceHeldIcons;
	} else if(itemIndex == E_item.tremorInducer) {
		return spr_breakerTalisman;
	}
	
	return spr_heart; // no do thisss
}