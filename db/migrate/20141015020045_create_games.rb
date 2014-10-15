class CreateGames < ActiveRecord::Migration
  def change
    create_table :games, id: :uuid do |t|
      t.text :board
      t.integer :total_pairs
      t.text :flipped
      t.integer :pairs_found

      t.timestamps
    end
  end
end
