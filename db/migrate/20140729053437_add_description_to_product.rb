class AddDescriptionToProduct < ActiveRecord::Migration
  def change
    add_column :products, :description, :string
    add_column :categories, :description, :string
    add_column :categories, :keywords, :string
  end
end
