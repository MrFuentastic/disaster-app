class EmergencyReliefService < ApplicationRecord
  belongs_to :relief_services
  belongs_to :emergencies
end