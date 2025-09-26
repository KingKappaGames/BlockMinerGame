if(global.timer % 270 == 180) {
	var _shockwave = script_createShockwaveSpell(x, y, shockwaveDuration,, radiusExpand, 0, .7 * strengthMult);
} else if(global.timer % 270 == 0) {
	var _shockwave = script_createShockwaveSpell(x, y, shockwaveDuration,, radiusExpand, materialType, .35 * strengthMult, false);
}

part_particles_create_color(sys, x + irandom_range(-21, 21), y + irandom_range(-21, 21), breakPart, image_blend, 15);

var _dir = irandom(360);
var _dist = irandom(270);

part_particles_create_color(sys, x + dcos(_dir) * _dist, y - dsin(_dir) * _dist, thickTrailPart, image_blend, 1);

if(irandom(300) == 0) {
	script_placeTileAtPos(x + dcos(_dir) * _dist, y - dsin(_dir) * _dist, materialType, true);
}