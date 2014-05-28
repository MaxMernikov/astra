class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :product, index: true
      t.references :cloth, index: true
      t.string :email
      t.string :phone
      t.string :name
      t.text :details
      t.text :mark

      t.boolean :complete, default: false

      t.timestamps
    end
  end
end
