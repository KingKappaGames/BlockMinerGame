//if (live_call()) return live_result;

if(global.manager.splashIntroProgress >= 1) {
	if(loadNextFrame) {
		global.manager.startGameWorld();
	} else {
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
				optionPosition = clamp((mouse_y - (y + menuBorder)) div optionHeight, 0, optionAmount - 1);
				
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
	}
}