import "scenes/scene" for Scene

import "systems/circle" for Circle 

class Game is Scene {
    time { _time }

    construct new() {}

    enter() {
        _entities = []
        _time = 0

        _circles = []

        _circles.add(Circle.new(0, 0, Num.pi * 2, 200, 255, 0, 0))

        _circles.add(Circle.new(0, 0, Num.pi * 2, 100, 255, 0, 0))

        _circles.add(Circle.new(0, 100, Num.pi/2, 150, 255, 0, 0))
        _circles.add(Circle.new(Num.pi/2, 100, Num.pi, 150, 255, 255, 255))
        _circles.add(Circle.new(Num.pi, 100, Num.pi*3/2, 150, 255, 255, 255))
        _circles.add(Circle.new(Num.pi*3/2, 100, Num.pi*2, 150, 255, 255, 255))
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
        for (c in _circles) {
            c.render()
        }

        for (e in _entities) {
            e.render()
        }
    }
}
