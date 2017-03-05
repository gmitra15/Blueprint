class Entity {
    id { _id }
    shouldRemove { _tombstone }

    static setup() {
        __id = 0
    }

    setID() {
        _id = __id
        __id = __id + 1
    }

    init() {
        _tombstone = false
        setID()
    }

    remove() {
        _tombstone = true
    }

    onRemove() {}

    update(dt) {}

    render() {}
}
Entity.setup()
