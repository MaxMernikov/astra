class CreateInstaFollowedTos < ActiveRecord::Migration
  def change
    create_table :insta_followed_tos do |t|
      t.integer :insta_id
      t.text :hash

      t.timestamps
    end
  end
end
