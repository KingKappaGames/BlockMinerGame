function script_pickaxeMineBanana(xx, yy) {
	if(irandom(2) == 0) {
		if(global.worldTiles[xx div tileSize][yy div tileSize] > 0) {
			script_placeTileAtPos(xx, yy, tileTypes.banana, true);
			
			repeat(irandom_range(2, 4)) {
				var _banana = instance_create_layer((xx + x) * .5, (yy + y) * .5, "Instances", obj_banana); // maybe find a better way to place the things in non stuck tiles..
				_banana.xChange = random_range(-4, 4);
				_banana.yChange = random_range(-4, 4);
			}
			
			audio_play_sound(snd_chime, 1, 0);
		}
		
		return false;
	} else {
		return script_breakTileAtPos(xx, yy); // expand i guess
	}
}