#region PARTICLE definitions
global.breakPart = part_type_create();
var _break = global.breakPart;
part_type_life(_break, 27, 45);
part_type_shape(_break, pt_shape_square);
part_type_size(_break, .07, .105, -.002, 0);
part_type_alpha2(_break, 1, 0);
part_type_speed(_break, .25, 1.05, 0, 0);
part_type_direction(_break, 0, 360, 0, 0);
part_type_orientation(_break, 0, 360, 3, 5, false);
part_type_gravity(_break, .032, 270);

global.explosionPart = part_type_create();
var _explosionPart = global.explosionPart;
part_type_life(_explosionPart, 20, 42);
part_type_shape(_explosionPart, pt_shape_square);
part_type_size(_explosionPart, .1, .14, -.002, 0);
part_type_size_x(_explosionPart, .3, .3, 0, 0);
part_type_alpha2(_explosionPart, 1, 0);
part_type_speed(_explosionPart, 1.6, 4.8, -.18, 0);
part_type_direction(_explosionPart, 0, 360, 0, 0);
part_type_orientation(_explosionPart, 0, 360, 3, 5, false);

global.starPart = part_type_create();
var _star = global.starPart;
part_type_life(_star, 150, 180);
part_type_sprite(_star, spr_starShape, false, false, false);
part_type_size(_star, .15, .5, -.0025, 0); // limiting factor hopefully
part_type_speed(_star, 1.6, 4.8, -.18, 0); // do override this when you want though, should be set per effect in game
part_type_direction(_star, 0, 360, 0, 0);
part_type_orientation(_star, 0, 360, 3, 5, false);

global.radialShimmerPart = part_type_create();
var _radialShimmer = global.radialShimmerPart;
part_type_life(_radialShimmer, 110, 130);
part_type_sprite(_radialShimmer, spr_roundBeamShape, false, false, false);
part_type_size(_radialShimmer, .35, .7, -.0065, 0); // limiting factor hopefully
part_type_speed(_radialShimmer, 1, 1.9, -.02, 0); // do override this when you want though, should be set per effect in game
part_type_direction(_radialShimmer, 0, 360, 0, 0);

global.roundTrail = part_type_create();
var _roundTrail = global.roundTrail;
part_type_life(_roundTrail, 45, 55);
part_type_shape(_roundTrail, pt_shape_square);
part_type_size(_roundTrail, .05, .05, -.001, 0);
part_type_alpha2(_roundTrail, 1, .3);
part_type_speed(_roundTrail, 0, .4, -.004, 0);
part_type_direction(_roundTrail, 0, 360, 0, 0);
part_type_orientation(_roundTrail, 0, 0, 1.7, 0, 0);
part_type_color1(_roundTrail, #ffffff)

global.overwrittenTrailerPart = part_type_create(); // no visuals?
var _trailerPart = global.overwrittenTrailerPart;
part_type_life(_trailerPart, 25, 90);
part_type_direction(_trailerPart, 0, 360, 0, 0); // over write speed per particle use case in code, no default
part_type_gravity(_trailerPart, .04, 270);
part_type_step(_trailerPart, -2, _roundTrail);

global.smokeTrailPart = part_type_create();
var _smokeTrail = global.smokeTrailPart;
part_type_life(_smokeTrail, 75, 110);
part_type_shape(_smokeTrail, pt_shape_square);
part_type_size(_smokeTrail, .02, .02, .001, 0);
part_type_alpha2(_smokeTrail, 1, 0);
part_type_speed(_smokeTrail, 0.15, .3, -.008, 0);
part_type_direction(_smokeTrail, 0, 360, 0, 0);
part_type_gravity(_smokeTrail, -.01, 270);

global.thickTrail = part_type_create();
var _thickTrail = global.thickTrail;
part_type_life(_thickTrail, 50, 70);
part_type_shape(_thickTrail, pt_shape_square);
part_type_size(_thickTrail, .1, .14, -.003, 0);
part_type_speed(_thickTrail, 0.0, .2, -.002, 0);
part_type_direction(_thickTrail, 0, 360, 0, 0);
part_type_orientation(_thickTrail, 0, 360, 0, 0, false);
part_type_gravity(_thickTrail, -.01, 270);

global.partSwirl = part_type_create();
var _swirl = global.partSwirl;
part_type_life(_swirl, 50, 70);
part_type_sprite(_swirl, spr_swirldShape, false, false, false);
part_type_size(_swirl, 1, 1.4, -.03, 0);
part_type_speed(_swirl, 0.0, .65, -.005, 0);
part_type_direction(_swirl, 0, 360, 0, 0);
part_type_orientation(_swirl, 0, 360, 0, 0, false);
part_type_gravity(_swirl, -.01, 270);

global.bloodSpurt = part_type_create();
var _bloodSpurt = global.bloodSpurt;
part_type_life(_bloodSpurt, 35, 70);
part_type_shape(_bloodSpurt, pt_shape_disk);
part_type_size(_bloodSpurt, .08, .13, -.003, 0);
part_type_speed(_bloodSpurt, 1.5, 2.7, -.003, 0);
part_type_gravity(_bloodSpurt, .02, 270);

global.partDebrisKnock = part_type_create();
var _debrisKnock = global.partDebrisKnock;
part_type_life(_debrisKnock, 60, 90);
part_type_shape(_debrisKnock, pt_shape_square);
part_type_size(_debrisKnock, .03, .05, .005, 0);
part_type_speed(_debrisKnock, 1.5, 2.7, -.003, 0);
part_type_gravity(_debrisKnock, .02, 270);
part_type_alpha3(_debrisKnock, 1, 1, 0);

global.rushPart = part_type_create();
var _rushPart = global.rushPart;
part_type_life(_rushPart, 62, 85);
part_type_shape(_rushPart, pt_shape_square);
part_type_size(_rushPart, .15, .21, -.002, 0);
part_type_orientation(_rushPart, 0, 360, 0, 0, false);
part_type_gravity(_rushPart, .04, 270);

global.partStreamerSpellTrail = part_type_create();
var _streamerTrail = global.partStreamerSpellTrail;
part_type_life(_streamerTrail, 30, 40);
part_type_shape(_streamerTrail, pt_shape_square);
part_type_size(_streamerTrail, .06, .06, -.001, 0);
part_type_alpha2(_streamerTrail, 1, .2);
part_type_color1(_streamerTrail, #ffffff);
part_type_speed(_streamerTrail, 0, .3, -.004, 0);
part_type_direction(_streamerTrail, 0, 360, 0, 0);
part_type_orientation(_streamerTrail, 0, 360, 1.7, 0, 0);

global.partSmallStreamerTrail = part_type_create();
var _smallStreamerTrail = global.partSmallStreamerTrail;
part_type_life(_smallStreamerTrail, 27, 27);
part_type_shape(_smallStreamerTrail, pt_shape_square);
part_type_size(_smallStreamerTrail, .032, .032, -.0008, 0);
part_type_alpha2(_smallStreamerTrail, 1, 0);
part_type_color1(_smallStreamerTrail, #ffffff);

global.itemGlimmerPart = part_type_create();
var _itemGlimmer = global.itemGlimmerPart;
part_type_life(_itemGlimmer, 90, 300);
part_type_shape(_itemGlimmer, pt_shape_square);
part_type_size(_itemGlimmer, .06, .09, -.0004, 0);
part_type_speed(_itemGlimmer, 0.2, .4, -.001, 0);
part_type_direction(_itemGlimmer, 0, 360, 0, 0);
part_type_gravity(_itemGlimmer, -.003, 270);

global.bossTrail = part_type_create();
var _bossTrail = global.bossTrail;
part_type_life(_bossTrail, 150, 150);
part_type_shape(_bossTrail, pt_shape_disk);
part_type_size(_bossTrail, .5, .7, -.005, 0);
part_type_speed(_bossTrail, 0.0, .1, -.001, 0);
part_type_direction(_bossTrail, 0, 360, 0, 0);

global.partPoofDust = part_type_create();
var _dustPoof = global.partPoofDust;
part_type_life(_dustPoof, 120, 210);
part_type_shape(_dustPoof, pt_shape_square);
part_type_size(_dustPoof, .035, .09, -.00038, 0);
part_type_speed(_dustPoof, 0.2, .8, -.005, 0);
part_type_direction(_dustPoof, 70, 110, 0, 0);
part_type_orientation(_dustPoof, 0, 360, 0, 5, 0);
part_type_gravity(_dustPoof, -.0075, 90);

global.partPoofDustRadial = part_type_create();
var _dustPoofRadial = global.partPoofDustRadial;
part_type_life(_dustPoofRadial, 120, 210);
part_type_shape(_dustPoofRadial, pt_shape_square);
part_type_size(_dustPoofRadial, .035, .09, -.00038, 0);
part_type_speed(_dustPoofRadial, 0.2, .8, -.005, 0);
part_type_direction(_dustPoofRadial, 0, 360, 0, 0);
part_type_orientation(_dustPoofRadial, 0, 360, 0, 5, 0);
part_type_gravity(_dustPoofRadial, -.0075, 90);