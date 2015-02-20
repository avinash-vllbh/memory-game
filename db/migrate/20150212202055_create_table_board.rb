class CreateTableBoard < ActiveRecord::Migration
  def change
    create_table :boards do |t|
    	t.integer :game_id
    	t.integer :card_id
    	t.integer :position
    	t.string :state, default: "origin", null: false
    end
    add_index :boards, :game_id
  end
end
