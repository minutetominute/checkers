#! /usr/bin/env ruby

require './board.rb'
require './player.rb'
require './error.rb'

class Game

	def initialize(red_player, black_player)
		@board = Board.new	
		@board.populate
		@red_player = red_player
		@black_player = black_player
		@players = [@red_player, @black_player]
	end

	def run
		loop do
			@players.cycle do |player|
				puts @board.render
				begin
					input = player.get_input
					@board[input.shift].perform_moves(input)
				rescue InvalidMoveError
					puts "Invalid move! Error: #{e}"
				end
				puts input
				break if @board.over?
			end
		end
		puts "Game over!"
	end

end

if __FILE__ == $PROGRAM_NAME
	puts "Welcome to checkers!"
	game = Game.new(HumanPlayer.new, HumanPlayer.new)
	game.run
end
