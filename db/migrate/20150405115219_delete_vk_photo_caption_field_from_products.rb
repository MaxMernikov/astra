class DeleteVkPhotoCaptionFieldFromProducts < ActiveRecord::Migration
  def change
    remove_column :products, :vk_photo_caption
  end
end
