class CreateEmergencySafeLocations < ActiveRecord::Migration[5.1]
  def change
    create_table :emergency_safe_locations do |t|
      t.integer :emergency_id
      t.integer :safe_location_id

      t.timestamps
    end
  end
end
