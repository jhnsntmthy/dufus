class CreateTweets < ActiveRecord::Migration
  def self.up
    create_table :tweets do |t|
      t.string :message
      t.string :location
      t.decimal :latitude
      t.decimal :longitude
      t.integer :twitter_status_id
      t.integer :in_reply_to_user_id
      t.string :in_reply_to_screen_name
      t.integer :in_reply_to_status_id
      t.integer :post_id
      t.string :profile_image_url
      t.string :screen_name

      t.timestamps
    end
  end

  def self.down
    drop_table :tweets
  end
end
