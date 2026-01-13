enum E_spell {
	none = 0,
	bolt = 1,
	shockwave = 2,
	bananaShimmer = 3,
	explosiveBolt = 4,
	shockwaveMaterial = 5,
	streamer = 6,
	balista = 7,
	bouncyBolt = 8,
	laser = 9,
}

enum E_robe {
	basicPurple = 0,
	superRed = 1,
	teleporterWhite = 2,
	bananaYellow = 3,
	materialGrass = 4,
	materialCrystal = 5,
	materialFlesh = 6, 
	materialMetal = 7,
	abyssLord = 8
}

enum E_pickaxe {
	basicRed = 0,
	blue = 1,
	long = 2,
	banana = 3,
	cycle = 4
}

enum E_tile { // ideas, meat, bones, black crystal, hot lava rock, explosiveSomething?, smooth granite, bookBlock (block of books yes), toad block (yeah), 
	decMushroom = -3,
	decRock = -2,
	decGrass = -1,
	empty = 0,
	grass = 1,
	diamond = 2,
	dirt = 3,
	wood = 4,
	flesh = 5,
	banana = 6,
	explosive = 7,
	metal = 8,
	stone = 9,
	deepStone = 9,
	tileIndexMax
}

enum E_biome {
	surface, 
	underground,
	depths,
	sky,
	biomeStructure1,
	biomeStructure2,
	biomeStructure3,
}

enum E_musicLayer {
	sky = 0,
	surface = 1,
	underground = 2,
	abyssCeiling = 3,
	abyssDepths = 4,
	musicLayerCount = 5
}

enum E_item {
	none = 0,
	memento,
	fairySummon,
	clusterBomb,
	materialSpray,
	tremorInducer,
	itemCount,
}