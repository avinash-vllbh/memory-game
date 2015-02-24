class Game < ActiveRecord::Base

  belongs_to :user
  has_many :boards
  has_many :cards, through: :boards

  before_save :validate_pair_count
  after_create :prepare_game_board

  GRID_SIZES = [2, 4, 6, 8]
  DIFFICULTY_LEVELS = ["easy", "medium", "hard", "extra_hard"]

  def prepare_game_board
    Board.prepare_board(self)
  end

  # Gives you the board related to this game.
  def game_board
    Board.game_board(self)
  end

  def validate_pair_count
    self.total_pairs = ( grid_size * grid_size ) / 2
  end

  def update_preferences(params)
    return InvalidGameAttributes unless validate_preferences(params)
    self.grid_size = params["grid_size"].to_i
    self.difficulty = params["difficulty"]
    save_game_preferences if self.changed?
  end

  def save_game_preferences
    self.pairs_found = 0
    self.status = "pending"
    self.save! and Board.update_board(self)
  end

  def validate_preferences(params)
    GRID_SIZES.include?(params["grid_size"].to_i) && DIFFICULTY_LEVELS.include?(params["difficulty"])
  end

end
