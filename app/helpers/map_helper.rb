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
    end
  end
end
