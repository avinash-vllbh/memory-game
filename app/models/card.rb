class Card < ActiveRecord::Base
  DEFAULT_CARDS = ["circle", "square", "triangle", "pentagon"]
  validates :content, presence: true, uniqueness: true, length: { in: 4..10 }

  def self.default_cards
    DEFAULT_CARDS
  end
end
