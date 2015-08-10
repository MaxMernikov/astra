class CreateImageResizes < ActiveRecord::Migration

  def change
    create_table :image_resizes do |t|
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type
      t.datetime :image_updated_at

      t.timestamps
    end
  end
end
