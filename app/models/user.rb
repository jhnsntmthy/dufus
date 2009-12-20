require "geokit"
require "bitly"

class User < ActiveRecord::Base
  acts_as_authentic
  is_gravtastic!
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }
  
  has_many :posts
  belongs_to :twit
  
  before_save :geolocate
  
  
  def user_pic_url(size=nil)
    if self.avatar.exists?
      return self.avatar.url(size)
    elsif !twit_id.nil?
      pic = self.twit.profile_image_url
    else
      pic = gravatar_url(:default => "/images/missing_avatar.png") if pic.nil? || pic == ""
    end
    pic
  end
  
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
  
end
