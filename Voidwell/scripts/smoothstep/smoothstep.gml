function smoothstep(minimum, maximum, value) {
    var _x = max(0, min(1, (value - minimum) / (maximum - minimum)));
    return _x * _x * (3 - 2 * _x);
}