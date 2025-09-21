function perlin(posX, posY) {
    var _wholeX = floor(posX);
    var _wholeY = floor(posY);
	
	var _decimalX = posX % 1;
	var _decimalY = posY % 1;
	
	random_set_seed(_wholeX * 100000 + _wholeY); // add a seed to this to get level generation seeds, I'm too lazy to do it right now tho
    var _a = random(1);
	random_set_seed((_wholeX + 1) * 100000 + _wholeY);
    var _b = random(1);
	random_set_seed(_wholeX * 100000 + _wholeY + 1);
    var _c = random(1);
	random_set_seed((_wholeX + 1)* 100000 + _wholeY + 1);
    var _d = random(1);

	randomize(); // undo any set seed..

    var _mixX = _decimalX*_decimalX*(3.0-2.0*_decimalX);
    var _mixY = _decimalY*_decimalY*(3.0-2.0*_decimalY);

    return lerp(_a, _b, _mixX) +(_c - _a)* _mixY * (1.0 - _mixX) + (_d - _b) * _mixX * _mixY;
}