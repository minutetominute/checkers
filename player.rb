class Player
	attr_reader :color
	def initialize(color)
		@color = color
	end	
end

class HumanPlayer < Player

	def get_input
		puts "#{color.to_s.capitalize}'s turn!"
		puts "Make a move!"
		input = gets.chomp
		parse_input(input)
	end
	
	def parse_input(input)
		moves = input.split(' ')
		moves.each_with_object([]) do |coordinate, move|
			move << parse_coordinates(coordinate)		
		end
	end
	
	def parse_coordinates(coordinates)
		col, row = coordinates.split('')
		[num_to_index(row), char_to_index(col)]
	end

	def char_to_index(char)
		char.downcase.ord - "a".ord
	end

	def num_to_index(num)
		8 - num.to_i
	end

end

class ComputerPlayer < Player

end
