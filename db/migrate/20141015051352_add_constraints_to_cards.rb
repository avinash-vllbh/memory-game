class AddConstraintsToCards < ActiveRecord::Migration
  def change
    change_column :cards, :content, :string, null: false
    add_index :cards, :content, unique: true
  end
end
