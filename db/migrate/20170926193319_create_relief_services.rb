class CreateReliefServices < ActiveRecord::Migration[5.1]
  def change
    create_table :relief_services do |t|
      t.string :name
      t.string :phone

      t.timestamps
    end
  end
end
