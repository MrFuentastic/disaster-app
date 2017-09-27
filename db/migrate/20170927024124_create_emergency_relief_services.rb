class CreateEmergencyReliefServices < ActiveRecord::Migration[5.1]
  def change
    create_table :emergency_relief_services do |t|
      t.integer :emergency_id
      t.integer :relief_service_id

      t.timestamps
    end
  end
end
