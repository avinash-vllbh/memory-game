class AddGridSizeToGame < ActiveRecord::Migration
  def change
    add_column :games, :grid_size, :integer, default: 4
  end
end
