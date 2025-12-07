if (live_call()) return live_result;

event_inherited();

if(global.timer % 20 == 0) {
	if(point_distance(x, y - 8, player.x, player.y) < 15) {
		player.hit(damage + choose(-1, 1), point_direction(x, y, player.x, player.y), 2.5);
		directionFacing = sign(player.x - x);
	} else {
		if(irandom(3) == 0) {
			if(waitTimer <= 0) {
				directionFacing = sign(player.x - x);
			}
		}
	}
}

if(waitTimer <= 0) {
	xChange = directionFacing;
} else {
	waitTimer--;
}


if(inWorld) {
	if(alive) {
		//debugTileDraw = [];
		var _tX = x div tileSize;
		var _tY = (y) div tileSize;
		var _tFootY = (y + 1) div tileSize;
		var _tileStanding = tiles[_tX][_tFootY];
	
		if(_tileStanding > 0) {
			var _facing = directionFacing;
			xChange *= speedDecay;
			
			if(waitTimer <= 0) {
				if(irandom(2) == 0) {
					#region AI ###########################################################################################################################
					if(_tX > 3 && _tX < global.tileRangeWorld - 4) {
						if(_tY > 3 && _tY < global.tileRangeWorld - 4) {
							//var _x = _facing == -1 ? 4 : 0; // depending on which way you're looking you're either on the end of the set or the beginning
							//var _y = 3;
							
							//var _map = array_create(5);
							//for(var _arrayInsertI = 0; _arrayInsertI < 5; _arrayInsertI++) {
								//_map[_arrayInsertI] = array_create(0);
							//}
							//if(_facing == -1) {
								//for(var _xOff = -4; _xOff <= 0; _xOff++) {
									//array_copy(_map[_xOff + 4], 0, tiles[_tX + _xOff], _tFootY - 4, 7);
									//for(var _debugYOff = -4; _debugYOff < 3; _debugYOff++) {
										//array_push(debugTileDraw, [_tX + _xOff, _tFootY + _debugYOff]);
									//}
								//}
							//} else {
								//for(var _xOff = 0; _xOff <= 4; _xOff++) {
									//array_copy(_map[_xOff], 0, tiles[_tX + _xOff], _tFootY - 4, 7);
									//for(var _debugYOff = -4; _debugYOff < 3; _debugYOff++) {
										//array_push(debugTileDraw, [_tX + _xOff, _tFootY + _debugYOff]);
									//}
								//}
							//}
							
							var _aboveClear = move(0, 1) isClear;
							var _aboveClear2 = _aboveClear && move(0, 2) isClear;
							var _aboveClear3 = _aboveClear2 && move(0, 3) isClear;
							
							var _underPlayer = player.y + tileSize < y;
							var _alreadyJumped = false;
							if(_underPlayer) {
								if(irandom(15) == 0) {
									var _pX = player.x;
									var _pY = player.y;
									if(point_distance(x, y - 8, _pX, _pY) < 70) { // jump AT player in air
										var _lineOfSight = true;
										for(var _pathI = 1; _pathI < 5; _pathI++) {
											if(tiles[(lerp(x, _pX, _pathI * .2)) div tileSize][(lerp(y, _pY, _pathI * .2)) div tileSize] isSolid) {
												_lineOfSight = false;
												break;
											}
										}
										
										if(_lineOfSight) {
											yChange = -sqrt(abs(_pY - y)) * .6 + .8;
											xChange = (_pX - x) * .055;
											waitTimer = 30;
											
											audio_play_sound(snd_monsterSquak, 0, 0, random_range(.9, 1.15), undefined, random_range(.85, 1.25));
											
											_alreadyJumped = true;
										}
									}
								}
								
								if(!_alreadyJumped) {
									if(_underPlayer && _aboveClear3 && move(1, 3) isSolid && move(1, 4) isClear) {
										yChange = -5.7;
										xChange = _facing * 0.2;
										waitTimer = 29;
										_alreadyJumped = true;
									} else if(_underPlayer && _aboveClear2 && move(1, 2) isSolid && move(1, 3) isClear) {
										yChange = -4.7;
										xChange = _facing * .4;
										waitTimer = 29;
										_alreadyJumped = true;
									} else if(_underPlayer && _aboveClear && move(1, 1) isSolid && move(1, 2) isClear) { // jump up optional tile ahead
										yChange = -3.8;
										xChange = _facing * .7;
										waitTimer = 25;
										_alreadyJumped = true;
									}
								}
							}
	
							if(!_alreadyJumped) {
							
								if(move(1, 0) isClear) { 
									if(move(1, -1) isClear) {
										//check potential fall one ahead
										
										//check jump option by checking other side of gap for solid ground
										
										if(move(2, 0) isClear || move(2, 1) isClear) { // some kind of gap to jump to (no guarentee that there's something solid below at this step)
											var _facingBack = _facing == 1;
											if(move(2, 1) isClear && move(2, 0) isSolid) {
												yChange = -3;
												xChange = _facing * 2.5;
												
											} else if(move(2, -1) isSolid) {
												yChange = -2;
												xChange = _facing * 1.2 - (x % tileSize - 16 * _facingBack) * .025;
												waitTimer = 50;
											} else if(move(2, -2) isSolid) {
												//jump?
												yChange = -2.05;
												xChange = _facing * 1.11;
												waitTimer = 50;
											} else { // jumping 2 gap
												if(move(3, 1) isClear && move(3, 0) isSolid) {
													yChange = -2.8;
													xChange = _facing * 1.62 - (x % tileSize - 16 * _facingBack) * .05;
													waitTimer = 50;
												} else if(move(3, -1) isSolid) {
													yChange = -2.05;
													xChange = _facing * 1.66 - (x % tileSize - 16 * _facingBack) * .05;
													waitTimer = 50;
												} else if(move(3, -2) isSolid) {
													yChange = -1.5;
													xChange = _facing * 1.52 - (x % tileSize - 16 * _facingBack) * .05;
													waitTimer = 50;
												} else if(move(3, -3) isSolid) {
													yChange = -1.1;
													xChange = _facing * 1.45 - (x % tileSize - 16 * _facingBack) * .05;
													waitTimer = 50;
												} else if(move(3, 2) isClear && move(3, 1) isSolid) {
													yChange = -4;
													xChange = _facing * 1.86;
													waitTimer = 40;
												} else {
													var _depth = script_checkDepthAtTile(_tX + _facing, _tFootY + 1, 4);
													if(_depth == -1) { // too far yo
														//okay yeah turn around
														waitTimer = 25;
														_facing *= -1;
													} else {
														//drop aka nothing
													}
												}
											}
										} else if(move(2, 1) isSolid && move(2, 2) isClear) {
											//jump?
											yChange = -4.05;
											xChange = _facing * 1.11;
											waitTimer = 35;
										}
									}
								} else {
									// check jump options for going over a tile in front of you
									if(move(0, 1) isClear) {
										if(move(1, 1) isClear) {
											yChange = -2.4;
											xChange = _facing * .4;
										} else {
											if(move(0, 2) isClear) {
												if(move(1, 2) isClear) {
													yChange = -4;
													xChange = _facing * .35;
													waitTimer = 23;
												} else {
													if(move(0, 3) isClear) {
														if(move(1, 3) isClear) {
															yChange = -4.6;
															xChange = _facing * .6; // sequence of jump attempts up high straight walls
															waitTimer = 26;
														} else {
															xChange = 0;
															waitTimer = 20;
															_facing *= -1;
														}
													} else {
														
														//turn around
														xChange = 0;
														waitTimer = 25;
														_facing *= -1;
													}
												}
											} else {
												waitTimer = 25;
												_facing *= -1;
											}
										}
									} else {
										//no jump possible, blocked above instantly
										waitTimer = 25;
										_facing *= -1;
									}
								}
							}
						}
					}
					
					#endregion
				}
				directionFacing = _facing;
			}
		}
		
		xChange *= speedDecayAir;
		yChange *= speedDecayAir;
		yChange += grav;
		
		script_moveCollide();
	}
} else {
	die();
}


//added states from here, jump two tiles if too big of gap, and jump up an optional jump if player higher than enemy and lower if lower i guess? (if one ahead blocked, stop early and jump up an overhang), or in terms of optional jumps

/*
Simple ai for jumping up tiles, check the 4 tiles horizontally in the direction you want to move and if there's any blocks blocking you within the first two go up from there one or two blocks and if you find a gap within two blocks do a hard coded jump to land on that 1/2 block distant tile and repeat. 
You should also check the tile under you always for falling but also the tiles one to the direction you're moving below. If the jump logic fails (no access) and there's a non dangerous hole in front of you then drop down or turn around.

 Maybe some check to see that the hole has a way out?