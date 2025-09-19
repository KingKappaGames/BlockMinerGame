randomize();

global.manager = id;

#macro tileColors [c_black, c_green, c_aqua, #884411, #bba280] // hmmmm
#macro grav .13

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

#region
global.breakPart = part_type_create();
var _break = global.breakPart;
part_type_life(_break, 27, 45);
part_type_shape(_break, pt_shape_square);
part_type_size(_break, .07, .105, -.002, 0);
part_type_alpha2(_break, 1, 0);
part_type_speed(_break, 0, 1.4, 0, 0);
part_type_direction(_break, 0, 360, 0, 0);
part_type_orientation(_break, 0, 360, 3, 5, false);
part_type_gravity(_break, .05, 270);

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