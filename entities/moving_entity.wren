import "entities/entity" for Entity
import "systems/vec" for Vec

class MovingEntity is Entity {
    position { _position }
    velocity { _velocity }

    angle { _angle }
    angle=(val) {
        _angle = val
    }

    init() {
        super.init()

        _position = Vec.new()
        _velocity = Vec.new()
        _angle = 0
    }

    update(dt) {
        _position.add(_velocity * dt)
    }
}