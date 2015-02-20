class Card < ActiveRecord::Base

  has_many :boards
  has_many :games, through: :boards

  SAMPLE_FOR_DIFFICULTY = { easy: 2, medium: 4, hard: 6, extra_hard: 8}

  validates :content, presence: true, uniqueness: true, length: { in: 4..10 }

  # Return a collection of cards for the game
  def self.cards_collection(game)
    game_cards = []
    cards = random_cards_for_game(game.difficulty)
    game.total_pairs.times do
      card = cards.sample
      2.times { game_cards.push(card) }
    end
    return game_cards.shuffle
  end

  # Pluck a random sampl of cards from database based on difficulty level.
  def self.random_cards_for_game(difficulty_level)
    self.order("RANDOM()").first( SAMPLE_FOR_DIFFICULTY[difficulty_level.to_sym] )
  end

end
