class Vec {
    x { _x }
    y { _y }

    x=(value) {
        _x = value
    }
    y=(value) {
        _y = value
    }

    set(other) {
        _x = other.x
        _y = other.y
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

    +(other) {
        return Vec.new(_x.add(other.x), _y.add(other.y))
    }

    -(other) {
        return Vec.new(_x.sub(other.x), _y.sub(other.y))
    }

    *(val) {
        return Vec.new(_x.mul(val), _y.mul(val))
    }

    /(val) {
        return Vec.new(_x.div(val), _y.div(val))
    }

    add(other) {
        _x = _x.add(other.x)
        _y = _y.add(other.y)
    }

    sub(other) {
        _x = _x.sub(other.x)
        _y = _y.sub(other.y)
    }

    mul(val) {
        _x = _x.mul(val)
        _y = _y.mul(val)
    }

    div(val) {
        _x = _x.div(val)
        _y = _y.div(val)
    }

    length() { _x.mul(_x).add(_y.mul(_y)).fsqrt }
    lengthSq() { _x.mul(_x).add(_y.mul(_y)) }

    trunc(max) {
        if (max <= 0) {
            _x = 0
            _y = 0
        } else if (lengthSq() > max.mul(max)) {
            normalize()

            mul(max)
        }
    }

    normalize() {
        var len = length()

        if (len > 10) {
            div(len)
        }
    }
}
