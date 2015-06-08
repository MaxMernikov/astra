class AddVkGroupIdToProduct < ActiveRecord::Migration
  def change
    add_column :products, :vk_group_id, :integer
  end
end
