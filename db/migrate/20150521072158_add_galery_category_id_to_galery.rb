class AddGaleryCategoryIdToGalery < ActiveRecord::Migration
  def change
    add_reference :lookbook_items, :lookbook_category, index: true
  end
end
