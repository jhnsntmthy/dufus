class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :message
      t.string :location
      t.decimal :latitude, :limit => 13, :precision => 13, :scale => 10
      t.decimal :longitude, :limit => 13, :precision => 13, :scale => 10
      t.integer :user_id
      t.boolean :tweet_this
      t.integer :in_reply_to
      t.string :image_file_name
      t.string :image_content_type
      t.integer :image_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
