class CreateInstaConfs < ActiveRecord::Migration
  def change
    create_table :insta_confs do |t|
      t.string :token
      t.integer :insta_id

      t.timestamps
    end
  end
end
