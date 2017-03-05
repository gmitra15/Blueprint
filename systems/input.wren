class Keyboard {
    static init() {
        __keys = {}
    }

    foreign static keydown(key)

    static keystate(key) {
        var old = __keys[key]
        var next = keydown(key)
        __keys[key] = next

        if (old) {
            if (next) {
                return 0
            } else {
                return -1
            }
        } else if (next) {
            return 1
        }
    }
}
Keyboard.init()

class Mouse {
    static init() {
        __buttons = {}
    }

    foreign static buttondown(button)
    foreign static x
    foreign static y

    static buttonstate(button) {
        var old = __buttons[button]
        var next = buttondown(button)
        __buttons[button] = next

        if (old) {
            if (next) {
                return 0
            } else {
                return -1
            }
        } else if (next) {
            return 1
        }
    }
}
Mouse.init()

class Joystick {
    static init() {
        __buttons = {}
        for (i in 0...4) {
            __buttons[i] = {}
        }
    }

    foreign static x(i)
    foreign static y(i)
    foreign static z(i)
    foreign static r(i)
    foreign static buttondown(i, button)

    static buttonstate(i, button) {
        var old = __buttons[i][button]
        var next = buttondown(i, button)
        __buttons[i][button] = next

        if (old) {
            if (next) {
                return 0
            } else {
                return -1
            }
        } else if (next) {
            return 1
        }
    }
}
Joystick.init()
