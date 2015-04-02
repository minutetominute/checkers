class Player
	def initialize()
		
	end	
end

class HumanPlayer < Player

	def get_input
		input = gets.chomp
		parse_input(input)
	end
	
	def parse_input(input)
		from, to = input.split(' ')
		from = parse_coordinate(from)
		to = parse_coordinate(to)
		[from, to]
	end
	
	def parse_coordinates(coordinates)
		col, row = coordinates.split('')
		[num_to_index(row), char_to_index(col)]
	end

	def char_to_index(char)

	end

	def num_to_index(num)

	end

end

class ComputerPlayer < Player

end
