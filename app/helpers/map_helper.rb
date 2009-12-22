require "geokit"

module MapHelper
  
  def init_map
    run_map_script do
      map = Google::Map.new(:controls => [:small_map, :map_type],
                            :center => {:latitude => -33.947, :longitude => 18.462},
                            :zoom => 12)

      map.click do |script, location|
        map.open_info_window(:location => location, :html => 'hello cape town!')
      end
    end
  end
  
  def harrisonburg_map
    run_map_script do
      hburg = Geokit::Geocoders::YahooGeocoder.geocode "Harrisonburg, VA"
      map = Google::Map.new(:controls => [:large_map_3D, :map_type], :zoom => 16,
                            :center => {:latitude => hburg.lat, :longitude => hburg.lng},
                            :zoom => 12)
      
      
      map.click do |script, location|
        # new_location = Google::Location.new(:latitude => 18, :longitude => 34, :zoom => 2)
        map.pan_to location # Outputs => 'map.panTo(new GLatLng(18, 34));'
        
        # map.open_info_window(:location => location, :html => 'sup, burger-town?')
        
      end
      
    end
  end
  
  
  def get_map(lat, lng)
    run_map_script do    
      map = Google::Map.new(:controls => [:large_map, :map_type],
                            :center => {:latitude => lat, :longitude => lng},
                            :zoom => 12)
      markers = [[lat, lng]].collect do |location|
                   map.add_marker :location => location
      end             
    end
  end
  
  def all_posts_map(latitude, longitude, posts)
    run_map_script do
      map = Google::Map.new(:controls => [:large_map, :map_type],
                            :center => {:latitude => latitude, :longitude => longitude},
                            :zoom => 6)
      # :post_marker
      # markers = [[latitude, longitude]].collect do |location|
      #           map.add_marker :location => location
      # end
      map.add_marker (:location => [latitude, longitude], :icon => @current_user.user_pic_url)
      for post in posts
        marker = map.add_marker (:location => [post.latitude, post.longitude]) #:icon => :blue_circle)
        marker.click do |script|
          marker.open_info_window :html => '<img src="'+ @current_user.user_pic_url + '" width="30" height="30" style="float:left; margin-right: 10px;" align="top" /><b style="float:left">' + post.title + '</b>'
          marker.circle!
        end                 
      end
    end
  end
  
end
