class Game < ActiveRecord::Base
  include Counter
  # remove_method :increment_match_counter

  belongs_to :user
  has_many :boards
  has_many :cards, through: :boards

  before_save :validate_pair_count, :calculate_accuracy
  after_create :prepare_game_board

  GRID_SIZES = [2, 4, 6, 8]
  DIFFICULTY_LEVELS = ["easy", "medium", "hard", "extra_hard"]

  def game_board
    Board.game_board(self)
  end

  def validate_pair_count
    self.total_pairs = ( grid_size * grid_size ) / 2
  end

  def calculate_accuracy
    self.accuracy = self.guesses == 0 ? 0 : ((self.pairs_found.to_f / self.guesses) * 100).ceil
  end

  def update_preferences(params)
    # raise InvalidGameUpdate if self.status == "completed"
    return self.errors[:base] << "Invalid - Game already completed" if self.status == "completed"
    # raise InvalidUpdatePreferences unless validate_preferences(params)
    return self.errors[:base] << "Invalid update preferences for the game" unless validate_preferences(params)
    self.grid_size = params["grid_size"].to_i
    self.difficulty = params["difficulty"]
    if self.changed?
      save_game_preferences
    else
      self.errors[:base] << "preferences were not changed"
    end
  end

  def increment_guess_counter
    @user = self.user
    @user.increment_guess_counter
    super
  end

  private 

  def reset_game_defaults
    self.pairs_found = 0
    self.guesses = 0
    self.status = "pending"
  end

  def prepare_game_board
    Board.prepare_board(self)
  end

  def save_game_preferences
    reset_game_defaults
    self.save! and Board.update_board(self)
  end

  def validate_preferences(params)
    GRID_SIZES.include?(params["grid_size"].to_i) && DIFFICULTY_LEVELS.include?(params["difficulty"])
  end

end
