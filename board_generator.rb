module BoardGenerator
  def self.generate(width, height)
    board = []
    height.times do
      row = []
      width.times { row << false }
      board << row
    end
    board
  end
end
