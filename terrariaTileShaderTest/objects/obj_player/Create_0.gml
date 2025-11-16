global.player = id;

event_inherited();

audio_listener_set_position(0, x, y, 0);
audio_listener_orientation(0, 1, 0, 0, 0, 1);
audio_falloff_set_model(audio_falloff_linear_distance);

HealthMax = 10;
Health = HealthMax;
healthRegen = 1;

heartCurve = animcurve_get_channel(curve_heartBeat, "val");

knockbackMult = 1;

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

materialWearingType = 0;

depth -= 10;

essential = true;

directionFacing = 1;
dirToMouse = 0;

canFly = false;
canTeleport = false;
canBeInVoid = false;

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
heldMaterialsUnlocked = [1, 2, 3, 4, 5, 6, 7, 8];

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
manaMax = 100;
mana = manaMax;
manaRegen = 3;
spellManaCost = 3;

spellsUnlocked = [E_spell.bolt, E_spell.shockwave];
spellArrayPos = 0;
spell = spellsUnlocked[spellArrayPos];

spellTimer = 0;
spellTimerDelay = 12;

spellXOff = 0;
spellYOff = 0;
spellXChange = 0;
spellYChange = 0;

bombMax = 3;
bombCount = bombMax;

hitGround = function(fallSpeed, tileIndex) {
	if(fallSpeed > 3.5) {
		audio_play_sound(global.tileFallSounds[tileIndex], 0, 0, .35);
		if(fallSpeed > 6) {
			hit((power(fallSpeed - 5, 1.75) - 1) * 2 * global.tileFallDamage[tileIndex]);
			
			audio_play_sound(snd_boneBreak, 0, 0, .5);
		}
	}
}

hit = function(damage = 0, dir, force = 0, destroyBody = false) {
	Health -= damage * (.85 + global.gameDifficultySelected * .15);
	
	audio_play_sound(snd_hit, 0, 0, random_range(.9, 1.15), undefined, random_range(.85, 1.25));
	
	if(Health <= 0) {
		die();
	} else {
		if(force != 0) {
			xChange += dcos(dir) * force;
			yChange -= dsin(dir) * force   + force; // hit in the direction plus a bit up because in 99% of cases that will be nice
		}
		
		hitFlash = 7;
	}
	
	part_particles_create_color(sys, x, y - 10, breakPart, c_maroon, power(damage * .75, 1.5) * 2 + 1);
}

die = function() {
	
	//place robe pickup here
	refreshCondition(true);
	
	if(instance_exists(robePreviousId)) {
		var _previousRobe = robePreviousId;
		setRobe(robePreviousId);
		
		instance_destroy(_previousRobe);
		
		robePreviousId = noone;
	} else {
		setRobe(E_robe.basicPurple,, true);
		
		x = irandom_range(global.worldSizePixels * .33, global.worldSizePixels * .66);
		y = script_findGroundBelow(x, 200, 3, false, 300);
		if(y == -1) {
			y = 1000; 
		}
	}
	
	script_centerCameraOnPlayer();
	
	part_particles_create_color(sys, x, y - 10, breakPart, c_purple, 50);
}

refreshCondition = function(useDifficulty = false) {
	var _difficulty = global.gameDifficultySelected;
	if(useDifficulty && _difficulty != 0) {
		Health = HealthMax * power(.5, _difficulty);
		mana = manaMax * power(.5, _difficulty);
		bombCount = round(bombMax * power(.5, _difficulty));
	} else {
		Health = HealthMax;
		mana = manaMax;
		bombCount = bombMax;
	}
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
	} else if(index == E_pickaxe.cycle) {
		pickaxeSprite = spr_pickaxeCycle;
		pickaxeRange = 40;
		pickaxeTimerDelay = 5;
		miningFunc = script_pickaxeMineNormal;
		
		swingSpeedAddMult = .25;
		angleApproachMult = 0;
		angleFlatApproachMult = 0; // cycle pick be spinning
		angleSpeedDecay = .4;
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

setRobe = function(newRobe, moveToNew = true, useIndex = false, dropOld = true) {
	if(instance_exists(newRobe) || useIndex) {
		if(robeIndex == E_robe.basicPurple) { // removing values based on taken off robe
			
		} else if(robeIndex == E_robe.bananaYellow) {
			removeSpell(E_spell.bananaShimmer);
		} else if(robeIndex == E_robe.superRed) {
			removeSpell(E_spell.explosiveBolt);
		} else if(robeIndex == E_robe.teleporterWhite) {
			
		} else if(robeIndex == E_robe.materialGrass) {
			removeSpell(E_spell.shockwaveMaterial);
			materialWearingType = 0;
		} else if(robeIndex == E_robe.materialCrystal) {
			removeSpell(E_spell.shockwaveMaterial);
			materialWearingType = 0;
		} else if(robeIndex == E_robe.materialFlesh) {
			removeSpell(E_spell.shockwaveMaterial);
			materialWearingType = 0;
		} else if(robeIndex == E_robe.materialMetal) {
			removeSpell(E_spell.shockwaveMaterial);
			materialWearingType = 0;
		}
		
		if(dropOld) {
			robePreviousId = script_createRobePickup(robeIndex, x, y);  // leave behind item pickup for previous (taken off) robe
			if(useIndex) {
				robePreviousId = noone; // if using index then probably you're not moving to an old robe and thus you should be abandoning your current one (eg you died too many times to have this robe still, you needed a "lender" body and thus have lost all bodies and so don't return to this one... Do you get it????)
			}
		}
		
		if(useIndex) {
			robeIndex = newRobe;
		} else {
			robeIndex = newRobe.pickupIndex; // set current index of robe to pick up coming in
		
			if(moveToNew) {
				x = newRobe.x;
				y = newRobe.y;
			}
		}
		
		sprite_index = script_getRobeSprite(robeIndex);
		
		healthRegen = 1;
		manaRegen = 3;
		HealthMax = 10; // defaulting
		manaMax = 100;
		canBeInVoid = false;
		canTeleport = false;
		canFly = false;
		
		jumpSpeed = 3.45;
		moveSpeed = .19;
		
		if(robeIndex == E_robe.basicPurple) { // load new robe values (non defaults)
			
		} else if(robeIndex == E_robe.superRed) {
			HealthMax = 50;
			healthRegen = 4;
			manaRegen = 1;
			manaMax = 100;
			array_push(spellsUnlocked, E_spell.explosiveBolt);
		} else if(robeIndex == E_robe.bananaYellow) {
			array_push(spellsUnlocked, E_spell.bananaShimmer);
		} else if(robeIndex == E_robe.teleporterWhite) {
			canTeleport = true;
			HealthMax = 8;
			healthRegen = .5;
			manaMax = 60;
			knockbackMult = 2;
		} else if(robeIndex == E_robe.materialGrass) {
			HealthMax = 15;
			healthRegen = 2;
			manaMax = 80;
			manaRegen = 4;
			jumpSpeed = 4.25;
			moveSpeed = .21;
			array_push(spellsUnlocked, E_spell.shockwaveMaterial);
			materialWearingType = E_tile.grass;
		} else if(robeIndex == E_robe.materialCrystal) {
			HealthMax = 5;
			healthRegen = .5;
			manaMax = 250;
			manaRegen = 8;
			jumpSpeed = 2.45;
			moveSpeed = .12;
			array_push(spellsUnlocked, E_spell.shockwaveMaterial);
			materialWearingType = E_tile.diamond;
		} else if(robeIndex == E_robe.materialFlesh) {
			HealthMax = 20;
			healthRegen = 4;
			manaMax = 40;
			manaRegen = 2;
			jumpSpeed = 4.15;
			moveSpeed = .20;
			array_push(spellsUnlocked, E_spell.shockwaveMaterial);
			materialWearingType = E_tile.flesh;
		} else if(robeIndex == E_robe.materialMetal) {
			HealthMax = 40;
			healthRegen = 1;
			manaMax = 200;
			manaRegen = 2;
			jumpSpeed = 2.4;
			moveSpeed = .1;
			array_push(spellsUnlocked, E_spell.shockwaveMaterial);
			materialWearingType = E_tile.metal;
		} else if(robeIndex == E_robe.abyssLord) {
			healthRegen = 2;
			manaRegen = 5;
			HealthMax = 25; // defaulting
			manaMax = 200;
		
			jumpSpeed = 4.15;
			moveSpeed = .24;
			
			canFly = true;
			canBeInVoid = true;
		}
		
		mana = min(manaMax, mana);
		Health = min(HealthMax, Health);
	}
}

equipSpell = function() {
	if(spell == E_spell.none) {
		spellTimerDelay = 12;
		spellManaCost = 3;
	} else if(spell == E_spell.bolt) {
		spellTimerDelay = 15;
		spellManaCost = 4;
	} else if(spell == E_spell.shockwave) {
		spellTimerDelay = 70;
		spellManaCost = 25;
	} else if(spell == E_spell.bananaShimmer) {
		spellTimerDelay = 12;
		spellManaCost = 30;
	} else if(spell == E_spell.explosiveBolt) {
		spellTimerDelay = 24;
		spellManaCost = 15;
	} else if(spell == E_spell.shockwaveMaterial) {
		spellTimerDelay = 40;
		spellManaCost = 30;
	}
}

removeSpell = function(index) {
	var _removed = array_get_index(spellsUnlocked, index);
	if(_removed != -1) {
		array_delete(spellsUnlocked, _removed, 1);
	}
	
	
	if(spell == index) { // if removing the spell you're currently holding..
		spell = spellsUnlocked[0];
		spellArrayPos = 0;
	}
}

castSpell = function(targetX, targetY) {
	if(mana > spellManaCost) {
		mana -= spellManaCost * (.9 + .1 * global.gameDifficultySelected);
		
		var _shockwaveType = spell == E_spell.shockwaveMaterial ? materialWearingType : 0;
		var _spell = script_castSpell(spell, chestX + spellXOff, chestY + spellYOff, mouse_x, mouse_y, 1, 1, _shockwaveType);
	}
}

setPickaxe(E_pickaxe.basicRed);