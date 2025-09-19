function script_saveWorld() {
	var _saveData = [variable_clone(global.worldTiles), global.player.x, global.player.y];
	var _jsonWorld = json_stringify(_saveData);
	
    var _worldSavebuffer = buffer_create(string_byte_length(_jsonWorld) + 1, buffer_fixed, 1);
	
    buffer_write(_worldSavebuffer, buffer_string, _jsonWorld);
    buffer_save(_worldSavebuffer, "worldSave.txt");
    buffer_delete(_worldSavebuffer);
}

function script_loadWorld() {
	global.worldTiles = []; // not necessary but nice feeling
	
	var _worldLoadBuffer = buffer_load("worldSave.txt");
	
	var _worldLoadData = buffer_read(_worldLoadBuffer, buffer_string);
	
	var _loadData = json_parse(_worldLoadData);
	
	global.worldTiles = _loadData[0];
	
	global.player.x = _loadData[1];
	global.player.y = _loadData[2];
	
	buffer_delete(_worldLoadBuffer);
	
	var _tileManager = global.tileManager;
	
	_tileManager.tiles = global.worldTiles; // tile manager holding onto ref to old world, cut it loose into the void
	_tileManager.updateScreenStatic();
}