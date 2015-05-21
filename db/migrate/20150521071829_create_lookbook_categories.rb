class CreateLookbookCategories < ActiveRecord::Migration
  def change
    create_table :lookbook_categories do |t|
      t.string :title
      t.text :overview
      t.boolean :show, default: false

      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
