event_inherited();

source = noone;

image_blend = make_color_rgb(irandom_range(200, 255), irandom_range(200, 255), irandom_range(200, 255)); // lower range

duration = 300 + irandom(120);

depth -= 10;

bounceStrengthGround = .93;

bounceSound = snd_banana;

expire = function() {
	
}