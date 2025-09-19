sys = global.sys;
breakPart = global.breakPart; // localizing globals... Hm
cam = view_camera[0];

inWorld = false;

xChange = 0;
yChange = 0;

speedDecay = 1;

horizontalBounce = 0;
verticalBounce = 0;

mask_index = spr_pointMask;

hitGround = function() { // does various bounce and fall damage related things?
	
}