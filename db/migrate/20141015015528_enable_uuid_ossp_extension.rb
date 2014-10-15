class EnableUuidOsspExtension < ActiveRecord::Migration
  def change
    # To enable the uuid-ossp module in PostgreSQL which provides functions to generate UUIDs
    enable_extension 'uuid-ossp'
  end
end
