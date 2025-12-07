/**
 * processes the application surface to look like the platonic memory of a old computer screen
 */
function computer_lab_nineteen_eighty_and_six() {
	
    static red_bleed_uniform = shader_get_uniform(color_bleed, "red_bleed");
    static green_bleed_uniform = shader_get_uniform(color_bleed, "green_bleed");
    static blue_bleed_uniform = shader_get_uniform(color_bleed, "blue_bleed");
    static texel_dimension_bleed_uniform = shader_get_uniform(color_bleed, "texel_dimensions");

    static kawase_down_texel_uniform = shader_get_uniform(kawase_down, "texel_dimensions");
    static kawase_down_distance_uniform = shader_get_uniform(kawase_down, "sample_distance");
    
    static kawase_up_texel_uniform = shader_get_uniform(kawase_up, "texel_dimensions");
    static kawase_up_distance_uniform = shader_get_uniform(kawase_up, "sample_distance");
    
    static composite_noise_texture_sampler = shader_get_sampler_index(composite_render, "noise_texture");
    static composite_noise_dimensions_uniform = shader_get_uniform(composite_render, "noise_dimensions");
    static composite_noise_intensity_uniform = shader_get_uniform(composite_render, "noise_intensity");
    static composite_noise_blend_uniform = shader_get_uniform(composite_render, "noise_blend");
    
    static composite_scanline_intensity_uniform = shader_get_uniform(composite_render, "scanline_intensity");
    
    static composite_bleed_texture_sampler = shader_get_sampler_index(composite_render, "bleed_texture");
    static composite_bleed_mix_uniform = shader_get_uniform(composite_render, "bleed_mix");
    
    static composite_surface_dimensions_uniform = shader_get_uniform(composite_render, "surface_dimensions");
	
	static composite_scale_factor_uniform = shader_get_uniform(composite_render, "scale_factor");
	
    static bleed_red_amount = 1;
    static bleed_red_direction = 34;
    
    static bleed_green_amount = 0;
    static bleed_green_direction = 0;
    
    static bleed_blue_amount = 4;
    static bleed_blue_direction = 234;
    
    static bleed_kawase_sample_distance = 0.5;
	
    static abberate_red_amount = 0;
    static abberate_red_direction = 0;
    
    static abberate_green_amount = 2;
    static abberate_green_direction = 189;
    
    static abberate_blue_amount = 0;
    static abberate_blue_direction = 0;
	
	static composite_noise_intensity = 0.170;
    static composite_noise_blend = 0.450;
    static composite_scanline_intensity = 1;
    static composite_bleed_mix = .65;
	
	static composite_scale_factor = 3;
    
    static composite_noise_texture = sprite_get_texture(bluenoise_texture, 0);
	
	
	static ping = undefined;
	static pong = undefined;
	
	var source_width = surface_get_width(ppxSurface);
	var source_height = surface_get_height(ppxSurface);
	
	var half_width = source_width div 2;
	var half_height = source_height div 2;
	
	gpu_set_tex_filter(true);
	gpu_set_tex_repeat(true);
	
	if (surface_exists(ping) == false) {
		ping = surface_create(source_width, source_height);
	}	
	
	if (surface_exists(pong) == false) {
		pong = surface_create(source_width, source_height);
	}
	
	surface_resize(ping, source_width, source_height);
    surface_resize(pong, half_width, half_height);
	
	surface_set_target(ping) {
		
        shader_set(color_bleed);
        shader_set_uniform_f(red_bleed_uniform, -dcos(bleed_red_direction), dsin(bleed_red_direction), bleed_red_amount);
        shader_set_uniform_f(green_bleed_uniform, -dcos(bleed_green_direction), dsin(bleed_green_direction), bleed_green_amount);
        shader_set_uniform_f(blue_bleed_uniform, -dcos(bleed_blue_direction), dsin(bleed_blue_direction), bleed_blue_amount);
        shader_set_uniform_f(texel_dimension_bleed_uniform, 1 / source_width, 1 / source_height);
        
        draw_surface(ppxSurface, 0, 0);
        
        shader_reset();
        
        surface_reset_target();	
		
	}
	
	surface_set_target(pong) {
		
		shader_set(kawase_down);
		
		shader_set_uniform_f(kawase_down_texel_uniform, 1 / half_width, 1 / half_height);
		shader_set_uniform_f(kawase_down_distance_uniform, bleed_kawase_sample_distance);
		
		draw_surface_stretched(ping, 0, 0, half_width, half_height);
		
		shader_reset();

		surface_reset_target();		
		
	}
	
	surface_set_target(ping) {
		
		shader_set(kawase_up);
		
		shader_set_uniform_f(kawase_up_texel_uniform, 1 / source_width, 1 / source_height);
		shader_set_uniform_f(kawase_up_distance_uniform, bleed_kawase_sample_distance);
		
		draw_surface_stretched(pong, 0, 0, source_width, source_height);
		
		shader_reset();

		surface_reset_target();

	}
	
	
	surface_resize(pong, source_width, source_height);
	
	surface_set_target(pong) {
	
        shader_set(color_bleed);
        shader_set_uniform_f(red_bleed_uniform, -dcos(abberate_red_direction), dsin(abberate_red_direction), abberate_red_amount);
        shader_set_uniform_f(green_bleed_uniform, -dcos(abberate_green_direction), dsin(abberate_green_direction), abberate_green_amount);
        shader_set_uniform_f(blue_bleed_uniform, -dcos(abberate_blue_direction), dsin(abberate_blue_direction), abberate_blue_amount);
        shader_set_uniform_f(texel_dimension_bleed_uniform, 1 / source_width, 1 / source_height);
        
        draw_surface(ppxSurface, 0, 0);
        
        shader_reset();
        
        surface_reset_target();	
		
	}
	
	
	surface_set_target(ppxSurface) {
        
        shader_set(composite_render);
        shader_set_uniform_f(composite_surface_dimensions_uniform, source_width, source_height);
        
        texture_set_stage(composite_noise_texture_sampler, composite_noise_texture);
        shader_set_uniform_f(composite_noise_dimensions_uniform, 256, 256);
        shader_set_uniform_f(composite_noise_intensity_uniform, composite_noise_intensity);
        shader_set_uniform_f(composite_noise_blend_uniform, composite_noise_blend);
		shader_set_uniform_f(composite_scale_factor_uniform, composite_scale_factor)
        
        shader_set_uniform_f(composite_scanline_intensity_uniform, composite_scanline_intensity);
        
        texture_set_stage(composite_bleed_texture_sampler, surface_get_texture(ping));
        shader_set_uniform_f(composite_bleed_mix_uniform, composite_bleed_mix);
        
        draw_surface(pong, 0, 0);
        
        shader_reset();
        
        surface_reset_target();   		
		
	}
	
	gpu_set_tex_filter(false);
	gpu_set_tex_repeat(false);
	
}

function computer_lab_nineteen_eighty_and_six_debug(show = false) {
	
	if (show == true) {
	
	    var static_chain = static_get(computer_lab_nineteen_eighty_and_six);
	    dbg_view("i was born in 1986", true);
	    dbg_section("bleed");
	    dbg_slider(ref_create(static_chain, "bleed_red_amount"), 0, 10, "red bleed", 0.5);
	    dbg_slider(ref_create(static_chain, "bleed_red_direction"), 0, 360, "red direction", 1);
	    dbg_slider(ref_create(static_chain, "bleed_green_amount"), 0, 10, "green bleed", 0.5);
	    dbg_slider(ref_create(static_chain, "bleed_green_direction"), 0, 360, "green direction", 1);
	    dbg_slider(ref_create(static_chain, "bleed_blue_amount"), 0, 10, "blue bleed", 0.5);
	    dbg_slider(ref_create(static_chain, "bleed_blue_direction"), 0, 360, "blue direction", 1);
	    dbg_slider(ref_create(static_chain, "bleed_kawase_sample_distance"), 0, 1, "bleed sample distance", 0.1);
	    dbg_section("abberation");
	    dbg_slider(ref_create(static_chain, "abberate_red_amount"), 0, 10, "red abberation", 0.5);
	    dbg_slider(ref_create(static_chain, "abberate_red_direction"), 0, 360, "red direction", 1);
	    dbg_slider(ref_create(static_chain, "abberate_green_amount"), 0, 10, "green abberation", 0.5);
	    dbg_slider(ref_create(static_chain, "abberate_green_direction"), 0, 360, "green direction", 1);
	    dbg_slider(ref_create(static_chain, "abberate_blue_amount"), 0, 10, "blue abberation", 0.5);
	    dbg_slider(ref_create(static_chain, "abberate_blue_direction"), 0, 360, "blue direction", 1);
	    dbg_section("composite");
		dbg_slider_int(ref_create(static_chain, "composite_scale_factor"), 1, 4, "scale factor", 1);
	    dbg_slider(ref_create(static_chain, "composite_noise_intensity"), 0, 1, "noise intensity", 0.001);
	    dbg_slider(ref_create(static_chain, "composite_noise_blend"), 0, 1, "noise blend", 0.001);
	    dbg_slider(ref_create(static_chain, "composite_scanline_intensity"), 0, 1, "scanline intensity", 0.001);
	    dbg_slider(ref_create(static_chain, "composite_bleed_mix"), 0, 1, "bleed mix", 0.001);	
	
	}
	
}

//computer_lab_nineteen_eighty_and_six_debug(true);