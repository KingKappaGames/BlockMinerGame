if(!flying) {
	draw_sprite_ext(spr_resourceHeldIcons, heldResourceIndex, chestX + 3 * directionFacing + heldResourceXOff, chestY + heldResourceYOff, 1, 1, current_time * .2, heldResourceIndex >= 0 ? global.tileColors[heldResourceIndex] : global.tileColorsDecorative[abs(heldResourceIndex)], 1);
}

event_inherited();

if(usingPickaxeNotSpell) {
	if(!flying) {
		draw_sprite_ext(pickaxeSprite, 0, chestX - 2 * directionFacing, chestY, 1, 1, pickaxeAngle, c_white, 1);
	}
} else {
	draw_sprite_ext(spr_talisman, 0, chestX + 3 * directionFacing + spellXOff, chestY + spellYOff, 1, 1, 60 + dsin(current_time * .15) * 15, c_white, 1);
}

if(pickaxeMineTileLine && pickaxeTimer > 0) {
	var _range = min(point_distance(chestX, chestY, mouse_x, mouse_y), pickaxeRange);
	draw_set_alpha(pickaxeTimer * .01);
	draw_circle_color(chestX + dcos(dirToMouse) * _range, chestY - dsin(dirToMouse) * _range, 2, c_yellow, c_yellow, true);
	draw_set_alpha(1);
}

//draw_text(x, y - 50, Health);

//
//var _id = collision_rectangle(mouse_x - 50, mouse_y - 50, mouse_x + 50, mouse_y + 50, obj_player, false, false);
//
//draw_set_color(instance_exists(_id) ? c_green : c_red);
//
//draw_rectangle(mouse_x - 50, mouse_y - 50, mouse_x + 50, mouse_y + 50, true);
//
//draw_set_color(c_white);