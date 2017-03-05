import "scenes/scene" for Scene
import "systems/circle" for Circle
import "systems/input" for Mouse, Keyboard
import "systems/vec" for Vec

import "entities/board" for Board
import "entities/player" for Player

class Game is Scene {
    time { _time }
    board { _board }

    construct new() {}

    enter() {
        _time = 0

        _board = Board.new()
        _player = Player.new()
    }

    entities(type) {
        return _entities.where {|e| e is type }
    }

    handleMouse(point) {
        var m = point.length()
        var ang = point.angle()
        if (ang < 0) {
            ang = ang + Num.pi*2
        }

        if (m <= 50) {
            return 0
        } else if (m <= 100) {
            var start = Num.pi * 3/2
            var dif = Num.pi/2

            var i = (ang / dif).floor

            return (i + 1) % 4 + 1
        } else if (m <= 150) {
            var start = Num.pi * 3/2
            var dif = Num.pi/4

            var i = ((ang / dif) - 0.5).floor

            if (i == -1) i = 7

            return (i + 3) % 8 + 5
        } else if (m <= 200) {
            var start = Num.pi * 3/2
            var dif = Num.pi/4

            var i = (ang / dif).floor

            return (i + 2) % 8 + 13
        }
    }

    endTurn() {
        _board.boardSwap()
        _player.movesLeft = 6
    }

    update(dt) {
        _time = _time + dt

        if (Mouse.buttonstate(0) == 1) {

            var target = handleMouse(Vec.new(Mouse.x - 1920/2, Mouse.y - 1080/2))
            if (target != null) _player.move(target)
        } else if (Keyboard.keystate(57) == 1) {
            endTurn()
        }
    }

    render() {
        _board.render()
        _player.render()
    }
}
