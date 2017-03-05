import "scenes/scene" for Scene
import "systems/circle" for Circle

import "entities/board" for Board

class Game is Scene {
    time { _time }

    construct new() {}

    enter() {
        _entities = []
        _time = 0

        _board = Board.new()
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

        if (!_done && _time > 1) {
            _board.boardSwap()
            _doone = true
        }

        purge()
    }

    render() {
        _board.render()

        for (e in _entities) {
            e.render()
        }
    }
}
