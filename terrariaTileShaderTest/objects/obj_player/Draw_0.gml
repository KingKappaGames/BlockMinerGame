if(!flying) {
	draw_sprite_ext(spr_resourceHeldIcons, heldResourceIndex, chestX + 3 * directionFacing + heldResourceXOff, chestY + heldResourceYOff, 1, 1, current_time * .2, tileColors[heldResourceIndex], 1);
}

draw_sprite_ext(sprite_index, image_index, x, y, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);

if(usingPickaxeNotSpell) {
	if(!flying) {
		draw_sprite_ext(pickaxeSprite, 0, chestX - 2 * directionFacing, chestY, 2, 2, pickaxeAngle, c_white, 1);
	}
} else {
	draw_sprite_ext(spr_talisman, 0, chestX + 3 * directionFacing + spellXOff, chestY + spellYOff, 1, 1, 60 + dsin(current_time * .15) * 15, c_white, 1);
}

//draw_circle_color(chestX, chestY, 4, c_red, c_red, true);

//
//var _id = collision_rectangle(mouse_x - 50, mouse_y - 50, mouse_x + 50, mouse_y + 50, obj_player, false, false);
//
//draw_set_color(instance_exists(_id) ? c_green : c_red);
//
//draw_rectangle(mouse_x - 50, mouse_y - 50, mouse_x + 50, mouse_y + 50, true);
//
//draw_set_color(c_white);