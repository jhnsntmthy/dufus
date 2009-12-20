class Post < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "500x300>", :thumb => "100x100#" }
  
  before_save :geolocate
  
  after_save :replicate
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
    post_to_twitter if user.twit_id && self.tweet_this
  end
  
  def post_to_twitter
    begin
      oauth = Twitter::OAuth.new("TQhTZL7aABTGkS2kYuO0Q", "ZtCsgcIrWYVDhWNmPTqjbS4Rg8UjR2t14KPt1vuySs")
      oauth.authorize_from_access(user.twit.oauth_token, user.twit.oauth_token_secret)
      client = Twitter::Base.new(oauth)
      twitter_response = client.update(self.title)
    rescue Twitter::Unauthorized
      logger.debug "Twitter did not Authorize this request"
      logger.debug twitter_response
    end
  end
end
