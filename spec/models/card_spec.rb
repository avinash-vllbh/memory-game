require 'rails_helper'

describe Card, :type => :model do
  describe "validations" do
    fixtures :cards
    it "is invalid without content" do
      card = Card.new(:content => nil)
      expect(card).not_to be_valid
    end
    
    it "content needs to be unique" do
      card = Card.new(:content => "square")
      expect(card).not_to be_valid
    end

    it "content cannot be less that 4 characters" do
      expect(Card.new(:content => "ttt")).not_to be_valid
    end
  end
end
