class CreateCloths < ActiveRecord::Migration
  def change
    create_table :cloths do |t|
      t.text :composition
      t.boolean :show, default: true

      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
