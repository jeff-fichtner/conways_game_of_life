require_relative 'board_generator'
require_relative 'game'
require_relative 'game_view'

class GameController

  def self.run
    generation_count = 0
    generations = 1000
    width = 20
    height = 20
    game = Game.new(BoardGenerator.generate(20, 20))

    # alter board in some way

    while generation_count < generations
      game.board = evolve(game)
      GameView.display_board(game.board)
      generation_count += 1
    end

  end


  private

  def self.evolve(game)
    current_board = game.board
    dup_board = game.board.dup
    # iterate through current_board
    # add results to dup_board, return dup_board
  end

end
