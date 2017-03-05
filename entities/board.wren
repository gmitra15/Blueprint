class Board { 
	construct new() {
		_sections = []	
		_rows = [[],[],[],[]]
		for(i in 0...21){
			var s = Section.new(i)
			_sections.add(s)
			if((0...1).contains(i)){
				_rows[0].add(s)
			}
			else if((1...5).contains(i)){
				_rows[1].add(s)
			}
			else if((5...13).contains(i)){
				_rows[2].add(s)
			}
			else if((13...21).contains(i)){
				_rows[3].add(s)
			}
		}		
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
}
