import "scenes/scene" for Scene
import "systems/circle" for Circle
import "systems/input" for Mouse, Keyboard
import "systems/vec" for Vec
import "systems/text" for Text
import "systems/view" for View

import "entities/board" for Board
import "entities/player" for Player

class Game is Scene {
    time { _time }
    board { _board }

    activePlayer { _players[_turn % _players.count] }
    nonActivePlayer { _players[(_turn + 1) % _players.count] }

    construct new() {}

    enter() {
        _view = View.new(1920/2, 1080/2, 1920/2, 1080/2)
        _old = View.new(1920/2, 1080/2, 1920, 1080)

        _time = 0

        _turn = 0

        _board = Board.new()
        _players = [Player.new(), Player.new()]

//         _turns = Text.new()

        activePlayer.roll()
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
        } else {
            return -1
        }
    }

    resetRound() {
        _turn = 0

        _players = [Player.new(), Player.new()]
    }

    endTurn() {
        _turn = _turn + 1
        if (_turn % _players.count == 0) {
            board.boardSwap()
            for (p in _players) {
                p.movesLeft = 0
                board.givePoints(p)
                System.print(p.points)
            }
        }

        if (_turn >= _players.count * 6) {
            resetRound()
        }

        var count = 0
        for (p in _players) {
            if (!p.dead) count = count + 1
        }

        if (count <= 1) {
            resetRound()
        }

        activePlayer.roll()

        if (activePlayer.dead) {
            endTurn()
        }
    }

    update(dt) {
        _view.activate()
        _time = _time + dt

        if (Mouse.buttonstate(0) == 1) {

            var target = handleMouse(Vec.new(Mouse.x - 1920/2, Mouse.y - 1080/2))
            if (target != -1) activePlayer.move(target)
        } else if (Mouse.buttonstate(1) == 1) {
            var target = handleMouse(Vec.new(Mouse.x - 1920/2, Mouse.y - 1080/2))
            activePlayer.moveEnemy(nonActivePlayer, target)
        } else if (Keyboard.keystate(57) == 1) {
            endTurn()
        }
    }

    render() {
        _view.activate()

        _board.render()

        _old.activate()
        for (p in 0..._players.count) _players[p].render(p)
    }
}
