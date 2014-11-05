class CreateLookbookItems < ActiveRecord::Migration
  def change
    create_table :lookbook_items do |t|
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.integer :row, index: true
      t.text :position
      t.text :background_position
      t.references :product, index: true
      t.string :url
      t.text :comment
      t.boolean :show

      t.timestamps
    end
  end
end
