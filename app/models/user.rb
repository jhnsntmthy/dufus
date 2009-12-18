require "geokit"

class User < ActiveRecord::Base
  acts_as_authentic
  
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  before_save :geolocate
  # R_0be80a3f0fbd12ff3422bd38a9584b92
  protected
  
  def geolocate
    if self.location
      geo = Geokit::Geocoders::YahooGeocoder.geocode self.location
      logger.debug geo
      self.latitude = geo.lat
      self.longitude = geo.lng
    end
  end
end
