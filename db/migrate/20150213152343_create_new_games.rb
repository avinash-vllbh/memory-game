class CreateNewGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :user_id, null: :false
      t.integer :total_pairs, null: :false
      t.integer :pairs_found, null: :false
      t.string :difficulty, default: "easy", null: :false
      t.string :status, default: "pending", null: :false
    end
  end
end
