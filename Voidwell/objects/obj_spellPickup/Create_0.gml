event_inherited();

shimmerPart = global.radialShimmerPart;

pickupType = "spell";
pickupIndex = E_spell.explosiveBolt;
//sprite_index = -1;

//image_xscale = 1;
//image_yscale = 1;

//image_angle = 0;

pickUp = function() {
	var _player = player;
	
	//??
	
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	
	instance_destroy();
}