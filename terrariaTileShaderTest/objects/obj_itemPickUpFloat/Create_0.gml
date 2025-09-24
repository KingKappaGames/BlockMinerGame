event_inherited();

image_xscale = 2;
image_yscale = 2;

originX = x;
originY = y;

bobRange = 30;
bobRangeXMult = .3;
bobTimeScale = .12; // over current_time as a direction

xChange = 0;
yChange = 0;

moveSpeed = .1;
speedDecay = .98;

depth -= 10;

pickupType = "pickaxe";
pickupIndex = E_pickaxe.banana;
sprite_index = spr_pickaxeBanana;

explosionPart = global.explosionPart;
glimmerPart = global.itemGlimmerPart;

//pickUp = function() {
	//
//}

// when close enough to be obvious that the player is trying to approach the item lerp the camera towards the item to create a two sided scene, yk what i'm saying?