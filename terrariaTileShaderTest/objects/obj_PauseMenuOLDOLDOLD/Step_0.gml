//if (live_call()) return live_result;

pauseMenuSwitchPosition(input_check_released("down") -  input_check_released("up"));
pauseMenuChangeField(   input_check_released("right") - input_check_released("left"));

if(input_check_released("activate") || input_check_released("jump") || input_check_released("leftClick")) {
	pauseMenuSelectOption();
}

var _playersArray = global.players;
for(var _playerI = array_length(_playersArray) - 1; _playerI >= 0; _playerI--) {
	if(input_check_released("escape", _playersArray[_playerI].playerIndex)) { // if pause menu stuff ( for all players shared)
		closeLayer();
	}
}


























