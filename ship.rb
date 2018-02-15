class Ship
	attr_reader :length
	attr_accessor :placed, :orientation, :placement, :sunk, :name

	def initialize(name,length)
		@name = name
		@length = length
		@placed = 'not yet'
		@sunk = 'no'
		@orientation = 'vertical'
		@placement = []
	end

	def build_ship
		@placed = 'yes'
		@placement.each{|cell| cell.content = 'ship'}
	end

	def hit?
		@hit=0
		@placement.each{|cell| @hit +=1 if cell.status == 'hit'} 
		@hit
	end

	def sunk?
		if @hit==@length
			@sunk = 'yes'
			@placement.each{|cell| cell.sunk_ship = 'yes'}
			puts "You have sunk a ship #{@name}!"
			true
		else
			false
		end
	end

end