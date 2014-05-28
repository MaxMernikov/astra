class AddDetailProductToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :detail_product, :text
    add_column :categories, :sub_detail, :text
    remove_column :products, :detail, :text
    remove_column :cloths, :composition, :text
  end
end
