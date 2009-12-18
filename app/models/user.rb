require "geokit"
require "bitly"

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
  
  
  
  # bitly = Bitly.new("jhnsntmthy", "R_0be80a3f0fbd12ff3422bd38a9584b92")
  # 
  #   You can then use that client to shorten or expand urls or return more information or statistics as so:
  # 
  #   bitly.shorten('http://www.google.com')
  #   bitly.shorten('http://www.google.com', :history => 1) # adds the url to the api user's history
  #   bitly.expand('wQaT')
  #   bitly.info('http://bit.ly/wQaT')
  #   bitly.stats('http://bit.ly/wQaT')
  # 
  #   Each can be used in all the methods described in the API docs, the shorten function, for example, takes a url or an 
  #   array of urls.
  # 
  #   All four functions return a Bitly::Url object (or an array of Bitly::Url objects if you supplied an array as the input). 
  #   You can then get all the information required from that object.
  # 
  #   u = bitly.shorten('http://www.google.com') #=> Bitly::Url
  # 
  #   u.long_url #=> "http://www.google.com"
  #   u.short_url #=> "http://bit.ly/Ywd1"
  #   u.user_hash #=> "Ywd1"
  #   u.hash #=> "2V6CFi"
  #   u.info #=> a ruby hash of the JSON returned from the API
  #   u.stats #=> a ruby hash of the JSON returned from the API
end
