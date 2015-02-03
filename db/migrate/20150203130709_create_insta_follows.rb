class CreateInstaFollows < ActiveRecord::Migration
  def change
    create_table :insta_follows do |t|
      t.integer :insta_id, index: true
      t.text :hash
      t.datetime :unsubscribe_at

      t.timestamps
    end
  end
end
