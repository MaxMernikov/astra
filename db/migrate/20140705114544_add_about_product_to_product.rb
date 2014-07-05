class AddAboutProductToProduct < ActiveRecord::Migration
  def change
    add_column :products, :about_product, :text
  end
end
