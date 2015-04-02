require "colorize"
require "./checkers_helper"

class Board
	include CheckersHelper
	
	def initialize
		@squares = Array.new(8) { Array.new(8) }	
	end

	def render
		square_color = :red
		@squares.each_with_object('') do |row, board|
			row.each do |square|

				if square.nil?
					board << "  ".colorize(background: color_maps_to(square_color)) if square.nil?
				else	
					board << square.render
				end

				square_color = opposite_color(square_color)
			end
			board << "\n"
			square_color = opposite_color(square_color)
		end
	end
	
	def color_maps_to(color)
		color == :black ? :light_black : :red
	end

	def populate
		(0..7).to_a
	end

	def [](pos)
		row, col = pos
		@squares[row][col]
	end

end
