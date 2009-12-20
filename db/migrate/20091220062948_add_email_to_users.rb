class AddEmailToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email, :string
    add_column :twits, :email, :string
  end

  def self.down
    remove_column :users, :email
    remove_column :twits, :email
  end
end
