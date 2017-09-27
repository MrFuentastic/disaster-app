class ReliefService < ApplicationRecord
  has_many :emergency_relief_services
  has_many :emergencies, through: :emergency_relief_services
end
