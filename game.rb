class Game
  attr_accessor :board

  def initialize board
    @board = board
  end

  def random_seed
		height = board.length - 1
		width = board.first.length - 1

		height.times do |row|
			width.times do |col|
				odds = rand(4)
				if odds == 0
					board[row][col] = true
				end
			end
		end

  end

end
