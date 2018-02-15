require '/home/karolina/ruby/battleship_game/game.rb'
require '/home/karolina/ruby/battleship_game/round.rb'

battleship = Game.new
battleship.place_ships_on_grid

round = Round.new(battleship.grid)
round.full_game
