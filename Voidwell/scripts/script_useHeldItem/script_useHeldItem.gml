function script_useHeldItem() {
	if(heldItem != E_item.none) {
		heldItemTimer = heldItemTimerMax;
		heldItemActiveGlowTimer = 20;
		
		if(heldItem == E_item.memento) {
			heldItemActiveGlowTimer = 60;
			
			script_createShockwaveSpell(mouse_x, mouse_y, 90, 64, 1.014,, .3,, c_red);
			setHeldItem(E_item.none);
		} else if(heldItem == E_item.fairySummon) {
			script_spawnCreature(obj_fairyLord, global.player.x, global.player.y - 320);
			
			setHeldItem(E_item.none);
		} else if(heldItem == E_item.striderSummon) {
			script_spawnCreature(obj_striderLord, global.player.x + choose(-300, 300), global.player.y - 200);
			
			setHeldItem(E_item.none);
		} else if(heldItem == E_item.amalgamSummon) {

			script_createConglomerate(global.player.x + choose(-200, 200), global.player.y - 300, 40);
			
			setHeldItem(E_item.none);
		} else if(heldItem == E_item.clusterBomb) {
			repeat(12) {
				var _bomb = script_createBomb(chestX, chestY, dirToMouse + random_range(-6, 6), random_range(5, 9), irandom_range(210, 360));
			}
		} else if(heldItem == E_item.materialSpray) {
			repeat(21) {
				script_createMovingTile(chestX, chestY, lengthdir_x(7.1 * random_range(.7, 1.35), dirToMouse) + random_range(-1, 1), lengthdir_y(7.1 * random_range(.7, 1.35), dirToMouse) + random_range(-1, 1), irandom(E_tile.tileIndexMax - 1));
			}
		} else if(heldItem == E_item.tremorInducer) {
			heldItemActiveGlowTimer = 120;
			
			audio_play_sound(snd_chime, 0, 0, .18);
			
			script_createTremor(x, y, irandom_range(240, 600), 1, true);
		} else if(heldItem == E_item.heartLantern) {
			heldItemActiveGlowTimer = 45;
			
			audio_play_sound(snd_breakBlockMetal, 0, 0, .4);
			
			var _item = instance_create_layer(chestX, chestY, "Instances", obj_heartVortex);
				_item.xChange = dcos(dirToMouse) * 1.6 * random_range(.9, 1.1);
				_item.yChange = -dsin(dirToMouse) * 1.6 * random_range(.9, 1.1);
		}
	}
}