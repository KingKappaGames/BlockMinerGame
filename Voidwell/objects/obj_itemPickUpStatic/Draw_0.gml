//shader_set(shd_white); // if hidden behind tiles then no need for shader effect i guess..

//shader_set_uniform_f(shader_get_uniform(shd_white, "alpha"), glowIntensity);

draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, c_white, 1);

//shader_reset();