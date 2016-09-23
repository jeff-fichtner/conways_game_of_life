require_relative 'board_generator'
require_relative 'game'
require_relative 'game_view'
require_relative 'reset_screen'

class GameController

  def self.run

    # initialize animation
    generation_count = 0
    generations = 500
    width = 60
    height = 20
    game = Game.new(BoardGenerator.generate(width, height))

    # alter the board
    game.board = add_glider(game.board)
    # game.board = add_beacon(game.board)
    # game.board = add_block(game.board)
    reset_screen
    GameView.display_board(game.board)
    sleep(1)

    # start evolution
    while generation_count < generations
      game.board = evolve(game)
      reset_screen
      GameView.display_board(game.board)
      sleep(1)
      generation_count += 1
    end

  end


  private

  def self.add_single board
    board[5][5] = true
    board
  end

  def self.add_block board
    board[5][5] = true
    board[6][5] = true
    board[5][6] = true
    board[6][6] = true
    board
  end

  def self.add_glider board
    board[2][2] = true
    board[3][3] = true
    board[3][4] = true
    board[2][4] = true
    board[1][4] = true
    board
  end

  def self.add_beacon board
    board[10][10] = true
    board[10][11] = true
    board[9][10] = true
    board[9][11] = true
    board[12][13] = true
    board[11][13] = true
    board[12][12] = true
    board[11][12] = true
    board
  end

  def self.evolve game
    current_board = game.board
    dup_board = current_board.dup
    final_board = current_board.map { |row| row }
    height = current_board.length - 1
    width = current_board.first.length - 1

    (0..height).each do |row|
      (0..width).each do |column|
        final_board = check_neighbors(current_board, dup_board, row, column)
      end
    end
    final_board
  end

  def self.check_neighbors current_board, dup_board, row, column
    neighbor_count = 0

    north_direction = current_board[(row - 1)]
    south_direction = current_board[(row + 1)]

    if north_direction

      north = north_direction[column]
      if north
        neighbor_count += 1
      end

      northeast = north_direction[(column + 1)]
      if northeast
        neighbor_count += 1
      end

      northwest = north_direction[(column - 1)]
      if northwest
        neighbor_count += 1
      end

    end

    if south_direction

      south = south_direction[column]
      if south
        neighbor_count += 1
      end

      southwest = south_direction[(column - 1)]
      if southwest
        neighbor_count += 1
      end

      southeast = south_direction[(column + 1)]
      if southeast
        neighbor_count += 1
      end

    end

    east = current_board[row][(column + 1)]
    if east
      neighbor_count += 1
    end

    west = current_board[row][(column - 1)]
    if west
      neighbor_count += 1
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
