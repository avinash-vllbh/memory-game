class AddGuessCountersToGamesAndUsers < ActiveRecord::Migration
  def change
    add_column :games, :guesses, :integer, default: 0
    add_column :users, :guesses, :integer, default: 0
    add_column :users, :matches, :integer, default: 0
  end
end
