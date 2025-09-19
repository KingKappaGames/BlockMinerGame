sys = global.sys;
sysUnder = global.sysUnder;
breakPart = global.breakPart; // localizing globals... Hm

cam = view_camera[0];

inWorld = false;

xChange = 0;
yChange = 0;

speedDecay = 1;
speedDecayAir = 1;

horizontalBounce = 0;
verticalBounce = 0;

hitGround = function() { // does various bounce and fall damage related things?
	
}