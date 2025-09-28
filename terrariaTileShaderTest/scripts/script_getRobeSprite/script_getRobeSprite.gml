function script_getRobeSprite(index) {
	if(index == E_robe.basicPurple) {
		return spr_player;
	} else if(index == E_robe.bananaYellow) {
		return spr_playerBanana;
	} else if(index == E_robe.materialGrass) {
		return spr_player;
	} else if(index == E_robe.teleporterWhite) {
		return spr_playerWhite;
	} else if(index == E_robe.superRed) { // todo the rest of these
		return spr_playerRed;
	}
}