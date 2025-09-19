randomize();

global.manager = id;

#macro tileColors [c_black, c_green, c_aqua, #884411, #bba280] // hmmmm
#macro grav .13

#region audio fall off values both for convenience and because the manual is very confusing and I want to stop screwing this up when I stop using audio stuff for a few months and come back to screw it up again
#macro audioRefTiny 75
#macro audioMaxTiny 320
#macro audioRefQuiet 150
#macro audioMaxQuiet 440
#macro audioRefMedium 240 // these aren't optimal or unique per sound (as they should be) but they at least ensure I'm not screwing up the ref values as I often do... (ref is the distance in which it halves I believe (or whatever your falloff ratio is) and max is how far out it should be audible at all)
#macro audioMaxMedium 740
#macro audioRefLoud 400
#macro audioMaxLoud 1300
#endregion

//ef_reverb = audio_effect_create(AudioEffectType.Reverb1);
//ef_reverb.size = 1.1;
//ef_reverb.mix = 0.3;
//audio_bus_main.effects[0] = ef_reverb;

timer = 0; // count up and use for applying updates eveny n frames

#region camera values
view_enabled = true;
view_camera[0] = camera_create();
view_visible[0] = true;

cam = view_camera[0];

surface_resize(application_surface, 960, 540);
view_set_wport(0, 960);
view_set_hport(0, 540);
camera_set_view_size(cam, 640, 360);
camera_set_view_pos(cam, 0, 0);
#endregion

#region particle stuff
sys = part_system_create();
part_system_depth(sys, depth - 100); // above, idk
global.sys = sys;

sysUnder = part_system_create();
part_system_depth(sysUnder, depth + 250); // under everything else (not background tho)
global.sysUnder = sysUnder;

#region
global.breakPart = part_type_create();
var _break = global.breakPart;
part_type_life(_break, 27, 45);
part_type_shape(_break, pt_shape_square);
part_type_size(_break, .07, .105, -.002, 0);
part_type_alpha2(_break, 1, 0);
part_type_speed(_break, .3, 1.2, 0, 0);
part_type_direction(_break, 0, 360, 0, 0);
part_type_orientation(_break, 0, 360, 3, 5, false);
part_type_gravity(_break, .04, 270);

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

global.smokeTrailPart = part_type_create();
var _smokeTrail = global.smokeTrailPart;
part_type_life(_smokeTrail, 75, 110);
part_type_shape(_smokeTrail, pt_shape_square);
part_type_size(_smokeTrail, .02, .02, .001, 0);
part_type_alpha2(_smokeTrail, 1, 0);
part_type_speed(_smokeTrail, 0.2, .5, -.004, 0);
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

global.itemGlimmerPart = part_type_create();
var _itemGlimmer = global.itemGlimmerPart;
part_type_life(_itemGlimmer, 90, 300);
part_type_shape(_itemGlimmer, pt_shape_square);
part_type_size(_itemGlimmer, .06, .09, -.0004, 0);
part_type_speed(_itemGlimmer, 0.2, .4, -.001, 0);
part_type_direction(_itemGlimmer, 0, 360, 0, 0);
part_type_gravity(_itemGlimmer, -.003, 270);
#endregion

#endregion

#region filter layer things
cameraWorldDepth = .5;

abyssEffectRange = [.65, 1]; // normalized depth of world for this effect to range over
abyssLayer = layer_get_id("EffectAbyss");
abyssFilter = layer_get_fx(abyssLayer);
abyssParams = fx_get_parameters(abyssFilter);

vignetteEffectRange = [.25, 1]; // normalized depth of world for this effect to range over
#endregion

instance_create_layer(0, 0, "Instances", obj_player);