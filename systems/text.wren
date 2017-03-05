import "systems/sprite" for Sprite
import "systems/vec" for Vec

class Text {
    construct new() {
        _font = Sprite.new("font.png")
        _font.setFrameSize(6, 12)

        _string = ""
        _position = Vec.new()
    }

    setPosition(x, y) {
        _position.x = x
        _position.y = y
    }

    setString(string) {
        string = string.split(" ")
        var final = string[0]

        var len = 0
        for (s in string[1...string.count]) {
            if (overShoot(final + " " + s)) {
                final = final + "\n" + s
            } else {
                final = final + " " + s
            }
        }

        _string = final
    }

    overShoot(string) {
        var len = 0
        for (c in string) {
            if (c == "\n") {
                len = 0
            } else {
                len = len + 1
                if (len > 50) return true
            }
        }
        return false
    }

    setLetter(c, pos) {
        if (c >= 65 && c <= 90) {
            var spot = c - 65

            _font.frame = (spot * 2)
        } else if (c >= 97 && c <= 122) {
            var spot = c - 97

            _font.frame = (spot * 2 + 1)
        } else if (c == 32) {
            pos.x = pos.x + 6

            return
        } else if (c == 39) {
            _font.frame = 70
        } else if (c == 46) {
            _font.frame = 52
        } else if (c == 44) {
            _font.frame = 53
        } else if (c == 10) {
            pos.x = _position.x
            pos.y = pos.y + 12

            return
        } else if (c >= 48 && c < 58) {
            var spot = c - 48

            _font.frame = 60 + spot
        } else if (c == 58) {
            _font.frame = 54
        } else if (c == 91) {
            _font.frame = 59
        } else if (c == 93) {
            _font.frame = 58
        }

        renderLetter(pos)
    }

    renderLetter(pos) {
        _font.setPosition(pos.x + 3, pos.y + 6)
        _font.render()

        pos.x = pos.x + 6
    }

    render() {
        var pos = Vec.new(_position)
        System.print(_string)
        for (c in _string.codePoints) {
            setLetter(c, pos)
        }
    }
}