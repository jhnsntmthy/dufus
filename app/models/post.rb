class Post < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "500x300>", :thumb => "100x100#" }
  
  before_save :geolocate
  
  before_save :replicate
  # R_0be80a3f0fbd12ff3422bd38a9584b92
  protected
  
  def geolocate
    if self.location && self.location_changed? && !self.location.blank?
      geo = Geokit::Geocoders::GoogleGeocoder.geocode self.location
      logger.debug geo
      self.latitude = geo.lat
      self.longitude = geo.lng
    end
  end
  
  def replicate
    post_to_twitter if self.new_record? && user.twit_id && self.tweet_this
  end
  
  def post_to_twitter
    begin
      oauth = Twitter::OAuth.new("3BqFrzv3sYtWyMTswUkx1A", "mBkPpC2dVKpFYIINHHZEl3Gl66uQTqnP6Y2lx5Tsw")
      oauth.authorize_from_access(user.twit.oauth_token, user.twit.oauth_token_secret)
      client = Twitter::Base.new(oauth)
      logger.debug client.update(self.title)
      self.twitter_response = "Twitter successfully updated your status"
    # rescue Twitter::Unauthorized
    #   self.twitter_response = "Twitter did not Authorize this request"
    # ensure
    #   logger.debug twitter_response
    end
  end
end
