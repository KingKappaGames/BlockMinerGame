event_inherited();

pickUp = function() {
	var _player = player;
	
	_player.setHeldItem(pickupIndex);
	
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	
	instance_destroy();
}