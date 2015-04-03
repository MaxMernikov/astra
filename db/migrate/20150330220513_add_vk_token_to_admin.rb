class AddVkTokenToAdmin < ActiveRecord::Migration
  def change
    add_column :admins, :vk_token, :string
  end
end
