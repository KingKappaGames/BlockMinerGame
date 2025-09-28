if (live_call()) return live_result;

if(!pauseNextFrame) {
	var _horizontalInput = keyboard_check_released(ord("S")) - keyboard_check_released(ord("W"));
	var _verticalInput = keyboard_check_released(ord("D")) - keyboard_check_released(ord("A"));
	
	if(_horizontalInput != 0) {
		menuSwitchPosition(_horizontalInput);
		mouseSelecting = false;
	}
	if(_verticalInput != 0) {
		menuChangeField(_verticalInput);
		mouseSelecting = false;
	}
	
	if(keyboard_check_released(vk_space) || keyboard_check_released(ord("E"))) {
		menuSelectOption();
		mouseSelecting = false;
	}
	
	if(mouseSelecting || window_mouse_get_delta_x() != 0 || window_mouse_get_delta_y() != 0) { //do selection based on mouse
		if((mouse_x > x && mouse_x < x + menuWidth) && (mouse_y > y + menuBorder && mouse_y < y + menuBorder + optionAmount * optionHeight)) {		
			mouseSelecting = true;
			
			if(optionGroup != 7) { // map selection
				optionPosition = clamp((mouse_y - (y + menuBorder)) div optionHeight, 0, optionAmount - 1);
			} else {
				var _prevOption = optionPosition;
				
				var _relativeX = mouse_x - x;
				var _relativeY = mouse_y - y; // nice but jesus man
				if(_relativeX > 57 && _relativeX < 171 && _relativeY > 13 && _relativeY < 67) {
					optionPosition = 0;
				} else if(_relativeX > 23 && _relativeX < 78 && _relativeY > 67 && _relativeY < 216) {
					optionPosition = 1;
				} else if(_relativeX > 91 && _relativeX < 146 && _relativeY > 67 && _relativeY < 216) {
					optionPosition = 2;
				} else if(_relativeX > 159 && _relativeX < 214 && _relativeY > 67 && _relativeY < 216) {
					optionPosition = 3;
				} else if(point_distance(_relativeX, _relativeY, 50, 242) < 18) {
					if(map1) {
						optionPosition = 4;
					}
				} else if(point_distance(_relativeX, _relativeY, 119, 242) < 18) {
					if(map2) {
						optionPosition = 5;
					}
				} else if(point_distance(_relativeX, _relativeY, 188, 242) < 18) {
					if(map3) {
						optionPosition = 6;
					}
				}
				
				if(_prevOption != optionPosition) {
					map1DeletePrompt = false;
					map2DeletePrompt = false;
					map3DeletePrompt = false; // im sure there are better ways to reset the sure prompts but whatever bro
				}
			}
			
			if(mouse_check_button_released(mb_left)) {
				menuSelectOption(1); // whatever is current under mouse selection
			} else if(mouse_check_button_released(mb_right)) {
				menuSelectOption(-1); // whatever is current under mouse selection
			}
		}
	}
	
	if(!mouseSelecting) { // this area just makes it possible to click to affect menus instead of using the arrow keys WHEN using keyboard input, why would someone want to use wd for up down but mouse for left right?.. Idk, but I like it myself even so screw it. It's neat.
		if(mouse_check_button_released(mb_left)) {
			menuSelectOption(1); // whatever is current under mouse selection
		} else if(mouse_check_button_released(mb_right)) {
			menuSelectOption(-1); // whatever is current under mouse selection
		}
	}
} else {
	//script_setPauseState();
}