class CreateGaleries < ActiveRecord::Migration
  def change
    create_table :galeries do |t|
      t.references :product, index: true
      t.references :lookbook_item, index: true

      t.timestamps
    end
  end
end
