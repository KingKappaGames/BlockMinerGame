event_inherited();

bloodSpurtPart = global.bloodSpurt;
radialGlimmer = global.radialShimmerPart;

source = noone;
sourceOffX = 0;
sourceOffY = 0;

HealthMax = 5;
Health = HealthMax;

knockbackMult = 1;

speedDecay = .8;
speedDecayAir = .97;

moveDir = irandom(360);
moveSpeed = .21;

material = E_tile.dirt;
sprite_index = spr_tileBanana;
image_index = 0;

depth -= 5;

hit = function(damage, dir = 0, force = 0, destroyBody = false) {
	if(alive) {
		Health -= damage;
		
		if(Health <= 0) {
			die();
		} else {
			hitFlash = 5;
		}
		
		audio_play_sound(snd_hit, 0, 0, random_range(.85, 1.25), undefined, random_range(1.2, 2.1));
		
		xChange += dcos(dir) * force * knockbackMult;
		yChange -= dsin(dir) * force * knockbackMult;
	}
	
	//knockdown
}

die = function() {
	audio_play_sound_at(snd_bugDie, x, y, 0, audioRefMedium, audioMaxMedium, 1, 0, 0, 1,, random_range(.9, 1.1));
	
	script_createBlockParticles(material, x, y);
	
	repeat(3) {
		var _debris = instance_create_layer(x, y, "Instances", obj_bouncingDebris);
		_debris.xChange = random_range(-5, 5) + random_range(-5, 5);
		_debris.yChange = random_range(-5, 5) + random_range(-5, 5);
	}

	instance_destroy();	
	
	//uh, then what?
}