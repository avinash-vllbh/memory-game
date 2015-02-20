class Board < ActiveRecord::Base
  belongs_to :game
  belongs_to :card

  def self.prepare_board(game)

    game_cards = Card.cards_collection(game)

    game_cards.each_with_index do |card, index|
      Board.create!(game_id: game.id, card_id: card.id, position: index)
    end

  end

  def self.update_board(game)
    # Delete exisiting cards in the game and prepare the board again
    destroy_all(game_id: game.id)
    prepare_board(game)
  end

  def validate_board_state
    # There is only one card that could be in a selected state previously
    selected_card = Board.includes(:card).where(game_id: self.game_id, state: "selected").first
    
    game = Game.find(self.game_id)
    
    if selected_card.nil?
      self.state = "selected"
      self.save!
    else
      if selected_card.card.content == self.card.content
        self.update!(state: "matched")
        selected_card.update!(state: "matched")
        game.pairs_found = game.pairs_found + 1
        game.status = "completed" if game.pairs_found == game.total_pairs
        game.save!
      else
        selected_card.update!(state: "origin")
      end
    end

  end
  
end

