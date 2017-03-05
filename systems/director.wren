class Director {
    static current { __curent }

    static startWith(scene) {
        __curent = scene
        __curent.enter()
    }

    static update(dt) {
        if (__curent.update(dt)) {
            __curent.exit()
            __curent = __next

            if (!__curent) {
                return true
            }

            __curent.enter()
        }

        return false
    }

    static render() {
        __curent.render()
    }
}