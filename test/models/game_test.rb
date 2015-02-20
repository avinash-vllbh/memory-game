require 'test_helper'

describe Game do

  describe "new instance " do
    before do 
      @game = Game.new
    end

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

  describe "#prepare_game_board" do
    before do 
      @game = Game.new
    end

    it "should call prepare_board on Board" do
      Board.expects(:prepare_board).with(@game)
      @game.user = users(:avi)
      @game.save
    end

  end

  describe "#update_preferences" do
    before do 
      @game = games(:easy_game)
    end

    let(:old_params) { { "grid_size" => "4", "difficulty" => "easy" } }

    it "doesn't update_board when the preferences aren't changed" do
      skip
      Board.expects(:prepare_board).with(@game).never
      @game.update_preferences(old_params)
    end

    let(:params) { { "grid_size" => "4", "difficulty" => "hard" } }

    it "calls update_board on Board" do
      Board.expects(:prepare_board).with(@game)
      @game.update_preferences(params)
    end

    it "updates new preferences for the game" do
      @game.update_preferences(params)
      assert_equal params["difficulty"], @game.difficulty
    end

    it "returns false when there is an issue with updating preferences" do
      params["grid_size"] = nil
      assert_not @game.update_preferences(params)
    end

    
  end

  
end