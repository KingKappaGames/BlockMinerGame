//if (live_call()) return live_result;

//reset all paused things
surface_free(pauseSurface);
buffer_delete(pauseSurfaceBuffer);

//global.gameDifficultySelected = gameDifficultySelected;
//global.gameScreenShakeSelected = gameScreenShakeSelected;
global.gameWindowResolutionSelected = gameWindowResolutionSelected;
global.gameFullscreenSelected = gameFullscreenSelected;
global.gameVsyncSelected = gameVsyncSelected;
global.gameColorFilterSelected = gameColorFilterSelected;

global.gameCameraRotationSelected = gameViewRotationSelected;

global.gameEffectVolume = gameEffectVolume;
global.gameMusicVolume = gameMusicVolume;
global.gameSpecialVolume = gameSpecialVolume;
global.gameAmbientVolume = gameAmbientVolume;

draw_set_font(fnt_gameGeneral); 

script_setPauseState(0);