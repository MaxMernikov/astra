class AddVkPhotoImageToProducts < ActiveRecord::Migration
  def self.up
    add_attachment :products, :vk_photo_image
  end

  def self.down
    remove_attachment :products, :vk_photo_image
  end
end
