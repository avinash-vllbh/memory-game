require 'test_helper'

describe Board do
  describe '.prepare_board' do 
    before do
      @game = games(:easy_game)
      @cards = Card.cards_collection(@game)
    end

    it "calls cards_collection method" do
      Card.expects(:cards_collection).with(@game).returns(@cards)
      Board.prepare_board(@game)
    end
  end

  describe '.update_board' do
    before do
      @game = games(:easy_game)
      Board.prepare_board(@game)
    end

    it "updates the board with new card collection" do
      board = Board.game_board(@game)
      refute_same board, Board.update_board(@game)
    end

  end
  describe 'validate_board_state' do
    before do 
      @game = games(:easy_game)
      Board.prepare_board(@game)
      @game_board = Board.game_board(@game)
      @prepared_card = @game_board.first
    end

    let(:current_card) { @game_board[1..-1].sample }

    it "changes state to selected if there are no cards on board with state selected" do
      current_card.state = "selected"
      current_card.validate_board_state
      assert_equal "selected", current_card.state
    end

    it "changes state to origin if two cards content doesn't match" do
      
      @prepared_card.state = "selected"
      @prepared_card.card_id = 2
      @prepared_card.save!

      current_card.update(card_id: 1)

      current_card.validate_board_state

      assert_equal "origin", current_card.state
    end

    it "changes state to matched if two cards content's match" do
      
      @prepared_card.state = "selected"
      @prepared_card.card_id = 1
      @prepared_card.save!

      current_card.update(card_id: 1)

      current_card.validate_board_state

      assert_equal "matched", current_card.state
    end
  end
end