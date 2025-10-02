if (live_call()) return live_result;

event_inherited();

if(global.timer % 550 == 0) {
	directionFacing = sign(player.x - x);
}

xChange = directionFacing;

if(inWorld) {
	if(alive) {
		if(waitTimer <= 0) {
			debugTileDraw = [];
			var _tiles = global.worldTiles;
			var _tX = x div tileSize;
			var _tY = (y) div tileSize;
			var _tFootY = (y + 1) div tileSize;
			var _tileStanding = _tiles[_tX][(y + 1) div tileSize];
			
			array_push(debugTileDraw, [x div tileSize, _tY]);
		
			if(_tileStanding > 0) {
				xChange *= speedDecay;
				
				#region AI ###########################################################################################################################
				if(x > tileSize * 4 && x < global.worldSizePixels - tileSize * 4) {
					if(y > tileSize * 4 && y < global.worldSizePixels - tileSize * 4) {
						
						var _tileForward1 = _tiles[_tX + directionFacing][_tY]
						array_push(debugTileDraw, [_tX + directionFacing, _tY]);
						if(_tileForward1 isClear) {
							var _tileUnderForward1 = _tiles[_tX + directionFacing][_tFootY]
							array_push(debugTileDraw, [_tX + directionFacing, _tFootY]);
							
							if(_tileUnderForward1 isClear) {
								//check potential fall one ahead
								
								//check jump option by checking other side of gap for solid ground
								var _tileForward2 = _tiles[_tX + directionFacing * 2][_tY]
								array_push(debugTileDraw, [_tX + directionFacing * 2, _tY]);
								var _tileForward2Up = _tiles[_tX + directionFacing * 2][_tY - 1]
								array_push(debugTileDraw, [_tX + directionFacing * 2, _tY - 1]);
								if(_tileForward2 isClear || _tileForward2Up isClear) { // some kind of gap to jump to (no guarentee that there's something solid below at this step)
									var _tileUnderForward2 = _tiles[_tX + directionFacing * 2][_tFootY]
									array_push(debugTileDraw, [_tX + directionFacing * 2, _tFootY]);
									if(_tileUnderForward2 isSolid || (_tileForward2Up isClear && _tileForward2 isSolid)) {
										//jump?
										yChange = -2.5;
										xChange = directionFacing * 1.8;
									} else {
										var _depth = script_checkDepthAtTile(_tX + directionFacing, _tFootY + 1, 2);
										show_debug_message($"depth: {_depth}")
										var _depthLim = _depth == -1 ? min(2, global.tileRangeWorld - (_tFootY + 1)) : _depth;
										for(var _addY = 0; _addY < _depthLim - _tFootY - 1; _addY++) {
											array_push(debugTileDraw, [_tX + directionFacing, _tFootY + 1 + _addY]);
										}
										if(_depth == -1) { // too far yo
											//okay yeah turn around
											waitTimer = 25;
											directionFacing *= -1;
										} else {
											//drop aka nothing
											//but not if it's a stuck hole..?
										}
									}
								} else { // only one block forward clear the next solid, the one infront below you empty (probably just drop and hope for jump logic next time)
									
								}
							}
						} else {
							// check jump options for going over a tile in front of you
							var _tileUp1 = _tiles[_tX][_tY - 1]
							array_push(debugTileDraw, [_tX, _tY - 1]);
							if(_tileUp1 isClear) {
								var _tileForwardUp1 = _tiles[_tX + directionFacing][_tY - 1]
								array_push(debugTileDraw, [_tX + directionFacing, _tY - 1]);
								if(_tileForwardUp1 isClear) {
									//jump up one tile..
									yChange = -3;
									xChange = directionFacing * 2;
								} else {
									var _tileUp2 = _tiles[_tX][_tY - 2]
									array_push(debugTileDraw, [_tX, _tY - 2]);
									if(_tileUp2 isClear) {
										var _tileForwardUp2 = _tiles[_tX + directionFacing][_tY - 2]
										array_push(debugTileDraw, [_tX + directionFacing, _tY - 2]);
										if(_tileForwardUp2 isClear) {
											//jump up two tiles..
											yChange = -4;
											xChange = directionFacing * 2;
										} else {
											//turn around
											waitTimer = 25;
											directionFacing *= -1;
										}
									} else {
										waitTimer = 25;
										directionFacing *= -1;
									}
								}
							} else {
								//no jump possible, blocked above instantly
								waitTimer = 25;
								directionFacing *= -1;
							}
						}
					}
				}
				#endregion
			} else {
				xChange *= speedDecayAir;
				yChange *= speedDecayAir;
				yChange += grav;
			}
		} else {
			waitTimer--;
		}
		
		script_moveCollide();
	}
} else {
	die();
}

//added states from here, jump two tiles if too big of gap, jump 3 tiles up, and jump up an optional jump if player higher than enemy and lower if lower i guess?

/*
Simple ai for jumping up tiles, check the 4 tiles horizontally in the direction you want to move and if there's any blocks blocking you within the first two go up from there one or two blocks and if you find a gap within two blocks do a hard coded jump to land on that 1/2 block distant tile and repeat. 
You should also check the tile under you always for falling but also the tiles one to the direction you're moving below. If the jump logic fails (no access) and there's a non dangerous hole in front of you then drop down or turn around.

 Maybe some check to see that the hole has a way out?