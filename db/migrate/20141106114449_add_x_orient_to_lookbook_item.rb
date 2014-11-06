class AddXOrientToLookbookItem < ActiveRecord::Migration
  def change
    add_column :lookbook_items, :y_orient, :boolean, default: false
  end
end
