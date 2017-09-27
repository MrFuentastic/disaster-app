class SafeLocation < ApplicationRecord
  has_many :emergency_safe_locations
  has_many :emergencies, through: :emergency_safe_locations
end
