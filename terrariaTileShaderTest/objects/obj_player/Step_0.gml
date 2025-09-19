event_inherited();

#region item use controls
if(mouse_check_button_released(mb_left)) {
	if(clickTimer == 0) {
		if(point_distance(x, y, mouse_x, mouse_y) < reachRange) {
			script_breakTileAtPos(mouse_x, mouse_y);
			
			pickaxeAngleChange -= directionFacing * 40;
			
			clickTimer = clickTimerDelay;
		}
	}
} else if(mouse_check_button_released(mb_right)) {
	if(point_distance(x, y, mouse_x, mouse_y) < reachRange) {
		if(script_isTileEmpty(mouse_x, mouse_y, true)) {
			script_placeTileAtPos(mouse_x, mouse_y, heldResourceIndex);
			
			var _dirToMouse = point_direction(x, y, mouse_x, mouse_y);
			heldResourceXChange = dcos(_dirToMouse) * 5.2;
			heldResourceYChange = -dsin(_dirToMouse) * 4.4;
		}
	}
} else if(mouse_check_button_released(mb_middle)) {
	var _dirToMouse = point_direction(x, y, mouse_x, mouse_y);
	var _bomb = instance_create_layer(x, y - 10, "Instances", obj_bomb);
	_bomb.xChange = dcos(_dirToMouse) * 4.4;
	_bomb.yChange = -dsin(_dirToMouse) * 4.4;
}

if(keyboard_check_released(ord("T"))) {
	x = mouse_x;
	y = mouse_y;
	
	if(x < 0 || x > tileRangeWorld * tileSize - 1 || y < 0 || y > tileRangeWorld * tileSize - 1) {
		inWorld = false;
	}
}

if(keyboard_check_released(ord("R"))) {
	heldResourceIndex++;
	if(heldResourceIndex > 4) {
		heldResourceIndex = 1;
	}
}

if(clickTimer > 0) {
	clickTimer--;
}

pickaxeAngleChange += (pickaxeAngleBase - pickaxeAngle) * .015;

pickaxeAngleChange *= .85;

pickaxeAngle += pickaxeAngleChange;
pickaxeAngle = lerp(pickaxeAngle, pickaxeAngleBase, .03); // if you'd also like to force the angle along with the acceleration to the goal

heldResourceXOff *= .88;
heldResourceYOff *= .88; // position and speed can both be culled back to 0 to avoid springing and distance/dir calculations (plus the rigid lerp is more arcade-y)
heldResourceXOff += heldResourceXChange;
heldResourceYOff += heldResourceYChange;
heldResourceXChange *= .84;
heldResourceYChange *= .84;
#endregion

if(keyboard_check(ord("A"))) {
	xChange -= moveSpeed;
	
	directionFacing = -1;
	pickaxeAngleBase = 90 + 30 * directionFacing;
}

if(keyboard_check(ord("D"))) {
	xChange += moveSpeed;
	directionFacing = 1;
	pickaxeAngleBase = 90 + 30 * directionFacing;
}

if(inWorld) {
	if(keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_space)) {
		var _tileStanding = global.worldTiles[x div tileSize][(y + 1) div tileSize];
		if(_tileStanding != 0) {
			yChange -= jumpSpeed;
		}
	}
	
	
	#region movement checks and forces
	yChange += grav; // gravity
	
	script_moveCollide();
} else {
	if(keyboard_check(ord("W"))) { // if in edge lands just move as in fly mode...
		yChange -= moveSpeed;
	}
	if(keyboard_check(ord("S"))) {
		yChange += moveSpeed;
	}
	
	x += xChange;
	y += yChange;
}


xChange *= speedDecay;
#endregion

#region camera and screen updates
var _mousePush = 3; // inverse
var _goalX = ((x * _mousePush) + mouse_x) / (_mousePush + 1);
var _goalY = ((y * _mousePush) + mouse_y) / (_mousePush + 1)
var _camX = lerp(camera_get_view_x(cam), _goalX - camera_get_view_width(cam) * .5, .05);
var _camY = lerp(camera_get_view_y(cam), _goalY - camera_get_view_height(cam) * .5, .05);

camera_set_view_pos(cam, _camX, _camY);
global.tileManager.updateScreen(_camX, _camY);
#endregion