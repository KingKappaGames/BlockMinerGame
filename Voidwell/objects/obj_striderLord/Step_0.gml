if (live_call()) return live_result;
	
global.bossTrail = part_type_create();
var _bossTrail = global.bossTrail;
part_type_life(_bossTrail, 150, 150);
part_type_shape(_bossTrail, pt_shape_disk);
part_type_size(_bossTrail, .4, .55, -.005, 0);
part_type_speed(_bossTrail, 0.0, .1, -.001, 0);
part_type_direction(_bossTrail, 0, 360, 0, 0);

trailPart = global.thickTrail;

event_inherited();

if(state == "die") {
	script_cameraShake(.2);
	
	xChange *= .9;
	yChange *= .9;
	deathTimer++;
	if(deathTimer < deathTimerMax * .7) {
		if(deathTimer < deathTimerMax * .35) {
			if(global.gameGoreSelected != 0) {
				part_type_direction(bloodSpurtPart, 0, 360, 0, 0);
				part_particles_create_color(sys, x, y, bloodSpurtPart, c_maroon, 10 - deathTimer / 15);
			}
		}
		
		if(random(1) < ((deathTimer - 50) * .008)) {
			var _spawnX = x + irandom_range(-25, 25);
			var _spawnY = y - 8 + irandom_range(-25, 25);
			var _dir = point_direction(x, y - 8, _spawnX, _spawnY);
			part_type_orientation(radialGlimmer, _dir, _dir, 0, 0, false);
			part_type_direction(radialGlimmer, _dir, _dir, 0, 0);
			part_type_speed(radialGlimmer, 5, 7, -.05, 0);
			part_particles_create(sys, _spawnX, _spawnY, radialGlimmer, 1);
		}
	}
	
	if(deathTimer >= deathTimerMax) {
		instance_destroy();
	}
} else {
	var _dirToPlayer = point_direction(x, y, player.x, player.y);
	var _distToPlayer = point_distance(x, y, player.x, player.y);

	if(_distToPlayer < 15) {
		if(global.timer % 5 == 0) {
			player.hit(4, _dirToPlayer, 5);
		}
	}
	
	if(state == "idle") {
		#region ground movement code
		
		if(waitTimer <= 0) {
			xChange = directionFacing;
		} else {
			waitTimer--;
		}
		
		//debugTileDraw = [];
		var _tX = x div tileSize;
		var _tY = (y) div tileSize;
		var _tFootY = (y + 1) div tileSize;
		var _tileStanding = tiles[_tX][_tFootY];
	
		if(_tileStanding isSolid) {
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
		} else { // not solid
			if(irandom(90) == 0) {
				setState("leap", 45, [random_range(_dirToPlayer - 45, _dirToPlayer + 45), rushSpeed * .75]);
			}
			
			xChange *= speedDecayAir;
			yChange *= speedDecayAir;
			yChange += grav;
		}
	} else if(state == "barrage") {
		if(stateTimer < stateTimerMax - 15) {
			if(stateTimer % 24 == 0) {
				var _spell = script_castSpell(E_spell.bolt, x + irandom_range(-20, 20), y + irandom_range(-20, 20), global.player.x + irandom_range(-60, 60), global.player.y + irandom_range(-60, 60), .75);
				_spell.image_blend = c_aqua;
				var _kbDir = _dirToPlayer + 180;
				xChange += lengthdir_x(knockbackSpellStrength * 3, _kbDir); // the spells he uses here should be more billowy, almost breath attack to fly away or cloud jumping type stuff
				yChange += lengthdir_y(knockbackSpellStrength * 3, _kbDir);
			}
		}
	} else if(state == "leap") {
		part_particles_create(sysUnder, x + random_range(-3, 3), y + random_range(-3, 3), trailPart, 1);
		yChange += grav;
	} else if(state == "laser") {
		if(stateTimer < stateTimerMax * .9 && stateTimer > stateTimerMax * .125) {
			if(!instance_exists(spell)) {
				spell = script_castSpell(E_spell.laser, x, y, x, y - 1, 0, 1);
			} else {
				
				var _x = x;
				var _y = y;
				with(spell) {
					x = _x;
					y = _y;
					
					var _angleChange = angle_difference(_dirToPlayer, directionLaser);
					directionLaser += _angleChange * .04 + sign(_angleChange) * .05;
					duration = 10;
				}
			}
		}
	} else if(state == "rush") {
		part_particles_create(sysUnder, x + random_range(-3, 3), y + random_range(-3, 3), trailPart, 1);
		if(stateTimer == round(stateTimerMax * .8)) {
			xChange = lengthdir_x(rushSpeed, _dirToPlayer);
			yChange = lengthdir_y(rushSpeed, _dirToPlayer);
		}
		if(tiles[(x + xChange) div tileSize][(y + yChange) div tileSize] isSolid) {
			xChange *= -.3;
			yChange *= -.3;
			setState("bonk");
		}
	} else if(state == "spire") {
		y -= 5;
		if(stateTimer > stateTimerMax * .06) {
			script_placeTileAtPos(x, y + 15, E_tile.metal, false, true);
		}
	} else if(state == "bonk") {
		yChange += grav;
	} else if(state == "clearAbove") {
		if(stateTimer < stateTimerMax * .9 && stateTimer > stateTimerMax * .25) {
			if(stateTimer % 3 == 0) {
				var _shot = script_castSpell(E_spell.bolt, x + irandom_range(-9, 9), y - irandom_range(5, 32), x + irandom_range(-85, 85), y - 500, .8, 1);
				_shot.breakTileChance = 1; // guarentee
			}
		}
	}
	
	stateTimer--;
	if(stateTimer <= 0) {
		newState();
	}
}

if(state != "idle") {
	xChange *= speedDecayAir;
	yChange *= speedDecayAir;
}

if(inWorld) {
	script_moveCollide();	
} else {
	x += xChange;
	y += yChange;
}