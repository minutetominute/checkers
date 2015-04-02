require "colorize"
require "./checkers_helper"

class Board
	include CheckersHelper
	
	def initialize
		@squares = Array.new(8) { Array.new(8) }	
	end

	def render
		square_color = :white
		@squares.each_with_object('') do |row, board|
			row.each do |square|

				if square.nil?
					board << "  ".colorize(background: square_color) if square.nil?
				else	
					board << square.render(square_color)
				end

				square_color = opposite_color(square_color)
			end
			board << "\n"
			square_color = opposite_color(square_color)
		end
	end
	
end
