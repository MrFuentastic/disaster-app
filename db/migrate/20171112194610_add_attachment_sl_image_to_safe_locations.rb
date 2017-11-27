class AddAttachmentSlImageToSafeLocations < ActiveRecord::Migration[5.1]
  def self.up
    change_table :safe_locations do |t|
      t.attachment :sl_image
    end
  end

  def self.down
    remove_attachment :safe_locations, :sl_image
  end
end
