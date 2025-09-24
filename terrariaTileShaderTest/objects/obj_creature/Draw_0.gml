if(hitFlash > 0) {
	shader_set(shd_white);
	shader_set_uniform_f(shader_get_uniform(shd_white, "alpha"), 1.0);
	
	draw_sprite_ext(sprite_index, image_index, x, y, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);
	
	shader_reset();
	
	hitFlash--; // idk that this is in the draw event this is draw only logic anyway, it'll never affect anything else
} else {
	draw_sprite_ext(sprite_index, image_index, x, y, directionFacing * image_xscale, image_yscale, image_angle, image_blend, image_alpha);
}

draw_text(x, y - 30, hitFlash)