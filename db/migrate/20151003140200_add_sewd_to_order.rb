class AddSewdToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :sewd, :boolean, default: false
  end
end
