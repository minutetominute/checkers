require './board.rb'

class Game

	def initialize(red_player, black_player)
		@board = Board.new	
		@red_player = red_player
		@black_player = black_player
		@players = [@red_player, @black_player]
	end

	def run
		loop do
			@players.cycle do |player|
				puts @board.render
				break if board.over?
			end
		end
		puts "Game over!"
	end

end
