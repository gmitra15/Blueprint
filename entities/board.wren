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

        _sections[5].sectColor = 1
        _sections[7].sectColor = 3
        _sections[9].sectColor = 0
        _sections[10].sectColor = 2

        _sections[14].sectColor = 0
        _sections[15].sectColor = 2
        _sections[17].sectColor = 1
        _sections[19].sectColor = 2
        _sections[20].sectColor = 0
	}

	boardSwap() {
		for(row in _rows){
			var temp = row[-1].sectColor
			for(i in row){
				var temp2 = row[i].sectColor
				row[i].sectColor=temp
				temp = temp2
			}		
		}
	}

    render() {
        for (section in _sections) {
            section.render()
        }
    }
}
