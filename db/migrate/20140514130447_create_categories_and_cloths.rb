class CreateCategoriesAndCloths < ActiveRecord::Migration
  def change
    create_table :categories_cloths, id: false do |t|
      t.references :category
      t.references :cloth
    end

    add_index :categories_cloths, :category_id
    add_index :categories_cloths, :cloth_id
  end
end
