class CreateTwits < ActiveRecord::Migration
  def self.up
    create_table :twits do |t|
      t.string :name
      t.string :screen_name
      t.string :location
      t.decimal :latitude, :limit => 13, :precision => 13, :scale => 10
      t.decimal :longitude, :limit => 13, :precision => 13, :scale => 10
      t.string :profile_image_url
      t.string :url
      t.integer :twitter_user_id
      t.string :time_zone
      t.text :description
      t.string :oauth_token
      t.string :oauth_token_secret

      t.timestamps
    end
  end

  def self.down
    drop_table :twits
  end
end
