require '/home/karolina/ruby/battleship_game/cell.rb'

class Round
	def initialize(grid)
		@grid = grid
		@grid.print_player_board
	end

	def play
		puts "Type coordinates and press ENTER to hit"
		@coordinates = gets.chomp.upcase
	end

	def hit
		if @grid.cells[@coordinates].hit! == 'hit'
			@grid.ships.each{|ship| 
				if ship.sunk == 'no'
				ship.hit?
				ship.sunk?
				end
			}
		end
	rescue NoMethodError
		puts "Wrong input\ntype proper coordinates\nletter between A..#{@grid.letters_numbers.values[-1]} and number between 1..#{@grid.width}"
	end

	def all_sunk?
		@grid.ships.each {|ship|
		if ship.sunk =='yes'
			true
		else
			return false
		end
		}
	end

	def full_game
		shots=0
		while all_sunk? == false
			play
			hit
			shots+=1
			@grid.print_player_board
		end
		puts "All ships are sunk, Congratulations\nYour game took you #{shots} shots"
	
	end
end