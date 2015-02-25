class Board < ActiveRecord::Base
  belongs_to :game
  belongs_to :card

  # Returns the board that belongs to the game
  def self.game_board(game)
    cols = "boards.id, boards.game_id, boards.position, boards.card_id, cards.content as card_content, boards.state"
    joins(:card).where(game_id: game.id).select(cols).order("id ASC")
  end

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
    @selected_card = Board.includes(:card).where(game_id: self.game_id, state: "selected").first
    if @selected_card.nil?
      self.state = "selected"
      self.save!
    else
      check_for_cards_content
    end
  end

  private

  def check_game_completed
    @game.status = "completed" if @game.pairs_found == @game.total_pairs
    @game.save!
  end

  def update_game_status
    @game = self.game
    @game.pairs_found += 1
    @game.increment_guess_counter
    check_game_completed
  end

  def update_cards_state_to_matched
    self.update!(state: "matched")
    @selected_card.update!(state: "matched")
    update_game_status
    @user = self.game.user
    @user.increment_match_counter
  end

  def check_for_cards_content
    if @selected_card.card.content == self.card.content
      update_cards_state_to_matched
    else
      @selected_card.update!(state: "origin")
      self.game.increment_guess_counter
    end
  end
  
end

