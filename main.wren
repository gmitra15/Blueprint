import "systems/director" for Director
import "scenes/game" for Game
import "systems/settings" for Settings

Director.startWith(Game.new())