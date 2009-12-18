class AddAdditionalFieldsToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :name, :string
    add_column :users, :location, :string
    add_column :users, :longitude, :decimal
    add_column :users, :latitude, :decimal
    add_column :users, :avatar_file_name, :string
    add_column :users, :avatar_content_type, :string
    add_column :users, :avatar_file_size, :integer
    add_column :users, :avatar_updated_at, :datetime
        
  end

  def self.down
    remove_column :users, :avatar_updated_at
    remove_column :users, :avatar_file_size
    remove_column :users, :avatar_content_type
    remove_column :users, :avatar_file_name
    remove_column :users, :latitude
    remove_column :users, :longitude
    remove_column :users, :location
    remove_column :users, :name
  end
end
