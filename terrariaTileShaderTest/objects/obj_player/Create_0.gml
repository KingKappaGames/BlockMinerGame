event_inherited();

global.player = id;

audio_listener_set_position(0, x, y, 0);
audio_listener_orientation(0, 1, 0, 0, 0, 1);
audio_falloff_set_model(audio_falloff_linear_distance);

HealthMax = 10;
Health = HealthMax;
essential = true;

robeIndex = E_robe.basicPurple;
robePreviousId = noone; // id of last robe pick up (the one that's left behind when you assume a new one) to return to when you die ( if you die multiple times it should just keep you in the same robe after the first)

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

essential = true;

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

miningFunc = script_pickaxeMineNormal;

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
spellsUnlocked = [1, 2];
spellArrayPos = 0;
spell = spellsUnlocked[spellArrayPos];

spellTimer = 0;
spellTimerDelay = 12;

spellXOff = 0;
spellYOff = 0;
spellXChange = 0;
spellYChange = 0;

hitGround = function(fallSpeed, tileIndex) {
	if(fallSpeed > 3.5) {
		audio_play_sound(global.tileFallSounds[tileIndex], 0, 0, .25);
		if(fallSpeed > 6) {
			hit((power(fallSpeed - 5, 1.75) - 1) * 2 * global.tileFallDamage[tileIndex]);
			
			audio_play_sound(snd_breakBlockCrystal, 0, 0, .5);
		}
	}
}

hit = function(damage) {
	Health -= damage;
	
	if(Health <= 0) {
		die();
	} else {
		hitFlash = 7;
	}
	
	part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, power(damage * .75, 1.5) * 2 + 1);
}

die = function() {
	//place robe pickup here
	refreshCondition();
	
	if(instance_exists(robePreviousId)) {
		script_createRobePickup(robeIndex, x, y);
		
		var _previousRobe = robePreviousId;
		setRobe(robePreviousId);
		
		instance_destroy(_previousRobe);
		
		robePreviousId = noone;
	} else {
		x = irandom_range(global.worldSizePixels * .33, global.worldSizePixels * .66);
		y = script_findGroundBelow(x, 1500, 5, false, 300);
		if(y == -1) {
			y = 1000; 
		}
	}
	
	//script_centerCameraOnPlayer();
	
	part_particles_create_color(sys, x, y - 10, breakPart, c_purple, 50);
}

refreshCondition = function() {
	Health = HealthMax;
	//other stuff?
}

setPickaxe = function(index, swingSpeedAddMult = undefined, angleApproachMult = undefined, angleFlatApproachMult = undefined, angleSpeedDecay = undefined) {
	pickaxeIndex = index;
	
	if(index == E_pickaxe.basicRed) {
		pickaxeSprite = spr_pickaxe;
		pickaxeRange = 70;
		pickaxeTimerDelay = 24;
		miningFunc = script_pickaxeMineNormal;
	} else if(index == E_pickaxe.blue) {
		pickaxeSprite = spr_pickaxeBlue;
		pickaxeRange = 50;
		pickaxeTimerDelay = 10;
		miningFunc = script_pickaxeMineNormal;
	} else if(index == E_pickaxe.long) {
		pickaxeSprite = spr_pickaxeLong;
		pickaxeRange = 140;
		pickaxeTimerDelay = 90;
		miningFunc = script_pickaxeMineNormal;
	} else if(index == E_pickaxe.banana) {
		pickaxeSprite = spr_pickaxeBanana;
		pickaxeRange = 90;
		pickaxeTimerDelay = 40;
		miningFunc = script_pickaxeMineBanana;
	}
	
	swingSpeedAddMult ??= (24 / pickaxeTimerDelay);
	angleApproachMult ??= sqr(24 / pickaxeTimerDelay);
	angleFlatApproachMult ??= sqr(24 / pickaxeTimerDelay); // attempt to make the adherance animation line up with the speed of swinging..
	angleSpeedDecay ??= (24 / pickaxeTimerDelay);
	
	pickaxeSwingAngleAddMult = swingSpeedAddMult
	pickaxeAngleApproachMult = angleApproachMult;
	pickAxeFlatApproachMult = angleFlatApproachMult;
	pickaxeSpeedDecayMult = angleSpeedDecay;
}

setRobe = function(newRobeId, moveToNew = true) {
	if(instance_exists(newRobeId)) {
		if(robeIndex == E_robe.basicPurple) { // removing values based on taken off robe
			
		} else if(robeIndex == E_robe.bananaYellow) {
			removeSpell(E_spell.bananaShimmer);
		} else {
			
		}
		
		robePreviousId = script_createRobePickup(robeIndex, x, y);  // leave behind item pickup for previous (taken off) robe
		
		robeIndex = newRobeId.robeIndex; // set current index of robe to pick up coming in
		
		if(moveToNew) {
			x = newRobeId.x;
			y = newRobeId.y;
		}
		
		sprite_index = script_getRobeSprite(robeIndex);
		if(robeIndex == E_robe.basicPurple) { // load new robe values
		//} else if(_robeIndex == E_robe.) {
		//} else if(_robeIndex == E_robe.) {
		} else if(robeIndex == E_robe.bananaYellow) {
			array_push(spellsUnlocked, E_spell.bananaShimmer);
		//} else if(_robeIndex == E_robe.) {
			
		} 
		
		// pickup should delete itself when picked up
	}
}

equipSpell = function() {
	if(spell == E_spell.none) {
		spellTimerDelay = 12;
	} else if(spell == E_spell.bolt) {
		spellTimerDelay = 15;
	} else if(spell == E_spell.shockwave) {
		spellTimerDelay = 70;
	} else if(spell == E_spell.bananaShimmer) {
		spellTimerDelay = 12;
	}
}

removeSpell = function(index) {
	array_delete(spellsUnlocked, array_get_index(spellsUnlocked, index), 1);
	
	if(spell == index) { // if removing the spell you're currently holding..
		spell = spellsUnlocked[0];
		spellArrayPos = 0;
	}
}

castSpell = function(targetX, targetY) {
	if(spell == 0)  {
		// none
	} else if(spell == E_spell.bolt) {
		var _castX = x + spellXOff;
		var _castY = y + spellYOff - 10;
		var _dir = point_direction(x + spellXOff, y + spellYOff - 10, targetX, targetY) + irandom_range(-2, 2);
		
		var _spell = instance_create_layer(_castX, _castY, "Instances", obj_magicBolt);
		_spell.xChange = dcos(_dir) * 11.5;
		_spell.yChange = -dsin(_dir) * 11.5;
	} else if(spell == E_spell.shockwave) {
		var _spell = instance_create_layer(mouse_x, mouse_y, "Instances", obj_spellShockwave);
	} else if(spell == E_spell.bananaShimmer) {
		var _castX = x + spellXOff;
		var _castY = y + spellYOff - 10;
		var _dir = point_direction(x + spellXOff, y + spellYOff - 10, targetX, targetY) + irandom_range(-4, 4);
		
		var _bomb = instance_create_layer(_castX, _castY, "Instances", obj_bananaShimmer);
		_bomb.xChange = dcos(_dir) * 3.2;
		_bomb.yChange = -dsin(_dir) * 3.2;
	}
}

setPickaxe(E_pickaxe.basicRed);