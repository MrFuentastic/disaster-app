class Emergency < ApplicationRecord
  has_many :emergency_relief_services
  has_many :relief_services, through: :emergency_relief_services
  has_many :emergency_safe_locations
  has_many :safe_locations, through: :emergency_safe_locations
  has_many :events
end
