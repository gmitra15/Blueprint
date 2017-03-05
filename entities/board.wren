import "entities/section" for Section

class Board { 
	construct new() {
		_sections = []	
		_rows = [[],[],[],[]]
		for(i in 0...21){
			var s = Section.new(i)
			_sections.add(s)
			if((0...1).contains(i)){
				_rows[0].add(s)
			} else if((1...5).contains(i)){
				_rows[1].add(s)
			} else if((5...13).contains(i)){
				_rows[2].add(s)
			} else if((13...21).contains(i)){
				_rows[3].add(s)
			}
		}

        _sections[0].sectColor = 5

        _sections[2].sectColor = 1

        _sections[5].sectColor = 1
        _sections[7].sectColor = 3
        _sections[9].sectColor = 0
        _sections[10].sectColor = 2

        _sections[14].sectColor = 0
//         _sections[15].sectColor = 2
        _sections[17].sectColor = 1
        _sections[18].sectColor = 3
        _sections[19].sectColor = 2
        _sections[20].sectColor = 0
        
        _spincount = [0,1,2,3]
        _points = [0,1,2,4]
	}

    givePoints(player) {
        if (!player.dead) {
            for (r in 0..._rows.count) {
                var row = _rows[r]
                for (i in row) {
                    if (i.sectLocation == player.location) {
                        player.addPoints(_points[r])
                        i.runColor(player)
                        return
                    }
                }
            }
        }
    }
	
	boardSwap() {
		for(r in 0..._rows.count){
			var row = _rows[r]
			for(spin in 0..._spincount[r]){
				var temp = row[-1].sectColor
				for(i in row){
					var temp2 = i.sectColor
					i.sectColor=temp
					temp = temp2
				}		
			}
		}
	}
	
	nextTo(aLocation,bLocation){
		if(aLocation == 0 && [1,2,3,4].contains(bLocation)) {
			return true
		} else if(aLocation == 1 && [0,2,4,5,6,7].contains(bLocation)) {
			return true
		} else if(aLocation == 2 && [0,1,3,7,8,9].contains(bLocation)) {
			return true
		} else if(aLocation == 3 && [0,2,4,9,10,11].contains(bLocation)) {
			return true
		} else if(aLocation == 4 && [0,1,3,11,12,5].contains(bLocation)) {
			return true
		} else if(aLocation == 5 && [1,4,6,12,13,20].contains(bLocation)) {
			return true
		} else if(aLocation == 6 && [1,5,7,13,14].contains(bLocation)) {
			return true
		} else if(aLocation == 7 && [1,2,6,8,14,15].contains(bLocation)) {
			return true
		} else if(aLocation == 8 && [2,7,9,15,16].contains(bLocation)) {
			return true
		} else if(aLocation == 9 && [2,3,8,10,16,17].contains(bLocation)) {
			return true
		} else if(aLocation == 10 && [3,9,11,17,18].contains(bLocation)) {
			return true
		} else if(aLocation == 11 && [3,4,10,12,18,19].contains(bLocation)) {
			return true
		} else if(aLocation == 12 && [4,5,11,19,20].contains(bLocation)) {
			return true
		} else if(aLocation == 13 && [5,6,14,20,-1].contains(bLocation)) {
			return true
		} else if(aLocation == 14 && [6,7,13,15,-1].contains(bLocation)) {
			return true
		} else if(aLocation == 15 && [7,8,14,16,-1].contains(bLocation)) {
			return true
		} else if(aLocation == 16 && [8,9,15,17,-1].contains(bLocation)) {
			return true
		} else if(aLocation == 17 && [9,10,16,18,-1].contains(bLocation)) {
			return true
		} else if(aLocation == 18 && [10,11,17,19,-1].contains(bLocation)) {
			return true
		} else if(aLocation == 19 && [11,12,18,20,-1].contains(bLocation)) {
			return true
		} else if(aLocation == 20 && [5,12,13,19,-1].contains(bLocation)) {
			return true
		}
		return false 
	}
    render() {
        for (section in _sections) {
            section.render()
        }
    }
}
