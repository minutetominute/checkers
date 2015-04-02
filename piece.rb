require './utilities.rb'

class Piece

	attr_accessor :king, :position, :color

	def initialize(board, color)
		@color = color
		@king = false
		@position = position
		@board = board
	end

	def perform_slide(to)
		move_diffs.any? { |diff| diff.zip_sum(position) == to } ? move_to(to) : false
	end

	def move_to(location)
		@board[position] = nil
		self.position = location
		@board[location] = self
		self.king = true if promote?
		true
	end

	def perform_jump(location)
		@board[jumped_location(position, location)] = nil
		move_to(location)
	end

	def jumped_location(from, to)
		jumped = from.zip_sum(to).map { |vector| - vector / 2 }.zip_sum(from)
		p jumped
		jumped
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
end
