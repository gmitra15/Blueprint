import "scenes/scene" for Scene
import "systems/circle" for Circle
import "systems/input" for Mouse, Keyboard
import "systems/vec" for Vec
import "systems/view" for View
import "systems/sprite" for Text, Sprite
import "systems/director" for Director
import "systems/sound" for Sound

import "entities/board" for Board
import "entities/player" for Player

class Game is Scene {
    time { _time }
    board { _board }

    switch() { 
        _off = _off + 1
    }

    activePlayer { _players[(_turn + _off) % _players.count] }
    nonActivePlayer { _players[(_turn + 1 + _off) % _players.count] }

    construct new() {
        Sound.playSound("voice.wav") 
    }

    construct no() {
        _start = true
    }

    enter() {
        _view = View.new(1920/2, 1080/2, 1920/2, 1080/2)
        _old = View.new(1920/2, 1080/2, 1920, 1080)

        _time = 0

        _turn = 0

        _off = 0

        _board = Board.new()
        _players = [Player.new(0), Player.new(1)]

        _turns = Text.new("font.otf")

        _legend = Sprite.new("legend.png")

        _pos = Vec.new(1920/2, 1200)
        _ang = 0
        _wwe = Sprite.new("wwe.png")

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

        for (p in _players) {
            p.reset()
        }

        switch()
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

            activePlayer.addPoints(1)
        }

        if (_turn >= _players.count * 6) {
            if (activePlayer.points > nonActivePlayer.points) {
                activePlayer.win()
                _win = (_turn + _off) % _players.count
            } else if (activePlayer.points < nonActivePlayer.points) {
                nonActivePlayer.win()
                (_turn + _off) % _players.count
                _win = (_turn + _off) % _players.count
            }

            resetRound()
        }

        var count = 0
        for (p in _players) {
            if (!p.dead) count = count + 1
        }

        if (count <= 1) {
            for (p in 0..._players.count) {
                if (!_players[p].dead) {
                    _players[p].win()
                    _win = p
                }
            }

            resetRound()
        }

        activePlayer.roll()

        if (activePlayer.dead) {
            endTurn()
        }
    }

    update(dt) {
        if (!_start) {
            if (_pos.y > 300) {
                _pos.y = _pos.y - 6
            } else if (_ang < Num.pi * 4) {
                _ang = _ang + 0.1
            } else {
                _ang = Num.pi * 4
            }

            if (Keyboard.keystate(57) == 1) {
                _start = true
            }
        } else {
            _view.activate()
            _time = _time + dt

            if (Mouse.buttonstate(0) == 1) {

                var target = handleMouse(Vec.new(Mouse.x - 1920/2, Mouse.y - 1080/2))
                if (target != -1) activePlayer.move(target)
            } else if (Mouse.buttonstate(1) == 1) {
                var target = handleMouse(Vec.new(Mouse.x - 1920/2, Mouse.y - 1080/2))
                activePlayer.moveEnemy(nonActivePlayer, target)
            } else if (_players[0].roundsWon < 2 && _players[1].roundsWon < 2 && Keyboard.keystate(57) == 1) {
                endTurn()
            }
        }
    }

    render() {
        if (!_start) {
            _old.activate()
            _wwe.setPosition(_pos.x, _pos.y)
            _wwe.angle = _ang
            _wwe.render()
        } else if (_players[0].roundsWon >= 2) {
            _old.activate()
            _turns.setString("P1 wins")
            _turns.setPosition(900, 132)
            _turns.render()

            _turns.setString("%(_players[0].roundsWon)-%(_players[1].roundsWon)")
            _turns.setPosition(930, 164)
            _turns.render()

            if (Keyboard.keystate(57) == 1) Director.startWith(Game.no())
        } else if (_players[1].roundsWon >= 2) {
            _old.activate()
            _turns.setString("P2 wins")
            _turns.setPosition(900, 132)
            _turns.render()

            _turns.setString("%(_players[0].roundsWon)-%(_players[1].roundsWon)")
            _turns.setPosition(930, 164)
            _turns.render()

            if (Keyboard.keystate(57) == 1) Director.startWith(Game.no())
        } else {
            _view.activate()

            _board.render()

            _old.activate()

            _legend.setPosition(250, 550)
            _legend.render()

            for (p in 0..._players.count) _players[p].render(p)

            var t = (_turn + _off) % 2

            _turns.setString("Turn %((_turn/2).floor + 1)")
            _turns.setPosition(920, 50)
            _turns.render()

            _turns.setString("P%(t + 1)'s Turn")
            _turns.setPosition(500, 100)
            _turns.render()

            _turns.setString("Moves Left %(activePlayer.movesLeft)")
            _turns.setPosition(500, 132)
            _turns.render()

            _turns.setString("P1 Points %(_players[0].points)")
            _turns.setPosition(1920/2 + 360, 100)
            _turns.render()

            _turns.setString("P2 Points %(_players[1].points)")
            _turns.setPosition(1920/2 + 360, 132)
            _turns.render()

            _turns.setString("P1 Rounds won %(_players[0].roundsWon)")
            _turns.setPosition(1920/2 + 560, 100)
            _turns.render()

            _turns.setString("P2 Rounds won %(_players[1].roundsWon)")
            _turns.setPosition(1920/2 + 560, 132)
            _turns.render()

            if (_turn == 0 && _win) {
                _turns.setString("P%(_win + 1) Won the Round")
                _turns.setPosition(850, 82)
                _turns.render()
            }
        }
    }
}
