class CreateAboutProductImages < ActiveRecord::Migration
  def change
    create_table :about_product_images do |t|
      t.references :category, index: true

      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at
    end
  end
end
