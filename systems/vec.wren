class Vec {
    x { _x }
    y { _y }

    x=(value) {
        _x = value
    }
    y=(value) {
        _y = value
    }

    construct new() {
        _x = 0
        _y = 0
    }

    construct new(a, b) {
        _x = a
        _y = b
    }

    construct new(vec) {
        _x = vec.x
        _y = vec.y
    }

    angle() { _y.atan(_x) }

    length() { (_x * _x + _y * _y).sqrt }

    lengthSq() { (_x * _x + _y * _y) }

    dot(other) { _x * other.x + _y * other.y }

    perp() { Vec.new(-_y, _x) }

    distance(other) {
        var xdiff = other.x - x
        var ydiff = other.y - y

        return (xdiff * xdiff + ydiff * ydiff).sqrt
    }

    truncate(max) {
        if (length() > max) {
            normalize()

            mul(max)
        }
    }

    normalize() {
        var len = length()

        if (len > Num.smallest) {
            div(len)
        }
    }

    +(other) {
        return Vec.new(_x + other.x, _y + other.y)
    }

    -(other) {
        return Vec.new(_x - other.x, _y - other.y)
    }

    *(val) {
        return Vec.new(_x * val, _y * val)
    }

    /(val) {
        return Vec.new(_x / val, _y / val)
    }

    add(other) {
        _x = _x + other.x
        _y = _y + other.y
    }

    sub(other) {
        _x = _x - other.x
        _y = _y - other.y
    }

    mul(val) {
        _x = _x * val
        _y = _y * val
    }

    div(val) {
        _x = _x / val
        _y = _y / val
    }
}
