// import "random" for Random

import "systems/circle" for Circle

// var random = Random.new(677269698369)

var TOP = Num.pi * 3/2
var RIGHT = 0
var BOT = Num.pi/2
var LEFT = Num.pi

var R = [210, 52, 46, 145, 255, 108]
var G = [77, 152, 204, 61, 255, 122]
var B = [87, 219, 113, 136, 255, 137]

class Section {
//0 = red
//1 = blue
//2 = green
//3 = pink
//4 = white
    r { R[_sectColor] }
    g { G[_sectColor] }
    b { B[_sectColor] }

	construct new(location){
		sectLocation = location
        _sectColor = 4
        createCircle()
	}
	sectColor{_sectColor}
	sectColor = (value){
		_sectColor = value	
        createCircle()
	}
	sectLocation{_sectLocation}
	sectLocation = (value){
		_sectLocation = value	
	}

    createCircle() {
        _border = 2
        _rad = 0.01

        if (_sectLocation == 0) {
            _circle = Circle.new(0, 0, Num.pi*2, 50 - _border, r, g, b)
        } else if ((1..4).contains(_sectLocation)) {
            var start = TOP
            var dif = Num.pi / 2
            var i = _sectLocation - 1

            _circle = Circle.new(start + dif * i + _rad, 50 + _border, start + dif * (i + 1) - _rad, 100 - _border, r, g, b)
        } else if ((5..12).contains(_sectLocation)) {
            var start = TOP - Num.pi / 8
            var dif = Num.pi / 4
            var i = _sectLocation - 5

            _circle = Circle.new(start + dif * i + _rad, 100 + _border, start + dif * (i + 1) - _rad, 150 - _border, r, g, b)
        } else {
            var start = TOP
            var dif = Num.pi / 4
            var i = _sectLocation - 13

            _circle = Circle.new(start + dif * i + _rad, 150 + _border, start + dif * (i + 1) - _rad, 200 - _border, r, g, b)
        }
    }

	runColor(Section, player){
		if(Section.sectColor == 0){
			red(player)
		} else if(Section.sectColor == 1){
			blue(player)
		} else if(Section.sectColor == 2){
			green(player)
		} else if(Section.sectColor == 3){
			pink(player)
		} else if(Section.sectColor == 4){
			white(player)
		}
	}
	blue(player){
		player.movesLeft = player.movesLeft + 2	
	}
	red(player){
		player.dead()		
	}
	green(player){
		player.addPoints(2)
	}
	pink(player){
		player.location = random.int(20)
	}
	white(player){
		player.addPoints(1)
	}
    render() {
        if (_circle) _circle.render()
    }
}
