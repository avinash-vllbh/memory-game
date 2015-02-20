class AddTimestampsToGame < ActiveRecord::Migration
  def change
    add_column :games, :created_at, :datetime
    add_column :games, :updated_at, :datetime
  end
end
