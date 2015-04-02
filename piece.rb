class Piece

	attr_accessor :king

	def initialize(color)
		@color = color
		@king = false
	end

	def perform_slide
		
	end

	def perform_jump

	end

	def move_diffs
		diffs = @color == :red ? [[1, 1], [1, -1]] : [[-1, 1], [-1, -1]] 
		diffs + diffs.map { |diff| [-diff[0], diff[1]] } if king
		diffs
	end

	def promote?
		
	end

	def render
		@color == :red ? '○' : '●'
	end
end
