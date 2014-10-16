require 'rails_helper'

describe Game, :type => :model do
  describe "#board_size" do
    subject(:game) {Game.new}
    it "returns the correct board size" do
      expect(game.board_size).to eq(36)
    end
    it "board_size is based on GRID_SIZE constant" do
      # Remove the constant first before intializing it to a different value
      # Else ruby throws a constant already initialized warning
      Game.send(:remove_const, 'GRID_SIZE')
      Game::GRID_SIZE = 4
      expect(game.board_size).to eq(16)
    end
  end
end
