class GameView

  def self.display_board board
    output = String.new
    height = board.length - 1
    width = board.first.length - 1

    (0..height).each do |row|
      (0..width).each do |column|
        if board[row][column]
          output << "o"
        else
          output << "."
        end
      end
      output << "\n"
    end

    output << "\n"
    print output
  end

end
