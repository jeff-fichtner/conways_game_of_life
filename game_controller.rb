require_relative 'board_generator'
require_relative 'game'
require_relative 'game_view'
require_relative 'reset_screen'

class GameController

  def self.run

    # initialize animation
    generation_count = 0
    generations = 500
    width = 20
    height = 20
    game = Game.new(BoardGenerator.generate(60, 20))

    # alter the board
    game.board = add_glider(game.board)
    game.board = add_beacon(game.board)
    reset_screen
    GameView.display_board(game.board)
    sleep(0.5)

    # start evolution
    while generation_count < generations
      game.board = evolve(game)
      reset_screen
      GameView.display_board(game.board)
      sleep(0.2)
      generation_count += 1
    end

  end


  private

  def self.add_glider board
    board[3][2] = true
    board[3][3] = true
    board[3][4] = true
    board[2][4] = true
    board[1][3] = true
    board
  end

  def self.add_beacon board
    board[10][10] = true
    board[10][11] = true
    board[11][10] = true
    board[12][13] = true
    board[13][13] = true
    board[12][12] = true
    board
  end

  def self.evolve game
    current_board = game.board
    dup_board = game.board.dup
    height = current_board.length - 1
    width = current_board.first.length - 1

    (0..height).each do |row|
      (0..width).each do |column|
        dup_board = check_neighbors(current_board, dup_board, row, column)
      end
    end
    dup_board
  end

  def self.check_neighbors current_board, dup_board, row, column
    neighbor_count = 0

    if (row > 0 && row < 19 && column > 0 && column < 19)
      north = current_board[(row - 1)][column]
      if north
        neighbor_count += 1
      end

      northeast = current_board[(row - 1)][(column + 1)]
      if northeast
        neighbor_count += 1
      end

      east = current_board[row][(column + 1)]
      if east
        neighbor_count += 1
      end

      southeast = current_board[(row + 1)][(column + 1)]
      if southeast
        neighbor_count += 1
      end

      south = current_board[(row + 1)][column]
      if south
        neighbor_count += 1
      end

      southwest = current_board[(row + 1)][(column - 1)]
      if southwest
        neighbor_count += 1
      end

      west = current_board[row][(column - 1)]
      if west
        neighbor_count += 1
      end

      northwest = current_board[(row - 1)][(column - 1)]
      if northwest
        neighbor_count += 1
      end
    end

    if (!current_board[row][column] && neighbor_count == 3)
      dup_board[row][column] = true
    elsif current_board[row][column]
      if (neighbor_count < 2 || neighbor_count > 3)
        dup_board[row][column] = false
      elsif (neighbor_count >= 2 && neighbor_count <= 3)
        dup_board[row][column] = true
      end
    end

    dup_board
  end
end
