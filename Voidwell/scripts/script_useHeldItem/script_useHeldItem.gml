function script_useHeldItem() {
	if(heldItem != E_item.none) {
		if(heldItem == E_item.memento) {
			script_createShockwaveSpell(mouse_x, mouse_y, 50, 64, 1.06,,,, c_red);
			heldItem = E_item.none;
		} else if(heldItem == E_item.fairySummon) {
			script_spawnCreature(obj_fairyLord, mouse_x, mouse_y);
		} else if(heldItem == E_item.clusterBomb) {
			repeat(12) {
				var _bomb = instance_create_layer(chestX, chestY, "Instances", obj_bomb);
				_bomb.xChange = dcos(dirToMouse) * 7.1 * random_range(.7, 1.3);
				_bomb.yChange = -dsin(dirToMouse) * 7.1 * random_range(.7, 1.3);
				_bomb.duration *= random_range(.7, 2);
			}
		} else if(heldItem == E_item.materialSpray) {
			repeat(21) {
				script_createMovingTile(chestX, chestY, lengthdir_x(7.1 * random_range(.7, 1.35) + random_range(-1, 1), dirToMouse), lengthdir_y(7.1 * random_range(.7, 1.35) + random_range(-1, 1), dirToMouse), irandom(E_tile.tileIndexMax - 1));
			}
		}
	}
}