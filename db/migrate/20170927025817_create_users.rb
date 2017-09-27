class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
      t.decimal :lat, precision: 6, scale: 4
      t.decimal :long, precision: 7, scale: 4

      t.timestamps
    end
  end
end
