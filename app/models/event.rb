include Math

class Event < ApplicationRecord
  belongs_to :emergency
  
  def earth_radius_mi
    3959
  end

  def radians
    lambda { |deg| deg * PI / 180 }
  end

  def coord_radians
    lambda { |c| { :lat => radians[c[:lat]], :long => radians[c[:long]] } }
  end

  def event_location_coord
    {lat: lat, long: long}
  end
  # from/to = { :lat => (latitude_in_degrees), :lng => (longitude_in_degrees) }
  def haversine_distance(from)
    from = coord_radians[from]
    to = coord_radians[event_location_coord]
    cosines_product = cos(to[:lat]) * cos(from[:lat]) * cos(from[:long] - to[:long])
    sines_product = sin(to[:lat]) * sin(from[:lat])
    return earth_radius_mi * acos(cosines_product + sines_product)
  end
end
