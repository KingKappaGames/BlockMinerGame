function script_getSongAtLayer(layer) { // don't repeat but that implies there's more than one song and i'm not sure that's true lol
	if(layer == E_musicLayer.sky) {
		return choose(snd_chime, snd_chime);
	} else if(layer == E_musicLayer.surface) {
		return choose(snd_musicSurfaceChimey, snd_musicSurfaceChimey);
	} else if(layer == E_musicLayer.underground) { 
		return choose(snd_musicUndergroundSpaceGame, snd_musicUndergroundSpaceGame);
	} else if(layer == E_musicLayer.abyssCeiling) { 
		return choose(snd_musicAbyssTop, snd_musicAbyssTop);
	} else if(layer == E_musicLayer.abyssDepths) { 
		return choose(snd_musicDeepAbyss, snd_musicDeepAbyss);
	}
}