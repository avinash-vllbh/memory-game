require 'test_helper'

describe Card do

  describe "attribute validations" do
    before do
      @card = Card.new
    end
    
    it "invalid without content" do
      assert_not @card.valid?
    end

    it "invalid without minimum content" do
      @card.content = "t"
      assert_length(@card, :content)
    end

  end

  describe ".random_cards_for_game" do
    
    it "returns a sample of two cards for an easy game" do
      cards = Card.random_cards_for_game("easy")
      assert_equal 2,cards.size
    end

    it "returns a sample of four cards for a medium game" do
      cards = Card.random_cards_for_game("medium")
      assert_equal 4, cards.size
    end

    it "returns empty array when there are no cards in DB" do
      Card.destroy_all
      cards = Card.random_cards_for_game("easy")
      assert_equal 0, cards.size
    end

  end

  describe ".cards_collection" do
    before do
      @game = games(:easy_game)
    end

    it "returns a collection of cards needed for the game" do
      cards = Card.cards_collection(@game)
      assert_equal @game.total_pairs * 2, cards.size
    end
  end

end