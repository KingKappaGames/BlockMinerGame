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
		spriteList = [spr_introCutscene, spr_introCutscene, spr_introCutscene, spr_introCutscene, spr_introCutscene];
		imageList = [0, 1, 2, 3, 4];
		textList = ["From the very beginning you were interested in secrets. You wondered from an early age about the city, life, death, and the abyss.", "It was difficult, and as the years went on it took more and more to keep your mind from breaking.", "Beyond the walls lay chaos. The city was a bastion of order, peace, and light; standing above chaos.", "But there is something in the void. The voices are savage, loving, meaningless, and truth. You can hear them. Every second. Of every day.", "One may be borne from nothing, and the world may return them to nothing. Blood grants you passage, passage beyond; in chains; their blood, precious exile."];                                        
	} else if(cutscene == "boss") {
		spriteList = [spr_introCutscene, spr_introCutscene, spr_introCutscene, spr_introCutscene];
		imageList = [0, 1, 2, 3];
		textList = ["So much power... So much life in darkness.", "But the abyss is still there, there is no satisfaction here.", "All of this. Everything that has ever happened has been crawling away from chaos.", "Even you. No, that is not enough. You ran towards the abyss. Entered by force... You never learn."];
	}
	
	sceneCount = array_length(spriteList);
	textProgressMax = string_length(textList[0]);
}