class AddAdditionalFieldsToUser2 < ActiveRecord::Migration
  def self.up
    add_column :users, :last_location, :string
    add_column :users, :last_latitude, :decimal
    add_column :users, :last_longitude, :decimal
  end

  def self.down
    remove_column :users, :last_location
    remove_column :users, :last_latitude
    remove_column :users, :last_longitude
  end
end
