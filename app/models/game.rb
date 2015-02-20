class Game < ActiveRecord::Base

  belongs_to :user
  has_many :boards
  has_many :cards, through: :boards

  before_save :validate_pair_count
  after_create :prepare_game_board

  # validates :user_id, presence: true
  # 
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
    begin
      params["grid_size"] = params["grid_size"].to_i

      raise StandardError.new unless [2, 4, 6, 8].include?(params["grid_size"])

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
