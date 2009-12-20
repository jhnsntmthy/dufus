class AddTwitterResponseToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :twitter_response, :text
  end

  def self.down
    remove_column :posts, :twitter_response
  end
end
