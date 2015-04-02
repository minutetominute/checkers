require './utilities.rb'
require './checkers_helper.rb'

class Piece
	include CheckersHelper

	attr_accessor :king, :position, :color, :board

	def initialize(board, color, position = nil)
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
		move_available?(to) && @board.empty_square?(to) && @board.on_board?(to)
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
		jumped_piece = @board[jumped_location(position, location)] 
		@board.empty_square?(location) && 
			jumped_piece.color == opposite_color(color) && @board.on_board?(location)
	end
	
	def perform_moves(move_sequence)
		successful_move = valid_move_seq?(move_sequence)
		if successful_move
			perform_moves!(move_sequence)
		else
			raise InvalidMoveError.new("Can't move there!")
		end
	end

	def perform_moves!(move_sequence)
		successful_move = false
		if move_sequence.one? 
			successful_move = perform_slide(move_sequence.first)	
			unless successful_move
				successful_move = perform_jump(move_sequence.first)
			end
		else
			move_sequence.each do |move|
				successful_move = perform_jump(move)
				raise InvalidMoveError unless successful_move
			end
		end
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
		absolute_values = vector.map(&:abs)
		direction = vector.matrix(:/, absolute_values)
		raise InvalidMoveError unless direction.all? { |el| el.abs == 1 }
		direction.matrix(:+, to)
	rescue
		byebug
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
		king ? '☀' : '●'
	end
	
	def dup
		Piece.new(nil, color, self.position)
	end

end
