class AddUpdatedAtToLookbookItem < ActiveRecord::Migration
  def change
    add_column :lookbook_items, :image_updated_at, :datetime
    add_column :images, :image_updated_at, :datetime
  end
end
