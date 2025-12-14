event_inherited();

sprite_index = spr_book;

shimmerPart = global.radialShimmerPart;

bubbleInfo = ["All interactions in this game will be on the E key, the accept key is shown at the bottom of this box. Wasd to move, space/w to jump. Now, on to the proper intro:", "(Press f1 to spawn the fairy boss! (if or when you want) It's quite hard but pretty fun.)", "This is a manual written by past explorers, or as we call ourselves, fools. It will reappear over your head every time you enter the world. Just in case.", "It may help you survive here, like it helped us, for a time.", "First things first, you must know how to cast spells.", "Click the left mouse button to cast a spell at the cursor.", "Very good. Second, any good pursuer of the Voidwell should know how to mould matter to their will.", "Press the right mouse button to create a block at your cursor.", "Thirdly, you aught to have some bombs with you. Press middle mouse button to throw a bomb towards your cursor.", "There's that pickaxe too, press shift to \"shift\" (get it?) to your other item, be that pickaxe or talisman, for casting spells.", "When holding the pickaxe click left mouse to mine the block under your cursor.", "When holding your talisman press Q to switch which spell you want to cast, you can see this in the top left, inside the purple orb", "That icon is your spell, learn the icons. The amount of mana you have is shown by that orb, by the way. It comes back over time but be careful not to run out when you need it most.", "You can change the material type you're holding by hitting R, cycling your possessed materials", "These are infinite, you control the world down here, use it well.", "Lastly, if you press N you will toggle auto mining. This lets you mine wherever you're aiming without having to directly target the block.", "WIP, but have fun. You will need it, so good luck. Go find the boss at the bottom of the world now, pumpkin."];
state = 0;

criteria = array_create(array_length(bubbleInfo), ord("E"));

textBubble = noone;

active = false;

pickUpRange = 64;

pickUp = function() {
	activate();
}

activate = function() {
	active = true;
	available = false;
	
	sprite_index = spr_bookOpen;
	
	state = 0;
	createTextPanel();
}

deactivate = function() {
	active = false;
	available = true;
	
	sprite_index = spr_book;
	
	if(instance_exists(textBubble)) {
		textBubble.active = false;
	}
}

advance = function() {
	state++;
	
	if(instance_exists(textBubble)) {
		textBubble.active = false;
	}
	
	if(state >= array_length(bubbleInfo)) {
		deactivate();
	} else {
		createTextPanel();
	}
}

createTextPanel = function() {
	textBubble = instance_create_depth(x, y - 150, depth - 100, obj_textPanel);
	textBubble.source = id;
	textBubble.displayData.text = bubbleInfo[state];
	textBubble.displayData.buttonPromt = criteria[state];
	textBubble.bakeText();
}