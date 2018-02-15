require '/home/karolina/ruby/battleship_game/cell.rb'
require '/home/karolina/ruby/battleship_game/ship.rb'
require 'pry'
class Grid
	attr_reader :width, :height, :letters_numbers
	attr_accessor :cells, :ships

	def initialize
		@letters_numbers = Hash.new #1=>A, 2=> B etc.
		set_size
		@cells = Hash.new
		create_cells
		@ships =[]
		create_ships
	end

	def set_size
		puts "Type dimensions of board:\nheight:"
		@height = gets.chomp.to_i
		puts "width:"
		@width = gets.chomp.to_i
		@height = 10 if @height==0 #set default values, if user just press enter when asked for typing dimensions of board
		@width = 10 if @width==0
		if @height <8 || @width < 8
			puts "Wrong size board must be greater than 8\ndefault dimensions are set now:10x10" 
			@height,@width =10,10
		end
	end

	def create_cells
		headings = ("A".."Z").to_a # define titles of rows and assign them to numbers	
		columns = (1..@height).to_a
		columns.each_with_index{ |num,index| @letters_numbers[num]=headings[index]}
		@letters_numbers.values.each do |letter|
			(1..@width).each do |number|
				id="#{letter}#{number}"
				@cells[id]=Cell.new(id)
			end
		end
		@cells	
	end

	def create_ships
		@ships = [
			ship5 = Ship.new('ship5', 5),
			ship4 = Ship.new('ship4', 4),
			ship3 = Ship.new('ship3', 3),
			ship2 = Ship.new('ship2', 2),
			ship1 = Ship.new('ship1', 1)
		]
	end
	#shows board with visible ships
	def print_board 
		count = 1
		row=''
		@cells.each do |id,parameters|
			row+= "| # |" if @cells[id].content=='ship'
			row+= "| ~ |" if @cells[id].content=='water'	
			if count % @width == 0 
				puts row.squeeze('|')
				row.clear
			end
			count+=1
		end
	end

	def print_player_board
		count = 1
		letter_id = 1
		row=''
		
		1.upto(@width){|number| row += ('|%1.3s|' % " #{number} ")}
		puts row.insert(0, '   |').squeeze('|')
		row.clear

		1.upto(@width){|number| row += '+---+'}
		puts row.insert(0, '---+').squeeze('+')
		row.clear
		
		@cells.each do |id,parameters|
			if @cells[id].sunk_ship == "yes"
				row+= "| @ |"
			elsif @cells[id].content=='ship' && @cells[id].status=='hit'
				row+= "| # |" 
			end
			row+= "| ~ |" if @cells[id].status=='not_pointed'
			row+= "| * |" if @cells[id].status=='pointed'	
			
			if count % @width == 0 
				puts row.squeeze('|').insert(0," #{@letters_numbers.values_at(letter_id).join} ")
				letter_id+=1
				row.clear

				1.upto(@width){|number| row += '+---+'}
				puts row.insert(0, '---+').squeeze('+')
				row.clear
			end
			count+=1
		end
	end
end

