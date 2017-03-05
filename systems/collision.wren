class CollisionHandler {
    static handle (a,b) {
        for (h in __handles) {
            if (a is h[0] && b is h[1]) {
                if (a.collide(b)) {
                    h[2].call(a,b)
                }
                return true
            } else if (b is h[0] && a is h[1]) {
                if (a.collide(b)) {
                    h[2].call(b,a)
                }
                return true
            }
        }

        return false
    }

    static init() {
        __handles = []
    }

    static addHandle(a,b,fn) {
        __handles.add([a,b,fn])

        sort()
    }

    static sort() {}
}
CollisionHandler.init()
