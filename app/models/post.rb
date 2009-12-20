class Post < ActiveRecord::Base
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "500x300>", :thumb => "100x100#" }
  
  before_save :geolocate
  
  after_save :replicate
  # R_0be80a3f0fbd12ff3422bd38a9584b92
  protected
  
  def geolocate
    if self.location && self.location_changed?
      geo = Geokit::Geocoders::GoogleGeocoder.geocode self.location
      logger.debug geo
      self.latitude = geo.lat
      self.longitude = geo.lng
    end
  end
  
  def replicate
    post_to_twitter if user.twit_id
  end
  
  def post_to_twitter
    
  end
end
