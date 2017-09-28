class EmergencyReliefService < ApplicationRecord
  belongs_to :relief_service
  belongs_to :emergency
end