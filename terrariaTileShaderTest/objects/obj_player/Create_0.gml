event_inherited();

global.player = id;

x = tileRangeWorld * tileSize * .5;
y = tileRangeWorld * tileSize * .5; // spawn middle

jumpSpeed = 3.3;
moveSpeed = .21;
speedDecay = .89;

depth -= 10;

directionFacing = 1;

reachRange = 90;

pickaxeAngleBase = 90 + 30 * directionFacing;
pickaxeAngle = pickaxeAngleBase;
pickaxeAngleChange = 0;

clickTimer = 0;
clickTimerDelay = 24;

heldResourceIndex = 4;

heldResourceXOff = 0;
heldResourceYOff = 0;

heldResourceXChange = 0;
heldResourceYChange = 0;

camera_set_view_pos(cam, x - camera_get_view_width(cam) * .5, y - camera_get_view_height(cam) * .5);

global.tileManager.updateScreen();

hitGround = function(fallSpeed) {
	if(fallSpeed > 3) {
		audio_play_sound(snd_explosion, 0, 0, .25);
		if(fallSpeed > 6) {
			takeDamage(fallSpeed);
			audio_play_sound(snd_breakBlockCrystal, 0, 0, .5);
		}
	}
}

takeDamage = function(damage) {
	part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, power(damage, 1.5) * 2);
}