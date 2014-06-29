class AddPosToProduct < ActiveRecord::Migration
  def change
    add_column :products, :pos, :integer, default: 0
  end
end
