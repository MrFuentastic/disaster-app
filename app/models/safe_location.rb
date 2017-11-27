include Math


class SafeLocation < ApplicationRecord
  has_many :emergency_safe_locations
  has_many :emergencies, through: :emergency_safe_locations
  has_attached_file :sl_image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :sl_image, content_type: /\Aimage\/.*\z/

  def earth_radius_mi
    3959
  end

  def radians
    lambda { |deg| deg * PI / 180 }
  end

  def coord_radians
    lambda { |c| { :lat => radians[c[:lat]], :long => radians[c[:long]] } }
  end

  def safe_location_coord
    {lat: lat, long: long}
  end
  
  # from/to = { :lat => (latitude_in_degrees), :lng => (longitude_in_degrees) }
  def haversine_distance(from)
    from = coord_radians[from]
    to = coord_radians[safe_location_coord]
    cosines_product = cos(to[:lat]) * cos(from[:lat]) * cos(from[:long] - to[:long])
    sines_product = sin(to[:lat]) * sin(from[:lat])
    return earth_radius_mi * acos(cosines_product + sines_product)
  end
end
