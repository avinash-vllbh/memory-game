class AddConstraintsToGames < ActiveRecord::Migration
  def change
    change_column :games, :board, :text, null: false
    change_column :games, :total_pairs, :integer, null: false
    change_column :games, :pairs_found, :integer, default: 0
  end
end
