class AddVkOwnerIdAndVkPhotoIdAndVkPhotoCaptionToProducts < ActiveRecord::Migration
  def change
    add_column :products, :vk_owner_id,      :integer
    add_column :products, :vk_photo_id,      :integer
    add_column :products, :vk_photo_caption, :text
  end
end
