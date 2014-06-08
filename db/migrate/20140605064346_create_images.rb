class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_file_name
      t.integer :image_file_size
      t.string :image_content_type

      t.references :product, index: true
    end

    remove_column :products, :image_file_name, :string
    remove_column :products, :image_file_size, :integer
    remove_column :products, :image_content_type, :string
    remove_column :products, :image_updated_at, :datetime
  end
end
