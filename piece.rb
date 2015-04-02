require './utilities.rb'

class Piece

	attr_accessor :king, :position, :color, :board

	def initialize(board, color)
		@color = color
		@king = false
		@position = position
		@board = board
	end

	def perform_slide(to)
		if valid_slide?(to)
			move_to(to)
			true
		else
			false
		end
	end
	
	def valid_slide?(to) 
		move_available?(to) && @board.empty_square?(position)
	end

	def move_available?(to)
		move_diffs.any? { |diff| diff.matrix(:+, position) == to }
	end

	def move_to(location)
		@board[position] = nil
		@board[location] = self
		self.king = true if promote?
	end

	def perform_jump(location)
		if valid_jump?(location)
			jump_to(location)
			true
		else
			false
		end
	end
	
	def jump_to(location)
		@board[jumped_location(position, location)] = nil
		move_to(location)
	end
	
	def valid_jump?(location)
		@board.empty_square?(location) && 
			jumped_location(position, location).color == opposite_color(color)
	end
	
	def perform_moves(move_sequence)
		successful_move = valid_sequence?(move_sequence)
		successful_move
	end

	def perform_moves!(move_sequence)
		successful_move = false
		if move_sequence.one? 
			successful_move = perform_slide(move_sequence.first)	
		end

		move_sequence.each do |move|
			successful_move = perform_jump(move)
		end
		raise InvalidMoveError unless succcessful_move
	end

	def valid_move_seq?(move_sequence)
		new_board = board.dup				
		new_board[self.position].perform_moves!(move_sequence)
		true
	rescue InvalidMoveError
		false
	end

	def jumped_location(from, to)
		vector = from.matrix(:-, to)
		direction = vector.matrix(:/, vector)
		raise InvalidJumpError unless direction.all? { |el| el.abs == 1 }
		direction.matrix(:+, to)
	end

	def move_diffs
		diffs = color == :red ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]] 
		diffs.concat(diffs.map { |diff| [-diff[0], diff[1]] }) if king
		diffs
	end

	def promote?
		@position[0] == opposite_end	
	end

	def opposite_end
		color == :red ? 7 : 0
	end

	def render
		'●'
	end
	
	def dup
		Piece.new(nil, color)
	end

end
