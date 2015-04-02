require './board.rb'

class Game

	def initialize
		@board = Board.new	
	end
	
	def run
		until @board.over?
			puts @board.render
		end
		puts "Game over!"
	end

end
