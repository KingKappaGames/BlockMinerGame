event_inherited();

global.player = id;

timer = 0;

trailPart = global.thickTrail;

audio_listener_set_position(0, x, y, 0);
audio_listener_orientation(0, 1, 0, 0, 0, 1);
audio_falloff_set_model(audio_falloff_linear_distance);

x = spawnX;
y = spawnY; // spawn middle

chestOff = 9;
chestX = x;
chestY = y - chestOff;

flying = false; // whether the player is flying around or walking/jumping

jumpSpeed = 3.3;
moveSpeed = .19;
moveSpeedAir = .1;
moveSpeedFly = .21;
moveSpeedFlyVertical = .17;

speedDecay = .91;
speedDecayAir = .96;
speedDecayFly = .94;

depth -= 10;

directionFacing = 1;

usingPickaxeNotSpell = true; // bool to use pickaxe "instead" of spell, aka toggle between those two based on this

//pickaxe values
pickaxeSprite = spr_pickaxe;
pickaxeRange = 80;

pickaxeAngleBase = 90 + 30 * directionFacing;
pickaxeAngle = pickaxeAngleBase;
pickaxeAngleChange = 0;

pickaxeTimer = 0;
pickaxeTimerDelay = 24;

//held material/block values
heldMaterialsUnlocked = [1, 2, 3, 4];

heldResourceArrayPos = 0;
heldResourceIndex = heldMaterialsUnlocked[heldResourceArrayPos];
blockPlacementRange = 105; // blocks

heldResourceTimer = 0;
heldResourceTimerDelay = 12;

heldResourceXOff = 0;
heldResourceYOff = 0;
heldResourceXChange = 0;
heldResourceYChange = 0;

//spell values
spell = 4; // ineex, struct, global values?..

spellTimer = 0;
spellTimerDelay = 12;

spellXOff = 0;
spellYOff = 0;
spellXChange = 0;
spellYChange = 0;

camera_set_view_pos(cam, x - camera_get_view_width(cam) * .5, y - camera_get_view_height(cam) * .5);



hitGround = function(fallSpeed) {
	if(fallSpeed > 3.5) {
		audio_play_sound(snd_explosion, 0, 0, .25);
		if(fallSpeed > 6) {
			takeDamage(fallSpeed);
			audio_play_sound(snd_breakBlockCrystal, 0, 0, .5);
		}
	}
}

takeDamage = function(damage) {
	part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, power(damage * .6, 1.5) * 2);
}

setPickaxe = function(sprite) {
	pickaxeSprite = sprite;
	pickaxeRange = 80;
	pickaxeTimerDelay = 24;
}

castSpell = function(targetX, targetY) {
	var _castX = x + spellXOff;
	var _castY = y + spellYOff - 10;
	var _dir = point_direction(x + spellXOff, y + spellYOff - 10, targetX, targetY);
	
	var _bomb = instance_create_layer(_castX, _castY, "Instances", obj_bomb);
	_bomb.xChange = dcos(_dir) * 6.9;
	_bomb.yChange = -dsin(_dir) * 6.9;
}