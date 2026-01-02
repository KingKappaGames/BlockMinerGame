if (live_call()) return live_result;

global.cutsceneScreen = id; // gets set to noone upon unpausing!

draw_set_font(fnt_menuText);
//global.soundManager.songStart(snd_BackgroundMenuCrafts, false, 2.4);

cam = view_camera[0];

scale = camera_get_view_width(cam) / 480;

pauseSurface = -1;

startedByManager = false; // whether it was started out of a menu (where it won't have a pause surface and should return to game play half way through last frame instead of holding the frame till the end)

transition = 0.001; // 0 being full origin image, 1 being full goal image

scenePosition = -1;

textProgress = 0;
textProgressMax = 0;
periodStopTime = 0; 
periodStopTimeRef = 3; // character entry attempts to fail after a space (and so delay that many entries) I recommend setting this to 5 VVV

sceneCount = 0;

depth -= 2500;

startTransition = function() {
	transition = 0.001;
	scenePosition++;
	textProgress = 0;
	
	if(scenePosition < sceneCount - 1) {
		textProgressMax = string_length(textList[scenePosition + 1]);
	}
}

setCutscene = function(cutscene) {
	if(cutscene == "intro") {
		spriteList = [spr_introCutscene, spr_introCutscene, spr_introCutscene, spr_introCutscene, spr_introCutscene, spr_introCutscene, spr_introCutscene];
		imageList = [0, 1, 2, 3, 4, 5, 6];
		textList = ["Your life was a simple one, contained in a small pocket of civilization called the Bastion.", "Every day was the same. The tiny city seems to hold you prisoner for your own good.", "Beyond the walls lay chaos. The city was a bastion of order, peace, and light. And so you must stay, or else be lost in the darkness.", "But there is something in the void waiting to be found, and the only way to find it is by getting out. So one day you make your escape, it's not hard. Perhaps they let you go.", "But you're free now, alone... Free to follow the whims of your quickly deteriorating mind.", "You can only think one thing now: Delve to the bottom of the world, to the base of the Voidwell. Find... Find...", "COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN COME DOWN"];
	} else if(cutscene == "boss") {
		spriteList = [spr_introCutscene, spr_introCutscene, spr_introCutscene, spr_introCutscene];
		imageList = [0, 1, 2, 3];
		textList = ["So much power... So much life in darkness.", "But the abyss is still there, it is so empty below you. No amount of power will change that.", "All of this. Your search for answers has brought you no closer to the truth. Only sealed your fate.", "Now you are stuck in the Voidwell, locked out of the Bastion, to become yet another creation of darkness, another victim of forces beyond your comprehension."];
	}
	
	sceneCount = array_length(spriteList);
	textProgressMax = string_length(textList[0]);
}