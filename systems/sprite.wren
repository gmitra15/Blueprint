foreign class Sprite {
    construct new(file) {}

    foreign layer=(value)
    foreign setFrameSize(w, h)
    foreign frame=(value)
    foreign angle=(value)
    foreign direction=(value)

    foreign setPosition(x, y)

    foreign render()
}

foreign class Text {
    construct new(file) {}

    foreign setString(string)
    foreign setPosition(x, y)

    foreign render()
}
