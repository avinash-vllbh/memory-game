class Game < ActiveRecord::Base

  belongs_to :user
  has_many :boards
  has_many :cards, through: :boards

  before_save :validate_pair_count
  after_create :prepare_game_board

  # before_save :validate_pair_count

  def prepare_game_board
    # validate_pair_count
    Board.prepare_board(self)
  end

  ###
  # Why join? Includes doesn't work! why?
  def game_board
    # Board.includes(:card).references(:card).where(game_id: self.id).select('boards.id, boards.game_id, boards.position, boards.card_id, cards.content')
    Board.joins(:card).where(game_id: self.id).select('boards.id, boards.game_id, boards.position, boards.card_id, cards.content as card_content, boards.state').order("id ASC")
  end

  def validate_pair_count
    self.total_pairs = ( grid_size * grid_size ) / 2
  end

  def update_preferences(params)
    
    begin
      params["grid_size"] = params["grid_size"].to_i
      
      update_board = 0
      update_board = 1 unless self.grid_size == params["grid_size"]
      update_board = 1 unless self.difficulty == params["difficulty"]

      # Game preferences have been updated
      # Update the board
      if update_board
        self.pairs_found = 0
        self.status = "pending"
        self.update!(params)
        Board.update_board(self)
      end

    rescue StandardError => e
      return false
    end

  end

end
