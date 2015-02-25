class AddAccuracyToGames < ActiveRecord::Migration
  def change
    add_column :games, :accuracy, :integer, default: 0
  end
end
