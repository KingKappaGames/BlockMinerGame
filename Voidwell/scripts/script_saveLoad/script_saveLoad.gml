function script_saveWorld(filename) {
	var _player = global.player;
	var _respawnRobe = _player.robePreviousId;
	var _robeRespawnData = _respawnRobe == noone ? 0 : [_respawnRobe.x, _respawnRobe.y, _respawnRobe.pickupIndex];
	
	instance_activate_object(obj_materialOrbNode);
	instance_activate_object(obj_itemPickUpParent);

	var _materialNodeArray = [];
	with(obj_materialOrbNode) {
		array_push(_materialNodeArray, [x, y, materialType]);
	}
	
	var _itemPickups = [];
	with(obj_itemPickUpParent) {
		if(id != _respawnRobe) {
			array_push(_itemPickups, [x, y, pickupType, pickupIndex]); // type, index should be all the data you need
		}
	}
	
	instance_deactivate_object(obj_materialOrbNode);
	instance_deactivate_object(obj_itemPickUpParent);
	
	var _saveData = [variable_clone(global.worldTiles), _player.x, _player.y, variable_clone(_player.spellsUnlocked), variable_clone(_player.heldMaterialsUnlocked), _player.robeIndex, _player.pickaxeIndex, _robeRespawnData, _materialNodeArray, _itemPickups]; // 9 length so far
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
	
	instance_create_layer(_player.x, _player.y - 100, "Instances", obj_bouncingBookIntro);
	
	//_player.spellsUnlocked = _loadData[3]; // when robe is loaded all robe related spells are updated, however if I bring back the permanent unlocked spells then this becomes more complex...
	_player.heldMaterialsUnlocked = _loadData[4];
	_player.setRobe(_loadData[5],, true, false);
	_player.setPickaxe(_loadData[6]);
	
	if(_loadData[7] != 0) {
		var _respawnRobe = script_createRobePickup(_loadData[7][2], _loadData[7][0], _loadData[7][1])
		_player.robePreviousId = _respawnRobe;
	}
	
	var _materialNodeData = _loadData[8];
	for(var _materialNodes = array_length(_materialNodeData) - 1; _materialNodes >= 0; _materialNodes--) {
		script_createMaterialNode(_materialNodeData[_materialNodes][0], _materialNodeData[_materialNodes][1], _materialNodeData[_materialNodes][2]);
	}
	
	var _pickupData = _loadData[9];
	var _pickup;
	for(var _pickupI = array_length(_pickupData) - 1; _pickupI >= 0; _pickupI--) {
		_pickup = _pickupData[_pickupI];
		if(_pickup[2] == "pickaxe") {
			script_createPickaxe(_pickupData[_pickupI][3], _pickupData[_pickupI][0], _pickupData[_pickupI][1]); // i dont have a create pickaxe script...
		} else if(_pickup[2] == "robe") {
			script_createRobePickup(_pickupData[_pickupI][3], _pickupData[_pickupI][0], _pickupData[_pickupI][1]);
		}
	}
	
	buffer_delete(_worldLoadBuffer);
	
	var _tileManager = global.tileManager;
	
	_tileManager.tiles = global.worldTiles; // tile manager holding onto ref to old world, cut it loose into the void
	
	global.tileRangeWorld = array_length(global.worldTiles);
	global.worldSizePixels = global.tileRangeWorld * tileSize;
}