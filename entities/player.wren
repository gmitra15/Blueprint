import "random" for Random
var random = Random.new(677269698369)
class Player {
	location { _location }
	movesLeft { _movesLeft }
	dead {_location==-1}
	movesLeft = (value){
		_movesLeft = value;		
	}
	location = (value){
		_location = value
	}
	points { _points }
	points = (value){
		_points = value	
	}
	addPoints(value){
		_points = _points + value	
	}
	move(target) {
		if(_movesLeft > 0){
			_location = target
			_movesLeft = _movesLeft - 1
		}
	}
	roll() {
		movesLeft = random.int(5) + 1
	}
	die(){
		_location = -1 // bye felicia	
	}
	moveEnemy(Enemy,target){
		if(movesLeft >= 2){
			Enemy.location = target
			_movesLeft = _movesLeft - 2
		}
	}
}
