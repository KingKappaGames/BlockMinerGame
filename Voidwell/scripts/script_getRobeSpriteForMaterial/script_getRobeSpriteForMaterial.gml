function script_getRobeSpriteForMaterial(index) {
	if(index == E_tile.empty) {
		return spr_player;
	} else if(index == E_tile.grass) {
		return spr_playerGrass;
	} else if(index == E_tile.diamond) {
		return spr_playerCrystal;
	//} else if(index == E_tile.dirt) {
		//return spr_playerDirt;
	//} else if(index == E_tile.wood) {
		//return spr_playerGrass;
	} else if(index == E_tile.flesh) {
		return spr_playerFlesh;
	} else if(index == E_tile.banana) {
		return spr_playerBanana;
	//} else if(index == E_tile.explosive) {
		//return spr_playerMetal;
	} else if(index == E_tile.metal) {
		return spr_playerMetal;
	//} else if(index == E_tile.stone) {
		//return spr_playerAbyssLord;
	}
	
	return spr_player;
}