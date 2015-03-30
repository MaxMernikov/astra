class CreateInstaConfs < ActiveRecord::Migration
  def change
    create_table :insta_confs do |t|
      t.string :token
      t.integer :insta_id, index: true
      t.text :settings_response
      t.text :info_response

      t.timestamps
    end
  end
end
