event_inherited();

shimmerPart = global.radialShimmerPart;

pickupType = "robe";
pickupIndex = E_robe.basicPurple;
sprite_index = script_getRobeSprite(pickupIndex);

image_xscale = 1;
image_yscale = 1;

image_angle = 0;

pickUp = function() {
	var _player = player;

	_player.setRobe(id);
	
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	
	instance_destroy();
}