require_relative '../game'
require_relative '../board_generator'

describe Game do
  let (:board) { BoardGenerator.generate(20, 20) }
  let (:game) { Game.new(board) }

  describe "#initialize" do
    it 'has a readable board' do
      expect(game.board[0][0]).to be false
      expect(game.board[0].length).to eq 20
    end

    it 'has a writable board' do
      expect { game.board[0][0] = true }.to change { game.board[0][0] }.to true
    end
  end
end
