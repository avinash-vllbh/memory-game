class AddDefaultToPairsFoundInGames < ActiveRecord::Migration
  def change
    change_column :games, :pairs_found, :integer, default: 0
  end
end
