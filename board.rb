require "colorize"
require "./checkers_helper"

class Board
	include CheckersHelper
	
	def initialize
		@squares = Array.new(8) { Array.new(8) }	
	end

	def render
		square_color = :white
		@squares.each_with_object([]) do |row, board|
			row.each do |square|

				if square.nil?
					board << "  X".colorize(background: square_color) if square.nil?
				else	
					board << square.render(square_color)
				end
			end
		end
	end
	
end
