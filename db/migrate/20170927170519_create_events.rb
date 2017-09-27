class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :emergency_id
      t.datetime :time_of_occurence
      t.string :status
      t.decimal :lat, precision: 6, scale: 4
      t.decimal :long, precision: 7, scale: 4

      t.timestamps
    end
  end
end
