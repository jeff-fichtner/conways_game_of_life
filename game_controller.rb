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

  def self.add_glider(board)
    board[3][2] = true
    board[3][3] = true
    board[3][4] = true
    board[2][4] = true
    board[1][3] = true
  end

  def self.evolve(game)
    current_board = game.board
    dup_board = game.board.dup
    # iterate through current_board
    # add results to dup_board, return dup_board
  end

end
