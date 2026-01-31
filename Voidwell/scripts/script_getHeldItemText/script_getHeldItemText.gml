function script_getHeldItemText(item) {
	if(item == E_item.none) {
		return "Empty handed, unlucky.";
	} else if(item == E_item.clusterBomb) {
		return "A bundle of bombs all bound together, loosely.";
	} else if(item == E_item.fairySummon) {
		return "There's something inside and it wants out. It's indignant.";
	} else if(item == E_item.heartLantern) {
		return "Lovely, lovely. It feels soft, warm.";
	} else if(item == E_item.materialSpray) {
		return "It's so colorful, like a little universe. It wants to be free.";
	} else if(item == E_item.memento) {
		return "This little ribbon feels familiar.";
	} else if(item == E_item.tremorInducer) {
		return "Force of nature in a bottle, watch your head.";
	}
	
	return "Yo text machine broke, check the item get text script son."
}