module CheckersHelper
	def opposite_color(color)
		color == :red ? :black : :red
	end
end
