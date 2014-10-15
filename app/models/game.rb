class Game < ActiveRecord::Base
  GRID_SIZE = 4
  # Serializing board and flipped attributes of game
  serialize :board
  serialize :flipped

  def board_size
    GRID_SIZE * GRID_SIZE
  end
end
