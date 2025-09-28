function script_saveWorld(filename) {
	var _player = global.player;
	var _respawnRobe = _player.robePreviousId;
	var _robeRespawnData = _respawnRobe == noone ? 0 : [_respawnRobe.x, _respawnRobe.y, _respawnRobe.pickupIndex];
	var _saveData = [variable_clone(global.worldTiles), _player.x, _player.y, variable_clone(_player.spellsUnlocked), variable_clone(_player.heldMaterialsUnlocked), _player.robeIndex, _player.pickaxeIndex, _robeRespawnData];
	var _jsonWorld = json_stringify(_saveData);
	
    var _worldSavebuffer = buffer_create(string_byte_length(_jsonWorld) + 1, buffer_fixed, 1);
	
    buffer_write(_worldSavebuffer, buffer_string, _jsonWorld);
    buffer_save(_worldSavebuffer, filename);
    buffer_delete(_worldSavebuffer);
}

function script_loadWorld(filename) {
	global.worldTiles = []; // not necessary but nice feeling
	
	var _worldLoadBuffer = buffer_load(filename);
	
	var _worldLoadData = buffer_read(_worldLoadBuffer, buffer_string);
	
	var _loadData = json_parse(_worldLoadData);
	
	global.worldTiles = _loadData[0];
	
	var _player = instance_create_layer(0, 0, "Instances", obj_player);
	
	_player.x = _loadData[1];
	_player.y = _loadData[2];
	
	_player.spellsUnlocked = _loadData[3];
	_player.heldMaterialsUnlocked = _loadData[4];
	_player.setRobe(_loadData[5],, true, false);
	_player.setPickaxe(_loadData[6]);
	
	if(_loadData[7] != 0) {
		var _respawnRobe = script_createRobePickup(_loadData[7][2], _loadData[7][0], _loadData[7][1])
		_player.robePreviousId = _respawnRobe;
	}
	
	buffer_delete(_worldLoadBuffer);
	
	var _tileManager = global.tileManager;
	
	_tileManager.tiles = global.worldTiles; // tile manager holding onto ref to old world, cut it loose into the void
	
	global.tileRangeWorld = array_length(global.worldTiles);
	global.worldSizePixels = global.tileRangeWorld * tileSize;
}