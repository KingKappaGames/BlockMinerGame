event_inherited();

dirToMouse = point_direction(chestX, chestY, mouse_x, mouse_y);

#region movement checks and forces
if(keyboard_check_released(ord("X"))) {
	if(flying) {
		flying = false;
	} else {
		flying = true;
		yChange -= 1; // you should only be able to fly during nightime or something like that, some kind of thematic use case for flying so that it's more interesting. That or a harsh "fuel" perhaps even some kind of *kill to fuel your flight* kind of model where you have to kill enemies or harvest resources or something.
		y -= 1;
	}
}

if(inWorld) {
	script_moveCollide();
} else {
	x += xChange;
	y += yChange;
}

var _tileInside = inWorld ? max(global.worldTiles[x div tileSize][(y - 1) div tileSize], 0) : 0;

if(_tileInside) {
	if(global.timer % 50 == 0) {
		hit(1);
	}
}

var _tileStanding = inWorld ? max(global.worldTiles[x div tileSize][(y + 1) div tileSize], 0) : 0;

if(!flying) {
	if(keyboard_check(ord("W")) || keyboard_check(vk_space)) {
		if(_tileStanding != 0) {
			yChange = -jumpSpeed;
			_tileStanding = 0;
		}
	}
	
	if(keyboard_check(ord("A"))) {
		if(_tileStanding != 0) {
			xChange -= moveSpeed;
			if(global.timer % 30 == 0) { // if ANY step sound playing then don't play the sound
				audio_play_sound(global.tileStepSounds[_tileStanding], 0, 0);
			}
		} else {
			xChange -= moveSpeedAir;
		}
		
		directionFacing = -1;
		pickaxeAngleBase = 90 + 30 * directionFacing;
	} else if(keyboard_check(ord("D"))) {
		if(_tileStanding != 0) {
			xChange += moveSpeed;
			if(global.timer % 30 == 0) { // if ANY step sound playing then don't play the sound
				audio_play_sound(global.tileStepSounds[_tileStanding], 0, 0);
			}
		} else {
			xChange += moveSpeedAir;
		}
		directionFacing = 1;
		pickaxeAngleBase = 90 + 30 * directionFacing;
	}
} else {
	part_particles_create_color(sys, x + xChange + irandom_range(-2, 2), y + yChange + irandom_range(-2, 2), thickTrailPart, #251030, 1);
	
	if(keyboard_check(ord("A"))) {
		xChange -= moveSpeedFly;
		
		directionFacing = -1;
	}
	if(keyboard_check(ord("D"))) {
		xChange += moveSpeedFly;
		
		directionFacing = 1; // direction facing should be determined by angle of fly not input
	}
	
	if(keyboard_check(ord("W"))) { // if in edge lands just move as in fly mode...
		yChange -= moveSpeedFlyVertical;
	}
	if(keyboard_check(ord("S"))) {
		yChange += moveSpeedFlyVertical * 1.25;
	}
}

if(_tileStanding != 0) {
	xChange *= speedDecay;
	image_angle = 0;
	
	if(flying) {
		flying = false;
	}
} else {
	xChange *= speedDecayAir;
	if(!flying) {
		yChange += grav; // gravity
		yChange *= .995; // tiny bit of falling slow down
	} else {
		yChange *= speedDecayAir;
		
		image_angle += angle_difference(point_direction(0, 0, xChange, yChange - 3.5) - 90, image_angle) * .08;
	}
}

if(flying) { // argggggg flying checks redundant
	chestX = x + dcos(image_angle + 90) * chestOff;
	chestY = y - dsin(image_angle + 90) * chestOff;
} else {
	chestX = x;
	chestY = y - chestOff;
}

audio_listener_set_position(0, x, y, 0);
#endregion

#region item use controls
if(mouse_check_button(mb_left)) {
	directionFacing = sign(mouse_x - chestX);
	if(directionFacing == 0) {
		directionFacing = 1;
	}
	
	if(usingPickaxeNotSpell) {
		if(!flying) {
			if(pickaxeTimer <= 0) {
				if(pickaxeMineTileLine) {
					var _dist = min(point_distance(chestX, chestY, mouse_x, mouse_y), pickaxeRange);
					var _dir = point_direction(chestX, chestY, mouse_x, mouse_y);
					for(var _checkDist = 0; _checkDist < _dist - .1; _checkDist = min(_dist, _checkDist + tileSize * .2)) { // check at intervals up to final pixel of check for blocks to break
						if(miningFunc(chestX + dcos(_dir) * _checkDist, chestY - dsin(_dir) * _checkDist)) {
							break;
						}
					}
					
				} else if(point_distance(chestX, chestY, mouse_x, mouse_y) < pickaxeRange) {
					miningFunc(mouse_x, mouse_y);
				}
				
				pickaxeAngleChange -= directionFacing * 65 * pickaxeSwingAngleAddMult;
					
				pickaxeTimer = pickaxeTimerDelay;
			}
		}
	} else { // spell
		if(spellTimer <= 0) {
			castSpell(mouse_x, mouse_y);
			
			spellXChange = dcos(dirToMouse) * 5.2;
			spellYChange = -dsin(dirToMouse) * 4.4;
			
			spellTimer = spellTimerDelay;
		}
	}
} else if(!flying && mouse_check_button(mb_right)) {
	directionFacing = sign(mouse_x - x);
	if(directionFacing == 0) {
		directionFacing = 1;
	}
	
	if(heldResourceTimer <= 0) {
		if(point_distance(x, y - chestOff, mouse_x, mouse_y) < blockPlacementRange) {
			script_placeTileAtPos(mouse_x, mouse_y, heldResourceIndex);
			
			heldResourceXChange = dcos(dirToMouse) * 5.2;
			heldResourceYChange = -dsin(dirToMouse) * 4.4;
			
			heldResourceTimer = heldResourceTimerDelay;
		}
	}
} else if(mouse_check_button_released(mb_middle)) {
	var _bomb = instance_create_layer(chestX, chestY, "Instances", obj_bananaBomb);
	_bomb.xChange = dcos(dirToMouse) * 3.1 * random_range(.85, 1.2);
	_bomb.yChange = -dsin(dirToMouse) * 3.1 * random_range(.85, 1.2);
}

if(keyboard_check_released(ord("T"))) {
	x = mouse_x;
	y = mouse_y;
	
	if(x < 0 || x >= global.worldSizePixels || y < 0 || y >= global.worldSizePixels) {
		inWorld = false;
	}
}

if(keyboard_check_released(ord("R"))) {
	heldResourceArrayPos = (heldResourceArrayPos + 1) % array_length(heldMaterialsUnlocked);
	heldResourceIndex = heldMaterialsUnlocked[heldResourceArrayPos];
}

if(keyboard_check_released(ord("Q"))) {
	spellArrayPos = (spellArrayPos + 1) % array_length(spellsUnlocked);
	spell = spellsUnlocked[spellArrayPos];
	
	equipSpell();
}

if(keyboard_check_released(vk_shift)) {
	usingPickaxeNotSpell = !usingPickaxeNotSpell; // toggle between pick and spell
}

if(keyboard_check_released(ord("N"))) {
	pickaxeMineTileLine = !pickaxeMineTileLine;
}

pickaxeTimer--;
heldResourceTimer--;
spellTimer--;


if(usingPickaxeNotSpell) {
	pickaxeAngleChange += (pickaxeAngleBase - pickaxeAngle) * pickaxeAngleApproachMult * .02;

	pickaxeAngleChange *= 1 - .15 * pickaxeSpeedDecayMult;
	
	pickaxeAngle += pickaxeAngleChange;
	
	pickaxeAngle = lerp(pickaxeAngle, pickaxeAngleBase, pickAxeFlatApproachMult * .033); // if you'd also like to force the angle along with the acceleration to the goal
} else {
	spellXOff *= .88;
	spellYOff *= .88; // position and speed can both be culled back to 0 to avoid springing and distance/dir calculations (plus the rigid lerp is more arcade-y)
	spellXOff += spellXChange;
	spellYOff += spellYChange;
	spellXChange *= .84;
	spellYChange *= .84;
}

heldResourceXOff *= .88;
heldResourceYOff *= .88; // position and speed can both be culled back to 0 to avoid springing and distance/dir calculations (plus the rigid lerp is more arcade-y)
heldResourceXOff += heldResourceXChange;
heldResourceYOff += heldResourceYChange;
heldResourceXChange *= .84;
heldResourceYChange *= .84;
#endregion

#region camera and screen updates
var _camChange = keyboard_check(vk_subtract) - keyboard_check(vk_add);
if(_camChange != 0) {
	var _camScaleChange = 1 + _camChange * .01;
	camera_set_view_size(cam, clamp(camera_get_view_width(cam) * _camScaleChange, 240, 2560), clamp(camera_get_view_height(cam) * _camScaleChange, 135, 1440));
}

var _mousePush = 3; // inverse
var _goalX = ((x * _mousePush) + mouse_x) / (_mousePush + 1);
var _goalY = ((y * _mousePush) + mouse_y) / (_mousePush + 1)
var _camX = lerp(camera_get_view_x(cam), _goalX - camera_get_view_width(cam) * .5, .05);
var _camY = lerp(camera_get_view_y(cam), _goalY - camera_get_view_height(cam) * .5, .05);

camera_set_view_pos(cam, _camX, _camY);
global.tileManager.updateScreen(_camX, _camY, _camChange != 0);

if(global.timer % 60 == 0) { // delete or disable all far enemies
	script_refreshActivations();
}
#endregion

if(irandom(1000) == 0) {
	instance_create_layer(x, y, "Instances", obj_pixie);
}

if(keyboard_check_released(vk_insert)) {
	script_loadStructure(mouse_x div tileSize, mouse_y div tileSize, "STRUCTUREDATA/exampleStructure.txt");
}