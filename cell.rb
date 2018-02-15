require '/home/karolina/ruby/battleship_game/grid.rb'

class Cell
attr_accessor :content, :status, :sunk_ship
attr_reader :coordinates

	def initialize(coordinates)
		@status = 'not_pointed'
		@content = 'water'
		@coordinates = coordinates
		@sunk_ship = 'no'
	end


	def hit!
		if @content == 'water' 
			puts 'missed'
			@status = 'pointed'
		else
			puts 'hit'
			@status = 'hit'
		end
	end
end