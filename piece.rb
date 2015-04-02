class Piece

	def initialize(color)
		@color = color
		@king = false
	end

	def perform_slide
		
	end

	def perform_jump

	end

	def move_diffs

	end

	def promote?
		
	end

	def render
		self.color == :red ? '○' : '●'
	end
end
