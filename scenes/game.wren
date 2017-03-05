import "scenes/scene" for Scene

class Game is Scene {
    tick { _tick }

    construct new() {}

    enter() {
        _entities = []
        _time = 0
    }

    addEntity(entity) {
        _entities.add(entity)
    }

    purge() {
        for (e in _entities.where {|e| e.shouldRemove }) {
            e.onRemove()
        }

        _entities = _entities.where {|e| !e.shouldRemove }
    }

    entities(type) {
        return _entities.where {|e| e is type }
    }

    update(dt) {
        _time = _time + dt
        for (e in _entities) {
            e.update(dt)
        }

        purge()
    }

    render() {
        for (e in _entities) {
            e.render()
        }
    }
}
