event_inherited();

var _goalX = originX + dcos(current_time * bobTimeScale * 2.37) * bobRange * bobRangeXMult; // 8.7 just random modifier
var _goalY = originY + dsin(current_time * bobTimeScale) * bobRange;

var _dirToGoal = point_direction(x, y, _goalX, _goalY)

xChange += dcos(_dirToGoal) * moveSpeed;
yChange -= dsin(_dirToGoal) * moveSpeed;

x += xChange;
y += yChange;

xChange *= speedDecay;
yChange *= speedDecay;

if(available) {
	if(keyboard_check_pressed(ord("E"))) {
		pickUp();
		keyboard_clear(ord("E"));
	}
}

part_particles_create(sys, x, y, glimmerPart, 1);