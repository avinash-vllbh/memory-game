require 'test_helper'

describe Game do
  before do 
    @game = Game.new
  end

  describe "new instance " do

    it "game status defaults to pending" do
      assert_equal "pending", @game.status
    end
    it "pairs found defaults to zero" do
      assert_equal 0, @game.pairs_found      
    end

    it "total_pairs defaults to 8 when game is saved" do
      @game.save
      assert_equal 8, @game.total_pairs
    end

  end

  
end