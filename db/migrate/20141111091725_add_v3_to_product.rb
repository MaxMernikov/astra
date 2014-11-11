class AddV3ToProduct < ActiveRecord::Migration
  def change
    add_column :products, :v3, :boolean, default: false
  end
end
