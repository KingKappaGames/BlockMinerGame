function script_centerCameraOnPlayer() {
	var _player = global.player;
	camera_set_view_pos(cam, _player.x - camera_get_view_width(cam) * .5, _player.y - camera_get_view_height(cam) * .5);
}