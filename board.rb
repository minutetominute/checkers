require "byebug"
require "colorize"
require "./checkers_helper"

class Board
	include CheckersHelper
	
	def initialize
		@squares = Array.new(8) { Array.new(8) }	
		self.populate
	end

	def render
		square_color = :red
		@squares.each_with_object('') do |row, board|
			row.each do |square|

				if square.nil?
					board << "  ".colorize(background: color_maps_to(square_color)) if square.nil?
				else	
					board << render_square_with_piece(square, square_color)
				end

				square_color = opposite_color(square_color)
			end
			board << "\n"
			square_color = opposite_color(square_color)
		end
	end
	
	def render_square_with_piece(piece, square_color)
		(piece.render + " ").colorize(piece.color).colorize(background: color_maps_to(square_color))
	end
	
	def color_maps_to(color)
		color == :black ? :light_black : :red
	end

	def populate
		shift = 1
		3.times do |row_index|
			7.times do |col_index|
				#red pieces
					self[[row_index, col_index + shift]] = Piece.new(self, :red)
				#black pieces
					self[[row_index + 5, col_index + shift - 1]] = Piece.new(self, :black)
					shift = (shift + 1) % 2
			end
		end
	end

	def [](pos)
		row, col = pos
		@squares[row][col]
	end

	def []=(pos, piece)
		row, col = pos
		piece.position = pos unless piece.nil?
		@squares[row][col] = piece
	end

end
