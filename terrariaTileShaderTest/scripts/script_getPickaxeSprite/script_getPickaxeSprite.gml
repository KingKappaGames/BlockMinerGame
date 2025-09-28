function script_getPickaxeSprite(index) {
	if(index == E_pickaxe.basicRed) {
		return spr_pickaxe;
	} else if(index == E_pickaxe.banana) {
		return spr_pickaxeBanana;
	} else if(index == E_pickaxe.blue) { // todo the rest of these
		return spr_pickaxeBlue;
	} else if(index == E_pickaxe.long) { // todo the rest of these
		return spr_pickaxeLong;
	}
}