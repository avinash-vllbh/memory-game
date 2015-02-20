require 'test_helper'

describe Card do
  before do
    @card = Card.new
  end

  describe "attribute validations" do
    
    it "invalid without content" do
      assert !@card.valid?
    end

    it "invalid without minimum content" do
      @card.content = "t"
      assert_length(@card, :content)
    end

  end
  describe ".random_cards_for_game" do
    
    it "returns empty array when 0 cards in DB" do
      cards = Card.random_cards_for_game("easy")
      assert cards.empty?
    end
    
  end

end