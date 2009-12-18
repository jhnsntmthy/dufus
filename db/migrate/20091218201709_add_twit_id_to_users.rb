class AddTwitIdToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :twit_id, :integer
  end

  def self.down
    remove_column :users, :twit_id
  end
end
