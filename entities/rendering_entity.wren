import "entities/moving_entity" for MovingEntity
import "systems/vec" for Vec

class RenderingEntity is MovingEntity {
    renderObjects { _renderObjects }
    animators { _animators }

    init() {
        super.init()

        _renderObjects = {}
        _animators = {}
    }

    update(dt) {
        for (key in _animators.keys) {
            _animators[key].update(dt)
        }
    }

    render() {
        for (key in _renderObjects.keys) {
            _renderObjects[key].setPosition(position.x, position.y)
            if (_animators[key]) {
                _animators[key].render(_renderObjects[key])
            }

            _renderObjects[key].render()
        }
    }
}
