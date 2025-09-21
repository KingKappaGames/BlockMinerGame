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

jumpSpeed = 3.45;
moveSpeed = .19;
moveSpeedAir = .11;
moveSpeedFly = .21;
moveSpeedFlyVertical = .17;

speedDecay = .91;
speedDecayAir = .96;
speedDecayFly = .94;

depth -= 10;

directionFacing = 1;
dirToMouse = 0;

usingPickaxeNotSpell = true; // bool to use pickaxe "instead" of spell, aka toggle between those two based on this

//pickaxe values
pickaxeMineTileLine = false;

pickaxeSprite = spr_pickaxe;
pickaxeRange = 60;

pickaxeAngleBase = 90 + 30 * directionFacing;
pickaxeAngle = pickaxeAngleBase;
pickaxeAngleChange = 0;

pickaxeSwingAngleAddMult = 1;
pickaxeAngleApproachMult = 1;
pickaxeSpeedDecayMult = 1;
pickAxeFlatApproachMult = 1;

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
spellsUnlocked = [1, 2, 3, 4];
spellArrayPos = 0;
spell = spellsUnlocked[spellArrayPos];

spellTimer = 0;
spellTimerDelay = 12;

spellXOff = 0;
spellYOff = 0;
spellXChange = 0;
spellYChange = 0;

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

setPickaxe = function(sprite, range, delay, swingSpeedAddMult = undefined, angleApproachMult = undefined, angleFlatApproachMult = undefined, angleSpeedDecay = undefined) {
	pickaxeSprite = sprite;
	pickaxeRange = range;
	pickaxeTimerDelay = delay;
	
	swingSpeedAddMult ??= (24 / delay);
	angleApproachMult ??= sqr(24 / delay);
	angleFlatApproachMult ??= sqr(24 / delay); // attempt to make the adherance animation line up with the speed of swinging..
	angleSpeedDecay ??= (24 / delay);
	
	pickaxeSwingAngleAddMult = swingSpeedAddMult
	pickaxeAngleApproachMult = angleApproachMult;
	pickAxeFlatApproachMult = angleFlatApproachMult;
	pickaxeSpeedDecayMult = angleSpeedDecay;
}

equipSpell = function() {
	if(spell == spells.none) {
		spellTimerDelay = 12;
	} else if(spell == spells.bolt) {
		spellTimerDelay = 15;
	} else if(spell == spells.shockwave) {
		spellTimerDelay = 70;
	} else if(spell == spells.hold1) {
		spellTimerDelay = 12;
	}
}

castSpell = function(targetX, targetY) {
	if(spell == 0)  {
		// none
	} else if(spell == spells.bolt) {
		var _castX = x + spellXOff;
		var _castY = y + spellYOff - 10;
		var _dir = point_direction(x + spellXOff, y + spellYOff - 10, targetX, targetY);
		
		var _spell = instance_create_layer(_castX, _castY, "Instances", obj_magicBolt);
		_spell.xChange = dcos(_dir) * 11.5;
		_spell.yChange = -dsin(_dir) * 11.5;
	} else if(spell == spells.shockwave) {
		var _spell = instance_create_layer(mouse_x, mouse_y, "Instances", obj_spellShockwave);
	} else if(spell == spells.shockwave + 1) {
		var _castX = x + spellXOff;
		var _castY = y + spellYOff - 10;
		var _dir = point_direction(x + spellXOff, y + spellYOff - 10, targetX, targetY);
		
		var _bomb = instance_create_layer(_castX, _castY, "Instances", obj_bomb);
		_bomb.xChange = dcos(_dir) * 6.9;
		_bomb.yChange = -dsin(_dir) * 6.9;
	}
}