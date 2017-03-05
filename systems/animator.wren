class Animator {
    update(dt) {}

    render(renderObject) {}
}

class FrameAnimator {
    frames { _frames }

    setDefault(anim) {
        if (_defualtAnimation != anim) {
            _defualtAnimation = anim
            playAnimation(anim)
        }
    }

    playAnimation(anim) {
        _currentAnimation = anim
        _currentFrame = 0
        _duration = 0
    }

    construct new() {
        _frames = {}
        _currentAnimation = "idle"
        _defualtAnimation = "idle"
        _currentFrame = 0
        _duration = 0
    }

    update(dt) {
        _duration = _duration + dt
        if (_duration >= _frames[_currentAnimation][_currentFrame][1]) {
            _currentFrame = _currentFrame + 1
            if (_currentFrame >= _frames[_currentAnimation].count) {
                _currentAnimation = _defualtAnimation
                _currentFrame = 0
            }

            _duration = 0
        }
    }

    render(renderObject) {
        renderObject.frame = _frames[_currentAnimation][_currentFrame][0]
    }
}