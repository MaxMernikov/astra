class AddBookToLookbookItem < ActiveRecord::Migration
  def change
    add_column :lookbook_items, :book, :boolean, default: false
  end
end
