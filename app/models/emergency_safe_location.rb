class EmergencySafeLocation < ApplicationRecord
  belongs_to :emergency
  belongs_to :safe_location
end
