require File.expand_path('../game.rb', __FILE__)
require File.expand_path('../round.rb', __FILE__)

battleship = Game.new
battleship.place_ships_on_grid

round = Round.new(battleship.grid)
round.full_game
