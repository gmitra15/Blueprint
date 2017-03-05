import "random" for Random
var random = Random.new(677269698369)
class Section{
//0 = red
//1 = blue
//2 = green
//3 = pink
//4 = white
	construct new(location){
		sectLocation = location	
	}
	sectColor{_sectColor}
	sectColor = (value){
		_sectColor = value	
	}
	sectLocation{_sectLocation}
	sectLocation = (value){
		_sectLocation = value	
	}
	runColor(Section, player){
		if(Section.sectColor == 0){
			Red(player)
		}	
		else if(Section.sectColor == 1){
			Blue(player)
		}
		else if(Section.sectColor == 2){
			Green(player)
		}
		else if(Section.sectColor == 3){
			Pink(player)
		}
		else if(Section.sectColor == 4){
			White(player)
		}
	}
	Blue(player){
		player.movesLeft = player.movesLeft + 2	
	}
	Red(player){
		player.dead()		
	}
	Green(player){
		player.addPoints(2)
	}
	Pink(player){
		player.location = random.int(20)
	}
	White(player){
		player.addPoints(1)
	}
}
