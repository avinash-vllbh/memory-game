class AddNewColumnsToGames < ActiveRecord::Migration
  def change
  	remove_column :games, :board
  	remove_column :games, :flipped
  	remove_column :games, :pairs_found
  	add_column :games, :user_id, :integer, null: false
  	add_column :games, :status, :string
  end
end
