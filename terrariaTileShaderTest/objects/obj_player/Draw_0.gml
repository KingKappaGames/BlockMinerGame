draw_sprite_ext(spr_resourceHeldIcons, heldResourceIndex, x + 3 * directionFacing + heldResourceXOff, y - 10 + heldResourceYOff, 1, 1, current_time * .2, tileColors[heldResourceIndex], 1);

draw_sprite_ext(spr_player, 0, x, y, directionFacing, 1, 0, c_white, 1);

draw_sprite_ext(spr_pickaxe, 0, x - 4 * directionFacing, y - 10, 2, 2, pickaxeAngle, c_white, 1);

//draw_circle_color(x, y, 50, c_red, c_red, true);