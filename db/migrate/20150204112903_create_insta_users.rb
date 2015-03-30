class CreateInstaUsers < ActiveRecord::Migration
  def change
    create_table :insta_users do |t|
      t.integer :insta_id
      t.datetime :followed_at
      t.datetime :unfollowed_at
      t.boolean :private, default: false
      t.text :info_hash
      t.integer :followed_by_count, default: 0

      t.boolean :followed_by, default: false
      t.boolean :follows, default: false
      t.boolean :potential, default: false
      t.boolean :not_unsubscribe, default: false

      t.integer :bot_version
      t.datetime :start_monitoring
      t.datetime :start_follow
      t.boolean :not_resultative, default: false
      t.integer :bot_step, default: 0


      t.integer :insta_likes_count, default: 0

      t.timestamps
    end

    add_index :insta_users, :insta_id
  end
end
