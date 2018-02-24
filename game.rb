require File.expand_path('../grid.rb', __FILE__)
require File.expand_path('../ship.rb', __FILE__)

class Game
attr_accessor :grid

	def initialize
		init_game
		@score = 0
	end

	def init_game
		puts "Hello! That is battleship game\n Type your name here:"
		@player = gets.chomp
		@grid = Grid.new
	end

	def place_ships_on_grid
		@grid.ships.each do |ship|
			@ship = ship
			loop do
				@current_ship=[]
				@orientation = ['vertical', 'horizontal'].sample
				if @orientation=='vertical'
					@letter = @grid.letters_numbers.values[0..-ship.length].sample  #single value with letter - ship length
					@number = rand(@grid.width)+1 # column +1 because in rand range is unclosed and we don't need 0
				else
					@letter = @grid.letters_numbers.values.sample
					@number = rand(@grid.width)+1-ship.length
				end
				placing_single_ship
				break if ship.length == @current_ship.length 
			end

			#update objects Cell and Ship.
			@current_ship.each {|cell| ship.placement<<cell}
			ship.build_ship
			@ship.orientation = @orientation
			# puts "ship with length #{ship.length} is on a board!"
		end
		#commented because we don't want to show to the Player where the ships are placed
		# @grid.print_board
	end 

	def placing_single_ship
		i=0
		if @orientation == 'horizontal'
			while i<@ship.length
				cell_id = "#{@letter}#{@number+i}" #ship grows horizontally
				if @grid.cells[cell_id] != nil 
					@placement = @grid.cells[cell_id]
				else
					break
				end
				if @grid.cells[cell_id].content =='water' && check_adherence #check if cell contains a ship, run mathod check adherence and check if there is no another ship around
					@current_ship << @placement
				else
					break	
				end
				i+=1
			end
		else
			while i<@ship.length
				alfabet = ("A".."Z").to_a
				cell_id ="#{@letter}#{@number}" 
				num_of_current_row = alfabet.index(@letter)+1 # it's number
				@letter = alfabet[num_of_current_row]

				if @grid.cells[cell_id] != nil 
					@placement = @grid.cells[cell_id]
				else
					break
				end

				if @grid.cells[cell_id].content == 'water' && check_adherence
					@current_ship << @placement  # check if there is no another ship around
				else
					break
				end
				i+=1
			end
		end
		

	end

	def check_adherence
		result=true
		coord = @placement.coordinates.split('')
		rows = [(coord[0].ord-1).chr, coord[0], (coord[0].ord+1).chr]
		columns = [coord[1].to_i-1, coord[1].to_i, coord[1].to_i+1]
		rows.each{|row|
			columns.each{|column|
				cell_id = "#{row}#{column}"
				if @grid.cells[cell_id] !=nil
					return result = false if @grid.cells[cell_id].content== 'ship' 
				end
			}
		}
	end

end


