event_inherited();

shimmerPart = global.radialShimmerPart;

pickupType = "level";
pickupIndex = 0;
sprite_index = spr_starShape;

pickupText = "E : Collect essence"

image_xscale = 1;
image_yscale = 1;

image_angle = 0;

pickUp = function() {
	global.gameInfo.level++;
	
	part_particles_create_color(sys, x, y, explosionPart, #ffffaa, 50);
	
	//sound and particles
	sound_play(snd_chime,,, .08, .08);
	
	instance_destroy();
}